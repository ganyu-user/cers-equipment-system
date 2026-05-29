package com.ruoyi.equipment.order.task;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.equipment.order.domain.ResOrder;
import com.ruoyi.equipment.order.mapper.ResOrderMapper;
import com.ruoyi.system.service.ISysMsgService;
import com.ruoyi.system.service.ISysNoticeService;

@Component
public class OrderMsgTask
{
    @Autowired
    private ResOrderMapper resOrderMapper;

    @Autowired
    private ISysMsgService sysMsgService;

    @Autowired
    private ISysNoticeService sysNoticeService;

    @Scheduled(cron = "0 0/5 * * * ?")
    public void remindBeforeReturn()
    {
        Date now = DateUtils.getNowDate();
        Date fifteenMinLater = new Date(now.getTime() + 15L * 60 * 1000);

        ResOrder query = new ResOrder();
        query.setOrderStatus("1");
        List<ResOrder> usingOrders = resOrderMapper.selectResOrderList(query);

        for (ResOrder order : usingOrders)
        {
            try
            {
                if (order.getExpectReturnTime() != null && !order.getExpectReturnTime().isEmpty())
                {
                    Date expectReturn = DateUtils.parseDate(order.getExpectReturnTime());
                    if (expectReturn != null && expectReturn.after(now) && !expectReturn.after(fifteenMinLater))
                    {
                        String content = "温馨提示：您预约的设备（{0}）将于15分钟后（{1}）到期，请及时归还。";
                        content = java.text.MessageFormat.format(content, order.getEquipmentName(), order.getExpectReturnTime());
                        sysMsgService.sendMsgToUser(order.getUserId(), "return", "即将到期提醒", content, order.getOrderId());
                    }
                }
            }
            catch (Exception e)
            {
                // ignore
            }
        }
    }

    @Scheduled(cron = "0 0 8,18 * * ?")
    public void checkAndUrgeOverdue()
    {
        Date now = DateUtils.getNowDate();
        ResOrder query = new ResOrder();
        query.setOrderStatus("1");
        List<ResOrder> usingOrders = resOrderMapper.selectResOrderList(query);

        for (ResOrder order : usingOrders)
        {
            try
            {
                if (order.getExpectReturnTime() != null && !order.getExpectReturnTime().isEmpty())
                {
                    Date expectReturn = DateUtils.parseDate(order.getExpectReturnTime());
                    if (expectReturn != null && now.after(expectReturn))
                    {
                        order.setOrderStatus("4");
                        order.setUpdateTime(now);
                        resOrderMapper.updateResOrder(order);

                        String content = "您的预约设备（{0}）已逾期未归还！请尽快归还，否则将影响后续预约权限。";
                        content = java.text.MessageFormat.format(content, order.getEquipmentName());
                        sysMsgService.sendMsgToUser(order.getUserId(), "overdue", "逾期催还", content, order.getOrderId());
                    }
                }
            }
            catch (Exception e)
            {
                // ignore
            }
        }
    }

    public int urgeReturn(Long orderId)
    {
        ResOrder order = resOrderMapper.selectResOrderById(orderId);
        if (order == null)
        {
            return 0;
        }

        try
        {
            String content = "管理员提醒您：您预约的设备（{0}）已超期未归还，订单号：{1}，请尽快归还设备！";
            content = java.text.MessageFormat.format(content, order.getEquipmentName(), order.getOrderNo());
            sysMsgService.sendMsgToUser(order.getUserId(), "overdue", "管理员催还提醒", content, orderId);
            return 1;
        }
        catch (Exception e)
        {
            return 0;
        }
    }
}