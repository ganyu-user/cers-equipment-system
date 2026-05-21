-- =============================================
-- 归还流程升级 - 数据库迁移脚本
-- 执行前请备份数据库
-- =============================================

-- 1. 安全添加列（自包含，不依赖外部存储过程）
SET @col_exists = (
  SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'eq_equipment'
    AND COLUMN_NAME = 'damaged_stock'
);

SET @sql_add_col = IF(@col_exists = 0,
  'ALTER TABLE `eq_equipment` ADD COLUMN `damaged_stock` INT(11) DEFAULT 0 COMMENT ''损坏库存数量''',
  'SELECT ''damaged_stock 已存在，跳过'' AS msg'
);

PREPARE stmt_add_col FROM @sql_add_col;
EXECUTE stmt_add_col;
DEALLOCATE PREPARE stmt_add_col;

-- 2. 创建归还明细表
DROP TABLE IF EXISTS `res_return_detail`;
CREATE TABLE `res_return_detail` (
  `detail_id`          BIGINT(20)    NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id`           BIGINT(20)    NOT NULL COMMENT '预约单ID',
  `equipment_id`       BIGINT(20)    NOT NULL COMMENT '设备ID',
  `unit_id`            BIGINT(20)    DEFAULT NULL COMMENT '设备单元ID（可追踪设备）',
  `unit_code`          VARCHAR(50)   DEFAULT '' COMMENT '设备编号（可追踪设备）',
  `return_status`      CHAR(1)       DEFAULT '2' COMMENT '归还状态（2=正常归还 3=损坏归还）',
  `damage_remark`      VARCHAR(500)  DEFAULT '' COMMENT '损坏备注',
  `return_quantity`    INT(11)       DEFAULT 0 COMMENT '本次归还数量（不可追踪设备）',
  `damage_quantity`    INT(11)       DEFAULT 0 COMMENT '损坏数量（不可追踪设备）',
  `create_time`        DATETIME      DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`detail_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_equipment_id` (`equipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='归还核验明细表';

-- 3. 更新预约状态字典 (res_order_status)
UPDATE sys_dict_data SET dict_label = '待审批' WHERE dict_type = 'res_order_status' AND dict_value = '0';
UPDATE sys_dict_data SET dict_label = '使用中' WHERE dict_type = 'res_order_status' AND dict_value = '1';
UPDATE sys_dict_data SET dict_label = '已拒绝' WHERE dict_type = 'res_order_status' AND dict_value = '2';
UPDATE sys_dict_data SET dict_label = '已归还' WHERE dict_type = 'res_order_status' AND dict_value = '3';
UPDATE sys_dict_data SET dict_label = '已逾期' WHERE dict_type = 'res_order_status' AND dict_value = '4';
UPDATE sys_dict_data SET dict_label = '已取消' WHERE dict_type = 'res_order_status' AND dict_value = '5';

INSERT IGNORE INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time) VALUES
(7, '待归还核验', '6', 'res_order_status', '', 'warning', 'N', '0', 'admin', NOW());

-- 4. 更新归还状态字典 (eq_return_status) - 先迁移已有数据再更新字典
UPDATE eq_equipment_unit SET return_status = '2' WHERE return_status = '1';
UPDATE eq_equipment_unit SET return_status = '3' WHERE return_status = '2';
UPDATE res_order SET return_status = '2' WHERE return_status = '1';
UPDATE res_order SET return_status = '3' WHERE return_status = '2';

DELETE FROM sys_dict_data WHERE dict_type = 'eq_return_status';

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time) VALUES
(1, '未归还',   '0', 'eq_return_status', '', 'default', 'N', '0', 'admin', NOW()),
(2, '待核验',   '1', 'eq_return_status', '', 'warning', 'N', '0', 'admin', NOW()),
(3, '正常归还', '2', 'eq_return_status', '', 'success', 'N', '0', 'admin', NOW()),
(4, '损坏归还', '3', 'eq_return_status', '', 'danger',  'N', '0', 'admin', NOW()),
(5, '无需归还', '4', 'eq_return_status', '', 'info',    'N', '0', 'admin', NOW());

-- 5. 预约状态数据迁移（如有旧数据）
UPDATE res_order SET order_status = '1' WHERE order_status = '4';
UPDATE res_order SET order_status = '3' WHERE order_status = '5';
UPDATE res_order SET order_status = '5' WHERE order_status = '3';
