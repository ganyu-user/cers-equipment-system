package com.ruoyi.equipment.order.service.impl;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

import com.ruoyi.common.constant.CacheConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.equipment.info.domain.EqEquipment;
import com.ruoyi.equipment.info.mapper.EqEquipmentMapper;
import com.ruoyi.equipment.order.domain.ResOrder;
import com.ruoyi.equipment.order.domain.ReturnDetail;
import com.ruoyi.equipment.order.mapper.ResOrderMapper;
import com.ruoyi.equipment.order.mapper.ReturnDetailMapper;
import com.ruoyi.equipment.order.service.IBookingSlotService;
import com.ruoyi.equipment.order.service.IResOrderService;
import com.ruoyi.equipment.order.util.SlotSegment;
import com.ruoyi.equipment.unit.domain.EqEquipmentUnit;
import com.ruoyi.equipment.unit.mapper.EqEquipmentUnitMapper;
import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.service.ISysMsgService;
import com.ruoyi.system.service.ISysNoticeService;

/**
 * 预约订单Service业务层处理
 * 
 * @author ganyu
 * @date 2026-05-07
 */
@Service
public class ResOrderServiceImpl implements IResOrderService
{
    @Autowired
    private ResOrderMapper resOrderMapper;

    @Autowired
    private EqEquipmentUnitMapper eqEquipmentUnitMapper;

    @Autowired
    private EqEquipmentMapper eqEquipmentMapper;

    @Autowired
    private ReturnDetailMapper returnDetailMapper;

    @Autowired
    private ISysMsgService sysMsgService;

    @Autowired
    private ISysNoticeService sysNoticeService;

    @Autowired
    private IBookingSlotService bookingSlotService;

    @Autowired
    private RedisCache redisCache;

    private static final DateTimeFormatter TIME_FMT = DateTimeFormatter.ofPattern("HH:mm:ss");
    private static final DateTimeFormatter DATE_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    public ResOrder selectResOrderById(Long orderId)
    {
        String cacheKey = CacheConstants.RES_ORDER_KEY + orderId;
        ResOrder cached = redisCache.getCacheObject(cacheKey);
        if (cached != null)
        {
            return cached;
        }
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order != null)
        {
            redisCache.setCacheObject(cacheKey, order, 30, java.util.concurrent.TimeUnit.MINUTES);
        }
        return order;
    }

    @Override
    public List<ResOrder> selectResOrderList(ResOrder resOrder)
    {
        return resOrderMapper.selectResOrderList(resOrder);
    }

    @Override
    public List<ResOrder> selectMyOrderList(ResOrder resOrder)
    {
        Long currentUserId = SecurityUtils.getUserId();
        resOrder.setUserId(currentUserId);
        return resOrderMapper.selectResOrderListByUserId(resOrder);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertResOrder(ResOrder resOrder)
    {
        resOrder.setCreateTime(DateUtils.getNowDate());

        resOrder.setOrderNo(generateOrderNo());

        Long currentUserId = SecurityUtils.getUserId();
        String currentUserName = SecurityUtils.getUsername();
        resOrder.setUserId(currentUserId);

        if (resOrder.getOrderStatus() == null || resOrder.getOrderStatus().isEmpty())
        {
            resOrder.setOrderStatus("0");
        }

        if (resOrder.getReturnStatus() == null || resOrder.getReturnStatus().isEmpty())
        {
            resOrder.setReturnStatus("0");
        }

        EqEquipment equipment = eqEquipmentMapper.selectEqEquipmentByEquipmentId(resOrder.getEquipmentId());
        if (equipment == null)
        {
            throw new RuntimeException("设备不存在");
        }

        if (resOrder.getEquipmentName() == null || resOrder.getEquipmentName().isEmpty())
        {
            resOrder.setEquipmentName(equipment.getEquipmentName());
        }

        // ---- 时间槽预占 ----
        String slotInfo = preOccupyTimeSlots(resOrder, equipment);
        resOrder.setSlotInfo(slotInfo);

        if ("1".equals(equipment.getTrackUnit()))
        {
            List<EqEquipmentUnit> availableUnits = eqEquipmentUnitMapper.selectAvailableUnitsByEquipmentId(resOrder.getEquipmentId());
            int needQty = resOrder.getQuantity() != null ? resOrder.getQuantity() : 1;

            if (availableUnits.size() < needQty)
            {
                throw new RuntimeException("设备 '" + equipment.getEquipmentName() + "' 可用数量不足，当前可用: " + availableUnits.size() + "，需要: " + needQty);
            }

            List<EqEquipmentUnit> selectedUnits = availableUnits.subList(0, needQty);
            String assignedCodes = selectedUnits.stream().map(EqEquipmentUnit::getUnitCode).collect(Collectors.joining(","));
            resOrder.setAssignedUnitCodes(assignedCodes);
        }

        resOrder.setCreateBy(currentUserName);
        int result = resOrderMapper.insertResOrder(resOrder);

        try
        {
            String content = "您已成功提交预约申请，设备：{0}，数量：{1}，请等待管理员审批。";
            content = java.text.MessageFormat.format(content, resOrder.getEquipmentName(), resOrder.getQuantity());
            sysMsgService.sendMsgToUser(resOrder.getUserId(), "reserve", "预约提交成功", content, resOrder.getOrderId());

            String adminContent = "用户 <b>{0}</b> 提交了预约申请。<br>订单号：{1}<br>设备：{2}<br>数量：{3}<br>请前往【预约单管理】进行审批。";
            adminContent = java.text.MessageFormat.format(adminContent, resOrder.getRealName(), resOrder.getOrderNo(), resOrder.getEquipmentName(), resOrder.getQuantity());
            createAdminNotice("待审批 - {0} 预约了 {1}".replace("{0}", resOrder.getRealName()).replace("{1}", resOrder.getEquipmentName()), adminContent);
            // app 消息使用纯文本版本，避免 HTML 标签乱码
            String plainAdminContent = "用户 " + resOrder.getRealName() + " 提交了预约申请。订单号：" + resOrder.getOrderNo() + "，设备：" + resOrder.getEquipmentName() + "，数量：" + resOrder.getQuantity() + "。请前往【预约单管理】进行审批。";
            sysMsgService.sendMsgToRole("admin", "reserve", "待审批预约", plainAdminContent, resOrder.getOrderId());
        }
        catch (Exception e)
        {
            // 通知发送失败不影响主流程
        }

        return result;
    }

    private String generateOrderNo()
    {
        String timestamp = DateUtils.parseDateToStr("yyyyMMddHHmmssSSS", new Date());
        int random = ThreadLocalRandom.current().nextInt(100, 999);
        return "RES" + timestamp + random;
    }

    private void createAdminNotice(String title, String content)
    {
        try
        {
            SysNotice notice = new SysNotice();
            notice.setNoticeTitle(title);
            notice.setNoticeType("1");
            notice.setNoticeContent(content);
            notice.setStatus("0");
            notice.setCreateBy("system");
            sysNoticeService.insertNotice(notice);
        }
        catch (Exception e)
        {
            // 公告创建失败不影响主流程
        }
    }

    @Override
    public int updateResOrder(ResOrder resOrder)
    {
        resOrder.setUpdateTime(DateUtils.getNowDate());
        int rows = resOrderMapper.updateResOrder(resOrder);
        if (rows > 0)
        {
            deleteOrderCache(resOrder.getOrderId());
        }
        return rows;
    }

    @Override
    public int deleteResOrderByIds(Long[] ids)
    {
        return resOrderMapper.deleteResOrderByIds(ids);
    }

    @Override
    public int deleteResOrderById(Long orderId)
    {
        return resOrderMapper.deleteResOrderById(orderId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int approveOrder(Long orderId)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            throw new RuntimeException("订单不存在");
        }
        if (!"0".equals(order.getOrderStatus()))
        {
            throw new RuntimeException("当前订单状态不允许审批");
        }

        Long approverId = SecurityUtils.getUserId();
        String approverName = SecurityUtils.getUsername();
        Date now = DateUtils.getNowDate();
        String approveTime = DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, now);

        EqEquipment equipment = eqEquipmentMapper.selectEqEquipmentByEquipmentId(order.getEquipmentId());

        if ("1".equals(equipment.getTrackUnit()))
        {
            String assignedUnitCodes = order.getAssignedUnitCodes();
            if (assignedUnitCodes == null || assignedUnitCodes.isEmpty())
            {
                throw new RuntimeException("订单未预分配设备单元，请先编辑分配");
            }

            List<String> codes = Arrays.asList(assignedUnitCodes.split(","));
            for (String code : codes)
            {
                String trimmedCode = code.trim();
                EqEquipmentUnit queryParam = new EqEquipmentUnit();
                queryParam.setEquipmentId(order.getEquipmentId());
                queryParam.setUnitCode(trimmedCode);
                List<EqEquipmentUnit> units = eqEquipmentUnitMapper.selectEqEquipmentUnitList(queryParam);
                if (units.isEmpty())
                {
                    throw new RuntimeException("设备单元 '" + trimmedCode + "' 不存在");
                }
                EqEquipmentUnit unit = units.get(0);
                if (!"0".equals(unit.getStatus()))
                {
                    throw new RuntimeException("设备单元 '" + trimmedCode + "' 当前不可用");
                }

                unit.setStatus("1");
                unit.setBorrowerId(order.getUserId());
                unit.setBorrowOrderId(orderId);
                unit.setBorrowTime(now);
                if (order.getExpectReturnTime() != null && !order.getExpectReturnTime().isEmpty())
                {
                    try
                    {
                        unit.setExpectedReturnTime(DateUtils.parseDate(order.getExpectReturnTime()));
                    }
                    catch (Exception e)
                    {
                        // ignore parse error
                    }
                }
                unit.setReturnStatus("0");
                unit.setUpdateTime(now);
                eqEquipmentUnitMapper.updateEqEquipmentUnit(unit);
            }
        }

        int remainStock = (int)(equipment.getRemainStock() - order.getQuantity());
        equipment.setRemainStock((long)Math.max(remainStock, 0));
        equipment.setUpdateTime(now);
        eqEquipmentMapper.updateEqEquipment(equipment);

        order.setOrderStatus("1");
        order.setApproverId(approverId);
        order.setApproverName(approverName);
        order.setApproveTime(approveTime);
        order.setUpdateTime(now);

        int result = resOrderMapper.updateResOrder(order);

        deleteOrderCache(orderId);

        try
        {
            String location = equipment.getLocation() != null ? equipment.getLocation() : "指定地点";
            String content = "恭喜！您的预约已通过审批。设备：{0}，请于{1}前往{2}使用。";
            content = java.text.MessageFormat.format(content, order.getEquipmentName(), order.getReserveTime(), location);
            sysMsgService.sendMsgToUser(order.getUserId(), "reserve", "预约已通过", content, orderId);
        }
        catch (Exception e)
        {
            // 通知发送失败不影响主流程
        }

        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int rejectOrder(Long orderId, String rejectReason)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            throw new RuntimeException("订单不存在");
        }
        if (!"0".equals(order.getOrderStatus()))
        {
            throw new RuntimeException("当前订单状态不允许拒绝");
        }

        Long approverId = SecurityUtils.getUserId();
        String approverName = SecurityUtils.getUsername();
        Date now = DateUtils.getNowDate();
        String approveTime = DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, now);

        order.setOrderStatus("2");
        order.setReturnStatus("4");
        order.setApproverId(approverId);
        order.setApproverName(approverName);
        order.setApproveTime(approveTime);
        order.setRejectReason(rejectReason);
        order.setUpdateTime(now);

        int result = resOrderMapper.updateResOrder(order);

        // 释放已预占的时间槽
        releaseOrderSlots(order);

        deleteOrderCache(orderId);

        try
        {
            String content = "很遗憾，您的预约申请被拒绝。设备：{0}，原因：{1}。";
            content = java.text.MessageFormat.format(content, order.getEquipmentName(), rejectReason);
            sysMsgService.sendMsgToUser(order.getUserId(), "reserve", "预约已拒绝", content, orderId);
        }
        catch (Exception e)
        {
            // 通知发送失败不影响主流程
        }

        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int returnOrder(Long orderId, String returnStatus)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            throw new RuntimeException("订单不存在");
        }
        if (!"1".equals(order.getOrderStatus()))
        {
            throw new RuntimeException("当前订单状态不允许归还操作");
        }

        Date now = DateUtils.getNowDate();

        EqEquipment equipment = eqEquipmentMapper.selectEqEquipmentByEquipmentId(order.getEquipmentId());

        if ("1".equals(equipment.getTrackUnit()))
        {
            String assignedUnitCodes = order.getAssignedUnitCodes();
            if (assignedUnitCodes != null && !assignedUnitCodes.isEmpty())
            {
                List<String> codes = Arrays.asList(assignedUnitCodes.split(","));
                for (String code : codes)
                {
                    String trimmedCode = code.trim();
                    EqEquipmentUnit queryParam = new EqEquipmentUnit();
                    queryParam.setEquipmentId(order.getEquipmentId());
                    queryParam.setUnitCode(trimmedCode);
                    List<EqEquipmentUnit> units = eqEquipmentUnitMapper.selectEqEquipmentUnitList(queryParam);
                    if (!units.isEmpty())
                    {
                        EqEquipmentUnit unit = units.get(0);
                        unit.setActualReturnTime(now);
                        unit.setReturnStatus(returnStatus != null ? returnStatus : "2");
                        unit.setUpdateTime(now);
                        eqEquipmentUnitMapper.clearBorrowInfoByUnitId(unit);
                    }
                }
            }
        }

        if (returnStatus == null || "2".equals(returnStatus))
        {
            int restoredStock = (int)(equipment.getRemainStock() + order.getQuantity());
            equipment.setRemainStock(Math.min(restoredStock, equipment.getTotalStock()));
        }
        else if ("3".equals(returnStatus))
        {
            int damagedStock = (int)((equipment.getDamagedStock() != null ? equipment.getDamagedStock() : 0) + order.getQuantity());
            equipment.setDamagedStock((long)Math.min(damagedStock, equipment.getTotalStock()));
        }
        equipment.setUpdateTime(now);
        eqEquipmentMapper.updateEqEquipment(equipment);

        order.setOrderStatus("3");
        order.setReturnStatus(returnStatus != null ? returnStatus : "2");
        order.setActualReturnTime(DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, now));
        order.setUpdateTime(now);

        int result = resOrderMapper.updateResOrder(order);
        deleteOrderCache(orderId);
        return result;
    }

    @Override
    public int cancelOrder(Long orderId)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            throw new RuntimeException("订单不存在");
        }
        if (!"0".equals(order.getOrderStatus()))
        {
            throw new RuntimeException("只有待审批的订单可以取消");
        }

        Long currentUserId = SecurityUtils.getUserId();
        if (!currentUserId.equals(order.getUserId()))
        {
            throw new RuntimeException("只能取消自己的订单");
        }

        order.setOrderStatus("5");
        order.setReturnStatus("4");
        order.setUpdateTime(DateUtils.getNowDate());
        int result = resOrderMapper.updateResOrder(order);

        // 释放已预占的时间槽
        releaseOrderSlots(order);

        deleteOrderCache(orderId);
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int initiateReturn(Long orderId)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            throw new RuntimeException("订单不存在");
        }
        if (!"1".equals(order.getOrderStatus()))
        {
            throw new RuntimeException("当前订单状态不允许发起归还");
        }

        Long currentUserId = SecurityUtils.getUserId();
        if (!currentUserId.equals(order.getUserId()))
        {
            throw new RuntimeException("只能归还自己的订单");
        }

        Date now = DateUtils.getNowDate();

        order.setOrderStatus("6");
        order.setReturnStatus("1");
        order.setUpdateTime(now);
        resOrderMapper.updateResOrder(order);
        deleteOrderCache(orderId);

        EqEquipment equipment = eqEquipmentMapper.selectEqEquipmentByEquipmentId(order.getEquipmentId());
        if ("1".equals(equipment.getTrackUnit()))
        {
            String assignedUnitCodes = order.getAssignedUnitCodes();
            if (assignedUnitCodes != null && !assignedUnitCodes.isEmpty())
            {
                List<String> codes = Arrays.asList(assignedUnitCodes.split(","));
                for (String code : codes)
                {
                    String trimmedCode = code.trim();
                    EqEquipmentUnit queryParam = new EqEquipmentUnit();
                    queryParam.setEquipmentId(order.getEquipmentId());
                    queryParam.setUnitCode(trimmedCode);
                    List<EqEquipmentUnit> units = eqEquipmentUnitMapper.selectEqEquipmentUnitList(queryParam);
                    if (!units.isEmpty())
                    {
                        EqEquipmentUnit unit = units.get(0);
                        unit.setReturnStatus("1");
                        unit.setUpdateTime(now);
                        eqEquipmentUnitMapper.updateEqEquipmentUnit(unit);
                    }
                }
            }
        }

        try
        {
            String adminContent = "用户 <b>{0}</b>（{1}）已发起设备归还申请。<br>订单号：{2}<br>设备：{3}<br>请前往【预约单管理】进行核验归还。";
            adminContent = java.text.MessageFormat.format(adminContent, order.getRealName(), order.getPhone(), order.getOrderNo(), order.getEquipmentName());
            createAdminNotice("待核验 - " + order.getRealName() + " 归还 " + order.getEquipmentName(), adminContent);
            String plainAdminContent = "用户 " + order.getRealName() + "（" + (order.getPhone() != null ? order.getPhone() : "") + "）已发起设备归还申请。订单号：" + order.getOrderNo() + "，设备：" + order.getEquipmentName() + "。请前往【预约单管理】进行核验归还。";
            sysMsgService.sendMsgToRole("admin", "return", "待核验归还", plainAdminContent, orderId);
        }
        catch (Exception e)
        {
            // 通知发送失败不影响主流程
        }

        return 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int verifyReturn(Long orderId, List<Map<String, Object>> verifyDetails)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            throw new RuntimeException("订单不存在");
        }
        if (!"6".equals(order.getOrderStatus()))
        {
            throw new RuntimeException("当前订单状态不允许核验归还");
        }

        Date now = DateUtils.getNowDate();
        EqEquipment equipment = eqEquipmentMapper.selectEqEquipmentByEquipmentId(order.getEquipmentId());

        List<ReturnDetail> allDetails = new ArrayList<>();
        int totalNormalReturned = 0;
        int totalDamageReturned = 0;

        if ("1".equals(equipment.getTrackUnit()))
        {
            String assignedUnitCodes = order.getAssignedUnitCodes();
            if (assignedUnitCodes == null || assignedUnitCodes.isEmpty())
            {
                throw new RuntimeException("订单未分配设备单元");
            }

            Set<String> verifiedCodes = new HashSet<>();
            for (Map<String, Object> detail : verifyDetails)
            {
                String unitCode = (String) detail.get("unitCode");
                if (unitCode == null || verifiedCodes.contains(unitCode))
                {
                    continue;
                }
                verifiedCodes.add(unitCode);

                String returnStatus = detail.get("returnStatus") != null ? detail.get("returnStatus").toString() : "2";
                String damageRemark = detail.get("damageRemark") != null ? detail.get("damageRemark").toString() : "";

                if ("3".equals(returnStatus) && (damageRemark == null || damageRemark.trim().isEmpty()))
                {
                    throw new RuntimeException("损坏归还时，损坏备注不能为空");
                }

                EqEquipmentUnit queryParam = new EqEquipmentUnit();
                queryParam.setEquipmentId(order.getEquipmentId());
                queryParam.setUnitCode(unitCode.trim());
                List<EqEquipmentUnit> units = eqEquipmentUnitMapper.selectEqEquipmentUnitList(queryParam);

                if (!units.isEmpty())
                {
                    EqEquipmentUnit unit = units.get(0);
                    unit.setActualReturnTime(now);
                    unit.setReturnStatus(returnStatus);
                    unit.setUpdateTime(now);
                    if ("3".equals(returnStatus))
                    {
                        unit.setDamageRemark(damageRemark);
                        unit.setStatus("2");
                        eqEquipmentUnitMapper.updateEqEquipmentUnit(unit);
                        totalDamageReturned++;
                    }
                    else
                    {
                        eqEquipmentUnitMapper.clearBorrowInfoByUnitId(unit);
                        totalNormalReturned++;
                    }

                    ReturnDetail rd = new ReturnDetail();
                    rd.setOrderId(orderId);
                    rd.setEquipmentId(order.getEquipmentId());
                    rd.setUnitId(unit.getUnitId());
                    rd.setUnitCode(unitCode);
                    rd.setReturnStatus(returnStatus);
                    rd.setDamageRemark(damageRemark);
                    rd.setReturnQuantity("2".equals(returnStatus) ? 1 : 0);
                    rd.setDamageQuantity("3".equals(returnStatus) ? 1 : 0);
                    rd.setCreateTime(now);
                    allDetails.add(rd);
                }
            }
        }
        else
        {
            for (Map<String, Object> detail : verifyDetails)
            {
                int normalQty = detail.get("returnQuantity") != null ? Integer.parseInt(detail.get("returnQuantity").toString()) : 0;
                int damageQty = detail.get("damageQuantity") != null ? Integer.parseInt(detail.get("damageQuantity").toString()) : 0;
                String damageRemark = detail.get("damageRemark") != null ? detail.get("damageRemark").toString() : "";

                if (damageQty > 0 && (damageRemark == null || damageRemark.trim().isEmpty()))
                {
                    throw new RuntimeException("损坏数量大于0时，损坏备注不能为空");
                }

                int previouslyReturned = 0;
                List<ReturnDetail> existingDetails = returnDetailMapper.selectReturnDetailByOrderId(orderId);
                for (ReturnDetail ed : existingDetails)
                {
                    previouslyReturned += (ed.getReturnQuantity() != null ? ed.getReturnQuantity() : 0)
                            + (ed.getDamageQuantity() != null ? ed.getDamageQuantity() : 0);
                }

                if (normalQty + damageQty > order.getQuantity() - previouslyReturned)
                {
                    throw new RuntimeException("归还数量超过预约数量");
                }

                totalNormalReturned += normalQty;
                totalDamageReturned += damageQty;

                ReturnDetail rd = new ReturnDetail();
                rd.setOrderId(orderId);
                rd.setEquipmentId(order.getEquipmentId());
                rd.setReturnQuantity(normalQty);
                rd.setDamageQuantity(damageQty);
                rd.setReturnStatus(damageQty > 0 ? "3" : "2");
                rd.setDamageRemark(damageRemark);
                rd.setCreateTime(now);
                allDetails.add(rd);
            }
        }

        if (!allDetails.isEmpty())
        {
            returnDetailMapper.batchInsertReturnDetail(allDetails);
        }

        List<ReturnDetail> allExistingDetails = returnDetailMapper.selectReturnDetailByOrderId(orderId);

        int totalVerified = 0;
        if ("1".equals(equipment.getTrackUnit()))
        {
            totalVerified = allExistingDetails.size();
        }
        else
        {
            for (ReturnDetail rd : allExistingDetails)
            {
                totalVerified += (rd.getReturnQuantity() != null ? rd.getReturnQuantity() : 0)
                        + (rd.getDamageQuantity() != null ? rd.getDamageQuantity() : 0);
            }
        }

        boolean allReturned = false;
        if ("1".equals(equipment.getTrackUnit()))
        {
            int totalUnits = order.getAssignedUnitCodes().split(",").length;
            allReturned = totalVerified >= totalUnits;
        }
        else
        {
            allReturned = totalVerified >= order.getQuantity();
        }

        if (allReturned)
        {
            int normalStock = (int)(equipment.getRemainStock() + totalNormalReturned);
            equipment.setRemainStock(Math.min(normalStock, equipment.getTotalStock()));

            long currentDamagedStock = equipment.getDamagedStock() != null ? equipment.getDamagedStock() : 0;
            long newDamagedStock = currentDamagedStock + totalDamageReturned;
            equipment.setDamagedStock(Math.min(newDamagedStock, equipment.getTotalStock()));

            equipment.setUpdateTime(now);
            eqEquipmentMapper.updateEqEquipment(equipment);

            String finalReturnStatus = totalDamageReturned > 0 ? "3" : "2";
            order.setOrderStatus("3");
            order.setReturnStatus(finalReturnStatus);
            order.setActualReturnTime(DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, now));
            order.setUpdateTime(now);
        }
        else
        {
            int normalStock = (int)(equipment.getRemainStock() + totalNormalReturned);
            equipment.setRemainStock(Math.min(normalStock, equipment.getTotalStock()));

            long currentDamagedStock = equipment.getDamagedStock() != null ? equipment.getDamagedStock() : 0;
            long newDamagedStock = currentDamagedStock + totalDamageReturned;
            equipment.setDamagedStock(Math.min(newDamagedStock, equipment.getTotalStock()));

            equipment.setUpdateTime(now);
            eqEquipmentMapper.updateEqEquipment(equipment);

            order.setUpdateTime(now);
        }

        int result = resOrderMapper.updateResOrder(order);

        deleteOrderCache(orderId);

        if (allReturned)
        {
            try
            {
                String returnStatusText = totalDamageReturned > 0 ? "损坏归还" : "正常归还";
                String content = "您的设备归还已核验完成。设备：{0}，归还状态：{1}。感谢您的使用！";
                content = java.text.MessageFormat.format(content, order.getEquipmentName(), returnStatusText);
                sysMsgService.sendMsgToUser(order.getUserId(), "return", "归还核验完成", content, orderId);
            }
            catch (Exception e)
            {
                // 通知发送失败不影响主流程
            }
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> getReturnDetailList(Long orderId)
    {
        List<ReturnDetail> details = returnDetailMapper.selectReturnDetailByOrderId(orderId);
        List<Map<String, Object>> result = new ArrayList<>();
        for (ReturnDetail detail : details)
        {
            Map<String, Object> map = new HashMap<>();
            map.put("detailId", detail.getDetailId());
            map.put("orderId", detail.getOrderId());
            map.put("equipmentId", detail.getEquipmentId());
            map.put("unitId", detail.getUnitId());
            map.put("unitCode", detail.getUnitCode());
            map.put("returnStatus", detail.getReturnStatus());
            map.put("damageRemark", detail.getDamageRemark());
            map.put("returnQuantity", detail.getReturnQuantity());
            map.put("damageQuantity", detail.getDamageQuantity());
            map.put("createTime", detail.getCreateTime());
            result.add(map);
        }
        return result;
    }

    // ==================== 时间槽预占/释放 ====================

    /**
     * 根据订单的时间范围预占时间槽
     * <p>
     * 从 reserveTime 提取日期和起始时间，从 expectReturnTime 提取结束时间，
     * 计算覆盖的时间槽索引列表，通过 Redis Lua 原子脚本进行容量检查与预占。
     *
     * @param order     预约订单
     * @param equipment 设备信息（用于获取单槽最大容量）
     * @return 槽位字符串（如 "2026-06-12:4,5,6,7"），失败时抛异常
     */
    private String preOccupyTimeSlots(ResOrder order, EqEquipment equipment) {
        try {
            // 1. 解析日期和时间
            LocalDate date;
            LocalTime startTime, endTime;

            String reserveTime = order.getReserveTime();
            if (reserveTime != null && reserveTime.contains(" ")) {
                // 格式: "yyyy-MM-dd HH:mm:ss"
                String[] parts = reserveTime.split(" ");
                date = LocalDate.parse(parts[0], DATE_FMT);
                startTime = LocalTime.parse(parts[1].substring(0, 8), TIME_FMT);
            } else if (reserveTime != null) {
                date = LocalDate.parse(reserveTime, DATE_FMT);
                startTime = SlotSegment.DAY_START;
            } else {
                throw new RuntimeException("预约时间不能为空");
            }

            String expectReturn = order.getExpectReturnTime();
            if (expectReturn != null && expectReturn.contains(" ")) {
                String[] parts = expectReturn.split(" ");
                endTime = LocalTime.parse(parts[1].substring(0, 8), TIME_FMT);
            } else {
                endTime = SlotSegment.DAY_END;
            }

            // 2. 计算覆盖的槽位
            List<Integer> coveredSlots = SlotSegment.getCoveredSlots(startTime, endTime);
            if (coveredSlots.isEmpty()) {
                throw new RuntimeException("预约时间不在可预约时段内（" +
                    SlotSegment.DAY_START + "-" + SlotSegment.DAY_END + "）");
            }

            // 3. 确定单槽最大容量（优先取设备总库存）
            int maxCapacity = equipment.getRemainStock() != null
                ? equipment.getRemainStock().intValue()
                : equipment.getTotalStock() != null ? equipment.getTotalStock().intValue() : 999;
            int quantity = order.getQuantity() != null ? order.getQuantity() : 1;

            // 4. 执行时间槽预占（分布式锁 + Lua 原子脚本）
            Long equipmentId = order.getEquipmentId();
            String dateStr = date.format(DATE_FMT);

            boolean success = bookingSlotService.tryOccupySlots(
                equipmentId, dateStr, coveredSlots, quantity, maxCapacity);

            if (!success) {
                throw new RuntimeException("所选时间段设备 '" + equipment.getEquipmentName()
                    + "' 可用数量不足，请选择其他时间段");
            }

            return SlotSegment.toSlotString(date, coveredSlots);

        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("时间槽预占失败: " + e.getMessage(), e);
        }
    }

    /**
     * 释放订单已预占的时间槽
     */
    private void releaseOrderSlots(ResOrder order) {
        try {
            String slotInfo = order.getSlotInfo();
            if (slotInfo == null || slotInfo.isEmpty()) {
                return;
            }
            SlotSegment.SlotRange range = SlotSegment.parseSlotString(slotInfo);
            if (range == null) {
                return;
            }
            int quantity = order.getQuantity() != null ? order.getQuantity() : 1;
            String dateStr = range.date.format(DATE_FMT);

            bookingSlotService.releaseSlots(
                order.getEquipmentId(), dateStr, range.slotIndices, quantity);
        } catch (Exception e) {
            log.error("释放时间槽失败, orderId={}", order.getOrderId(), e);
        }
    }

    // ==================== 缓存辅助方法 ====================

    private void deleteOrderCache(Long orderId) {
        try {
            redisCache.deleteObject(CacheConstants.RES_ORDER_KEY + orderId);
        } catch (Exception e) {
            log.error("删除订单缓存失败, orderId={}", orderId, e);
        }
    }

    /**
     * 每日缓存一致性校验与修复：比对 DB 与 Redis 中的订单数据，若不一致则删除缓存使其下次查询时从 DB 重新加载
     */
    public void repairCacheConsistency() {
        try {
            // 查询所有订单ID
            List<ResOrder> allOrders = resOrderMapper.selectResOrderList(new ResOrder());
            for (ResOrder dbOrder : allOrders) {
                try {
                    String cacheKey = CacheConstants.RES_ORDER_KEY + dbOrder.getOrderId();
                    ResOrder cached = redisCache.getCacheObject(cacheKey);
                    if (cached == null) {
                        continue;
                    }
                    // 对比 version 判断是否一致
                    if (!dbOrder.getVersion().equals(cached.getVersion())) {
                        redisCache.deleteObject(cacheKey);
                        log.info("缓存不一致已修复, orderId={}", dbOrder.getOrderId());
                    }
                } catch (Exception e) {
                    log.error("校验订单缓存失败, orderId={}", dbOrder.getOrderId(), e);
                }
            }
        } catch (Exception e) {
            log.error("缓存一致性校验任务执行失败", e);
        }
    }

    private static final org.slf4j.Logger log =
        org.slf4j.LoggerFactory.getLogger(ResOrderServiceImpl.class);
}
