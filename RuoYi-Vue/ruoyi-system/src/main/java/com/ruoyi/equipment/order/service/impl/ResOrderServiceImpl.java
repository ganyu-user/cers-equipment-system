package com.ruoyi.equipment.order.service.impl;

import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.equipment.order.mapper.ResOrderMapper;
import com.ruoyi.equipment.order.mapper.ReturnDetailMapper;
import com.ruoyi.equipment.order.domain.ResOrder;
import com.ruoyi.equipment.order.domain.ReturnDetail;
import com.ruoyi.equipment.order.service.IResOrderService;
import com.ruoyi.equipment.unit.domain.EqEquipmentUnit;
import com.ruoyi.equipment.unit.mapper.EqEquipmentUnitMapper;
import com.ruoyi.equipment.info.domain.EqEquipment;
import com.ruoyi.equipment.info.mapper.EqEquipmentMapper;
import com.ruoyi.system.service.ISysMsgService;
import com.ruoyi.system.service.ISysNoticeService;
import com.ruoyi.system.domain.SysNotice;

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

    @Override
    public ResOrder selectResOrderById(Long orderId)
    {
        return resOrderMapper.selectResOrderById(orderId);
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
            sysMsgService.sendMsgToRole("admin", "reserve", "待审批预约", adminContent, resOrder.getOrderId());
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
        return resOrderMapper.updateResOrder(resOrder);
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

        return resOrderMapper.updateResOrder(order);
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
        return resOrderMapper.updateResOrder(order);
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
            sysMsgService.sendMsgToRole("admin", "return", "待核验归还", adminContent, orderId);
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
}
