package com.ruoyi.equipment.order.mapper;

import java.util.List;
import com.ruoyi.equipment.order.domain.ReturnDetail;

public interface ReturnDetailMapper
{
    public List<ReturnDetail> selectReturnDetailByOrderId(Long orderId);

    public int insertReturnDetail(ReturnDetail returnDetail);

    public int batchInsertReturnDetail(List<ReturnDetail> detailList);

    public int deleteReturnDetailByOrderId(Long orderId);
}
