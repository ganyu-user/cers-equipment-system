/*
 Navicat Premium Data Transfer

 Source Server         : Local-MySQL
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : campus_equipment_reservation

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 12/06/2026 14:40:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for eq_category
-- ----------------------------
DROP TABLE IF EXISTS `eq_category`;
CREATE TABLE `eq_category`  (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父分类ID（0为顶级）',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `sort` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eq_category
-- ----------------------------
INSERT INTO `eq_category` VALUES (1, '物理设备', 0, '0', 1, '0', '', NULL, '', NULL, '物理实验相关设备');
INSERT INTO `eq_category` VALUES (2, '化学设备', 0, '0', 2, '0', '', NULL, '', NULL, '化学实验相关设备');
INSERT INTO `eq_category` VALUES (3, '电子电气设备', 0, '0', 3, '0', '', NULL, '', NULL, '电子、电气、电路类设备');
INSERT INTO `eq_category` VALUES (4, '计算机设备', 0, '0', 4, '0', '', NULL, '', NULL, '计算机、服务器、网络设备');
INSERT INTO `eq_category` VALUES (5, '机械加工设备', 0, '0', 5, '0', '', NULL, '', NULL, '机械、数控、加工设备');
INSERT INTO `eq_category` VALUES (6, '土木建筑设备', 0, '0', 6, '0', '', NULL, '', NULL, '土木、测量、建材设备');
INSERT INTO `eq_category` VALUES (7, '体育器材', 0, '0', 7, '0', '', NULL, '', NULL, '体育教学、训练器材');
INSERT INTO `eq_category` VALUES (8, '通识教学设备', 0, '0', 8, '0', '', NULL, '', NULL, '公共课、多媒体、通用设备');
INSERT INTO `eq_category` VALUES (9, '其他设备', 0, '0', 99, '0', '', NULL, '', NULL, '未分类设备');
INSERT INTO `eq_category` VALUES (10, '力学设备', 1, '0,1', 1, '0', '', NULL, '', NULL, '运动、摩擦、杠杆、重力设备');
INSERT INTO `eq_category` VALUES (11, '热学设备', 1, '0,1', 2, '0', '', NULL, '', NULL, '温度、热量、气体实验设备');
INSERT INTO `eq_category` VALUES (12, '电磁学设备', 1, '0,1', 3, '0', '', NULL, '', NULL, '电场、磁场、电路实验设备');
INSERT INTO `eq_category` VALUES (13, '光学设备', 1, '0,1', 4, '0', '', NULL, '', NULL, '激光、透镜、光谱、成像设备');
INSERT INTO `eq_category` VALUES (14, '近代物理设备', 1, '0,1', 5, '0', '', NULL, '', NULL, '原子、核物理、真空、微波设备');
INSERT INTO `eq_category` VALUES (15, '无机化学设备', 2, '0,2', 1, '0', '', NULL, '', NULL, '无机反应、滴定设备');
INSERT INTO `eq_category` VALUES (16, '有机化学设备', 2, '0,2', 2, '0', '', NULL, '', NULL, '有机合成、蒸馏设备');
INSERT INTO `eq_category` VALUES (17, '分析化学设备', 2, '0,2', 3, '0', '', NULL, '', NULL, '天平、色谱、光谱、pH计');
INSERT INTO `eq_category` VALUES (18, '环境化学设备', 2, '0,2', 4, '0', '', NULL, '', NULL, '水质、大气、土壤检测设备');
INSERT INTO `eq_category` VALUES (19, '化学安全设备', 2, '0,2', 9, '0', '', NULL, '', NULL, '通风橱、防爆、防护、废液处理');
INSERT INTO `eq_category` VALUES (20, '基础电子器件', 3, '0,3', 1, '0', '', NULL, '', NULL, '电阻、电容、电感、二极管、三极管');
INSERT INTO `eq_category` VALUES (21, '实验箱/开发板', 3, '0,3', 2, '0', '', NULL, '', NULL, '模电、数电、单片机、嵌入式实验箱');
INSERT INTO `eq_category` VALUES (22, '测量仪器', 3, '0,3', 3, '0', '', NULL, '', NULL, '示波器、信号源、电源、万用表');
INSERT INTO `eq_category` VALUES (23, '电气控制设备', 3, '0,3', 4, '0', '', NULL, '', NULL, 'PLC、变频器、继电器、电机设备');
INSERT INTO `eq_category` VALUES (24, '通信设备', 3, '0,3', 5, '0', '', NULL, '', NULL, '光纤、射频、无线通信实验设备');
INSERT INTO `eq_category` VALUES (25, 'PC计算机', 4, '0,4', 1, '0', '', NULL, '', NULL, '台式机、一体机、笔记本');
INSERT INTO `eq_category` VALUES (26, '服务器设备', 4, '0,4', 2, '0', '', NULL, '', NULL, '机架服务器、塔式服务器');
INSERT INTO `eq_category` VALUES (27, '网络设备', 4, '0,4', 3, '0', '', NULL, '', NULL, '交换机、路由器、防火墙、AP');
INSERT INTO `eq_category` VALUES (28, '存储设备', 4, '0,4', 4, '0', '', NULL, '', NULL, '硬盘、U盘、移动硬盘、阵列');
INSERT INTO `eq_category` VALUES (29, '外设设备', 4, '0,4', 5, '0', '', NULL, '', NULL, '打印机、扫描仪、投影仪、摄像头');
INSERT INTO `eq_category` VALUES (30, '机床设备', 5, '0,5', 1, '0', '', NULL, '', NULL, '车床、铣床、磨床、钻床');
INSERT INTO `eq_category` VALUES (31, '数控设备', 5, '0,5', 2, '0', '', NULL, '', NULL, 'CNC、加工中心、雕刻机');
INSERT INTO `eq_category` VALUES (32, '钳工工具', 5, '0,5', 3, '0', '', NULL, '', NULL, '台虎钳、锉刀、扳手、量具');
INSERT INTO `eq_category` VALUES (33, '3D打印设备', 5, '0,5', 4, '0', '', NULL, '', NULL, 'FDM、SLA 3D打印机、耗材');
INSERT INTO `eq_category` VALUES (34, '测量设备', 6, '0,6', 1, '0', '', NULL, '', NULL, '全站仪、水准仪、经纬仪、测距仪');
INSERT INTO `eq_category` VALUES (35, '建材实验设备', 6, '0,6', 2, '0', '', NULL, '', NULL, '压力机、水泥、混凝土、砂浆设备');
INSERT INTO `eq_category` VALUES (36, '土木模型设备', 6, '0,6', 3, '0', '', NULL, '', NULL, '结构模型、BIM、测绘配套设备');
INSERT INTO `eq_category` VALUES (37, '球类器材', 7, '0,7', 1, '0', '', NULL, '', NULL, '篮球、足球、排球、羽毛球、乒乓球');
INSERT INTO `eq_category` VALUES (38, '田径器材', 7, '0,7', 2, '0', '', NULL, '', NULL, '秒表、发令枪、跨栏、跳高架、铅球');
INSERT INTO `eq_category` VALUES (39, '健身器材', 7, '0,7', 3, '0', '', NULL, '', NULL, '哑铃、杠铃、跑步机、综合训练器');
INSERT INTO `eq_category` VALUES (40, '武术体操器材', 7, '0,7', 4, '0', '', NULL, '', NULL, '垫子、单杠、双杠、武术器械');
INSERT INTO `eq_category` VALUES (41, '多媒体设备', 8, '0,8', 1, '0', '', NULL, '', NULL, '智慧黑板、音响、功放、麦克风');
INSERT INTO `eq_category` VALUES (42, '办公设备', 8, '0,8', 2, '0', '', NULL, '', NULL, '桌椅、讲台、储物柜、白板');
INSERT INTO `eq_category` VALUES (43, '实验室通用设备', 8, '0,8', 3, '0', '', NULL, '', NULL, '实验台、试剂架、工具、耗材');
INSERT INTO `eq_category` VALUES (44, '备品备件', 9, '0,9', 1, '0', '', NULL, '', NULL, '备用零件、耗材、配件');
INSERT INTO `eq_category` VALUES (45, '报废待处理', 9, '0,9', 99, '1', '', NULL, '', NULL, '已报废、待处置设备');

-- ----------------------------
-- Table structure for eq_equipment
-- ----------------------------
DROP TABLE IF EXISTS `eq_equipment`;
CREATE TABLE `eq_equipment`  (
  `equipment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `equipment_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备名称',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '设备图片URL',
  `total_stock` int NULL DEFAULT 0 COMMENT '设备总库存',
  `remain_stock` int NULL DEFAULT 0 COMMENT '剩余可用数量',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '维修状态（0正常 1维修中）',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '存放地点',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '设备描述/备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0正常 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `track_unit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '是否追踪单台设备 (0=否 1=是)',
  `unit_code_prefix` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编号前缀',
  `damaged_stock` int NULL DEFAULT 0 COMMENT '损坏库存数量',
  PRIMARY KEY (`equipment_id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eq_equipment
-- ----------------------------
INSERT INTO `eq_equipment` VALUES (1, '1', 1, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/94bc0dc666f34cc4993f0b7165a5a677.png', 111, NULL, '0', NULL, NULL, '2', NULL, '2026-05-08 00:35:44', NULL, NULL, NULL, '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (2, '2', 3, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/d99a71f93ccf46d1ba417b7491f6cc58.png', 10, NULL, '1', '11', '1111', '2', NULL, '2026-05-08 00:37:19', NULL, NULL, '1111', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (3, '1', 6, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/3f1cceaeb73743eaa9efe3a549a956ca.png', 20, NULL, '1', '201', NULL, '2', NULL, '2026-05-08 15:56:26', NULL, NULL, NULL, '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (4, 'test1', 7, NULL, 10, 10, '1', NULL, NULL, '2', 'admin', '2026-05-08 16:08:17', NULL, NULL, NULL, '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (5, '电阻包', 20, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/8c85c877fd6447eb9fb65a3496558dc4.png', 100, 100, '0', '电子实验室401', '各种阻值电阻', '0', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-29 23:44:34', '电子实验专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (6, '模电实验箱', 21, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/515171478c5f4f5e870f136a5be71885.png', 20, 20, '0', '电子实验室401', '模拟电路实验', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-21 23:36:36', '电子实验专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (7, '台式计算机', 25, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/5bbf7506fdc3451d8c636319c4b698c5.png', 60, 60, '0', '计算机房501', 'i5/16G/512G台式机', '0', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-28 23:35:58', '计算机教学专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (8, '千兆交换机', 27, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 20, 20, '0', '网络机房503', '24口千兆交换机', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '网络设备专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (9, '普通车床', 30, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 5, 5, '0', '机械车间701', '教学用普通车床', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-21 23:51:40', '机械加工专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (10, 'FDM3D打印机', 33, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 10, 10, '0', '创新实验室704', '熔融沉积3D打印机', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '3D打印专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (11, '全站仪', 34, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 8, 8, '0', '土木实验室801', '工程测量全站仪', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-21 23:26:45', '土木测量专用', '0', '示波器-01', 0);
INSERT INTO `eq_equipment` VALUES (12, '篮球', 37, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/487031bfcac14a79bb0e10ddea7b3254.png', 50, 48, '0', '体育馆901', '标准7号篮球', '0', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-27 18:03:00', '体育教学专用', '0', NULL, 2);
INSERT INTO `eq_equipment` VALUES (13, '哑铃套装', 39, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/5d41574b6e8d4c7f9c01f7c8d747f03b.png', 40, 40, '0', '健身室903', '1-10kg哑铃', '0', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-29 23:40:38', '健身训练专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (14, '智慧黑板', 41, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 20, 20, '0', '教学楼1001', '交互式智慧黑板', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-21 16:12:18', '通识教学专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (15, '学生课桌椅', 42, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 200, 200, '0', '教学楼1002', '标准课桌椅', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '办公教学专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (16, '实验台', 43, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 40, 40, '0', '各实验室1101', '学生实验操作台', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '实验室通用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (17, '电子元件备件', 44, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 200, 200, '0', '备件库1201', '电阻电容等备件', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '备品备件专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (18, '直流电源', 12, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 20, 20, '0', '物理实验室103', '0-30V可调直流电源', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '电磁学实验专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (19, '通风橱', 19, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 8, 8, '0', '化学实验室204', '实验废气排放', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '化学安全防护专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (20, '数字示波器', 22, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png', 15, 15, '0', '电子实验室402', '100MHz数字示波器', '2', 'admin', '2026-05-07 00:00:00', 'admin', '2026-05-07 00:00:00', '电子测量专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (21, 'test--设备单元管理测试', 6, NULL, 100, 100, '0', '201', NULL, '2', 'admin', '2026-05-16 23:33:14', NULL, '2026-05-21 23:17:20', NULL, '0', 'test-001', 7);
INSERT INTO `eq_equipment` VALUES (22, '模电实验箱', 21, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/b6d61315a7b3405aa52b925d5ee0316a.png', 70, 70, '0', '电子实验室401', '模拟电路实验', '0', 'admin', '2026-05-21 23:46:09', NULL, NULL, '电子实验专用', '1', '模电实验箱-01', NULL);
INSERT INTO `eq_equipment` VALUES (23, '千兆交换机', 27, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/7492014fec8d4fc0a313e4b424a3b834.png', 60, 55, '0', '网络机房503', '24口千兆交换机', '0', 'admin', '2026-05-21 23:49:48', NULL, '2026-05-22 00:20:10', '网络设备专用', '1', '千兆交换机-01', NULL);
INSERT INTO `eq_equipment` VALUES (24, '普通车床', 30, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/e32bb55adc23491cb6e2c004a518ac7f.png', 5, 5, '0', '机械与汽车工程学院--机械车间104', '教学用普通车床', '0', 'admin', '2026-05-21 23:54:41', NULL, NULL, '机械加工专用', '1', '普通车床', NULL);
INSERT INTO `eq_equipment` VALUES (25, 'FAM3D打印机', 33, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/aeb97cbc33a644a995e18989448d89d3.png', 15, 15, '0', '实训中心--创新实验室301', '熔融沉积3D打印机\n', '0', 'admin', '2026-05-21 23:57:16', NULL, NULL, '3D打印专用', '1', 'FDM3D打印机', NULL);
INSERT INTO `eq_equipment` VALUES (26, '全站仪', 34, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/8379182dd0ff4091890ced5c4b22a446.png', 8, 8, '0', '机械与汽车学院--土木实验室204', '工程测量全站仪', '0', 'admin', '2026-05-21 23:59:20', NULL, NULL, '工程测量专用', '1', '全站仪', NULL);
INSERT INTO `eq_equipment` VALUES (27, '智慧黑板', 41, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/318ffb25d0594d0cbe1bafcf44ed2e33.png', 20, 20, '0', '第一教学楼--设备房104', '交互式智慧黑板', '0', 'admin', '2026-05-22 00:05:43', NULL, NULL, '通识教学专用', '1', '智慧黑板', NULL);
INSERT INTO `eq_equipment` VALUES (28, '学生课桌椅', 42, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/0c54b01f09d34f0d981d160c2f4be9a0.png', 200, 200, '0', '第一教学楼--设备房105、第二教学楼---设备房间102', '标准课桌椅', '0', 'admin', '2026-05-22 00:07:16', NULL, NULL, '办公教学专用', '0', NULL, NULL);
INSERT INTO `eq_equipment` VALUES (29, '实验台', 43, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/06e06ec2673c4c038d82c6d56b195b6c.png', 40, 40, '0', '生命科学院--104、环境与化学工程学院--207', '学生实验操作台', '0', 'admin', '2026-05-22 00:09:46', NULL, NULL, '实验室备用', '1', '实验台', NULL);
INSERT INTO `eq_equipment` VALUES (30, '电子元件备件', 44, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/bd693daf858e4b4394be70a76577f13f.png', 200, 200, '0', '实训中心--备件库307', '电阻电容等备件', '0', 'admin', '2026-05-22 00:12:10', NULL, NULL, '备品备件专用', '0', NULL, NULL);
INSERT INTO `eq_equipment` VALUES (31, '直流电源', 12, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/b9328b9967ef4ac18eda2e5169a5d6c1.png', 120, 120, '0', '物理实验室103', '0-30V可调直流电源', '0', 'admin', '2026-05-22 00:13:56', NULL, '2026-05-30 00:22:44', '电磁学实验专用', '0', NULL, 0);
INSERT INTO `eq_equipment` VALUES (32, '数字示波器', 22, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/a06b33bba23744b7889ca454ca3e67a2.png', 20, 20, '0', '电子实验室402', '100MHz数字示波器', '0', 'admin', '2026-05-22 00:15:50', NULL, NULL, '电子测量专用', '1', '数字示波器', NULL);
INSERT INTO `eq_equipment` VALUES (33, '足球', 37, 'https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/23658c8decc0414ea598200bb5a030c3.png', 200, 200, '0', '体育馆--102', '标准足球', '0', 'admin', '2026-05-22 00:17:16', NULL, NULL, '足球', '0', NULL, NULL);

-- ----------------------------
-- Table structure for eq_equipment_unit
-- ----------------------------
DROP TABLE IF EXISTS `eq_equipment_unit`;
CREATE TABLE `eq_equipment_unit`  (
  `unit_id` bigint NOT NULL AUTO_INCREMENT COMMENT '单元ID',
  `equipment_id` bigint NOT NULL COMMENT '所属设备ID',
  `unit_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备编号（如：示波器-001）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态 (0=在库 1=借出 2=维修 3=报废)',
  `borrower_id` bigint NULL DEFAULT NULL COMMENT '当前借用人ID',
  `borrower_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '当前借用人姓名',
  `borrow_order_id` bigint NULL DEFAULT NULL COMMENT '当前借用订单ID',
  `borrow_time` datetime NULL DEFAULT NULL COMMENT '借出时间',
  `expected_return_time` datetime NULL DEFAULT NULL COMMENT '预计归还时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '实际归还时间',
  `return_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '归还状态 (0=未归还 1=正常归还 2=损坏归还)',
  `damage_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '损坏备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`unit_id`) USING BTREE,
  UNIQUE INDEX `uk_equip_code`(`equipment_id` ASC, `unit_code` ASC) USING BTREE,
  INDEX `idx_equipment_id`(`equipment_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 339 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备单元表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eq_equipment_unit
-- ----------------------------
INSERT INTO `eq_equipment_unit` VALUES (101, 22, '模电实验箱-01-001', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (102, 22, '模电实验箱-01-002', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (103, 22, '模电实验箱-01-003', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (104, 22, '模电实验箱-01-004', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (105, 22, '模电实验箱-01-005', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (106, 22, '模电实验箱-01-006', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (107, 22, '模电实验箱-01-007', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (108, 22, '模电实验箱-01-008', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (109, 22, '模电实验箱-01-009', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (110, 22, '模电实验箱-01-010', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (111, 22, '模电实验箱-01-011', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (112, 22, '模电实验箱-01-012', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (113, 22, '模电实验箱-01-013', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (114, 22, '模电实验箱-01-014', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (115, 22, '模电实验箱-01-015', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (116, 22, '模电实验箱-01-016', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (117, 22, '模电实验箱-01-017', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (118, 22, '模电实验箱-01-018', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (119, 22, '模电实验箱-01-019', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (120, 22, '模电实验箱-01-020', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (121, 22, '模电实验箱-01-021', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (122, 22, '模电实验箱-01-022', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (123, 22, '模电实验箱-01-023', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (124, 22, '模电实验箱-01-024', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (125, 22, '模电实验箱-01-025', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (126, 22, '模电实验箱-01-026', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (127, 22, '模电实验箱-01-027', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (128, 22, '模电实验箱-01-028', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (129, 22, '模电实验箱-01-029', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (130, 22, '模电实验箱-01-030', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (131, 22, '模电实验箱-01-031', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (132, 22, '模电实验箱-01-032', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (133, 22, '模电实验箱-01-033', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (134, 22, '模电实验箱-01-034', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (135, 22, '模电实验箱-01-035', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (136, 22, '模电实验箱-01-036', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (137, 22, '模电实验箱-01-037', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (138, 22, '模电实验箱-01-038', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (139, 22, '模电实验箱-01-039', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (140, 22, '模电实验箱-01-040', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (141, 22, '模电实验箱-01-041', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (142, 22, '模电实验箱-01-042', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (143, 22, '模电实验箱-01-043', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (144, 22, '模电实验箱-01-044', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (145, 22, '模电实验箱-01-045', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (146, 22, '模电实验箱-01-046', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (147, 22, '模电实验箱-01-047', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (148, 22, '模电实验箱-01-048', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (149, 22, '模电实验箱-01-049', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (150, 22, '模电实验箱-01-050', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (151, 22, '模电实验箱-01-051', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (152, 22, '模电实验箱-01-052', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (153, 22, '模电实验箱-01-053', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (154, 22, '模电实验箱-01-054', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (155, 22, '模电实验箱-01-055', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (156, 22, '模电实验箱-01-056', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (157, 22, '模电实验箱-01-057', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (158, 22, '模电实验箱-01-058', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (159, 22, '模电实验箱-01-059', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (160, 22, '模电实验箱-01-060', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (161, 22, '模电实验箱-01-061', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (162, 22, '模电实验箱-01-062', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (163, 22, '模电实验箱-01-063', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (164, 22, '模电实验箱-01-064', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (165, 22, '模电实验箱-01-065', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (166, 22, '模电实验箱-01-066', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (167, 22, '模电实验箱-01-067', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (168, 22, '模电实验箱-01-068', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (169, 22, '模电实验箱-01-069', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (170, 22, '模电实验箱-01-070', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:46:09', '2026-05-21 23:46:09');
INSERT INTO `eq_equipment_unit` VALUES (171, 23, '千兆交换机-01-001', '1', 1, NULL, 19, '2026-05-22 00:20:10', '2026-05-22 12:00:00', NULL, '1', NULL, '2026-05-21 23:49:48', '2026-06-12 10:54:56');
INSERT INTO `eq_equipment_unit` VALUES (172, 23, '千兆交换机-01-002', '1', 1, NULL, 19, '2026-05-22 00:20:10', '2026-05-22 12:00:00', NULL, '1', NULL, '2026-05-21 23:49:48', '2026-06-12 10:54:56');
INSERT INTO `eq_equipment_unit` VALUES (173, 23, '千兆交换机-01-003', '1', 1, NULL, 19, '2026-05-22 00:20:10', '2026-05-22 12:00:00', NULL, '1', NULL, '2026-05-21 23:49:48', '2026-06-12 10:54:56');
INSERT INTO `eq_equipment_unit` VALUES (174, 23, '千兆交换机-01-004', '1', 1, NULL, 19, '2026-05-22 00:20:10', '2026-05-22 12:00:00', NULL, '1', NULL, '2026-05-21 23:49:48', '2026-06-12 10:54:56');
INSERT INTO `eq_equipment_unit` VALUES (175, 23, '千兆交换机-01-005', '1', 1, NULL, 19, '2026-05-22 00:20:10', '2026-05-22 12:00:00', NULL, '1', NULL, '2026-05-21 23:49:48', '2026-06-12 10:54:56');
INSERT INTO `eq_equipment_unit` VALUES (176, 23, '千兆交换机-01-006', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (177, 23, '千兆交换机-01-007', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (178, 23, '千兆交换机-01-008', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (179, 23, '千兆交换机-01-009', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (180, 23, '千兆交换机-01-010', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (181, 23, '千兆交换机-01-011', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (182, 23, '千兆交换机-01-012', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (183, 23, '千兆交换机-01-013', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (184, 23, '千兆交换机-01-014', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (185, 23, '千兆交换机-01-015', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (186, 23, '千兆交换机-01-016', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (187, 23, '千兆交换机-01-017', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (188, 23, '千兆交换机-01-018', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (189, 23, '千兆交换机-01-019', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (190, 23, '千兆交换机-01-020', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (191, 23, '千兆交换机-01-021', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (192, 23, '千兆交换机-01-022', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (193, 23, '千兆交换机-01-023', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (194, 23, '千兆交换机-01-024', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (195, 23, '千兆交换机-01-025', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (196, 23, '千兆交换机-01-026', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (197, 23, '千兆交换机-01-027', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (198, 23, '千兆交换机-01-028', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (199, 23, '千兆交换机-01-029', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (200, 23, '千兆交换机-01-030', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (201, 23, '千兆交换机-01-031', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (202, 23, '千兆交换机-01-032', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (203, 23, '千兆交换机-01-033', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (204, 23, '千兆交换机-01-034', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (205, 23, '千兆交换机-01-035', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (206, 23, '千兆交换机-01-036', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (207, 23, '千兆交换机-01-037', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (208, 23, '千兆交换机-01-038', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (209, 23, '千兆交换机-01-039', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (210, 23, '千兆交换机-01-040', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (211, 23, '千兆交换机-01-041', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (212, 23, '千兆交换机-01-042', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (213, 23, '千兆交换机-01-043', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (214, 23, '千兆交换机-01-044', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (215, 23, '千兆交换机-01-045', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (216, 23, '千兆交换机-01-046', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (217, 23, '千兆交换机-01-047', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (218, 23, '千兆交换机-01-048', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (219, 23, '千兆交换机-01-049', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (220, 23, '千兆交换机-01-050', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (221, 23, '千兆交换机-01-051', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (222, 23, '千兆交换机-01-052', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (223, 23, '千兆交换机-01-053', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (224, 23, '千兆交换机-01-054', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (225, 23, '千兆交换机-01-055', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (226, 23, '千兆交换机-01-056', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (227, 23, '千兆交换机-01-057', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (228, 23, '千兆交换机-01-058', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (229, 23, '千兆交换机-01-059', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (230, 23, '千兆交换机-01-060', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:49:48', '2026-05-21 23:49:47');
INSERT INTO `eq_equipment_unit` VALUES (231, 24, '普通车床-001', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:54:41', '2026-05-21 23:54:40');
INSERT INTO `eq_equipment_unit` VALUES (232, 24, '普通车床-002', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:54:41', '2026-05-21 23:54:40');
INSERT INTO `eq_equipment_unit` VALUES (233, 24, '普通车床-003', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:54:41', '2026-05-21 23:54:40');
INSERT INTO `eq_equipment_unit` VALUES (234, 24, '普通车床-004', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:54:41', '2026-05-21 23:54:40');
INSERT INTO `eq_equipment_unit` VALUES (235, 24, '普通车床-005', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:54:41', '2026-05-21 23:54:40');
INSERT INTO `eq_equipment_unit` VALUES (236, 25, 'FDM3D打印机-001', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (237, 25, 'FDM3D打印机-002', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (238, 25, 'FDM3D打印机-003', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (239, 25, 'FDM3D打印机-004', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (240, 25, 'FDM3D打印机-005', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (241, 25, 'FDM3D打印机-006', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (242, 25, 'FDM3D打印机-007', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (243, 25, 'FDM3D打印机-008', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (244, 25, 'FDM3D打印机-009', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (245, 25, 'FDM3D打印机-010', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (246, 25, 'FDM3D打印机-011', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (247, 25, 'FDM3D打印机-012', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (248, 25, 'FDM3D打印机-013', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (249, 25, 'FDM3D打印机-014', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (250, 25, 'FDM3D打印机-015', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:57:16', '2026-05-21 23:57:16');
INSERT INTO `eq_equipment_unit` VALUES (251, 26, '全站仪-001', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (252, 26, '全站仪-002', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (253, 26, '全站仪-003', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (254, 26, '全站仪-004', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (255, 26, '全站仪-005', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (256, 26, '全站仪-006', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (257, 26, '全站仪-007', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (258, 26, '全站仪-008', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-21 23:59:20', '2026-05-21 23:59:20');
INSERT INTO `eq_equipment_unit` VALUES (259, 27, '智慧黑板-001', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (260, 27, '智慧黑板-002', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (261, 27, '智慧黑板-003', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (262, 27, '智慧黑板-004', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (263, 27, '智慧黑板-005', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (264, 27, '智慧黑板-006', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (265, 27, '智慧黑板-007', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (266, 27, '智慧黑板-008', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (267, 27, '智慧黑板-009', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (268, 27, '智慧黑板-010', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (269, 27, '智慧黑板-011', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (270, 27, '智慧黑板-012', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (271, 27, '智慧黑板-013', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (272, 27, '智慧黑板-014', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (273, 27, '智慧黑板-015', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (274, 27, '智慧黑板-016', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (275, 27, '智慧黑板-017', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (276, 27, '智慧黑板-018', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (277, 27, '智慧黑板-019', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (278, 27, '智慧黑板-020', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:05:43', '2026-05-22 00:05:43');
INSERT INTO `eq_equipment_unit` VALUES (279, 29, '实验台-001', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (280, 29, '实验台-002', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (281, 29, '实验台-003', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (282, 29, '实验台-004', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (283, 29, '实验台-005', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (284, 29, '实验台-006', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (285, 29, '实验台-007', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (286, 29, '实验台-008', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (287, 29, '实验台-009', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (288, 29, '实验台-010', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (289, 29, '实验台-011', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (290, 29, '实验台-012', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (291, 29, '实验台-013', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (292, 29, '实验台-014', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (293, 29, '实验台-015', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (294, 29, '实验台-016', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (295, 29, '实验台-017', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (296, 29, '实验台-018', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (297, 29, '实验台-019', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (298, 29, '实验台-020', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (299, 29, '实验台-021', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (300, 29, '实验台-022', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (301, 29, '实验台-023', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (302, 29, '实验台-024', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (303, 29, '实验台-025', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (304, 29, '实验台-026', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (305, 29, '实验台-027', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (306, 29, '实验台-028', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (307, 29, '实验台-029', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (308, 29, '实验台-030', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (309, 29, '实验台-031', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (310, 29, '实验台-032', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (311, 29, '实验台-033', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (312, 29, '实验台-034', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (313, 29, '实验台-035', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (314, 29, '实验台-036', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (315, 29, '实验台-037', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (316, 29, '实验台-038', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (317, 29, '实验台-039', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (318, 29, '实验台-040', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:09:46', '2026-05-22 00:09:46');
INSERT INTO `eq_equipment_unit` VALUES (319, 32, '数字示波器-001', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (320, 32, '数字示波器-002', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (321, 32, '数字示波器-003', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (322, 32, '数字示波器-004', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (323, 32, '数字示波器-005', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (324, 32, '数字示波器-006', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (325, 32, '数字示波器-007', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (326, 32, '数字示波器-008', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (327, 32, '数字示波器-009', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (328, 32, '数字示波器-010', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (329, 32, '数字示波器-011', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (330, 32, '数字示波器-012', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (331, 32, '数字示波器-013', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (332, 32, '数字示波器-014', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (333, 32, '数字示波器-015', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (334, 32, '数字示波器-016', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (335, 32, '数字示波器-017', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (336, 32, '数字示波器-018', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (337, 32, '数字示波器-019', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');
INSERT INTO `eq_equipment_unit` VALUES (338, 32, '数字示波器-020', '0', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2026-05-22 00:15:50', '2026-05-22 00:15:50');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'eq_category', '设备分类表', '', '', 'EqCategory', 'tree', 'element-plus', 'com.ruoyi.equipment', 'system', 'category', '设备分类', 'ganyu', 1, '0', '/', '{\"genView\":\"0\",\"treeCode\":\"category_id\",\"treeName\":\"category_name\",\"treeParentCode\":\"parent_id\"}', 'admin', '2026-05-06 16:24:01', '', '2026-05-06 16:51:37', NULL);
INSERT INTO `gen_table` VALUES (2, 'eq_equipment', '设备表', NULL, NULL, 'EqEquipment', 'crud', 'element-plus', 'com.ruoyi.system', 'system', 'equipment', '设备', 'ganyu', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":0}', 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44', '设备信息');
INSERT INTO `gen_table` VALUES (3, 'res_order', '设备预约单表', NULL, NULL, 'ResOrder', 'crud', 'element-plus', 'com.ruoyi.system', 'system', 'reserveOrder', '设备预约单管理', 'ganyu', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":0}', 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'category_id', '分类ID', 'bigint', 'Long', 'categoryId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-06 16:24:01', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (2, 1, 'category_name', '分类名称', 'varchar(50)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (3, 1, 'parent_id', '父分类ID（0为顶级）', 'bigint', 'Long', 'parentId', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'input', '', 3, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (4, 1, 'ancestors', '祖级列表', 'varchar(500)', 'String', 'ancestors', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'textarea', '', 4, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (5, 1, 'sort', '显示顺序', 'int', 'Long', 'sort', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (6, 1, 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', 'sys_normal_disable', 6, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'input', '', 7, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (8, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (9, 1, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', '0', NULL, 'EQ', 'input', '', 9, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (10, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', '0', NULL, 'EQ', 'datetime', '', 10, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (11, 1, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 11, 'admin', '2026-05-06 16:24:02', '', '2026-05-06 16:51:37');
INSERT INTO `gen_table_column` VALUES (12, 2, 'equipment_id', '设备ID', 'bigint', 'Long', 'equipmentId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (13, 2, 'equipment_name', '设备名称', 'varchar(100)', 'String', 'equipmentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (14, 2, 'category_id', '分类ID', 'bigint', 'Long', 'categoryId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (15, 2, 'image', '设备图片URL', 'varchar(255)', 'String', 'image', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'imageUpload', '', 4, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (16, 2, 'total_stock', '设备总库存', 'int', 'Long', 'totalStock', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (17, 2, 'remain_stock', '剩余可用数量', 'int', 'Long', 'remainStock', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 6, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (18, 2, 'status', '维修状态（0正常 1维修中）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'eq_equipment_status', 7, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (19, 2, 'location', '存放地点', 'varchar(200)', 'String', 'location', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 8, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (20, 2, 'description', '设备描述/备注', 'text', 'String', 'description', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'textarea', '', 9, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (21, 2, 'del_flag', '删除标志（0正常 2删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (22, 2, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (23, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (24, 2, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (25, 2, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (26, 2, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 15, 'admin', '2026-05-06 18:16:08', '', '2026-05-06 18:37:44');
INSERT INTO `gen_table_column` VALUES (27, 3, 'order_id', '预约单ID', 'bigint', 'Long', 'orderId', '1', '1', '0', '0', NULL, '1', '1', 'EQ', 'input', '', 1, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (28, 3, 'user_id', '预约用户ID', 'bigint', 'Long', 'userId', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 2, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (29, 3, 'equip_id', '设备ID', 'bigint', 'Long', 'equipId', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 3, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (30, 3, 'quantity', '预约数量', 'int', 'Long', 'quantity', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 4, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (31, 3, 'real_name', '预约人姓名', 'varchar(30)', 'String', 'realName', '0', '0', '0', '0', '0', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (32, 3, 'student_no', '学号', 'varchar(30)', 'String', 'studentNo', '0', '0', '0', '0', '0', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (33, 3, 'grade', '年级', 'varchar(20)', 'String', 'grade', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 7, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (34, 3, 'major', '专业', 'varchar(50)', 'String', 'major', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 8, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (35, 3, 'phone', '手机号', 'varchar(20)', 'String', 'phone', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 9, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (36, 3, 'reserve_time', '预约开始时间', 'datetime', 'Date', 'reserveTime', '0', '0', '0', '0', '0', '1', '1', 'BETWEEN', 'datetime', '', 10, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (37, 3, 'expect_return_time', '预计归还时间', 'datetime', 'Date', 'expectReturnTime', '0', '0', '0', '0', '0', '1', '1', 'BETWEEN', 'datetime', '', 11, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (38, 3, 'actual_return_time', '实际归还时间', 'datetime', 'Date', 'actualReturnTime', '0', '0', '0', '0', '0', '1', '1', 'BETWEEN', 'datetime', '', 12, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (39, 3, 'order_status', '预约状态（0待审批 1审批通过/使用中 2审批拒绝 3已归还 4已逾期 5已取消）', 'char(2)', 'String', 'orderStatus', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'radio', 'res_order_status', 13, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (40, 3, 'reject_reason', '拒绝理由', 'varchar(255)', 'String', 'rejectReason', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 14, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (41, 3, 'pickup_location', '领取地点', 'varchar(200)', 'String', 'pickupLocation', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 15, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (42, 3, 'pickup_time', '领取时间（审批通过时填入）', 'datetime', 'Date', 'pickupTime', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'datetime', '', 16, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (43, 3, 'extend_status', '延期状态（0未申请 1延期审批中 2延期通过 3延期拒绝）', 'char(1)', 'String', 'extendStatus', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'radio', 'res_extend_status', 17, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (44, 3, 'extend_expect_return_time', '延期后的预计归还时间', 'datetime', 'Date', 'extendExpectReturnTime', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'datetime', '', 18, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (45, 3, 'extend_reason', '延期原因/审批意见', 'varchar(255)', 'String', 'extendReason', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 19, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:56');
INSERT INTO `gen_table_column` VALUES (46, 3, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, '1', 'BETWEEN', 'datetime', '', 20, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:57');
INSERT INTO `gen_table_column` VALUES (47, 3, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 21, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:57');
INSERT INTO `gen_table_column` VALUES (48, 3, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 22, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:57');
INSERT INTO `gen_table_column` VALUES (49, 3, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'textarea', '', 23, 'admin', '2026-05-06 23:53:55', '', '2026-05-07 00:07:57');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for res_extend_log
-- ----------------------------
DROP TABLE IF EXISTS `res_extend_log`;
CREATE TABLE `res_extend_log`  (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `order_id` bigint NOT NULL COMMENT '关联预约单ID',
  `old_expect_return_time` datetime NOT NULL COMMENT '原预计归还时间',
  `new_expect_return_time` datetime NOT NULL COMMENT '申请延期后的时间',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '申请原因',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '审批状态（0待审批 1通过 2拒绝）',
  `audit_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '审批意见',
  `create_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '延期申请记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of res_extend_log
-- ----------------------------

-- ----------------------------
-- Table structure for res_order
-- ----------------------------
DROP TABLE IF EXISTS `res_order`;
CREATE TABLE `res_order`  (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '预约单ID',
  `user_id` bigint NOT NULL COMMENT '预约用户ID',
  `equip_id` bigint NOT NULL COMMENT '设备ID',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '预约数量',
  `real_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '预约人姓名',
  `student_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '学号',
  `grade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '年级',
  `major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '专业',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号',
  `reserve_time` datetime NOT NULL COMMENT '预约开始时间',
  `expect_return_time` datetime NOT NULL COMMENT '预计归还时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '实际归还时间',
  `order_status` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '预约状态（0待审批 1审批通过/使用中 2审批拒绝 3已归还 4已逾期 5已取消）',
  `reject_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '拒绝理由',
  `pickup_location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '领取地点',
  `pickup_time` datetime NULL DEFAULT NULL COMMENT '领取时间（审批通过时填入）',
  `extend_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '延期状态（0未申请 1延期审批中 2延期通过 3延期拒绝）',
  `extend_expect_return_time` datetime NULL DEFAULT NULL COMMENT '延期后的预计归还时间',
  `extend_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '延期原因/审批意见',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int NOT NULL DEFAULT 1 COMMENT '乐观锁版本号',
  `assigned_unit_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '分配的设备编号列表',
  `approver_id` bigint NULL DEFAULT NULL COMMENT '审批人ID',
  `approver_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批人姓名',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `return_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '归还状态',
  `slot_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预约时间槽信息（如 2026-06-12:4,5,6,7）',
  `order_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '订单编号',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_equip_id`(`equip_id` ASC) USING BTREE,
  INDEX `idx_order_status`(`order_status` ASC) USING BTREE,
  INDEX `idx_reserve_time`(`reserve_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备预约单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of res_order
-- ----------------------------
INSERT INTO `res_order` VALUES (10, 1, 12, 5, '甘宇', '202324111213', '23级', '计算机科学与技术', '13760095982', '2026-05-21 14:00:00', '2026-05-21 16:00:00', '2026-05-21 18:00:21', '3', '', '', NULL, '0', NULL, '', 'admin', '2026-05-21 17:56:33', '', '2026-05-21 18:00:22', '今天归还', 1, NULL, 1, 'admin', '2026-05-21 17:59:29', '3', NULL, '');
INSERT INTO `res_order` VALUES (17, 100, 12, 1, '黎明', '202324111216', '23级物联网1班', '物联网', '13760090003', '2026-05-21 16:00:00', '2026-05-22 14:00:00', NULL, '1', '', '', NULL, '0', NULL, '', 'test', '2026-05-21 19:42:28', '', '2026-05-21 19:43:10', '', 1, NULL, 1, 'admin', '2026-05-21 19:43:10', '0', NULL, '');
INSERT INTO `res_order` VALUES (18, 1, 11, 2, '甘宇', '202324111213', '23级计科2班', '计算机科学与技术', '13760095982', '2026-05-21 23:00:00', '2026-05-22 03:00:00', NULL, '5', '', '', NULL, '0', NULL, '', 'admin', '2026-05-21 23:26:50', '', '2026-05-21 23:27:18', '', 1, NULL, NULL, NULL, NULL, '4', NULL, '');
INSERT INTO `res_order` VALUES (19, 1, 23, 5, '刘德华', '202324111219', '23级通信工程1班', '通信工程', '13760090007', '2026-05-22 09:00:00', '2026-05-22 12:00:00', NULL, '6', '', '', NULL, '0', NULL, '', 'admin', '2026-05-22 00:19:51', '', '2026-06-12 10:54:56', '网络课使用', 1, '千兆交换机-01-001,千兆交换机-01-002,千兆交换机-01-003,千兆交换机-01-004,千兆交换机-01-005', 1, 'admin', '2026-05-22 00:20:09', '1', NULL, '');
INSERT INTO `res_order` VALUES (20, 101, 12, 5, 'ganyu', '202324111213', '23级计科2班', '计算机科学与技术', '13760095982', '2026-05-22 14:00:00', '2026-05-22 17:00:00', '2026-05-27 18:02:59', '3', '', '', NULL, '0', NULL, '', 'ganyu', '2026-05-22 18:58:27', '', '2026-05-27 18:03:00', '当天归还', 1, NULL, 1, 'admin', '2026-05-22 18:59:26', '2', NULL, 'RES20260522185826932635');
INSERT INTO `res_order` VALUES (21, 102, 7, 5, '张学友', '202324111201', '23级计科2班', '计算机科学与技术', '13760090001', '2026-05-28 14:00:00', '2026-05-30 13:00:00', '2026-05-28 23:35:57', '3', '', '', NULL, '0', NULL, '', 'zhangxueyou', '2026-05-28 14:35:08', '', '2026-05-28 23:35:58', '', 1, NULL, 1, 'admin', '2026-05-28 23:30:06', '2', NULL, 'RES20260528143507698891');
INSERT INTO `res_order` VALUES (22, 102, 5, 1, '张学友', '202324111201', '23级计科2班', '计算机科学与技术', '13760090001', '2026-05-28 13:00:00', '2026-05-28 15:00:00', '2026-05-29 23:16:09', '3', '', '', NULL, '0', NULL, '', 'zhangxueyou', '2026-05-28 23:41:27', '', '2026-05-29 23:16:10', '', 1, NULL, 1, 'admin', '2026-05-28 23:50:18', '2', NULL, 'RES20260528234127025571');
INSERT INTO `res_order` VALUES (23, 101, 5, 1, '甘宇', '202324111213', '23计科2班', '计算机科学与技术', '13760095982', '2026-05-28 07:00:00', '2026-05-28 15:00:00', NULL, '2', '设备准备全部更新，暂停预约', '', NULL, '0', NULL, '', 'ganyu', '2026-05-28 23:59:38', '', '2026-05-29 00:00:21', '', 1, NULL, 1, 'admin', '2026-05-29 00:00:20', '4', NULL, 'RES20260528235938298667');
INSERT INTO `res_order` VALUES (24, 102, 13, 1, '张学友', '202324111201', '23级计科2班', '计算机科学与技术', '13760090001', '2026-05-29 13:00:00', '2026-05-29 22:00:00', '2026-05-29 23:40:38', '3', '', '', NULL, '0', NULL, '', 'zhangxueyou', '2026-05-29 23:21:01', '', '2026-05-29 23:40:38', '', 1, NULL, 1, 'admin', '2026-05-29 23:36:49', '2', NULL, 'RES20260529232100530743');
INSERT INTO `res_order` VALUES (25, 102, 5, 1, '张学友', '202324111201', '23级计科2班', '计算机科学与技术', '13760090001', '2026-05-29 00:00:00', '2026-05-29 23:00:00', '2026-05-29 23:44:34', '3', '', '', NULL, '0', NULL, '', 'zhangxueyou', '2026-05-29 23:41:49', '', '2026-05-29 23:44:34', '', 1, NULL, 1, 'admin', '2026-05-29 23:42:03', '2', NULL, 'RES20260529234148535347');
INSERT INTO `res_order` VALUES (26, 101, 31, 20, '甘宇', '202324111213', '23级计科2班', '计算机科学与技术', '13760095982', '2026-05-30 00:00:00', '2026-05-31 00:00:00', '2026-05-30 00:22:43', '3', '', '', NULL, '0', NULL, '', 'ganyu', '2026-05-30 00:17:19', '', '2026-05-30 00:22:44', '', 1, NULL, 1, 'admin', '2026-05-30 00:20:42', '2', NULL, 'RES20260530001718793649');
INSERT INTO `res_order` VALUES (27, 1, 7, 1, '甘宇', '202324111213', '23计科2班', '计算机', '13760095982', '2026-06-12 11:00:00', '2026-06-12 16:00:00', NULL, '0', '', '', NULL, '0', NULL, '', 'admin', '2026-06-12 11:19:41', '', NULL, '', 1, NULL, NULL, NULL, NULL, '0', '2026-06-12:6,7,8,9,10,11,12,13,14,15', 'RES20260612111940843936');

-- ----------------------------
-- Table structure for res_return_detail
-- ----------------------------
DROP TABLE IF EXISTS `res_return_detail`;
CREATE TABLE `res_return_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` bigint NOT NULL COMMENT '预约单ID',
  `equipment_id` bigint NOT NULL COMMENT '设备ID',
  `unit_id` bigint NULL DEFAULT NULL COMMENT '设备单元ID（可追踪设备）',
  `unit_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '设备编号（可追踪设备）',
  `return_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '2' COMMENT '归还状态（2=正常归还 3=损坏归还）',
  `damage_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '损坏备注',
  `return_quantity` int NULL DEFAULT 0 COMMENT '本次归还数量（不可追踪设备）',
  `damage_quantity` int NULL DEFAULT 0 COMMENT '损坏数量（不可追踪设备）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_equipment_id`(`equipment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '归还核验明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of res_return_detail
-- ----------------------------
INSERT INTO `res_return_detail` VALUES (1, 7, 21, 1, 'test-001-001', '2', '', 1, 0, '2026-05-21 17:53:00');
INSERT INTO `res_return_detail` VALUES (2, 7, 21, 2, 'test-001-002', '2', '', 1, 0, '2026-05-21 17:53:15');
INSERT INTO `res_return_detail` VALUES (3, 7, 21, 3, 'test-001-003', '2', '', 1, 0, '2026-05-21 17:53:15');
INSERT INTO `res_return_detail` VALUES (4, 7, 21, 4, 'test-001-004', '2', '', 1, 0, '2026-05-21 17:53:15');
INSERT INTO `res_return_detail` VALUES (5, 7, 21, 5, 'test-001-005', '2', '', 1, 0, '2026-05-21 17:53:15');
INSERT INTO `res_return_detail` VALUES (6, 7, 21, 6, 'test-001-006', '2', '', 1, 0, '2026-05-21 17:53:15');
INSERT INTO `res_return_detail` VALUES (7, 7, 21, 7, 'test-001-007', '2', '', 1, 0, '2026-05-21 17:53:15');
INSERT INTO `res_return_detail` VALUES (8, 7, 21, 10, 'test-001-010', '2', '', 1, 0, '2026-05-21 17:53:15');
INSERT INTO `res_return_detail` VALUES (9, 10, 12, NULL, NULL, '3', '一个漏气', 4, 1, '2026-05-21 18:00:22');
INSERT INTO `res_return_detail` VALUES (10, 11, 21, 1, 'test-001-001', '2', '', 1, 0, '2026-05-21 18:22:05');
INSERT INTO `res_return_detail` VALUES (11, 11, 21, 2, 'test-001-002', '2', '', 1, 0, '2026-05-21 18:22:05');
INSERT INTO `res_return_detail` VALUES (12, 7, 21, 11, 'test-001-011', '3', 'test', 0, 1, '2026-05-21 18:41:38');
INSERT INTO `res_return_detail` VALUES (13, 7, 21, 12, 'test-001-012', '2', '', 1, 0, '2026-05-21 18:41:40');
INSERT INTO `res_return_detail` VALUES (14, 13, 21, 1, 'test-001-001', '3', 'test', 0, 1, '2026-05-21 19:20:05');
INSERT INTO `res_return_detail` VALUES (15, 15, 21, 2, 'test-001-002', '3', 'test', 0, 1, '2026-05-21 19:23:46');
INSERT INTO `res_return_detail` VALUES (16, 15, 21, 3, 'test-001-003', '3', 'test', 0, 1, '2026-05-21 19:23:57');
INSERT INTO `res_return_detail` VALUES (17, 15, 21, 4, 'test-001-004', '3', 'test', 0, 1, '2026-05-21 19:24:07');
INSERT INTO `res_return_detail` VALUES (18, 15, 21, 5, 'test-001-005', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (19, 15, 21, 6, 'test-001-006', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (20, 15, 21, 7, 'test-001-007', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (21, 15, 21, 8, 'test-001-008', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (22, 15, 21, 9, 'test-001-009', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (23, 15, 21, 10, 'test-001-010', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (24, 15, 21, 11, 'test-001-011', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (25, 15, 21, 12, 'test-001-012', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (26, 15, 21, 13, 'test-001-013', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (27, 15, 21, 14, 'test-001-014', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (28, 15, 21, 15, 'test-001-015', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (29, 15, 21, 16, 'test-001-016', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (30, 15, 21, 17, 'test-001-017', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (31, 15, 21, 18, 'test-001-018', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (32, 15, 21, 19, 'test-001-019', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (33, 15, 21, 20, 'test-001-020', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (34, 15, 21, 21, 'test-001-021', '2', '', 1, 0, '2026-05-21 19:24:12');
INSERT INTO `res_return_detail` VALUES (35, 16, 21, 5, 'test-001-005', '2', '', 1, 0, '2026-05-21 19:27:02');
INSERT INTO `res_return_detail` VALUES (36, 16, 21, 6, 'test-001-006', '2', '', 1, 0, '2026-05-21 19:27:03');
INSERT INTO `res_return_detail` VALUES (37, 16, 21, 7, 'test-001-007', '2', '', 1, 0, '2026-05-21 19:27:03');
INSERT INTO `res_return_detail` VALUES (38, 16, 21, 8, 'test-001-008', '2', '', 1, 0, '2026-05-21 19:27:04');
INSERT INTO `res_return_detail` VALUES (39, 16, 21, 9, 'test-001-009', '3', 'test', 0, 1, '2026-05-21 19:27:13');
INSERT INTO `res_return_detail` VALUES (40, 16, 21, 10, 'test-001-010', '3', 'test', 0, 1, '2026-05-21 19:27:18');
INSERT INTO `res_return_detail` VALUES (41, 20, 12, NULL, NULL, '2', '', 5, 0, '2026-05-27 18:03:00');
INSERT INTO `res_return_detail` VALUES (42, 21, 7, NULL, NULL, '2', '', 5, 0, '2026-05-28 23:35:58');
INSERT INTO `res_return_detail` VALUES (43, 22, 5, NULL, NULL, '2', '', 1, 0, '2026-05-29 23:16:10');
INSERT INTO `res_return_detail` VALUES (44, 24, 13, NULL, NULL, '2', '', 1, 0, '2026-05-29 23:40:38');
INSERT INTO `res_return_detail` VALUES (45, 25, 5, NULL, NULL, '2', '', 1, 0, '2026-05-29 23:44:34');
INSERT INTO `res_return_detail` VALUES (46, 26, 31, NULL, NULL, '2', '', 20, 0, '2026-05-30 00:22:44');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2026-05-05 22:25:21', 'admin', '2026-05-22 18:13:42', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (9, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-05-05 22:25:21', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');
INSERT INTO `sys_config` VALUES (100, '用户注册', 'sys.account.registerUser', 'true', 'Y', 'admin', '2026-05-22 18:21:13', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 142 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '正常', '0', 'eq_equipment_status', NULL, 'default', 'N', '0', 'admin', '2026-05-06 18:31:09', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 1, '维修中', '1', 'eq_equipment_status', NULL, 'default', 'N', '0', 'admin', '2026-05-06 18:32:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 2, '已报废', '2', 'eq_equipment_status', NULL, 'default', 'N', '0', 'admin', '2026-05-06 18:32:16', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 3, '已借出', '3', 'eq_equipment_status', NULL, 'default', 'N', '0', 'admin', '2026-05-06 18:32:31', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 0, '未申请', '0', 'res_extend_status', NULL, 'default', 'N', '0', 'admin', '2026-05-07 00:05:33', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 1, '延期审批中', '1', 'res_extend_status', NULL, 'default', 'N', '0', 'admin', '2026-05-07 00:05:49', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (112, 2, '延期通过', '2', 'res_extend_status', NULL, 'default', 'N', '0', 'admin', '2026-05-07 00:06:01', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 3, '延期拒绝', '3', 'res_extend_status', NULL, 'default', 'N', '0', 'admin', '2026-05-07 00:06:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (114, 1, '在库', '0', 'eq_unit_status', '', 'primary', 'N', '0', 'admin', '2026-05-16 23:12:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 2, '借出', '1', 'eq_unit_status', '', 'warning', 'N', '0', 'admin', '2026-05-16 23:12:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (116, 3, '维修', '2', 'eq_unit_status', '', 'danger', 'N', '0', 'admin', '2026-05-16 23:12:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (117, 4, '报废', '3', 'eq_unit_status', '', 'info', 'N', '0', 'admin', '2026-05-16 23:12:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (123, 1, '待审批', '0', 'res_order_status', '', 'info', 'N', '0', 'admin', '2026-05-17 17:25:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (124, 2, '使用中', '1', 'res_order_status', '', 'success', 'N', '0', 'admin', '2026-05-17 17:25:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (125, 3, '已拒绝', '2', 'res_order_status', '', 'danger', 'N', '0', 'admin', '2026-05-17 17:25:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (126, 4, '已归还', '3', 'res_order_status', '', 'warning', 'N', '0', 'admin', '2026-05-17 17:25:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (127, 5, '已逾期', '4', 'res_order_status', '', 'primary', 'N', '0', 'admin', '2026-05-17 17:25:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (128, 6, '已取消', '5', 'res_order_status', '', 'success', 'N', '0', 'admin', '2026-05-17 17:25:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (132, 7, '待归还核验', '6', 'res_order_status', '', 'warning', 'N', '0', 'admin', '2026-05-21 17:39:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (133, 1, '未归还', '0', 'eq_return_status', '', 'default', 'N', '0', 'admin', '2026-05-21 17:39:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (134, 2, '待核验', '1', 'eq_return_status', '', 'warning', 'N', '0', 'admin', '2026-05-21 17:39:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (135, 3, '正常归还', '2', 'eq_return_status', '', 'success', 'N', '0', 'admin', '2026-05-21 17:39:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (136, 4, '损坏归还', '3', 'eq_return_status', '', 'danger', 'N', '0', 'admin', '2026-05-21 17:39:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (137, 5, '无需归还', '4', 'eq_return_status', '', 'info', 'N', '0', 'admin', '2026-05-21 17:39:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (138, 1, '预约通知', 'reserve', 'sys_msg_type', '', 'primary', 'N', '0', 'admin', '2026-05-27 19:18:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (139, 2, '归还通知', 'return', 'sys_msg_type', '', 'success', 'N', '0', 'admin', '2026-05-27 19:18:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (140, 3, '逾期通知', 'overdue', 'sys_msg_type', '', 'danger', 'N', '0', 'admin', '2026-05-27 19:18:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (141, 4, '系统通知', 'system', 'sys_msg_type', '', 'info', 'N', '0', 'admin', '2026-05-27 19:18:17', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-05-05 22:25:21', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '维修状态', 'eq_equipment_status', '0', 'admin', '2026-05-06 18:24:38', 'admin', '2026-05-06 19:23:22', '维修状态列表');
INSERT INTO `sys_dict_type` VALUES (101, '设备分类', 'category_id', '0', 'admin', '2026-05-06 19:22:49', '', NULL, '设备分类列表');
INSERT INTO `sys_dict_type` VALUES (102, '预约状态', 'res_order_status', '0', 'admin', '2026-05-07 00:03:07', '', NULL, '预约状态列表');
INSERT INTO `sys_dict_type` VALUES (103, '延期状态', 'res_extend_status', '0', 'admin', '2026-05-07 00:05:18', '', NULL, '延期状态列表');
INSERT INTO `sys_dict_type` VALUES (104, '设备单元状态', 'eq_unit_status', '0', 'admin', '2026-05-16 23:12:02', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (105, '归还状态', 'eq_return_status', '0', 'admin', '2026-05-16 23:12:03', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (106, '消息类型', 'sys_msg_type', '0', 'admin', '2026-05-27 19:18:17', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-05-05 22:25:21', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-05-05 22:25:21', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-05-05 22:25:21', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 208 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-05 22:35:40');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-06 15:54:51');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-06 17:48:57');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-06 23:53:41');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-07 16:48:21');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-07 18:01:22');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-07 23:00:15');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-07 23:53:24');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-08 15:42:59');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '1', '验证码错误', '2026-05-08 15:42:59');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-08 18:20:45');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-08 23:39:23');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-13 18:55:52');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-13 19:02:44');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-13 22:59:41');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-16 23:16:48');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-17 16:41:51');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-17 23:25:04');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.3131', 'Windows10', '0', '登录成功', '2026-05-18 22:13:14');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-18 22:23:30');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '1', '验证码错误', '2026-05-19 00:07:27');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-19 00:07:30');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-19 23:16:02');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-20 00:07:21');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-20 23:00:55');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-20 23:06:07');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-21 15:15:15');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '1', '验证码错误', '2026-05-21 15:15:22');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-21 15:15:26');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '退出成功', '2026-05-21 15:18:31');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-21 16:06:02');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-21 16:07:25');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-21 17:51:13');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-21 17:51:59');
INSERT INTO `sys_logininfor` VALUES (134, 'test', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '用户不存在/密码错误', '2026-05-21 19:37:17');
INSERT INTO `sys_logininfor` VALUES (135, 'test', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-21 19:37:25');
INSERT INTO `sys_logininfor` VALUES (136, 'test', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-21 19:37:29');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-21 23:15:49');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-21 23:15:49');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-22 00:18:04');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 16:32:21');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 16:34:02');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-22 16:34:02');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '1', '验证码已失效', '2026-05-22 16:57:43');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-22 16:57:44');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-22 17:03:18');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 17:03:28');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 18:12:40');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 18:22:37');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-22 18:25:51');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-22 18:25:57');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 18:26:01');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-22 18:34:33');
INSERT INTO `sys_logininfor` VALUES (153, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '注册成功', '2026-05-22 18:45:36');
INSERT INTO `sys_logininfor` VALUES (154, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '1', '用户不存在/密码错误', '2026-05-22 18:45:47');
INSERT INTO `sys_logininfor` VALUES (155, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-22 18:45:59');
INSERT INTO `sys_logininfor` VALUES (156, 'ganyu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-22 18:51:19');
INSERT INTO `sys_logininfor` VALUES (157, 'ganyu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 18:51:22');
INSERT INTO `sys_logininfor` VALUES (158, 'ganyu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-22 18:51:44');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-22 18:51:51');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 18:51:54');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-22 18:53:39');
INSERT INTO `sys_logininfor` VALUES (162, 'zhangxueyou', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '注册成功', '2026-05-22 18:55:00');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-05-22 18:57:06');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-22 18:57:14');
INSERT INTO `sys_logininfor` VALUES (165, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '退出成功', '2026-05-22 19:01:21');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-22 19:01:32');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '退出成功', '2026-05-22 19:05:43');
INSERT INTO `sys_logininfor` VALUES (168, 'zhangxueyou', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-22 19:05:53');
INSERT INTO `sys_logininfor` VALUES (169, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-27 18:01:38');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-27 18:02:17');
INSERT INTO `sys_logininfor` VALUES (171, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '退出成功', '2026-05-27 18:05:56');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-27 19:19:03');
INSERT INTO `sys_logininfor` VALUES (173, 'zhangxueyou', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '1', '用户不存在/密码错误', '2026-05-27 19:19:37');
INSERT INTO `sys_logininfor` VALUES (174, 'zhangxueyou', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-27 19:19:43');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-27 19:21:12');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 14:30:21');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 14:30:37');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-28 14:31:10');
INSERT INTO `sys_logininfor` VALUES (179, 'zhangxueyou', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 14:31:52');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 23:16:23');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 23:16:48');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-05-28 23:16:58');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 23:17:04');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-28 23:17:47');
INSERT INTO `sys_logininfor` VALUES (185, 'zhangxueyou', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 23:17:56');
INSERT INTO `sys_logininfor` VALUES (186, 'zhangxueyou', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-28 23:48:33');
INSERT INTO `sys_logininfor` VALUES (187, 'ganyu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 23:48:47');
INSERT INTO `sys_logininfor` VALUES (188, 'ganyu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '退出成功', '2026-05-28 23:49:20');
INSERT INTO `sys_logininfor` VALUES (189, 'zhangxueyou', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 23:49:33');
INSERT INTO `sys_logininfor` VALUES (190, 'ganyu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-28 23:49:56');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-05-29 23:13:38');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-05-29 23:13:45');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-29 23:13:51');
INSERT INTO `sys_logininfor` VALUES (194, 'zhangxueyou', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '1', '验证码已失效', '2026-05-29 23:14:07');
INSERT INTO `sys_logininfor` VALUES (195, 'zhangxueyou', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-29 23:14:13');
INSERT INTO `sys_logininfor` VALUES (196, 'zhangxueyou', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '退出成功', '2026-05-30 00:16:29');
INSERT INTO `sys_logininfor` VALUES (197, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-30 00:16:36');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-05-30 01:11:08');
INSERT INTO `sys_logininfor` VALUES (199, 'ganyu', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-05-30 01:12:26');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码已失效', '2026-06-12 10:45:50');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-06-12 10:45:50');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-12 10:45:51');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-06-12 10:54:24');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '退出成功', '2026-06-12 11:44:53');
INSERT INTO `sys_logininfor` VALUES (205, 'zhangxueyou', '127.0.0.1', '内网IP', 'Edge 130', 'Windows >=10', '0', '登录成功', '2026-06-12 11:45:43');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '1', '验证码错误', '2026-06-12 12:14:01');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.8.5161', 'Windows10', '0', '登录成功', '2026-06-12 12:14:01');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2019 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-05 22:25:20', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-05-05 22:25:20', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-05-05 22:25:20', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-05-05 22:25:20', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-05-05 22:25:20', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-05-05 22:25:20', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-05-05 22:25:20', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-05-05 22:25:20', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-05-05 22:25:20', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-05-05 22:25:20', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-05-05 22:25:20', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-05-05 22:25:20', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-05-05 22:25:20', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-05-05 22:25:20', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-05-05 22:25:20', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-05-05 22:25:20', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-05-05 22:25:20', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-05-05 22:25:20', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-05-05 22:25:20', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-05-05 22:25:20', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-05-05 22:25:20', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-05-05 22:25:20', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-05-05 22:25:20', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-05-05 22:25:20', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1090, '消息管理', 1, 7, 'msg', 'system/msg/index', NULL, '', 1, 0, 'C', '0', '0', 'system:msg:list', 'message', 'admin', '2026-05-27 19:18:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1091, '消息查询', 1090, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:msg:query', '#', 'admin', '2026-05-27 19:18:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1092, '消息新增', 1090, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:msg:add', '#', 'admin', '2026-05-27 19:18:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1093, '消息修改', 1090, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:msg:edit', '#', 'admin', '2026-05-27 19:18:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1094, '消息删除', 1090, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:msg:remove', '#', 'admin', '2026-05-27 19:18:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '设备分类管理', 2006, 1, 'category', 'system/category/index', NULL, '', 1, 0, 'C', '0', '0', 'system:category:list', 'tree', 'admin', '2026-05-06 17:12:03', 'admin', '2026-05-07 23:18:10', '设备分类菜单');
INSERT INTO `sys_menu` VALUES (2001, '设备分类查询', 2000, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:category:query', '#', 'admin', '2026-05-06 17:12:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '设备分类新增', 2000, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:category:add', '#', 'admin', '2026-05-06 17:12:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '设备分类修改', 2000, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:category:edit', '#', 'admin', '2026-05-06 17:12:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '设备分类删除', 2000, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:category:remove', '#', 'admin', '2026-05-06 17:12:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '设备分类导出', 2000, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:category:export', '#', 'admin', '2026-05-06 17:12:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '业务管理', 0, 1, 'business', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'build', 'admin', '2026-05-06 18:00:57', 'admin', '2026-05-06 18:01:43', '');
INSERT INTO `sys_menu` VALUES (2007, '设备信息管理', 2006, 1, 'equipment', 'system/equipment/index', NULL, '', 1, 0, 'C', '0', '0', 'system:equipment:list', 'documentation', 'admin', '2026-05-06 18:39:45', 'admin', '2026-05-07 23:19:38', '设备菜单');
INSERT INTO `sys_menu` VALUES (2008, '设备查询', 2007, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:equipment:query', '#', 'admin', '2026-05-06 18:39:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '设备新增', 2007, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:equipment:add', '#', 'admin', '2026-05-06 18:39:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '设备修改', 2007, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:equipment:edit', '#', 'admin', '2026-05-06 18:39:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '设备删除', 2007, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:equipment:remove', '#', 'admin', '2026-05-06 18:39:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '设备导出', 2007, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:equipment:export', '#', 'admin', '2026-05-06 18:39:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '设备预约单管理', 2006, 1, 'reserveOrder', 'system/reserveOrder/index', NULL, '', 1, 0, 'C', '0', '0', 'system:reserveOrder:list', 'list', 'admin', '2026-05-07 18:04:31', 'admin', '2026-05-07 23:19:25', '设备预约单管理菜单');
INSERT INTO `sys_menu` VALUES (2014, '设备预约单管理查询', 2013, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:reserveOrder:query', '#', 'admin', '2026-05-07 18:04:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '设备预约单管理新增', 2013, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:reserveOrder:add', '#', 'admin', '2026-05-07 18:04:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '设备预约单管理修改', 2013, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:reserveOrder:edit', '#', 'admin', '2026-05-07 18:04:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '设备预约单管理删除', 2013, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:reserveOrder:remove', '#', 'admin', '2026-05-07 18:04:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '设备预约单管理导出', 2013, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:reserveOrder:export', '#', 'admin', '2026-05-07 18:04:31', '', NULL, '');

-- ----------------------------
-- Table structure for sys_msg
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg`;
CREATE TABLE `sys_msg`  (
  `msg_id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `msg_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息类型（reserve=预约通知, return=归还通知, overdue=逾期通知, system=系统通知）',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息标题',
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息内容',
  `order_id` bigint NULL DEFAULT NULL COMMENT '关联订单ID',
  `sender_id` bigint NULL DEFAULT NULL COMMENT '发送者ID（NULL=系统）',
  `sender_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '系统' COMMENT '发送者名称',
  `priority` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'normal' COMMENT '优先级（urgent=紧急, normal=普通, low=低）',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发送目标类型（user=指定用户, role=指定角色, all=全部用户）',
  `target_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标ID列表',
  `target_role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标角色',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0=存在, 1=删除）',
  PRIMARY KEY (`msg_id`) USING BTREE,
  INDEX `idx_msg_type`(`msg_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '站内消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_msg
-- ----------------------------
INSERT INTO `sys_msg` VALUES (1, 'reserve', '预约提交成功', '您已成功提交预约申请，设备：null，数量：5，请等待管理员审批。', 21, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-28 14:35:08', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (2, 'reserve', '审批通过', '你预约的台式计算机已通过审批', NULL, 1, 'admin', 'urgent', 'user', '102', NULL, 'admin', '2026-05-28 14:36:57', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (3, 'reserve', '预约已通过', '恭喜！您的预约已通过审批。设备：台式计算机，请于2026-05-28 14:00:00前往计算机房501使用。', 21, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-28 23:30:07', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (4, 'return', '设备待归还核验', '用户 张学友（13760090001）已发起设备归还申请，设备：台式计算机，订单号：RES20260528143507698891，请及时处理。', NULL, NULL, '系统', 'normal', 'all', NULL, NULL, 'system', '2026-05-28 23:33:33', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (5, 'return', '归还核验完成', '您的设备归还已核验完成。设备：台式计算机，归还状态：正常归还。感谢您的使用！', 21, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-28 23:35:58', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (6, 'reserve', '预约提交成功', '您已成功提交预约申请，设备：null，数量：1，请等待管理员审批。', 22, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-28 23:41:27', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (7, 'reserve', '预约已通过', '恭喜！您的预约已通过审批。设备：电阻包，请于2026-05-28 13:00:00前往电子实验室401使用。', 22, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-28 23:50:19', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (8, 'reserve', '预约提交成功', '您已成功提交预约申请，设备：null，数量：1，请等待管理员审批。', 23, NULL, '系统', 'normal', 'user', '101', NULL, 'system', '2026-05-28 23:59:38', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (9, 'reserve', '预约已拒绝', '很遗憾，您的预约申请被拒绝。设备：电阻包，原因：设备准备全部更新，暂停预约。', 23, NULL, '系统', 'normal', 'user', '101', NULL, 'system', '2026-05-29 00:00:21', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (10, 'return', '归还核验完成', '您的设备归还已核验完成。设备：电阻包，归还状态：正常归还。感谢您的使用！', 22, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-29 23:16:10', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (11, 'reserve', '预约提交成功', '您已成功提交预约申请，设备：哑铃套装，数量：1，请等待管理员审批。', 24, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-29 23:21:01', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (12, 'reserve', '预约已通过', '恭喜！您的预约已通过审批。设备：哑铃套装，请于2026-05-29 13:00:00前往健身室903使用。', 24, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-29 23:36:49', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (13, 'return', '归还核验完成', '您的设备归还已核验完成。设备：哑铃套装，归还状态：正常归还。感谢您的使用！', 24, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-29 23:40:38', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (14, 'reserve', '预约提交成功', '您已成功提交预约申请，设备：电阻包，数量：1，请等待管理员审批。', 25, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-29 23:41:49', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (15, 'reserve', '预约已通过', '恭喜！您的预约已通过审批。设备：电阻包，请于2026-05-29 00:00:00前往电子实验室401使用。', 25, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-29 23:42:04', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (16, 'return', '归还核验完成', '您的设备归还已核验完成。设备：电阻包，归还状态：正常归还。感谢您的使用！', 25, NULL, '系统', 'normal', 'user', '102', NULL, 'system', '2026-05-29 23:44:34', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (17, 'overdue', '管理员催还提醒', '管理员提醒您：您预约的设备（千兆交换机）已超期未归还，订单号：，请尽快归还设备！', 19, NULL, '系统', 'normal', 'user', '1', NULL, 'system', '2026-05-30 00:02:05', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (18, 'overdue', '管理员催还提醒', '管理员提醒您：您预约的设备（篮球）已超期未归还，订单号：，请尽快归还设备！', 17, NULL, '系统', 'normal', 'user', '100', NULL, 'system', '2026-05-30 00:02:10', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (19, 'reserve', '预约提交成功', '您已成功提交预约申请，设备：直流电源，数量：20，请等待管理员审批。', 26, NULL, '系统', 'normal', 'user', '101', NULL, 'system', '2026-05-30 00:17:19', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (20, 'reserve', '待审批预约', '用户 <b>甘宇</b> 提交了预约申请。<br>订单号：RES20260530001718793649<br>设备：直流电源<br>数量：20<br>请前往【预约单管理】进行审批。', 26, NULL, '系统', 'normal', 'role', NULL, 'admin', 'system', '2026-05-30 00:17:19', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (21, 'reserve', '预约已通过', '恭喜！您的预约已通过审批。设备：直流电源，请于2026-05-30 00:00:00前往物理实验室103使用。', 26, NULL, '系统', 'normal', 'user', '101', NULL, 'system', '2026-05-30 00:20:42', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (22, 'return', '待核验归还', '用户 <b>甘宇</b>（13760095982）已发起设备归还申请。<br>订单号：RES20260530001718793649<br>设备：直流电源<br>请前往【预约单管理】进行核验归还。', 26, NULL, '系统', 'normal', 'role', NULL, 'admin', 'system', '2026-05-30 00:21:57', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (23, 'return', '归还核验完成', '您的设备归还已核验完成。设备：直流电源，归还状态：正常归还。感谢您的使用！', 26, NULL, '系统', 'normal', 'user', '101', NULL, 'system', '2026-05-30 00:22:44', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (24, 'return', '待核验归还', '用户 <b>刘德华</b>（13760090007）已发起设备归还申请。<br>订单号：<br>设备：千兆交换机<br>请前往【预约单管理】进行核验归还。', 19, NULL, '系统', 'normal', 'role', NULL, 'admin', 'system', '2026-06-12 10:54:56', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (25, 'overdue', '管理员催还提醒', '管理员提醒您：您预约的设备（篮球）已超期未归还，订单号：，请尽快归还设备！', 17, NULL, '系统', 'normal', 'user', '100', NULL, 'system', '2026-06-12 10:55:15', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (26, 'reserve', '预约提交成功', '您已成功提交预约申请，设备：台式计算机，数量：1，请等待管理员审批。', 27, NULL, '系统', 'normal', 'user', '1', NULL, 'system', '2026-06-12 11:19:41', '', NULL, NULL, '0');
INSERT INTO `sys_msg` VALUES (27, 'reserve', '待审批预约', '用户 甘宇 提交了预约申请。订单号：RES20260612111940843936，设备：台式计算机，数量：1。请前往【预约单管理】进行审批。', 27, NULL, '系统', 'normal', 'role', NULL, 'admin', 'system', '2026-06-12 11:19:41', '', NULL, NULL, '0');

-- ----------------------------
-- Table structure for sys_msg_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_read`;
CREATE TABLE `sys_msg_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读记录ID',
  `msg_id` bigint NOT NULL COMMENT '消息ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `read_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_msg_user`(`msg_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_msg_read
-- ----------------------------
INSERT INTO `sys_msg_read` VALUES (1, 2, 102, '2026-05-28 23:24:20');
INSERT INTO `sys_msg_read` VALUES (2, 1, 102, '2026-05-28 23:24:30');
INSERT INTO `sys_msg_read` VALUES (12, 3, 102, '2026-05-28 23:30:14');
INSERT INTO `sys_msg_read` VALUES (15, 4, 102, '2026-05-28 23:34:38');
INSERT INTO `sys_msg_read` VALUES (16, 5, 102, '2026-05-28 23:36:20');
INSERT INTO `sys_msg_read` VALUES (20, 6, 102, '2026-05-28 23:41:34');
INSERT INTO `sys_msg_read` VALUES (21, 4, 101, '2026-05-28 23:49:03');
INSERT INTO `sys_msg_read` VALUES (22, 9, 101, '2026-05-29 00:00:26');
INSERT INTO `sys_msg_read` VALUES (23, 7, 102, '2026-05-29 23:14:18');
INSERT INTO `sys_msg_read` VALUES (24, 10, 102, '2026-05-29 23:16:21');
INSERT INTO `sys_msg_read` VALUES (27, 11, 102, '2026-05-29 23:21:37');
INSERT INTO `sys_msg_read` VALUES (29, 12, 102, '2026-05-29 23:36:55');
INSERT INTO `sys_msg_read` VALUES (30, 13, 102, '2026-05-29 23:42:28');
INSERT INTO `sys_msg_read` VALUES (31, 15, 102, '2026-05-29 23:43:54');
INSERT INTO `sys_msg_read` VALUES (32, 14, 102, '2026-05-29 23:43:56');
INSERT INTO `sys_msg_read` VALUES (33, 16, 102, '2026-05-29 23:44:46');
INSERT INTO `sys_msg_read` VALUES (35, 8, 101, '2026-05-30 00:16:48');
INSERT INTO `sys_msg_read` VALUES (36, 19, 101, '2026-05-30 00:20:47');
INSERT INTO `sys_msg_read` VALUES (37, 21, 101, '2026-05-30 00:20:51');
INSERT INTO `sys_msg_read` VALUES (39, 23, 101, '2026-05-30 00:22:58');
INSERT INTO `sys_msg_read` VALUES (40, 20, 1, '2026-06-12 10:54:42');
INSERT INTO `sys_msg_read` VALUES (41, 17, 1, '2026-06-12 10:54:47');
INSERT INTO `sys_msg_read` VALUES (42, 24, 1, '2026-06-12 10:55:53');
INSERT INTO `sys_msg_read` VALUES (43, 27, 1, '2026-06-12 11:44:06');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-05-05 22:25:21', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-05-05 22:25:21', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-05-05 22:25:21', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (10, '待核验 - 张学友 归还 电阻包', '1', 0xE794A8E688B7203C623EE5BCA0E5ADA6E58F8B3C2F623EEFBC883133373630303930303031EFBC89E5B7B2E58F91E8B5B7E8AEBEE5A487E5BD92E8BF98E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303532383233343132373032353537313C62723EE8AEBEE5A487EFBC9AE794B5E998BBE58C853C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE6A0B8E9AA8CE5BD92E8BF98E38082, '0', 'system', '2026-05-29 23:15:43', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (11, '待审批 - 张学友 预约了 哑铃套装', '1', 0xE794A8E688B7203C623EE5BCA0E5ADA6E58F8B3C2F623E20E68F90E4BAA4E4BA86E9A284E7BAA6E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303532393233323130303533303734333C62723EE8AEBEE5A487EFBC9AE59391E99383E5A597E8A3853C62723EE695B0E9878FEFBC9A313C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE5AEA1E689B9E38082, '0', 'system', '2026-05-29 23:21:00', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (12, '待核验 - 张学友 归还 哑铃套装', '1', 0xE794A8E688B7203C623EE5BCA0E5ADA6E58F8B3C2F623EEFBC883133373630303930303031EFBC89E5B7B2E58F91E8B5B7E8AEBEE5A487E5BD92E8BF98E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303532393233323130303533303734333C62723EE8AEBEE5A487EFBC9AE59391E99383E5A597E8A3853C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE6A0B8E9AA8CE5BD92E8BF98E38082, '0', 'system', '2026-05-29 23:38:28', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (13, '待审批 - 张学友 预约了 电阻包', '1', 0xE794A8E688B7203C623EE5BCA0E5ADA6E58F8B3C2F623E20E68F90E4BAA4E4BA86E9A284E7BAA6E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303532393233343134383533353334373C62723EE8AEBEE5A487EFBC9AE794B5E998BBE58C853C62723EE695B0E9878FEFBC9A313C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE5AEA1E689B9E38082, '0', 'system', '2026-05-29 23:41:48', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (14, '待核验 - 张学友 归还 电阻包', '1', 0xE794A8E688B7203C623EE5BCA0E5ADA6E58F8B3C2F623EEFBC883133373630303930303031EFBC89E5B7B2E58F91E8B5B7E8AEBEE5A487E5BD92E8BF98E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303532393233343134383533353334373C62723EE8AEBEE5A487EFBC9AE794B5E998BBE58C853C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE6A0B8E9AA8CE5BD92E8BF98E38082, '0', 'system', '2026-05-29 23:44:01', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (15, '待审批 - 甘宇 预约了 直流电源', '1', 0xE794A8E688B7203C623EE79498E5AE873C2F623E20E68F90E4BAA4E4BA86E9A284E7BAA6E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303533303030313731383739333634393C62723EE8AEBEE5A487EFBC9AE79BB4E6B581E794B5E6BA903C62723EE695B0E9878FEFBC9A32303C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE5AEA1E689B9E38082, '0', 'system', '2026-05-30 00:17:18', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (16, '待核验 - 甘宇 归还 直流电源', '1', 0xE794A8E688B7203C623EE79498E5AE873C2F623EEFBC883133373630303935393832EFBC89E5B7B2E58F91E8B5B7E8AEBEE5A487E5BD92E8BF98E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303533303030313731383739333634393C62723EE8AEBEE5A487EFBC9AE79BB4E6B581E794B5E6BA903C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE6A0B8E9AA8CE5BD92E8BF98E38082, '0', 'system', '2026-05-30 00:21:56', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (17, '待核验 - 刘德华 归还 千兆交换机', '1', 0xE794A8E688B7203C623EE58898E5BEB7E58D8E3C2F623EEFBC883133373630303930303037EFBC89E5B7B2E58F91E8B5B7E8AEBEE5A487E5BD92E8BF98E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A3C62723EE8AEBEE5A487EFBC9AE58D83E58586E4BAA4E68DA2E69CBA3C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE6A0B8E9AA8CE5BD92E8BF98E38082, '0', 'system', '2026-06-12 10:54:55', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (18, '待审批 - 甘宇 预约了 台式计算机', '1', 0xE794A8E688B7203C623EE79498E5AE873C2F623E20E68F90E4BAA4E4BA86E9A284E7BAA6E794B3E8AFB7E380823C62723EE8AEA2E58D95E58FB7EFBC9A52455332303236303631323131313934303834333933363C62723EE8AEBEE5A487EFBC9AE58FB0E5BC8FE8AEA1E7AE97E69CBA3C62723EE695B0E9878FEFBC9A313C62723EE8AFB7E5898DE5BE80E38090E9A284E7BAA6E58D95E7AEA1E79086E38091E8BF9BE8A18CE5AEA1E689B9E38082, '0', 'system', '2026-06-12 11:19:41', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (1, 3, 1, '2026-05-28 23:35:12');
INSERT INTO `sys_notice_read` VALUES (2, 2, 1, '2026-05-28 23:35:12');
INSERT INTO `sys_notice_read` VALUES (3, 1, 1, '2026-05-28 23:35:12');
INSERT INTO `sys_notice_read` VALUES (4, 14, 1, '2026-05-30 00:00:45');
INSERT INTO `sys_notice_read` VALUES (5, 11, 1, '2026-05-30 00:00:58');
INSERT INTO `sys_notice_read` VALUES (6, 12, 1, '2026-05-30 00:01:01');
INSERT INTO `sys_notice_read` VALUES (7, 13, 1, '2026-05-30 00:01:04');
INSERT INTO `sys_notice_read` VALUES (8, 10, 1, '2026-05-30 00:01:06');
INSERT INTO `sys_notice_read` VALUES (9, 15, 1, '2026-05-30 00:17:32');
INSERT INTO `sys_notice_read` VALUES (10, 16, 1, '2026-05-30 00:22:24');
INSERT INTO `sys_notice_read` VALUES (11, 17, 1, '2026-06-12 12:19:51');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 313 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"nickName\":\"test\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":100,\"userName\":\"test\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-05 22:36:32', 196);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"eq_category\",\"tplWebType\":\"element-plus\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 16:24:02', 479);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"category\",\"className\":\"EqCategory\",\"columns\":[{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":1,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 16:24:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"分类名称\",\"columnId\":2,\"columnName\":\"category_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ParentId\",\"columnComment\":\"父分类ID（0为顶级）\",\"columnId\":3,\"columnName\":\"parent_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 16:24:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"parentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":true,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":true},{\"capJavaField\":\"Ancestors\",\"columnComment\":\"祖级列表\",\"columnId\":4,\"columnName\":\"ancestors\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 16:24:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isP', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 16:51:37', 222);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"eq_category\"}', NULL, 0, NULL, '2026-05-06 16:51:44', 429);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/category/index\",\"createTime\":\"2026-05-06 17:12:03\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"设备分类\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"category\",\"perms\":\"system:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 17:21:40', 49);
INSERT INTO `sys_oper_log` VALUES (105, '设备分类', 1, 'com.ruoyi.equipment.controller.EqCategoryController.add()', 'POST', 1, 'admin', '研发部门', '/system/category', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"categoryName\":\"test\",\"children\":[],\"createTime\":\"2026-05-06 17:52:02\",\"params\":{},\"parentId\":0,\"remark\":\"test\",\"sort\":1,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 17:52:02', 41);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/category/index\",\"createTime\":\"2026-05-06 17:12:03\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"设备分类\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"category\",\"perms\":\"system:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 17:52:44', 42);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/category/index\",\"createTime\":\"2026-05-06 17:12:03\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"设备分类\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"category\",\"perms\":\"system:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 17:55:22', 18);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"业务管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"/business\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:00:57', 21);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-06 18:00:57\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"业务管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"business\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:01:43', 20);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/category/index\",\"createTime\":\"2026-05-06 17:12:03\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"设备分类\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"category\",\"perms\":\"system:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:02:06', 16);
INSERT INTO `sys_oper_log` VALUES (111, '设备分类', 3, 'com.ruoyi.equipment.controller.EqCategoryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/category/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:06:55', 12);
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"eq_equipment\",\"tplWebType\":\"element-plus\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:16:08', 114);
INSERT INTO `sys_oper_log` VALUES (113, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"维修状态\",\"dictType\":\"eq_equipment_status\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:24:38', 24);
INSERT INTO `sys_oper_log` VALUES (114, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:24:38\",\"dictId\":100,\"dictName\":\"维修状态\",\"dictType\":\"eq_equipment_status\",\"params\":{},\"remark\":\"设备信息列表\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:25:03', 26);
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"equipment\",\"className\":\"EqEquipment\",\"columns\":[{\"capJavaField\":\"EquipmentId\",\"columnComment\":\"设备ID\",\"columnId\":12,\"columnName\":\"equipment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"equipmentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentName\",\"columnComment\":\"设备名称\",\"columnId\":13,\"columnName\":\"equipment_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":14,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Image\",\"columnComment\":\"设备图片URL\",\"columnId\":15,\"columnName\":\"image\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:25:25', 101);
INSERT INTO `sys_oper_log` VALUES (116, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"正常\",\"dictSort\":0,\"dictType\":\"eq_equipment_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:31:09', 12);
INSERT INTO `sys_oper_log` VALUES (117, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"维修中\",\"dictSort\":1,\"dictType\":\"eq_equipment_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:32:00', 11);
INSERT INTO `sys_oper_log` VALUES (118, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已报废\",\"dictSort\":2,\"dictType\":\"eq_equipment_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:32:16', 10);
INSERT INTO `sys_oper_log` VALUES (119, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已借出\",\"dictSort\":3,\"dictType\":\"eq_equipment_status\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:32:31', 12);
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"equipment\",\"className\":\"EqEquipment\",\"columns\":[{\"capJavaField\":\"EquipmentId\",\"columnComment\":\"设备ID\",\"columnId\":12,\"columnName\":\"equipment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"equipmentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-05-06 18:25:24\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentName\",\"columnComment\":\"设备名称\",\"columnId\":13,\"columnName\":\"equipment_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-05-06 18:25:24\",\"usableColumn\":false},{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":14,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-05-06 18:25:24\",\"usableColumn\":false},{\"capJavaField\":\"Image\",\"columnComment\":\"设备图片URL\",\"columnId\":15,\"columnName\":\"image\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:16:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUplo', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:37:44', 56);
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"eq_equipment\"}', NULL, 0, NULL, '2026-05-06 18:37:56', 444);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/equipment/index\",\"createTime\":\"2026-05-06 18:39:45\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"设备管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"equipment\",\"perms\":\"system:equipment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 18:59:00', 72);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/category/index\",\"createTime\":\"2026-05-06 17:12:03\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"设备分类\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"category\",\"perms\":\"system:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 19:00:31', 22);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/category/index\",\"createTime\":\"2026-05-06 17:12:03\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"设备分类\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"category\",\"perms\":\"system:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 19:04:13', 19);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/equipment/index\",\"createTime\":\"2026-05-06 18:39:45\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"设备管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"equipment\",\"perms\":\"system:equipment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 19:04:44', 18);
INSERT INTO `sys_oper_log` VALUES (126, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-05-06 19:06:12\",\"equipmentName\":\"烧杯\",\"image\":\"/profile/upload/2026/05/06/屏幕截图 2026-05-06 190119_20260506190538A001.png\",\"location\":\"502室\",\"params\":{},\"status\":\"0\",\"totalStock\":1000} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\info\\EqEquipmentMapper.xml]\r\n### The error may involve com.ruoyi.equipment.info.mapper.EqEquipmentMapper.insertEqEquipment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eq_equipment          ( equipment_name,                          image,             total_stock,                          status,             location,                                                    create_time )           values ( ?,                          ?,             ?,                          ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value', '2026-05-06 19:06:12', 287);
INSERT INTO `sys_oper_log` VALUES (127, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-05-06 19:06:19\",\"equipmentName\":\"烧杯\",\"image\":\"/profile/upload/2026/05/06/屏幕截图 2026-05-06 190119_20260506190538A001.png\",\"location\":\"502室\",\"params\":{},\"status\":\"0\",\"totalStock\":1000} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\info\\EqEquipmentMapper.xml]\r\n### The error may involve com.ruoyi.equipment.info.mapper.EqEquipmentMapper.insertEqEquipment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eq_equipment          ( equipment_name,                          image,             total_stock,                          status,             location,                                                    create_time )           values ( ?,                          ?,             ?,                          ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value', '2026-05-06 19:06:19', 5);
INSERT INTO `sys_oper_log` VALUES (128, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-05-06 19:17:59\",\"equipmentName\":\"1\",\"params\":{},\"status\":\"1\",\"totalStock\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\info\\EqEquipmentMapper.xml]\r\n### The error may involve com.ruoyi.equipment.info.mapper.EqEquipmentMapper.insertEqEquipment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eq_equipment          ( equipment_name,                                       total_stock,                          status,                                                                 create_time )           values ( ?,                                       ?,                          ?,                                                                 ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value', '2026-05-06 19:17:59', 11);
INSERT INTO `sys_oper_log` VALUES (129, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"设备分类\",\"dictType\":\"category_id\",\"params\":{},\"remark\":\"设备分类列表\",\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 19:22:49', 24);
INSERT INTO `sys_oper_log` VALUES (130, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-05-06 18:24:38\",\"dictId\":100,\"dictName\":\"维修状态\",\"dictType\":\"eq_equipment_status\",\"params\":{},\"remark\":\"维修状态列表\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 19:23:22', 44);
INSERT INTO `sys_oper_log` VALUES (131, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":10,\"createTime\":\"2026-05-06 19:30:24\",\"equipmentId\":1,\"equipmentName\":\"test\",\"image\":\"/profile/upload/2026/05/06/屏幕截图 2025-12-09 150059_20260506193018A001.png\",\"params\":{},\"status\":\"0\",\"totalStock\":111} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 19:30:24', 370);
INSERT INTO `sys_oper_log` VALUES (132, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"res_order\",\"tplWebType\":\"element-plus\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-06 23:53:55', 234);
INSERT INTO `sys_oper_log` VALUES (133, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"预约状态\",\"dictType\":\"res_order_status\",\"params\":{},\"remark\":\"预约状态列表\",\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:03:07', 24);
INSERT INTO `sys_oper_log` VALUES (134, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"待审批\",\"dictSort\":0,\"dictType\":\"res_order_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:03:42', 17);
INSERT INTO `sys_oper_log` VALUES (135, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审批通过（使用中）\",\"dictSort\":1,\"dictType\":\"res_order_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:03:58', 17);
INSERT INTO `sys_oper_log` VALUES (136, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审批拒绝\",\"dictSort\":2,\"dictType\":\"res_order_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:04:14', 10);
INSERT INTO `sys_oper_log` VALUES (137, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已归还\",\"dictSort\":3,\"dictType\":\"res_order_status\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:04:25', 13);
INSERT INTO `sys_oper_log` VALUES (138, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已逾期\",\"dictSort\":4,\"dictType\":\"res_order_status\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:04:35', 15);
INSERT INTO `sys_oper_log` VALUES (139, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已取消\",\"dictSort\":5,\"dictType\":\"res_order_status\",\"dictValue\":\"5\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:04:49', 15);
INSERT INTO `sys_oper_log` VALUES (140, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"延期状态\",\"dictType\":\"res_extend_status\",\"params\":{},\"remark\":\"延期状态列表\",\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:05:18', 15);
INSERT INTO `sys_oper_log` VALUES (141, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"未申请\",\"dictSort\":0,\"dictType\":\"res_extend_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:05:34', 15);
INSERT INTO `sys_oper_log` VALUES (142, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"延期审批中\",\"dictSort\":1,\"dictType\":\"res_extend_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:05:50', 13);
INSERT INTO `sys_oper_log` VALUES (143, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"延期通过\",\"dictSort\":2,\"dictType\":\"res_extend_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:06:01', 15);
INSERT INTO `sys_oper_log` VALUES (144, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"延期拒绝\",\"dictSort\":3,\"dictType\":\"res_extend_status\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:06:12', 17);
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"order\",\"className\":\"ResOrder\",\"columns\":[{\"capJavaField\":\"OrderId\",\"columnComment\":\"预约单ID\",\"columnId\":27,\"columnName\":\"order_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"orderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"预约用户ID\",\"columnId\":28,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EquipId\",\"columnComment\":\"设备ID\",\"columnId\":29,\"columnName\":\"equip_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"equipId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Quantity\",\"columnComment\":\"预约数量\",\"columnId\":30,\"columnName\":\"quantity\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:06:35', 139);
INSERT INTO `sys_oper_log` VALUES (146, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"order\",\"className\":\"ResOrder\",\"columns\":[{\"capJavaField\":\"OrderId\",\"columnComment\":\"预约单ID\",\"columnId\":27,\"columnName\":\"order_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"orderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-05-07 00:06:35\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"预约用户ID\",\"columnId\":28,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-05-07 00:06:35\",\"usableColumn\":false},{\"capJavaField\":\"EquipId\",\"columnComment\":\"设备ID\",\"columnId\":29,\"columnName\":\"equip_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"equipId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-05-07 00:06:35\",\"usableColumn\":false},{\"capJavaField\":\"Quantity\",\"columnComment\":\"预约数量\",\"columnId\":30,\"columnName\":\"quantity\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":fal', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:07:04', 87);
INSERT INTO `sys_oper_log` VALUES (147, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"reserveOrder\",\"className\":\"ResOrder\",\"columns\":[{\"capJavaField\":\"OrderId\",\"columnComment\":\"预约单ID\",\"columnId\":27,\"columnName\":\"order_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"orderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-05-07 00:07:04\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"预约用户ID\",\"columnId\":28,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-05-07 00:07:04\",\"usableColumn\":false},{\"capJavaField\":\"EquipId\",\"columnComment\":\"设备ID\",\"columnId\":29,\"columnName\":\"equip_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"equipId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-05-07 00:07:04\",\"usableColumn\":false},{\"capJavaField\":\"Quantity\",\"columnComment\":\"预约数量\",\"columnId\":30,\"columnName\":\"quantity\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-05-06 23:53:55\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increme', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 00:07:57', 94);
INSERT INTO `sys_oper_log` VALUES (148, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"res_order\"}', NULL, 0, NULL, '2026-05-07 00:08:32', 446);
INSERT INTO `sys_oper_log` VALUES (149, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createTime\":\"2026-05-07 17:00:44\",\"equipmentId\":2,\"equipmentName\":\"阿里云test\",\"image\":\"\",\"params\":{},\"status\":\"0\",\"totalStock\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 17:00:44', 392);
INSERT INTO `sys_oper_log` VALUES (150, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"createTime\":\"2026-05-07 17:07:35\",\"equipmentId\":3,\"equipmentName\":\"1\",\"image\":\"\",\"params\":{},\"status\":\"0\",\"totalStock\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 17:07:35', 10);
INSERT INTO `sys_oper_log` VALUES (151, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createTime\":\"2026-05-07 17:25:08\",\"equipmentId\":4,\"equipmentName\":\"1\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/27f8cf0a46d34e8893fe461c931f4fc0.png\",\"params\":{},\"status\":\"0\",\"totalStock\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 17:25:08', 375);
INSERT INTO `sys_oper_log` VALUES (152, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 17:26:54', 9);
INSERT INTO `sys_oper_log` VALUES (153, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":10,\"categoryName\":\"力学设备\",\"createBy\":\"\",\"createTime\":\"2026-05-06 19:30:25\",\"delFlag\":\"0\",\"equipmentId\":1,\"equipmentName\":\"test\",\"image\":\"\",\"location\":\"\",\"params\":{},\"remainStock\":0,\"status\":\"0\",\"totalStock\":111,\"updateBy\":\"\",\"updateTime\":\"2026-05-07 17:28:35\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 17:28:35', 11);
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/reserveOrder/index\",\"createTime\":\"2026-05-07 18:04:31\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"设备预约单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"reserveOrder\",\"perms\":\"system:reserveOrder:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 23:17:34', 147);
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/category/index\",\"createTime\":\"2026-05-06 17:12:03\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"设备分类管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"category\",\"perms\":\"system:category:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 23:18:10', 16);
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/equipment/index\",\"createTime\":\"2026-05-06 18:39:45\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"设备信息管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"equipment\",\"perms\":\"system:equipment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 23:18:18', 21);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/reserveOrder/index\",\"createTime\":\"2026-05-07 18:04:31\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"设备预约单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"reserveOrder\",\"perms\":\"system:reserveOrder:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 23:19:25', 23);
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/equipment/index\",\"createTime\":\"2026-05-06 18:39:45\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"设备信息管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"equipment\",\"perms\":\"system:equipment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-07 23:19:38', 23);
INSERT INTO `sys_oper_log` VALUES (159, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createTime\":\"2026-05-08 00:35:43\",\"equipmentId\":1,\"equipmentName\":\"1\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/94bc0dc666f34cc4993f0b7165a5a677.png\",\"params\":{},\"status\":\"0\",\"totalStock\":111} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-08 00:35:44', 394);
INSERT INTO `sys_oper_log` VALUES (160, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":3,\"createTime\":\"2026-05-08 00:37:18\",\"description\":\"1111\",\"equipmentId\":2,\"equipmentName\":\"2\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/d99a71f93ccf46d1ba417b7491f6cc58.png\",\"location\":\"11\",\"params\":{},\"remark\":\"1111\",\"status\":\"1\",\"totalStock\":10} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-08 00:37:18', 11);
INSERT INTO `sys_oper_log` VALUES (161, '设备', 5, 'com.ruoyi.equipment.info.controller.EqEquipmentController.export()', 'POST', 1, 'admin', '研发部门', '/system/equipment/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-05-08 15:44:54', 1303);
INSERT INTO `sys_oper_log` VALUES (162, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":6,\"createTime\":\"2026-05-08 15:56:25\",\"equipmentId\":3,\"equipmentName\":\"1\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/3f1cceaeb73743eaa9efe3a549a956ca.png\",\"location\":\"201\",\"params\":{},\"status\":\"1\",\"totalStock\":20} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-08 15:56:26', 370);
INSERT INTO `sys_oper_log` VALUES (163, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-08 15:58:07', 17);
INSERT INTO `sys_oper_log` VALUES (164, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":7,\"createBy\":\"admin\",\"createTime\":\"2026-05-08 16:08:16\",\"delFlag\":\"0\",\"equipmentId\":4,\"equipmentName\":\"test1\",\"params\":{},\"remainStock\":10,\"status\":\"1\",\"totalStock\":10} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-08 16:08:17', 309);
INSERT INTO `sys_oper_log` VALUES (165, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/4', '127.0.0.1', '内网IP', '[4] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-08 16:38:37', 52);
INSERT INTO `sys_oper_log` VALUES (166, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-05-13 19:04:48\",\"equipmentId\":6,\"params\":{},\"reserveStatus\":\"0\",\"reserveTime\":\"2026-05-13\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'reserve_status\' in \'field list\'\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             reserve_status,             equip_id,                                       create_time )           values ( ?,             ?,             ?,             ?,                                       ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'reserve_status\' in \'field list\'\n; bad SQL grammar []', '2026-05-13 19:04:48', 288);
INSERT INTO `sys_oper_log` VALUES (167, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":6,\"createBy\":\"admin\",\"createTime\":\"2026-05-16 23:33:13\",\"delFlag\":\"0\",\"equipmentId\":21,\"equipmentName\":\"test--设备单元管理测试\",\"location\":\"201\",\"params\":{},\"remainStock\":100,\"status\":\"0\",\"totalStock\":100,\"trackUnit\":\"1\",\"unitCodePrefix\":\"test-001\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 23:33:13', 140);
INSERT INTO `sys_oper_log` VALUES (168, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-010\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 16:43:53\",\"equipmentId\":21,\"expectReturnTime\":\"2026-05-18\",\"orderId\":2,\"orderStatus\":\"0\",\"params\":{},\"quantity\":10,\"reserveTime\":\"2026-05-17\",\"returnStatus\":\"0\",\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 16:43:54', 98);
INSERT INTO `sys_oper_log` VALUES (169, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/2', '127.0.0.1', '内网IP', '2 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 16:44:08', 145);
INSERT INTO `sys_oper_log` VALUES (170, '预约订单归还', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.returnOrder()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/return/2', '127.0.0.1', '内网IP', '2 {\"returnStatus\":\"1\",\"damageRemark\":\"\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 16:48:47', 121);
INSERT INTO `sys_oper_log` VALUES (171, '预约订单拒绝', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.reject()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/reject/1', '127.0.0.1', '内网IP', '1 {\"rejectReason\":\"库存不足\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 16:52:24', 15);
INSERT INTO `sys_oper_log` VALUES (172, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"params\":{},\"status\":\"3\",\"unitId\":10} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:30:51', 43);
INSERT INTO `sys_oper_log` VALUES (173, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"params\":{},\"status\":\"2\",\"unitId\":10} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:32:56', 7);
INSERT INTO `sys_oper_log` VALUES (174, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:34:59\",\"equipmentId\":21,\"orderStatus\":\"0\",\"params\":{},\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             order_status,             equip_id,                                       assigned_unit_codes,             return_status,                          create_by,             create_time )           values ( ?,             ?,             ?,             ?,                                       ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\n; Field \'expect_return_time\' doesn\'t have a default value', '2026-05-17 17:34:59', 323);
INSERT INTO `sys_oper_log` VALUES (175, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-05-17 17:35:07\",\"equipmentId\":21,\"orderStatus\":\"0\",\"params\":{},\"quantity\":100,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '设备 \'test--设备单元管理测试\' 可用数量不足，当前可用: 99，需要: 100', '2026-05-17 17:35:07', 21);
INSERT INTO `sys_oper_log` VALUES (176, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:35:23\",\"equipmentId\":21,\"orderStatus\":\"0\",\"params\":{},\"quantity\":15,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             order_status,             equip_id,             quantity,                          assigned_unit_codes,             return_status,                          create_by,             create_time )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\n; Field \'expect_return_time\' doesn\'t have a default value', '2026-05-17 17:35:23', 30);
INSERT INTO `sys_oper_log` VALUES (177, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:35:24\",\"equipmentId\":21,\"orderStatus\":\"0\",\"params\":{},\"quantity\":15,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             order_status,             equip_id,             quantity,                          assigned_unit_codes,             return_status,                          create_by,             create_time )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\n; Field \'expect_return_time\' doesn\'t have a default value', '2026-05-17 17:35:24', 24);
INSERT INTO `sys_oper_log` VALUES (178, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:35:33\",\"equipmentId\":21,\"orderStatus\":\"0\",\"params\":{},\"quantity\":15,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             order_status,             equip_id,             quantity,                          assigned_unit_codes,             return_status,                          create_by,             create_time )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\n; Field \'expect_return_time\' doesn\'t have a default value', '2026-05-17 17:35:33', 32);
INSERT INTO `sys_oper_log` VALUES (179, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:35:51\",\"equipmentId\":21,\"orderStatus\":\"0\",\"params\":{},\"quantity\":10,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             order_status,             equip_id,             quantity,                          assigned_unit_codes,             return_status,                          create_by,             create_time )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'expect_return_time\' doesn\'t have a default value\n; Field \'expect_return_time\' doesn\'t have a default value', '2026-05-17 17:35:51', 24);
INSERT INTO `sys_oper_log` VALUES (180, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:40:59\",\"equipmentId\":21,\"expectReturnTime\":\"2026-05-18\",\"orderId\":3,\"orderStatus\":\"0\",\"params\":{},\"quantity\":15,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:40:59', 40);
INSERT INTO `sys_oper_log` VALUES (181, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:41:22', 157);
INSERT INTO `sys_oper_log` VALUES (182, '预约订单归还', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.returnOrder()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/return/3', '127.0.0.1', '内网IP', '3 {\"returnStatus\":\"1\",\"damageRemark\":\"\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:42:03', 132);
INSERT INTO `sys_oper_log` VALUES (183, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:45:24', 17);
INSERT INTO `sys_oper_log` VALUES (184, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016,test-001-017,test-001-018,test-001-019,test-001-020,test-001-021,test-001-022,test-001-023,test-001-024,test-001-025,test-001-026,test-001-027,test-001-028,test-001-029,test-001-030,test-001-031,test-001-032,test-001-033,test-001-034,test-001-035,test-001-036,test-001-037,test-001-038,test-001-039,test-001-040,test-001-041,test-001-042,test-001-043,test-001-044,test-001-045,test-001-046,test-001-047,test-001-048,test-001-049,test-001-050,test-001-051\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:45:55\",\"equipmentId\":21,\"expectReturnTime\":\"2026-05-20\",\"orderStatus\":\"0\",\"params\":{},\"quantity\":50,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'assigned_unit_codes\' at row 1\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             order_status,             equip_id,             quantity,             expect_return_time,             assigned_unit_codes,             return_status,                          create_by,             create_time )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,             ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'assigned_unit_codes\' at row 1\n; Data truncation: Data too long for column \'assigned_unit_codes\' at row 1', '2026-05-17 17:45:55', 26);
INSERT INTO `sys_oper_log` VALUES (185, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016,test-001-017,test-001-018,test-001-019,test-001-020,test-001-021,test-001-022,test-001-023,test-001-024,test-001-025,test-001-026,test-001-027,test-001-028,test-001-029,test-001-030,test-001-031,test-001-032,test-001-033,test-001-034,test-001-035,test-001-036,test-001-037,test-001-038,test-001-039,test-001-040,test-001-041,test-001-042,test-001-043,test-001-044,test-001-045,test-001-046,test-001-047,test-001-048,test-001-049,test-001-050,test-001-051\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:46:02\",\"equipmentId\":21,\"expectReturnTime\":\"2026-05-20\",\"orderStatus\":\"0\",\"params\":{},\"quantity\":50,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'assigned_unit_codes\' at row 1\r\n### The error may exist in file [D:\\AAAA\\CERS\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\equipment\\order\\ResOrderMapper.xml]\r\n### The error may involve com.ruoyi.equipment.order.mapper.ResOrderMapper.insertResOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into res_order          ( user_id,             reserve_time,             order_status,             equip_id,             quantity,             expect_return_time,             assigned_unit_codes,             return_status,                          create_by,             create_time )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,             ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'assigned_unit_codes\' at row 1\n; Data truncation: Data too long for column \'assigned_unit_codes\' at row 1', '2026-05-17 17:46:02', 21);
INSERT INTO `sys_oper_log` VALUES (186, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 17:46:19\",\"equipmentId\":21,\"expectReturnTime\":\"2026-05-20\",\"orderId\":4,\"orderStatus\":\"0\",\"params\":{},\"quantity\":10,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:46:19', 26);
INSERT INTO `sys_oper_log` VALUES (187, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:46:24', 111);
INSERT INTO `sys_oper_log` VALUES (188, '预约订单归还', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.returnOrder()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/return/4', '127.0.0.1', '内网IP', '4 {\"returnStatus\":\"2\",\"damageRemark\":\"部分\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:46:36', 83);
INSERT INTO `sys_oper_log` VALUES (189, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016,test-001-017,test-001-018,test-001-019,test-001-020,test-001-021,test-001-022,test-001-023,test-001-024,test-001-025,test-001-026,test-001-027,test-001-028,test-001-029,test-001-030,test-001-031,test-001-032,test-001-033,test-001-034,test-001-035,test-001-036,test-001-037,test-001-038,test-001-039,test-001-040,test-001-041,test-001-042,test-001-043,test-001-044,test-001-045,test-001-046,test-001-047,test-001-048,test-001-049,test-001-050,test-001-051\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 23:26:32\",\"equipmentId\":21,\"expectReturnTime\":\"2026-05-19\",\"orderId\":5,\"orderStatus\":\"0\",\"params\":{},\"quantity\":50,\"reserveTime\":\"2026-05-17\",\"returnStatus\":\"0\",\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 23:26:32', 94);
INSERT INTO `sys_oper_log` VALUES (190, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/5', '127.0.0.1', '内网IP', '5 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 23:26:52', 550);
INSERT INTO `sys_oper_log` VALUES (191, '预约订单归还', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.returnOrder()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/return/5', '127.0.0.1', '内网IP', '5 {\"returnStatus\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 23:27:29', 360);
INSERT INTO `sys_oper_log` VALUES (192, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\"部分\",\"params\":{},\"status\":\"2\",\"unitId\":9,\"updateTime\":\"2026-05-17 23:28:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 23:28:09', 33);
INSERT INTO `sys_oper_log` VALUES (193, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\"部分\",\"params\":{},\"status\":\"3\",\"unitId\":8,\"updateTime\":\"2026-05-17 23:28:14\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 23:28:14', 22);
INSERT INTO `sys_oper_log` VALUES (194, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"params\":{},\"status\":\"0\",\"unitId\":10,\"updateTime\":\"2026-05-17 23:29:42\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 23:29:42', 21);
INSERT INTO `sys_oper_log` VALUES (195, '预约订单', 1, 'com.ruoyi.equipment.order.controller.ResOrderController.add()', 'POST', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-05-17 23:35:25\",\"equipmentId\":19,\"expectReturnTime\":\"2026-05-19\",\"orderId\":6,\"orderStatus\":\"0\",\"params\":{},\"quantity\":10,\"reserveTime\":\"2026-05-18\",\"returnStatus\":\"0\",\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 23:35:25', 13);
INSERT INTO `sys_oper_log` VALUES (196, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\"部分\",\"params\":{},\"status\":\"0\",\"unitId\":1,\"updateTime\":\"2026-05-18 00:02:29\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:02:29', 30);
INSERT INTO `sys_oper_log` VALUES (197, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\"部分\",\"params\":{},\"status\":\"0\",\"unitId\":3,\"updateTime\":\"2026-05-18 00:02:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:02:44', 9);
INSERT INTO `sys_oper_log` VALUES (198, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\"部分\",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":1,\"updateTime\":\"2026-05-18 00:04:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:04:13', 50);
INSERT INTO `sys_oper_log` VALUES (199, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":1,\"updateTime\":\"2026-05-18 00:04:32\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:04:32', 14);
INSERT INTO `sys_oper_log` VALUES (200, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":2,\"updateTime\":\"2026-05-18 00:04:56\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:04:56', 18);
INSERT INTO `sys_oper_log` VALUES (201, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\"部\",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":1,\"updateTime\":\"2026-05-18 00:05:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:13', 18);
INSERT INTO `sys_oper_log` VALUES (202, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":1,\"updateTime\":\"2026-05-18 00:05:24\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:24', 12);
INSERT INTO `sys_oper_log` VALUES (203, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":2,\"updateTime\":\"2026-05-18 00:05:34\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:34', 12);
INSERT INTO `sys_oper_log` VALUES (204, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":3,\"updateTime\":\"2026-05-18 00:05:37\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:37', 13);
INSERT INTO `sys_oper_log` VALUES (205, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":4,\"updateTime\":\"2026-05-18 00:05:40\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:40', 12);
INSERT INTO `sys_oper_log` VALUES (206, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":5,\"updateTime\":\"2026-05-18 00:05:43\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:43', 12);
INSERT INTO `sys_oper_log` VALUES (207, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":6,\"updateTime\":\"2026-05-18 00:05:47\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:47', 11);
INSERT INTO `sys_oper_log` VALUES (208, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"1\",\"status\":\"0\",\"unitId\":7,\"updateTime\":\"2026-05-18 00:05:50\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 00:05:50', 17);
INSERT INTO `sys_oper_log` VALUES (209, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.batchEdit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit/batch', '127.0.0.1', '内网IP', '{\"unitIds\":[8,9],\"damageRemark\":\" \"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-18 22:14:06', 28);
INSERT INTO `sys_oper_log` VALUES (210, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/7', '127.0.0.1', '内网IP', '7 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-20 23:07:25', 203);
INSERT INTO `sys_oper_log` VALUES (211, '预约订单拒绝', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.reject()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/reject/8', '127.0.0.1', '内网IP', '8 {\"rejectReason\":\"设备因损坏库存不足\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-20 23:08:52', 18);
INSERT INTO `sys_oper_log` VALUES (212, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/9', '127.0.0.1', '内网IP', '9 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 16:10:03', 44);
INSERT INTO `sys_oper_log` VALUES (213, '预约订单归还', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.returnOrder()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/return/9', '127.0.0.1', '内网IP', '9 {\"returnStatus\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 16:12:18', 28);
INSERT INTO `sys_oper_log` VALUES (214, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/7', '127.0.0.1', '内网IP', '7 {\"verifyDetails\":[{\"unitCode\":\"test-001-001\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 17:53:00', 59);
INSERT INTO `sys_oper_log` VALUES (215, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/7', '127.0.0.1', '内网IP', '7 {\"verifyDetails\":[{\"unitCode\":\"test-001-002\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-003\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-004\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-005\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-006\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-007\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-010\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 17:53:15', 105);
INSERT INTO `sys_oper_log` VALUES (216, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/10', '127.0.0.1', '内网IP', '10 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 17:59:29', 20);
INSERT INTO `sys_oper_log` VALUES (217, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/10', '127.0.0.1', '内网IP', '10 {\"verifyDetails\":[{\"returnQuantity\":4,\"damageQuantity\":1,\"damageRemark\":\"一个漏气\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:00:21', 30);
INSERT INTO `sys_oper_log` VALUES (218, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/10', '127.0.0.1', '内网IP', '10 {\"verifyDetails\":[{\"returnQuantity\":0,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', NULL, 1, '当前订单状态不允许核验归还', '2026-05-21 18:00:23', 13);
INSERT INTO `sys_oper_log` VALUES (219, '预约订单', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-05-17 23:35:26\",\"equipmentId\":19,\"equipmentImage\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png\",\"equipmentName\":\"通风橱\",\"expectReturnTime\":\"2026-05-19 00:00:00\",\"grade\":\"\",\"major\":\"\",\"orderId\":6,\"orderStatus\":\"3\",\"params\":{},\"phone\":\"\",\"quantity\":10,\"realName\":\"\",\"rejectReason\":\"\",\"reserveTime\":\"2026-05-18 00:00:00\",\"returnStatus\":\"0\",\"studentNo\":\"\",\"trackUnit\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-05-21 18:10:07\",\"userId\":1,\"userName\":\"若依\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:10:07', 30);
INSERT INTO `sys_oper_log` VALUES (220, '预约订单', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"approveTime\":\"2026-05-17 23:26:51\",\"approverId\":1,\"approverName\":\"admin\",\"assignedUnitCodes\":\"test-001-001,test-001-002,test-001-003,test-001-004,test-001-005,test-001-006,test-001-007,test-001-008,test-001-009,test-001-011,test-001-012,test-001-013,test-001-014,test-001-015,test-001-016,test-001-017,test-001-018,test-001-019,test-001-020,test-001-021,test-001-022,test-001-023,test-001-024,test-001-025,test-001-026,test-001-027,test-001-028,test-001-029,test-001-030,test-001-031,test-001-032,test-001-033,test-001-034,test-001-035,test-001-036,test-001-037,test-001-038,test-001-039,test-001-040,test-001-041,test-001-042,test-001-043,test-001-044,test-001-045,test-001-046,test-001-047,test-001-048,test-001-049,test-001-050,test-001-051\",\"createBy\":\"admin\",\"createTime\":\"2026-05-17 23:26:32\",\"equipmentId\":21,\"equipmentName\":\"test--设备单元管理测试\",\"expectReturnTime\":\"2026-05-19 00:00:00\",\"grade\":\"\",\"major\":\"\",\"orderId\":5,\"orderStatus\":\"3\",\"params\":{},\"phone\":\"\",\"quantity\":50,\"realName\":\"\",\"rejectReason\":\"\",\"reserveTime\":\"2026-05-17 00:00:00\",\"returnStatus\":\"3\",\"studentNo\":\"\",\"trackUnit\":\"1\",\"updateBy\":\"\",\"updateTime\":\"2026-05-21 18:10:26\",\"userId\":1,\"userName\":\"若依\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:10:26', 7);
INSERT INTO `sys_oper_log` VALUES (221, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/11', '127.0.0.1', '内网IP', '11 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:21:36', 53);
INSERT INTO `sys_oper_log` VALUES (222, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/11', '127.0.0.1', '内网IP', '11 {\"verifyDetails\":[{\"unitCode\":\"test-001-001\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-002\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:22:04', 33);
INSERT INTO `sys_oper_log` VALUES (223, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/7', '127.0.0.1', '内网IP', '7 {\"verifyDetails\":[{\"unitCode\":\"test-001-011\",\"returnStatus\":\"3\",\"damageRemark\":\"test\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:41:38', 471);
INSERT INTO `sys_oper_log` VALUES (224, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/7', '127.0.0.1', '内网IP', '7 {\"verifyDetails\":[{\"unitCode\":\"test-001-012\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:41:40', 52);
INSERT INTO `sys_oper_log` VALUES (225, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/12', '127.0.0.1', '内网IP', '[12] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:41:46', 16);
INSERT INTO `sys_oper_log` VALUES (226, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\"test\",\"params\":{},\"returnStatus\":\"2\",\"status\":\"0\",\"unitId\":11,\"updateTime\":\"2026-05-21 18:44:32\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 18:44:32', 32);
INSERT INTO `sys_oper_log` VALUES (227, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"2\",\"status\":\"0\",\"unitId\":8,\"updateTime\":\"2026-05-21 19:04:52\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:04:52', 20);
INSERT INTO `sys_oper_log` VALUES (228, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit', '127.0.0.1', '内网IP', '{\"damageRemark\":\" \",\"params\":{},\"returnStatus\":\"2\",\"status\":\"0\",\"unitId\":9,\"updateTime\":\"2026-05-21 19:05:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:05:09', 21);
INSERT INTO `sys_oper_log` VALUES (229, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/13', '127.0.0.1', '内网IP', '13 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:19:43', 112);
INSERT INTO `sys_oper_log` VALUES (230, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/13', '127.0.0.1', '内网IP', '13 {\"verifyDetails\":[{\"unitCode\":\"test-001-001\",\"returnStatus\":\"3\",\"damageRemark\":\"test\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:20:05', 56);
INSERT INTO `sys_oper_log` VALUES (231, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/15', '127.0.0.1', '内网IP', '15 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:22:31', 186);
INSERT INTO `sys_oper_log` VALUES (232, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/15', '127.0.0.1', '内网IP', '15 {\"verifyDetails\":[{\"unitCode\":\"test-001-002\",\"returnStatus\":\"3\",\"damageRemark\":\"test\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:23:46', 41);
INSERT INTO `sys_oper_log` VALUES (233, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/15', '127.0.0.1', '内网IP', '15 {\"verifyDetails\":[{\"unitCode\":\"test-001-003\",\"returnStatus\":\"3\",\"damageRemark\":\"test\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:23:56', 35);
INSERT INTO `sys_oper_log` VALUES (234, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/15', '127.0.0.1', '内网IP', '15 {\"verifyDetails\":[{\"unitCode\":\"test-001-004\",\"returnStatus\":\"3\",\"damageRemark\":\"test\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:24:06', 31);
INSERT INTO `sys_oper_log` VALUES (235, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/15', '127.0.0.1', '内网IP', '15 {\"verifyDetails\":[{\"unitCode\":\"test-001-005\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-006\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-007\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-008\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-009\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-010\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-011\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-012\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-013\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-014\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-015\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-016\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-017\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-018\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-019\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-020\",\"returnStatus\":\"2\",\"damageRemark\":\"\"},{\"unitCode\":\"test-001-021\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:24:12', 147);
INSERT INTO `sys_oper_log` VALUES (236, '预约订单', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001\",\"createBy\":\"admin\",\"createTime\":\"2026-05-21 18:57:56\",\"equipmentId\":21,\"equipmentName\":\"test--设备单元管理测试\",\"expectReturnTime\":\"2026-05-23 00:00:00\",\"grade\":\"1\",\"loginName\":\"admin\",\"major\":\"1\",\"orderId\":14,\"orderStatus\":\"1\",\"params\":{},\"phone\":\"1\",\"quantity\":1,\"realName\":\"admin\",\"rejectReason\":\"\",\"remark\":\"1\",\"reserveTime\":\"2026-05-22 00:00:00\",\"returnStatus\":\"4\",\"studentNo\":\"1\",\"trackUnit\":\"1\",\"updateBy\":\"\",\"updateTime\":\"2026-05-21 19:25:19\",\"userId\":1,\"userName\":\"若依\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:25:19', 29);
INSERT INTO `sys_oper_log` VALUES (237, '预约订单', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder', '127.0.0.1', '内网IP', '{\"assignedUnitCodes\":\"test-001-001\",\"createBy\":\"admin\",\"createTime\":\"2026-05-21 18:57:56\",\"equipmentId\":21,\"equipmentName\":\"test--设备单元管理测试\",\"expectReturnTime\":\"2026-05-23 00:00:00\",\"grade\":\"1\",\"loginName\":\"admin\",\"major\":\"1\",\"orderId\":14,\"orderStatus\":\"5\",\"params\":{},\"phone\":\"1\",\"quantity\":1,\"realName\":\"admin\",\"rejectReason\":\"\",\"remark\":\"1\",\"reserveTime\":\"2026-05-22 00:00:00\",\"returnStatus\":\"4\",\"studentNo\":\"1\",\"trackUnit\":\"1\",\"updateBy\":\"\",\"updateTime\":\"2026-05-21 19:25:29\",\"userId\":1,\"userName\":\"若依\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:25:29', 7);
INSERT INTO `sys_oper_log` VALUES (238, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/16', '127.0.0.1', '内网IP', '16 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:26:41', 45);
INSERT INTO `sys_oper_log` VALUES (239, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/16', '127.0.0.1', '内网IP', '16 {\"verifyDetails\":[{\"unitCode\":\"test-001-005\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:27:02', 30);
INSERT INTO `sys_oper_log` VALUES (240, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/16', '127.0.0.1', '内网IP', '16 {\"verifyDetails\":[{\"unitCode\":\"test-001-006\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:27:02', 26);
INSERT INTO `sys_oper_log` VALUES (241, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/16', '127.0.0.1', '内网IP', '16 {\"verifyDetails\":[{\"unitCode\":\"test-001-007\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:27:03', 26);
INSERT INTO `sys_oper_log` VALUES (242, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/16', '127.0.0.1', '内网IP', '16 {\"verifyDetails\":[{\"unitCode\":\"test-001-008\",\"returnStatus\":\"2\",\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:27:03', 23);
INSERT INTO `sys_oper_log` VALUES (243, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/16', '127.0.0.1', '内网IP', '16 {\"verifyDetails\":[{\"unitCode\":\"test-001-009\",\"returnStatus\":\"3\",\"damageRemark\":\"test\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:27:12', 24);
INSERT INTO `sys_oper_log` VALUES (244, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/16', '127.0.0.1', '内网IP', '16 {\"verifyDetails\":[{\"unitCode\":\"test-001-010\",\"returnStatus\":\"3\",\"damageRemark\":\"test\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:27:18', 25);
INSERT INTO `sys_oper_log` VALUES (245, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.batchEdit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit/batch', '127.0.0.1', '内网IP', '{\"unitIds\":[2,3,4,10,9],\"status\":\"0\",\"returnStatus\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:28:06', 67);
INSERT INTO `sys_oper_log` VALUES (246, '设备单元', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentUnitController.batchEdit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment/unit/batch', '127.0.0.1', '内网IP', '{\"unitIds\":[1],\"status\":\"0\",\"returnStatus\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:28:20', 17);
INSERT INTO `sys_oper_log` VALUES (247, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/16', '127.0.0.1', '内网IP', '[16] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:28:47', 10);
INSERT INTO `sys_oper_log` VALUES (248, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/8', '127.0.0.1', '内网IP', '[8] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:29:23', 5);
INSERT INTO `sys_oper_log` VALUES (249, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/9,7,6,5,4', '127.0.0.1', '内网IP', '[9,7,6,5,4] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:29:40', 7);
INSERT INTO `sys_oper_log` VALUES (250, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/2,3,13,14', '127.0.0.1', '内网IP', '[2,3,13,14] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:29:50', 5);
INSERT INTO `sys_oper_log` VALUES (251, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/17', '127.0.0.1', '内网IP', '17 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 19:43:10', 26);
INSERT INTO `sys_oper_log` VALUES (252, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":6,\"categoryName\":\"土木建筑设备\",\"createBy\":\"admin\",\"createTime\":\"2026-05-16 23:33:14\",\"damagedStock\":7,\"delFlag\":\"0\",\"equipmentId\":21,\"equipmentName\":\"test--设备单元管理测试\",\"location\":\"201\",\"params\":{},\"remainStock\":100,\"status\":\"0\",\"totalStock\":100,\"trackUnit\":\"0\",\"updateTime\":\"2026-05-21 23:17:20\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:17:20', 41);
INSERT INTO `sys_oper_log` VALUES (253, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":34,\"categoryName\":\"测量设备\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":0,\"delFlag\":\"0\",\"description\":\"工程测量全站仪\",\"equipmentId\":11,\"equipmentName\":\"全站仪\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png\",\"location\":\"土木实验室801\",\"params\":{},\"remainStock\":8,\"remark\":\"土木测量专用\",\"status\":\"0\",\"totalStock\":8,\"trackUnit\":\"1\",\"unitCodePrefix\":\"示波器-01\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:22:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:22:09', 9);
INSERT INTO `sys_oper_log` VALUES (254, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":34,\"categoryName\":\"测量设备\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":0,\"delFlag\":\"0\",\"description\":\"工程测量全站仪\",\"equipmentId\":11,\"equipmentName\":\"全站仪\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png\",\"location\":\"土木实验室801\",\"params\":{},\"remainStock\":8,\"remark\":\"土木测量专用\",\"status\":\"0\",\"totalStock\":8,\"trackUnit\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:26:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:26:44', 8);
INSERT INTO `sys_oper_log` VALUES (255, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":20,\"categoryName\":\"基础电子器件\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":0,\"delFlag\":\"0\",\"description\":\"各种阻值电阻\",\"equipmentId\":5,\"equipmentName\":\"电阻包\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/8c85c877fd6447eb9fb65a3496558dc4.png\",\"location\":\"电子实验室401\",\"params\":{},\"remainStock\":100,\"remark\":\"电子实验专用\",\"status\":\"0\",\"totalStock\":100,\"trackUnit\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:32:49\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:32:49', 9);
INSERT INTO `sys_oper_log` VALUES (256, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":37,\"categoryName\":\"球类器材\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":2,\"delFlag\":\"0\",\"description\":\"标准7号篮球\",\"equipmentId\":12,\"equipmentName\":\"篮球\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/487031bfcac14a79bb0e10ddea7b3254.png\",\"location\":\"体育馆901\",\"params\":{},\"remainStock\":48,\"remark\":\"体育教学专用\",\"status\":\"0\",\"totalStock\":50,\"trackUnit\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:33:49\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:33:49', 11);
INSERT INTO `sys_oper_log` VALUES (257, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":25,\"categoryName\":\"PC计算机\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":0,\"delFlag\":\"0\",\"description\":\"i5/16G/512G台式机\",\"equipmentId\":7,\"equipmentName\":\"台式计算机\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/5bbf7506fdc3451d8c636319c4b698c5.png\",\"location\":\"计算机房501\",\"params\":{},\"remainStock\":60,\"remark\":\"计算机教学专用\",\"status\":\"0\",\"totalStock\":60,\"trackUnit\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:36:07\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:36:07', 13);
INSERT INTO `sys_oper_log` VALUES (258, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":21,\"categoryName\":\"实验箱/开发板\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":0,\"delFlag\":\"0\",\"description\":\"模拟电路实验\",\"equipmentId\":6,\"equipmentName\":\"模电实验箱\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/515171478c5f4f5e870f136a5be71885.png\",\"location\":\"电子实验室401\",\"params\":{},\"remainStock\":20,\"remark\":\"电子实验专用\",\"status\":\"0\",\"totalStock\":20,\"trackUnit\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:36:36\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:36:36', 8);
INSERT INTO `sys_oper_log` VALUES (259, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":39,\"categoryName\":\"健身器材\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":0,\"delFlag\":\"0\",\"description\":\"1-10kg哑铃\",\"equipmentId\":13,\"equipmentName\":\"哑铃套装\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/5d41574b6e8d4c7f9c01f7c8d747f03b.png\",\"location\":\"健身室903\",\"params\":{},\"remainStock\":40,\"remark\":\"健身训练专用\",\"status\":\"0\",\"totalStock\":40,\"trackUnit\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:39:27\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:39:27', 12);
INSERT INTO `sys_oper_log` VALUES (260, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/5', '127.0.0.1', '内网IP', '[5] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:43:00', 14);
INSERT INTO `sys_oper_log` VALUES (261, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":21,\"createBy\":\"admin\",\"createTime\":\"2026-05-21 23:46:09\",\"delFlag\":\"0\",\"description\":\"模拟电路实验\",\"equipmentId\":22,\"equipmentName\":\"模电实验箱\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/b6d61315a7b3405aa52b925d5ee0316a.png\",\"location\":\"电子实验室401\",\"params\":{},\"remainStock\":70,\"remark\":\"电子实验专用\",\"status\":\"0\",\"totalStock\":70,\"trackUnit\":\"1\",\"unitCodePrefix\":\"模电实验箱-01\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:46:09', 42);
INSERT INTO `sys_oper_log` VALUES (262, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/6', '127.0.0.1', '内网IP', '[6] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:46:33', 5);
INSERT INTO `sys_oper_log` VALUES (263, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/21', '127.0.0.1', '内网IP', '[21] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:46:38', 6);
INSERT INTO `sys_oper_log` VALUES (264, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/8', '127.0.0.1', '内网IP', '[8] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:48:39', 11);
INSERT INTO `sys_oper_log` VALUES (265, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":27,\"createBy\":\"admin\",\"createTime\":\"2026-05-21 23:49:47\",\"delFlag\":\"0\",\"description\":\"24口千兆交换机\",\"equipmentId\":23,\"equipmentName\":\"千兆交换机\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/7492014fec8d4fc0a313e4b424a3b834.png\",\"location\":\"网络机房503\",\"params\":{},\"remainStock\":60,\"remark\":\"网络设备专用\",\"status\":\"0\",\"totalStock\":60,\"trackUnit\":\"1\",\"unitCodePrefix\":\"千兆交换机-01\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:49:47', 28);
INSERT INTO `sys_oper_log` VALUES (266, '设备', 2, 'com.ruoyi.equipment.info.controller.EqEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":30,\"categoryName\":\"机床设备\",\"createBy\":\"admin\",\"createTime\":\"2026-05-07 00:00:00\",\"damagedStock\":0,\"delFlag\":\"0\",\"description\":\"教学用普通车床\",\"equipmentId\":9,\"equipmentName\":\"普通车床\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/default_equipment.png\",\"location\":\"机械车间701\",\"params\":{},\"remainStock\":5,\"remark\":\"机械加工专用\",\"status\":\"0\",\"totalStock\":5,\"trackUnit\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-21 23:51:40\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:51:40', 7);
INSERT INTO `sys_oper_log` VALUES (267, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/9', '127.0.0.1', '内网IP', '[9] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:51:44', 6);
INSERT INTO `sys_oper_log` VALUES (268, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":30,\"createBy\":\"admin\",\"createTime\":\"2026-05-21 23:54:40\",\"delFlag\":\"0\",\"description\":\"教学用普通车床\",\"equipmentId\":24,\"equipmentName\":\"普通车床\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/e32bb55adc23491cb6e2c004a518ac7f.png\",\"location\":\"机械与汽车工程学院--机械车间104\",\"params\":{},\"remainStock\":5,\"remark\":\"机械加工专用\",\"status\":\"0\",\"totalStock\":5,\"trackUnit\":\"1\",\"unitCodePrefix\":\"普通车床\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:54:40', 17);
INSERT INTO `sys_oper_log` VALUES (269, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/10', '127.0.0.1', '内网IP', '[10] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:55:01', 7);
INSERT INTO `sys_oper_log` VALUES (270, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":33,\"createBy\":\"admin\",\"createTime\":\"2026-05-21 23:57:16\",\"delFlag\":\"0\",\"description\":\"熔融沉积3D打印机\\n\",\"equipmentId\":25,\"equipmentName\":\"FAM3D打印机\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/aeb97cbc33a644a995e18989448d89d3.png\",\"location\":\"实训中心--创新实验室301\",\"params\":{},\"remainStock\":15,\"remark\":\"3D打印专用\",\"status\":\"0\",\"totalStock\":15,\"trackUnit\":\"1\",\"unitCodePrefix\":\"FDM3D打印机\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:57:16', 15);
INSERT INTO `sys_oper_log` VALUES (271, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/11', '127.0.0.1', '内网IP', '[11] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:57:54', 6);
INSERT INTO `sys_oper_log` VALUES (272, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":34,\"createBy\":\"admin\",\"createTime\":\"2026-05-21 23:59:20\",\"delFlag\":\"0\",\"description\":\"工程测量全站仪\",\"equipmentId\":26,\"equipmentName\":\"全站仪\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/8379182dd0ff4091890ced5c4b22a446.png\",\"location\":\"机械与汽车学院--土木实验室204\",\"params\":{},\"remainStock\":8,\"remark\":\"工程测量专用\",\"status\":\"0\",\"totalStock\":8,\"trackUnit\":\"1\",\"unitCodePrefix\":\"全站仪\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-21 23:59:20', 16);
INSERT INTO `sys_oper_log` VALUES (273, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/14', '127.0.0.1', '内网IP', '[14] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:04:16', 7);
INSERT INTO `sys_oper_log` VALUES (274, '设备', 3, 'com.ruoyi.equipment.info.controller.EqEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/equipment/15,16,18,19,17,20', '127.0.0.1', '内网IP', '[15,16,18,19,17,20] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:04:27', 8);
INSERT INTO `sys_oper_log` VALUES (275, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":41,\"createBy\":\"admin\",\"createTime\":\"2026-05-22 00:05:43\",\"delFlag\":\"0\",\"description\":\"交互式智慧黑板\",\"equipmentId\":27,\"equipmentName\":\"智慧黑板\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/318ffb25d0594d0cbe1bafcf44ed2e33.png\",\"location\":\"第一教学楼--设备房104\",\"params\":{},\"remainStock\":20,\"remark\":\"通识教学专用\",\"status\":\"0\",\"totalStock\":20,\"trackUnit\":\"1\",\"unitCodePrefix\":\"智慧黑板\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:05:43', 24);
INSERT INTO `sys_oper_log` VALUES (276, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":42,\"createBy\":\"admin\",\"createTime\":\"2026-05-22 00:07:16\",\"delFlag\":\"0\",\"description\":\"标准课桌椅\",\"equipmentId\":28,\"equipmentName\":\"学生课桌椅\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/0c54b01f09d34f0d981d160c2f4be9a0.png\",\"location\":\"第一教学楼--设备房105、第二教学楼---设备房间102\",\"params\":{},\"remainStock\":200,\"remark\":\"办公教学专用\",\"status\":\"0\",\"totalStock\":200,\"trackUnit\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:07:16', 7);
INSERT INTO `sys_oper_log` VALUES (277, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":43,\"createBy\":\"admin\",\"createTime\":\"2026-05-22 00:09:46\",\"delFlag\":\"0\",\"description\":\"学生实验操作台\",\"equipmentId\":29,\"equipmentName\":\"实验台\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/06e06ec2673c4c038d82c6d56b195b6c.png\",\"location\":\"生命科学院--104、环境与化学工程学院--207\",\"params\":{},\"remainStock\":40,\"remark\":\"实验室备用\",\"status\":\"0\",\"totalStock\":40,\"trackUnit\":\"1\",\"unitCodePrefix\":\"实验台\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:09:46', 24);
INSERT INTO `sys_oper_log` VALUES (278, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/11', '127.0.0.1', '内网IP', '[11] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:10:16', 7);
INSERT INTO `sys_oper_log` VALUES (279, '预约订单', 3, 'com.ruoyi.equipment.order.controller.ResOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/resOrder/15', '127.0.0.1', '内网IP', '[15] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:10:18', 9);
INSERT INTO `sys_oper_log` VALUES (280, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":44,\"createBy\":\"admin\",\"createTime\":\"2026-05-22 00:12:10\",\"delFlag\":\"0\",\"description\":\"电阻电容等备件\",\"equipmentId\":30,\"equipmentName\":\"电子元件备件\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/bd693daf858e4b4394be70a76577f13f.png\",\"location\":\"实训中心--备件库307\",\"params\":{},\"remainStock\":200,\"remark\":\"备品备件专用\",\"status\":\"0\",\"totalStock\":200,\"trackUnit\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:12:10', 10);
INSERT INTO `sys_oper_log` VALUES (281, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":12,\"createBy\":\"admin\",\"createTime\":\"2026-05-22 00:13:56\",\"delFlag\":\"0\",\"description\":\"0-30V可调直流电源\",\"equipmentId\":31,\"equipmentName\":\"直流电源\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/b9328b9967ef4ac18eda2e5169a5d6c1.png\",\"location\":\"物理实验室103\",\"params\":{},\"remainStock\":120,\"remark\":\"电磁学实验专用\",\"status\":\"0\",\"totalStock\":120,\"trackUnit\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:13:56', 7);
INSERT INTO `sys_oper_log` VALUES (282, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":22,\"createBy\":\"admin\",\"createTime\":\"2026-05-22 00:15:50\",\"delFlag\":\"0\",\"description\":\"100MHz数字示波器\",\"equipmentId\":32,\"equipmentName\":\"数字示波器\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/a06b33bba23744b7889ca454ca3e67a2.png\",\"location\":\"电子实验室402\",\"params\":{},\"remainStock\":20,\"remark\":\"电子测量专用\",\"status\":\"0\",\"totalStock\":20,\"trackUnit\":\"1\",\"unitCodePrefix\":\"数字示波器\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:15:50', 16);
INSERT INTO `sys_oper_log` VALUES (283, '设备', 1, 'com.ruoyi.equipment.info.controller.EqEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/system/equipment', '127.0.0.1', '内网IP', '{\"categoryId\":37,\"createBy\":\"admin\",\"createTime\":\"2026-05-22 00:17:16\",\"delFlag\":\"0\",\"description\":\"标准足球\",\"equipmentId\":33,\"equipmentName\":\"足球\",\"image\":\"https://cers-equipment-ganyu.oss-cn-beijing.aliyuncs.com/equipment/images/23658c8decc0414ea598200bb5a030c3.png\",\"location\":\"体育馆--102\",\"params\":{},\"remainStock\":200,\"remark\":\"足球\",\"status\":\"0\",\"totalStock\":200,\"trackUnit\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:17:16', 11);
INSERT INTO `sys_oper_log` VALUES (284, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/19', '127.0.0.1', '内网IP', '19 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 00:20:09', 65);
INSERT INTO `sys_oper_log` VALUES (285, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-05-05 22:25:20\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,2000,2001,2002,2003,2004,2005,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018],\"params\":{},\"remark\":\"预约单审批员\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"预约单审批员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 17:04:38', 85);
INSERT INTO `sys_oper_log` VALUES (286, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-05-05 22:25:20\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,2000,2001,2002,2003,2004,2005,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018],\"params\":{},\"remark\":\"预约单审批员\",\"roleId\":2,\"roleKey\":\"auditor\",\"roleName\":\"预约单审批员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 17:33:11', 33);
INSERT INTO `sys_oper_log` VALUES (287, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"普通用户\",\"roleId\":100,\"roleKey\":\"common\",\"roleName\":\"普通用户\",\"roleSort\":3,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 17:33:37', 26);
INSERT INTO `sys_oper_log` VALUES (288, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-05-22 17:33:37\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"remark\":\"普通用户\",\"roleId\":100,\"roleKey\":\"common\",\"roleName\":\"普通用户\",\"roleSort\":3,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 17:34:16', 16);
INSERT INTO `sys_oper_log` VALUES (289, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2026-05-05 22:25:21\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 18:13:42', 49);
INSERT INTO `sys_oper_log` VALUES (290, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'ganyu', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/05/22/93de378ea1594c7193312d366a300174.png\",\"code\":200}', 0, NULL, '2026-05-22 18:49:47', 244);
INSERT INTO `sys_oper_log` VALUES (291, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'ganyu', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2026/05/22/93de378ea1594c7193312d366a300174.png\",\"createTime\":\"2026-05-22 18:45:36\",\"delFlag\":\"0\",\"email\":\"3050348752@qq.com\",\"nickName\":\"甘宇\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"13760095982\",\"pwdUpdateDate\":\"2026-05-22 18:45:36\",\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{\"@type\":\"java.util.HashMap\"},\"roleId\":100,\"roleKey\":\"common\",\"roleName\":\"普通用户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"ganyu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 18:50:44', 26);
INSERT INTO `sys_oper_log` VALUES (292, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/user/100', '127.0.0.1', '内网IP', '[100] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 18:52:59', 17);
INSERT INTO `sys_oper_log` VALUES (293, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/20', '127.0.0.1', '内网IP', '20 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 18:59:26', 33);
INSERT INTO `sys_oper_log` VALUES (294, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'zhangxueyou', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-05-22 18:55:00\",\"delFlag\":\"0\",\"email\":\"zhangxueyou@163.com\",\"nickName\":\"张学友\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"13760090001\",\"pwdUpdateDate\":\"2026-05-22 18:55:00\",\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{\"@type\":\"java.util.HashMap\"},\"roleId\":100,\"roleKey\":\"common\",\"roleName\":\"普通用户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":102,\"userName\":\"zhangxueyou\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 19:06:59', 14);
INSERT INTO `sys_oper_log` VALUES (295, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/20', '127.0.0.1', '内网IP', '20 {\"verifyDetails\":[{\"returnQuantity\":5,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-27 18:02:59', 110);
INSERT INTO `sys_oper_log` VALUES (296, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/20', '127.0.0.1', '内网IP', '20 {\"verifyDetails\":[{\"returnQuantity\":0,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', NULL, 1, '当前订单状态不允许核验归还', '2026-05-27 18:03:02', 22);
INSERT INTO `sys_oper_log` VALUES (297, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/20', '127.0.0.1', '内网IP', '20 {\"verifyDetails\":[{\"returnQuantity\":0,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', NULL, 1, '当前订单状态不允许核验归还', '2026-05-27 18:03:04', 9);
INSERT INTO `sys_oper_log` VALUES (298, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-28 23:30:06', 75);
INSERT INTO `sys_oper_log` VALUES (299, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/21', '127.0.0.1', '内网IP', '21 {\"verifyDetails\":[{\"returnQuantity\":5,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-28 23:35:57', 42);
INSERT INTO `sys_oper_log` VALUES (300, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/21', '127.0.0.1', '内网IP', '21 {\"verifyDetails\":[{\"returnQuantity\":0,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', NULL, 1, '当前订单状态不允许核验归还', '2026-05-28 23:35:59', 13);
INSERT INTO `sys_oper_log` VALUES (301, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/22', '127.0.0.1', '内网IP', '22 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-28 23:50:18', 38);
INSERT INTO `sys_oper_log` VALUES (302, '预约订单拒绝', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.reject()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/reject/23', '127.0.0.1', '内网IP', '23 {\"rejectReason\":\"设备准备全部更新，暂停预约\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 00:00:20', 28);
INSERT INTO `sys_oper_log` VALUES (303, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/22', '127.0.0.1', '内网IP', '22 {\"verifyDetails\":[{\"returnQuantity\":1,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 23:16:10', 79);
INSERT INTO `sys_oper_log` VALUES (304, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/24', '127.0.0.1', '内网IP', '24 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 23:36:49', 19);
INSERT INTO `sys_oper_log` VALUES (305, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/24', '127.0.0.1', '内网IP', '24 {\"verifyDetails\":[{\"returnQuantity\":1,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 23:40:38', 28);
INSERT INTO `sys_oper_log` VALUES (306, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/25', '127.0.0.1', '内网IP', '25 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 23:42:03', 43);
INSERT INTO `sys_oper_log` VALUES (307, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/25', '127.0.0.1', '内网IP', '25 {\"verifyDetails\":[{\"returnQuantity\":1,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 23:44:34', 23);
INSERT INTO `sys_oper_log` VALUES (308, '催还提醒', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.urgeReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/urgeReturn/19', '127.0.0.1', '内网IP', '19 ', '{\"msg\":\"催还消息已发送\",\"code\":200}', 0, NULL, '2026-05-30 00:02:05', 45);
INSERT INTO `sys_oper_log` VALUES (309, '催还提醒', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.urgeReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/urgeReturn/17', '127.0.0.1', '内网IP', '17 ', '{\"msg\":\"催还消息已发送\",\"code\":200}', 0, NULL, '2026-05-30 00:02:09', 13);
INSERT INTO `sys_oper_log` VALUES (310, '预约订单审批', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.approve()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/approve/26', '127.0.0.1', '内网IP', '26 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 00:20:42', 50);
INSERT INTO `sys_oper_log` VALUES (311, '归还核验', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.verifyReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/verifyReturn/26', '127.0.0.1', '内网IP', '26 {\"verifyDetails\":[{\"returnQuantity\":20,\"damageQuantity\":0,\"damageRemark\":\"\"}]} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 00:22:43', 33);
INSERT INTO `sys_oper_log` VALUES (312, '催还提醒', 2, 'com.ruoyi.equipment.order.controller.ResOrderController.urgeReturn()', 'PUT', 1, 'admin', '研发部门', '/system/resOrder/urgeReturn/17', '127.0.0.1', '内网IP', '17 ', '{\"msg\":\"催还消息已发送\",\"code\":200}', 0, NULL, '2026-06-12 10:55:15', 34);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-05-05 22:25:20', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-05-05 22:25:20', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-05-05 22:25:20', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '预约单审批员', 'auditor', 2, '2', 1, 1, '0', '0', 'admin', '2026-05-05 22:25:20', 'admin', '2026-05-22 17:33:11', '预约单审批员');
INSERT INTO `sys_role` VALUES (100, '普通用户', 'common', 3, '5', 1, 1, '0', '0', 'admin', '2026-05-22 17:33:37', '', '2026-05-22 17:34:16', '普通用户');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1090);
INSERT INTO `sys_role_menu` VALUES (1, 1091);
INSERT INTO `sys_role_menu` VALUES (1, 1092);
INSERT INTO `sys_role_menu` VALUES (1, 1093);
INSERT INTO `sys_role_menu` VALUES (1, 1094);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2013);
INSERT INTO `sys_role_menu` VALUES (2, 2014);
INSERT INTO `sys_role_menu` VALUES (2, 2015);
INSERT INTO `sys_role_menu` VALUES (2, 2016);
INSERT INTO `sys_role_menu` VALUES (2, 2017);
INSERT INTO `sys_role_menu` VALUES (2, 2018);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-06-12 12:13:59', '2026-05-05 22:25:20', 'admin', '2026-05-05 22:25:20', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-05 22:25:20', '2026-05-05 22:25:20', 'admin', '2026-05-05 22:25:20', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 100, 'test', 'test', '00', '', '', '0', '', '$2a$10$x/2CXUUgfsev3xnNmbAfIeXKm3w2LVbvCHyU0Ed.5E37uIjCjrWIW', '0', '2', '127.0.0.1', '2026-05-21 19:37:29', NULL, 'admin', '2026-05-05 22:36:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (101, NULL, 'ganyu', '甘宇', '00', '3050348752@qq.com', '13760095982', '0', '/profile/avatar/2026/05/22/93de378ea1594c7193312d366a300174.png', '$2a$10$x1ScfVadqtyCZQr6.5t1h.9Tlmm6D5ZkQiqaKGBynevxXG4IDdwLO', '0', '0', '127.0.0.1', '2026-05-30 01:12:27', '2026-05-22 18:45:36', '', '2026-05-22 18:45:36', '', '2026-05-22 18:50:44', NULL);
INSERT INTO `sys_user` VALUES (102, NULL, 'zhangxueyou', '张学友', '00', 'zhangxueyou@163.com', '13760090001', '0', '', '$2a$10$FvCXYrn2ava0yS6Qg/pVLO1kiTs08eLJM3n.ely7FP5Q/aJCp90OK', '0', '0', '127.0.0.1', '2026-06-12 11:45:44', '2026-05-22 18:55:00', '', '2026-05-22 18:55:00', '', '2026-05-22 19:06:59', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_profile
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_profile`;
CREATE TABLE `sys_user_profile`  (
  `profile_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户ID（关联sys_user）',
  `student_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '学号/工号',
  `grade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '年级',
  `major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '专业',
  `real_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '真实姓名（冗余，方便查询）',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号（冗余）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`profile_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_student_no`(`student_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户扩展信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_profile
-- ----------------------------
INSERT INTO `sys_user_profile` VALUES (1, 101, '202324111213', '23级计科2班', '计算机科学与技术', '甘宇', '13760095982', 'ganyu', '2026-05-22 18:45:36', '', NULL, NULL);
INSERT INTO `sys_user_profile` VALUES (2, 102, '202324111201', '23级计科2班', '计算机科学与技术', '张学友', '13760090001', 'zhangxueyou', '2026-05-22 18:55:00', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (101, 100);
INSERT INTO `sys_user_role` VALUES (102, 100);

SET FOREIGN_KEY_CHECKS = 1;
