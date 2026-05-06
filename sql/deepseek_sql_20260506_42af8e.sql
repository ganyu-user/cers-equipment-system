CREATE TABLE `sys_user_profile` (
  `profile_id`   bigint(20)    NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id`      bigint(20)    NOT NULL COMMENT '用户ID（关联sys_user）',
  `student_no`   varchar(30)   DEFAULT '' COMMENT '学号/工号',
  `grade`        varchar(20)   DEFAULT '' COMMENT '年级',
  `major`        varchar(50)   DEFAULT '' COMMENT '专业',
  `real_name`    varchar(30)   DEFAULT '' COMMENT '真实姓名（冗余，方便查询）',
  `phone`        varchar(20)   DEFAULT '' COMMENT '手机号（冗余）',
  `create_by`    varchar(64)   DEFAULT '' COMMENT '创建者',
  `create_time`  datetime      DEFAULT NULL COMMENT '创建时间',
  `update_by`    varchar(64)   DEFAULT '' COMMENT '更新者',
  `update_time`  datetime      DEFAULT NULL COMMENT '更新时间',
  `remark`       varchar(500)  DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  KEY `idx_student_no` (`student_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户扩展信息表';