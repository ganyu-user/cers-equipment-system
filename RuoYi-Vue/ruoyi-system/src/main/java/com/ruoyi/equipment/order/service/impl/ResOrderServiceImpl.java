package com.ruoyi.equipment.order.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.equipment.order.mapper.ResOrderMapper;
import com.ruoyi.equipment.order.domain.ResOrder;
import com.ruoyi.equipment.order.service.IResOrderService;
import com.ruoyi.equipment.unit.domain.EqEquipmentUnit;
import com.ruoyi.equipment.unit.mapper.EqEquipmentUnitMapper;
import com.ruoyi.equipment.info.domain.EqEquipment;
import com.ruoyi.equipment.info.mapper.EqEquipmentMapper;

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

        return resOrderMapper.insertResOrder(resOrder);
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

        int remainingStock = (int)(equipment.getRemainStock() - order.getQuantity());
        equipment.setRemainStock((long)Math.max(remainingStock, 0));
        equipment.setUpdateTime(now);
        eqEquipmentMapper.updateEqEquipment(equipment);

        order.setOrderStatus("4");
        order.setApproverId(approverId);
        order.setApproverName(approverName);
        order.setApproveTime(approveTime);
        order.setUpdateTime(now);

        return resOrderMapper.updateResOrder(order);
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
        order.setApproverId(approverId);
        order.setApproverName(approverName);
        order.setApproveTime(approveTime);
        order.setRejectReason(rejectReason);
        order.setUpdateTime(now);

        return resOrderMapper.updateResOrder(order);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int returnOrder(Long orderId, String returnStatus, String damageRemark)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            throw new RuntimeException("订单不存在");
        }
        if (!"4".equals(order.getOrderStatus()))
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
                        unit.setStatus("0");
                        unit.setBorrowerId(null);
                        unit.setBorrowerName(null);
                        unit.setBorrowOrderId(null);
                        unit.setBorrowTime(null);
                        unit.setExpectedReturnTime(null);
                        unit.setActualReturnTime(now);
                        unit.setReturnStatus(returnStatus != null ? returnStatus : "1");
                        unit.setDamageRemark(damageRemark);
                        unit.setUpdateTime(now);
                        eqEquipmentUnitMapper.updateEqEquipmentUnit(unit);
                    }
                }
            }
        }

        int restoredStock = (int)(equipment.getRemainStock() + order.getQuantity());
        equipment.setRemainStock(Math.min(restoredStock, equipment.getTotalStock()));
        equipment.setUpdateTime(now);
        eqEquipmentMapper.updateEqEquipment(equipment);

        order.setOrderStatus("5");
        order.setReturnStatus(returnStatus != null ? returnStatus : "1");
        order.setUpdateTime(now);

        return resOrderMapper.updateResOrder(order);
    }
}