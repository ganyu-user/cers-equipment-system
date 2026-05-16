-- =============================================
-- 设备单元追踪系统 - 数据库迁移脚本
-- 执行前请备份数据库
-- =============================================

-- 1. 创建设备单元表
DROP TABLE IF EXISTS `eq_equipment_unit`;
CREATE TABLE `eq_equipment_unit` (
  `unit_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '单元ID',
  `equipment_id` BIGINT NOT NULL COMMENT '所属设备ID',
  `unit_code` VARCHAR(50) NOT NULL COMMENT '设备编号（如：示波器-001）',
  `status` CHAR(1) DEFAULT '0' COMMENT '状态 (0=在库 1=借出 2=维修 3=报废)',
  `borrower_id` BIGINT DEFAULT NULL COMMENT '当前借用人ID',
  `borrower_name` VARCHAR(64) DEFAULT NULL COMMENT '当前借用人姓名',
  `borrow_order_id` BIGINT DEFAULT NULL COMMENT '当前借用订单ID',
  `borrow_time` DATETIME DEFAULT NULL COMMENT '借出时间',
  `expected_return_time` DATETIME DEFAULT NULL COMMENT '预计归还时间',
  `actual_return_time` DATETIME DEFAULT NULL COMMENT '实际归还时间',
  `return_status` CHAR(1) DEFAULT '0' COMMENT '归还状态 (0=未归还 1=正常归还 2=损坏归还)',
  `damage_remark` VARCHAR(500) DEFAULT NULL COMMENT '损坏备注',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`unit_id`),
  UNIQUE KEY `uk_equip_code` (`equipment_id`, `unit_code`),
  KEY `idx_equipment_id` (`equipment_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设备单元表';

-- 2. 通用：安全添加列（列存在则跳过）
DELIMITER $$
DROP PROCEDURE IF EXISTS `add_column_if_not_exists`$$
CREATE PROCEDURE `add_column_if_not_exists`(
    IN tableName VARCHAR(128),
    IN columnName VARCHAR(128),
    IN columnDef  VARCHAR(1024)
)
BEGIN
    DECLARE col_count INT DEFAULT 0;
    SELECT COUNT(*) INTO col_count
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = tableName
      AND COLUMN_NAME  = columnName;
    IF col_count = 0 THEN
        SET @sql = CONCAT('ALTER TABLE `', tableName, '` ADD COLUMN `', columnName, '` ', columnDef);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$
DELIMITER ;

-- 3. eq_equipment 新增字段
CALL add_column_if_not_exists('eq_equipment', 'track_unit',        "CHAR(1) DEFAULT '0' COMMENT '是否追踪单台设备 (0=否 1=是)'");
CALL add_column_if_not_exists('eq_equipment', 'unit_code_prefix',  "VARCHAR(30) DEFAULT NULL COMMENT '编号前缀'");

-- 4. res_order 新增字段
CALL add_column_if_not_exists('res_order', 'assigned_unit_codes', "VARCHAR(500) DEFAULT NULL COMMENT '分配的设备编号列表'");
CALL add_column_if_not_exists('res_order', 'approver_id',         "BIGINT DEFAULT NULL COMMENT '审批人ID'");
CALL add_column_if_not_exists('res_order', 'approver_name',       "VARCHAR(64) DEFAULT NULL COMMENT '审批人姓名'");
CALL add_column_if_not_exists('res_order', 'approve_time',        "DATETIME DEFAULT NULL COMMENT '审批时间'");
CALL add_column_if_not_exists('res_order', 'reject_reason',       "VARCHAR(500) DEFAULT NULL COMMENT '拒绝原因'");
CALL add_column_if_not_exists('res_order', 'return_status',       "CHAR(1) DEFAULT '0' COMMENT '归还状态'");

-- 5. 新增字典类型 - 设备单元状态
INSERT IGNORE INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time) 
VALUES ('设备单元状态', 'eq_unit_status', '0', 'admin', NOW());

INSERT IGNORE INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time) VALUES
(1, '在库', '0', 'eq_unit_status', '', 'primary', 'N', '0', 'admin', NOW()),
(2, '借出', '1', 'eq_unit_status', '', 'warning', 'N', '0', 'admin', NOW()),
(3, '维修', '2', 'eq_unit_status', '', 'danger', 'N', '0', 'admin', NOW()),
(4, '报废', '3', 'eq_unit_status', '', 'info', 'N', '0', 'admin', NOW());

-- 6. 新增字典类型 - 归还状态
INSERT IGNORE INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time) 
VALUES ('归还状态', 'eq_return_status', '0', 'admin', NOW());

INSERT IGNORE INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time) VALUES
(1, '未归还', '0', 'eq_return_status', '', 'default', 'N', '0', 'admin', NOW()),
(2, '正常归还', '1', 'eq_return_status', '', 'success', 'N', '0', 'admin', NOW()),
(3, '损坏归还', '2', 'eq_return_status', '', 'danger', 'N', '0', 'admin', NOW());

-- 7. 更新 res_order_status 字典（若已有请忽略）
UPDATE sys_dict_data SET dict_label = '待审核' WHERE dict_type = 'res_order_status' AND dict_value = '0';
UPDATE sys_dict_data SET dict_label = '已通过' WHERE dict_type = 'res_order_status' AND dict_value = '1';
UPDATE sys_dict_data SET dict_label = '已拒绝' WHERE dict_type = 'res_order_status' AND dict_value = '2';
UPDATE sys_dict_data SET dict_label = '已取消' WHERE dict_type = 'res_order_status' AND dict_value = '3';

INSERT IGNORE INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time) VALUES
(5, '使用中', '4', 'res_order_status', '', 'primary', 'N', '0', 'admin', NOW()),
(6, '已归还', '5', 'res_order_status', '', 'success', 'N', '0', 'admin', NOW());