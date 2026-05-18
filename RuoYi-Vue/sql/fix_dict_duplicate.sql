-- =============================================
-- 修复 res_order_status / eq_return_status 字典重复值
-- 两个状态问题的根因：旧字典行 + INSERT IGNORE 新行 共存
-- =============================================

-- 1. 清理 res_order_status（先删后插，确保一行一值）
DELETE FROM sys_dict_data WHERE dict_type = 'res_order_status' AND dict_value IN ('0','1','2','3','4','5');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time) VALUES
(1, '待审核', '0', 'res_order_status', '', 'info',    'N', '0', 'admin', NOW()),
(2, '已通过', '1', 'res_order_status', '', 'success', 'N', '0', 'admin', NOW()),
(3, '已拒绝', '2', 'res_order_status', '', 'danger',  'N', '0', 'admin', NOW()),
(4, '已取消', '3', 'res_order_status', '', 'warning', 'N', '0', 'admin', NOW()),
(5, '使用中', '4', 'res_order_status', '', 'primary', 'N', '0', 'admin', NOW()),
(6, '已归还', '5', 'res_order_status', '', 'success', 'N', '0', 'admin', NOW());

-- 2. 清理 eq_return_status（同样防止重复）
DELETE FROM sys_dict_data WHERE dict_type = 'eq_return_status' AND dict_value IN ('0','1','2');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time) VALUES
(1, '未归还',   '0', 'eq_return_status', '', 'default', 'N', '0', 'admin', NOW()),
(2, '正常归还', '1', 'eq_return_status', '', 'success', 'N', '0', 'admin', NOW()),
(3, '损坏归还', '2', 'eq_return_status', '', 'danger',  'N', '0', 'admin', NOW());
