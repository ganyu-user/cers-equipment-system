-- =============================================
-- 辅助修复脚本 2：assigned_unit_codes 扩容
-- 执行前请备份数据库
-- =============================================

-- 修复 assigned_unit_codes VARCHAR(500) 容量不足（50个编号轻松超500字符）
ALTER TABLE `res_order` MODIFY COLUMN `assigned_unit_codes` TEXT COMMENT '分配的设备编号列表';
