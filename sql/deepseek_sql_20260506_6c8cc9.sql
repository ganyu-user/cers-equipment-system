CREATE TABLE `res_extend_log` (
  `log_id`                    bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `order_id`                  bigint(20)    NOT NULL COMMENT '关联预约单ID',
  `old_expect_return_time`    datetime      NOT NULL COMMENT '原预计归还时间',
  `new_expect_return_time`    datetime      NOT NULL COMMENT '申请延期后的时间',
  `reason`                    varchar(255)  DEFAULT '' COMMENT '申请原因',
  `status`                    char(1)       DEFAULT '0' COMMENT '审批状态（0待审批 1通过 2拒绝）',
  `audit_remark`              varchar(255)  DEFAULT '' COMMENT '审批意见',
  `create_time`               datetime      DEFAULT NULL COMMENT '申请时间',
  `update_time`               datetime      DEFAULT NULL COMMENT '审批时间',
  PRIMARY KEY (`log_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='延期申请记录表';