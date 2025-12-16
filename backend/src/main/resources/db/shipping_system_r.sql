/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724 (5.7.24)
 Source Host           : localhost:3306
 Source Schema         : shipping_system

 Target Server Type    : MySQL
 Target Server Version : 50724 (5.7.24)
 File Encoding         : 65001

 Date: 14/05/2025 22:25:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cargo
-- ----------------------------
DROP TABLE IF EXISTS `cargo`;
CREATE TABLE `cargo`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ship_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船名',
  `origin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '始发地',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '目的地',
  `loading_time` datetime NOT NULL COMMENT '预装时间',
  `cargo_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货物种类',
  `weight` decimal(10, 2) NOT NULL COMMENT '货物吨数',
  `volume` decimal(10, 2) NOT NULL COMMENT '货物体积',
  `price` decimal(10, 2) NOT NULL COMMENT '运输价格',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '运输状态',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `date` datetime NOT NULL COMMENT '日期',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '航运货物表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cargo
-- ----------------------------
INSERT INTO `cargo` VALUES (1, 'OceanVoyager', '上海港', '鹿特丹港', '2024-03-20 08:00:00', '电子产品', 5000.00, 2000.00, 150000.00, '待运输', 'admin', '2024-03-19 00:00:00', '上海港仓库B区', '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);
INSERT INTO `cargo` VALUES (2, '测试', '测试', '测算', '2025-05-14 08:54:40', 'BULK', 1.00, 1.00, 1.00, 'SHIPPING', '出', '2025-05-14 08:54:50', '测', '2025-05-14 08:56:52', '2025-05-14 08:57:09', 1);
INSERT INTO `cargo` VALUES (3, '测试1', '连云港', '厦门', '2025-05-14 14:55:49', 'CONTAINER', 1.00, 1.00, 1.00, 'PENDING', '测试', '2025-05-14 14:56:04', '册书', '2025-05-14 14:56:13', '2025-05-14 14:56:13', 0);
INSERT INTO `cargo` VALUES (4, 'ces', '北京', '上海', '2025-05-14 21:35:27', 'BULK', 1.00, 1.00, 1.00, 'CANCELLED', '大道', '2025-05-14 21:35:35', '上盖', '2025-05-14 21:35:42', '2025-05-14 21:36:10', 1);

-- ----------------------------
-- Table structure for crew
-- ----------------------------
DROP TABLE IF EXISTS `crew`;
CREATE TABLE `crew`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '船员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of crew
-- ----------------------------
INSERT INTO `crew` VALUES (1, 'captain_li', '96e79218965eb72c92a549dd5a330112', '13812345678', 'li@shipping.com', 1, '2025-05-13 10:42:58', '2025-05-13 10:42:58', 0);
INSERT INTO `crew` VALUES (2, 'mate_wang', '96e79218965eb72c92a549dd5a330112', '13987654321', 'wang@shipping.com', 1, '2025-05-13 10:42:58', NULL, 0);
INSERT INTO `crew` VALUES (3, 'crew1', '111111', '13800138001', 'crew1@shipping.com', 1, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);
INSERT INTO `crew` VALUES (4, 'crew2', '222222', '13800138002', 'crew2@shipping.com', 1, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);
INSERT INTO `crew` VALUES (5, 'crew3', '333333', '13800138003', 'crew3@shipping.com', 1, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);
INSERT INTO `crew` VALUES (6, 'test1', '$2a$10$FJDQosvvB/5CrlWiLP0mWeqlajh2WUEvJj4gA6ZUsyQU5eqqJsfX6', '17387656711', '163545@qq.com', 1, NULL, NULL, 0);
INSERT INTO `crew` VALUES (7, 'test3', '$2a$10$VWG9k5qVBQvteGaJH99xEuo5OCyYJP25m4dxrrEaRW9vxt6uDkgUq', '17356545674', '1131@qq.com', 1, NULL, NULL, 1);

-- ----------------------------
-- Table structure for navigation_safety
-- ----------------------------
DROP TABLE IF EXISTS `navigation_safety`;
CREATE TABLE `navigation_safety`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ship_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船只名称',
  `navigation_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航行状态',
  `safety_status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航运安全',
  `publish_time` datetime NOT NULL COMMENT '发布时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '航行安全表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of navigation_safety
-- ----------------------------
INSERT INTO `navigation_safety` VALUES (1, 'OceanVoyager', '航行中', '一切正常', '2025-05-13 10:49:59', '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);

-- ----------------------------
-- Table structure for port
-- ----------------------------
DROP TABLE IF EXISTS `port`;
CREATE TABLE `port`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '港口名称',
  `latitude` decimal(10, 6) NOT NULL COMMENT '纬度',
  `longitude` decimal(10, 6) NOT NULL COMMENT '经度',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '港口表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of port
-- ----------------------------
INSERT INTO `port` VALUES (5, '上海港', 31.230416, 121.473701, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);
INSERT INTO `port` VALUES (6, '新加坡港', 1.290270, 103.851959, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);
INSERT INTO `port` VALUES (7, '鹿特丹港', 51.922500, 4.479170, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);

-- ----------------------------
-- Table structure for route
-- ----------------------------
DROP TABLE IF EXISTS `route`;
CREATE TABLE `route`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `start_port` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '起始港口',
  `end_port` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '目的港口',
  `distance` double NOT NULL COMMENT '航线距离（海里）',
  `estimated_time` int(11) NOT NULL COMMENT '预计航行时间（小时）',
  `weather_condition` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '天气状况',
  `sea_condition` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '海况',
  `traffic_density` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交通密度',
  `risk_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风险等级',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '可用' COMMENT '状态：可用、维护中、关闭',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_start_end_port`(`start_port`, `end_port`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '航线表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of route
-- ----------------------------
INSERT INTO `route` VALUES (1, '上海港', '宁波港', 120.5, 8, '晴朗', '平静', '一般', '低风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (2, '宁波港', '舟山港', 45.2, 3, '多云', '轻微', '稀疏', '低风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (3, '舟山港', '温州港', 180.8, 12, '阴天', '中等', '一般', '中风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (4, '温州港', '福州港', 220.3, 15, '晴朗', '平静', '密集', '中风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (5, '福州港', '厦门港', 150.6, 10, '多云', '轻微', '一般', '低风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (6, '厦门港', '汕头港', 180.2, 12, '晴朗', '平静', '稀疏', '低风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (7, '汕头港', '深圳港', 220.5, 15, '阴天', '中等', '密集', '中风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (8, '深圳港', '广州港', 80.3, 5, '晴朗', '平静', '非常密集', '高风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (9, '广州港', '湛江港', 280.6, 18, '多云', '轻微', '一般', '中风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (10, '湛江港', '海口港', 180.4, 12, '晴朗', '平静', '稀疏', '低风险', '可用', '2025-05-13 17:36:15', '2025-05-13 17:36:15', 0);
INSERT INTO `route` VALUES (11, '青岛港', '天津港', 350.7, 24, '大雾', '轻微', '稀疏', '中风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (12, '天津港', '大连港', 220.8, 16, '多云', '中等', '一般', '中风险', '维护中', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (13, '大连港', '烟台港', 89.5, 6, '晴朗', '平静', '密集', '低风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (14, '上海港', '东京港', 1080.3, 72, '台风', '大浪', '稀疏', '高风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (15, '香港港', '新加坡港', 1500.6, 96, '暴雨', '巨浪', '一般', '高风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (16, '厦门港', '马尼拉港', 680.4, 48, '多云', '中等', '稀疏', '中风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (17, '海口港', '三沙港', 450.2, 30, '晴朗', '平静', '稀疏', '低风险', '关闭', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (18, '湛江港', '北海港', 180, 12, '阴天', '轻微', '一般', '低风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (19, '防城港', '钦州港', 65.3, 4, '晴朗', '平静', '非常密集', '低风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (20, '南京港', '武汉港', 620.5, 84, '大雾', '平静', '一般', '中风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (21, '重庆港', '宜昌港', 350.8, 60, '暴雨', '湍急', '稀疏', '高风险', '维护中', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (22, '宁波港', '上海港', 120.5, 8, '暴雪', '结冰', '非常密集', '高风险', '关闭', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (23, '舟山港', '福州港', 320.7, 20, '晴朗', '平静', '一般', '低风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (24, '深圳港', '高雄港', 480.9, 32, '台风', '大浪', '稀疏', '高风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (25, '南沙港', '永暑礁', 820.5, 60, '雷暴', '极端', '无', '高风险', '关闭', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (26, '三亚港', '曾母暗沙', 1200.8, 96, '飓风', '灾难级', '无', '高风险', '关闭', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (27, '基隆港', '花莲港', 95.3, 7, '晴朗', '平静', '稀疏', '低风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (28, '仁川港', '釜山港', 280.6, 20, '多云', '中等', '一般', '中风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (29, '海参崴港', '大连港', 480.3, 60, '暴风雪', '结冰', '无', '高风险', '维护中', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (30, '连云港', '营口港', 680.2, 48, '大雪', '浮冰', '稀疏', '高风险', '可用', '2025-05-14 13:01:14', '2025-05-14 13:01:14', 0);
INSERT INTO `route` VALUES (31, '宁波港', '上海港', 122.3, 8, '多云', '轻微', '一般', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (32, '舟山港', '宁波港', 46.1, 3, '晴朗', '平静', '稀疏', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (33, '温州港', '舟山港', 182.5, 13, '阴天', '中等', '一般', '中风险', '维护中', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (34, '福州港', '温州港', 225, 16, '暴雨', '大浪', '密集', '高风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (35, '厦门港', '福州港', 153.2, 11, '大雾', '平静', '一般', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (36, '汕头港', '厦门港', 181.8, 13, '台风', '巨浪', '稀疏', '高风险', '关闭', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (37, '深圳港', '汕头港', 222.7, 15, '晴朗', '轻微', '密集', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (38, '广州港', '深圳港', 81.5, 5, '阴天', '中等', '非常密集', '高风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (39, '湛江港', '广州港', 285, 19, '雷暴', '湍急', '一般', '高风险', '维护中', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (40, '海口港', '湛江港', 179.6, 12, '晴朗', '平静', '稀疏', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (41, '上海港', '连云港', 380.5, 26, '多云', '轻微', '一般', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (42, '连云港', '上海港', 382, 27, '大雾', '平静', '稀疏', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (43, '广州港', '珠海港', 85.3, 6, '晴朗', '平静', '非常密集', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (44, '珠海港', '香港港', 45.2, 3, '暴雨', '中等', '密集', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (45, '香港港', '澳门港', 22.1, 2, '晴朗', '平静', '极端密集', '高风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (46, '澳门港', '广州港', 105.8, 7, '多云', '轻微', '非常密集', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (47, '武汉港', '九江港', 180.6, 24, '大雾', '平静', '一般', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (48, '九江港', '南京港', 320.4, 36, '晴朗', '轻微', '稀疏', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (49, '南京港', '南通港', 95.7, 12, '阴天', '中等', '密集', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (50, '南通港', '上海港', 108.3, 8, '暴雨', '大浪', '一般', '高风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (51, '天津港', '秦皇岛港', 120.3, 9, '晴朗', '平静', '稀疏', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (52, '秦皇岛港', '大连港', 210.8, 15, '大雪', '结冰', '一般', '高风险', '维护中', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (53, '大连港', '烟台港', 90.1, 6, '暴风雪', '结冰', '稀疏', '高风险', '关闭', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (54, '海口港', '洋浦港', 80.5, 5, '晴朗', '平静', '稀疏', '低风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (55, '洋浦港', '三亚港', 200.3, 14, '台风', '大浪', '无', '高风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (56, '三亚港', '三沙港', 450, 30, '飓风', '极端', '无', '高风险', '关闭', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (57, '东京港', '上海港', 1085, 72, '暴风雨', '巨浪', '稀疏', '高风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (58, '新加坡港', '香港港', 1510.2, 97, '雷暴', '大浪', '一般', '高风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);
INSERT INTO `route` VALUES (59, '马尼拉港', '厦门港', 682.5, 48, '晴朗', '中等', '稀疏', '中风险', '可用', '2025-05-14 13:08:00', '2025-05-14 13:08:00', 0);

-- ----------------------------
-- Table structure for route_node
-- ----------------------------
DROP TABLE IF EXISTS `route_node`;
CREATE TABLE `route_node`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `port_id` bigint(20) NOT NULL COMMENT '港口ID',
  `next_port_id` bigint(20) NOT NULL COMMENT '下一个港口ID',
  `distance` decimal(10, 2) NOT NULL COMMENT '距离(海里)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_port_id`(`port_id`) USING BTREE,
  INDEX `idx_next_port_id`(`next_port_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '航线节点关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of route_node
-- ----------------------------
INSERT INTO `route_node` VALUES (4, 1, 2, 2200.00, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);
INSERT INTO `route_node` VALUES (5, 2, 3, 8500.00, '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);

-- ----------------------------
-- Table structure for safety
-- ----------------------------
DROP TABLE IF EXISTS `safety`;
CREATE TABLE `safety`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ship_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船名',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '当前位置',
  `speed` double NOT NULL COMMENT '航速(节)',
  `direction` double NOT NULL COMMENT '航向(度)',
  `weather` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '天气状况',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1-正常，0-异常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_ship_name`(`ship_name`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '航行安全记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of safety
-- ----------------------------
INSERT INTO `safety` VALUES (1, '东方之星', '上海港', 12.5, 45, '晴朗', 1, '2023-10-01 08:00:00', '2023-10-01 08:00:00', 0);
INSERT INTO `safety` VALUES (2, '南海之光', '新加坡海峡', 24, 120, '多云', 1, '2023-10-01 09:15:00', '2023-10-01 09:15:00', 0);
INSERT INTO `safety` VALUES (3, '远航号', '马六甲海峡', 18.3, 270, '暴雨', 0, '2023-10-02 10:30:00', '2023-10-02 10:30:00', 0);
INSERT INTO `safety` VALUES (4, '海神号', '横滨港', 5.5, 180, '大雾', 1, '2023-10-02 12:45:00', '2023-10-02 12:45:00', 1);
INSERT INTO `safety` VALUES (5, '和平使者', '鹿特丹港', 30, 90, '大风', 1, '2023-10-03 14:00:00', '2023-10-03 14:00:00', 0);
INSERT INTO `safety` VALUES (6, '蓝鲸号', '好望角', 22.7, 210, '阴天', 1, '2023-10-04 16:20:00', '2023-10-04 16:20:00', 0);
INSERT INTO `safety` VALUES (7, '探索者', '巴拿马运河', 15.8, 300, '小雨', 1, '2023-10-05 18:35:00', '2023-10-05 18:35:00', 0);
INSERT INTO `safety` VALUES (8, '星辰号', '悉尼港', 0, 0, '台风', 0, '2023-10-06 20:50:00', '2023-10-06 20:50:00', 0);
INSERT INTO `safety` VALUES (9, '荣耀号', '洛杉矶港', 28.5, 45, '晴朗', 1, '2023-10-07 22:05:00', '2023-10-07 22:05:00', 0);
INSERT INTO `safety` VALUES (10, '海鸥号', '汉堡港', 8.9, 135, '多云', 1, '2023-10-08 23:15:00', '2023-10-08 23:15:00', 1);
INSERT INTO `safety` VALUES (11, '测试修改', '测试修改', 2, 2, '阴', 0, '2025-05-14 08:38:56', '2025-05-14 08:39:19', 1);
INSERT INTO `safety` VALUES (12, '测试1', '测试1', 3, 3, '多云1', 0, '2025-05-14 20:57:31', '2025-05-14 20:57:43', 1);

-- ----------------------------
-- Table structure for safety_monitor
-- ----------------------------
DROP TABLE IF EXISTS `safety_monitor`;
CREATE TABLE `safety_monitor`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备名称',
  `device_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备类型',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '正常' COMMENT '设备状态：正常、异常、离线',
  `health_percent` int(3) NULL DEFAULT NULL COMMENT '健康度百分比',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备位置',
  `ship_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属船舶',
  `last_check_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '最后检查时间',
  `next_check_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下次检查时间',
  `alert_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预警级别：高、中、低',
  `alert_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '预警内容',
  `alert_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '未处理' COMMENT '预警状态：未处理、处理中、已处理',
  `alert_time` datetime NULL DEFAULT NULL COMMENT '预警时间',
  `handler` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理人',
  `handle_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '处理结果',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_ship_name`(`ship_name`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_alert_time`(`alert_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '船舶设备安全监控表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of safety_monitor
-- ----------------------------
INSERT INTO `safety_monitor` VALUES (1, '雷达-001', '导航雷达', '正常', 95, '驾驶舱顶部', '东方之星', '2023-10-01 08:00', '2024-01-01 08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (2, '引擎-002', '主机引擎', '异常', 30, '机舱A区', '南海之光', '2023-09-28 14:00', '2023-12-28 14:00', '高', '润滑油压力过低', '未处理', '2023-10-02 15:30:00', NULL, NULL, NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (3, '消防泵-003', '消防系统', '正常', 85, '船尾泵房', '远航号', '2023-10-01 09:00', '2024-01-01 09:00', '中', '水泵流量异常', '处理中', '2023-10-03 10:15:00', '张三', '更换进水阀门', NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (4, 'GPS-004', '导航系统', '正常', 90, '驾驶舱', '海神号', '2023-10-05 11:20', '2024-01-05 11:20', '低', '卫星信号不稳定', '已处理', '2023-10-05 12:00:00', '李四', '重启GPS模块', '2023-10-05 13:30:00', '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (5, '摄像头-005', '监控系统', '离线', NULL, '货舱C区', '和平使者', '2023-09-20 16:00', '2023-12-20 16:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (6, '发电机-006', '电力系统', '异常', 25, '机舱B区', '蓝鲸号', '2023-10-04 08:45', '2024-01-04 08:45', '高', '输出电压波动', '未处理', '2023-10-04 09:10:00', NULL, NULL, NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (7, '声呐-007', '探测设备', '正常', 88, '船底龙骨', '探索者', '2023-10-06 14:30', '2024-01-06 14:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'1');
INSERT INTO `safety_monitor` VALUES (8, '空调-008', '生活设施', '异常', 60, '船员休息区', '星辰号', '2023-10-07 10:00', '2024-01-07 10:00', '中', '制冷剂泄漏', '处理中', '2023-10-07 11:20:00', '王五', '补充制冷剂', NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (9, '救生艇-009', '安全设备', '正常', NULL, '甲板右舷', '荣耀号', '2023-10-08 09:00', '2024-04-08 09:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');
INSERT INTO `safety_monitor` VALUES (10, '舵机-010', '操控系统', '异常', 40, '船尾舵机舱', '海鸥号', '2023-10-09 13:00', '2024-01-09 13:00', '高', '液压油温过高（当前温度：85°C）', '未处理', '2023-10-09 14:05:00', NULL, NULL, NULL, '2025-05-14 08:40:35', '2025-05-14 08:40:35', b'0');

-- ----------------------------
-- Table structure for ship
-- ----------------------------
DROP TABLE IF EXISTS `ship`;
CREATE TABLE `ship`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船名',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船舶类型：CARGO-货船, PASSENGER-客船, FISHING-渔船, OTHER-其他',
  `length` double NOT NULL COMMENT '船长(米)',
  `width` double NOT NULL COMMENT '船宽(米)',
  `draft` double NOT NULL COMMENT '吃水(米)',
  `tonnage` double NOT NULL COMMENT '吨位(吨)',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态：SAILING-在航, BERTHED-停泊, MAINTENANCE-维修, OTHER-其他',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '船舶信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ship
-- ----------------------------
INSERT INTO `ship` VALUES (1, '远洋巨人1', 'PASSENGER', 400, 59.8, 17.5, 220001, 'SAILING', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (2, '东方货轮', 'CARGO', 200, 32.5, 12, 80000, 'BERTHED', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (3, '钢铁之帆', 'CARGO', 150, 25, 9.8, 50000, 'MAINTENANCE', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (4, '海洋交响曲', 'PASSENGER', 347, 41, 8.9, 150000, 'SAILING', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (5, '皇家之星', 'PASSENGER', 180, 28, 7.5, 30000, 'BERTHED', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (6, '维京荣耀', 'PASSENGER', 228, 32, 6.8, 65000, 'OTHER', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (7, '渔夫之友', 'FISHING', 45, 8.5, 3.2, 180, 'SAILING', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (8, '丰收号', 'FISHING', 32, 6.8, 2.8, 120, 'BERTHED', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (9, '蛟龙号', 'OTHER', 8.2, 3.5, 1.2, 18, 'MAINTENANCE', '2025-05-14 08:48:52', '2025-05-14 08:48:52');
INSERT INTO `ship` VALUES (10, '海港卫士', 'OTHER', 65, 12, 4.5, 450, 'OTHER', '2025-05-14 08:48:52', '2025-05-14 08:48:52');

-- ----------------------------
-- Table structure for ship_dispatch
-- ----------------------------
DROP TABLE IF EXISTS `ship_dispatch`;
CREATE TABLE `ship_dispatch`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ship_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船名',
  `ship_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船型',
  `ship_size` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '尺寸',
  `dispatch_arrangement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度安排',
  `loading_order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '装载顺序',
  `route` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分配航线',
  `dispatch_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '调度详情',
  `dispatch_date` datetime NOT NULL COMMENT '调度日期',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `longitude` decimal(10, 6) NOT NULL COMMENT '经度',
  `latitude` decimal(10, 6) NOT NULL COMMENT '纬度',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '船舶调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ship_dispatch
-- ----------------------------
INSERT INTO `ship_dispatch` VALUES (1, 'OceanVoyager', '集装箱船', '300x45m', '上海港装货后前往鹿特丹', NULL, '上海港->新加坡港->鹿特丹港', NULL, '2024-03-20 08:00:00', 'admin', 121.473701, 31.230416, '上海港码头A区', '2025-05-13 10:49:59', '2025-05-13 10:49:59', 0);

-- ----------------------------
-- Table structure for ship_schedule
-- ----------------------------
DROP TABLE IF EXISTS `ship_schedule`;
CREATE TABLE `ship_schedule`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ship_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船舶名称',
  `ship_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '船舶类型',
  `start_port` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '起始港口',
  `end_port` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '目的港口',
  `route_string` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '航线',
  `departure_time` datetime NOT NULL COMMENT '计划出发时间',
  `arrival_time` datetime NOT NULL COMMENT '预计到达时间',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '待发' COMMENT '状态：待发、航行中、已到达、已取消',
  `route_id` bigint(20) NULL DEFAULT NULL COMMENT '航线ID',
  `cargo_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '货物类型',
  `cargo_weight` double NULL DEFAULT NULL COMMENT '货物重量',
  `captain` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '船长',
  `crew_count` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '船员数量',
  `weather_warning` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '天气预警',
  `traffic_warning` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交通预警',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_ship_name`(`ship_name`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_route_id`(`route_id`) USING BTREE,
  CONSTRAINT `fk_ship_schedule_route` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '船舶调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ship_schedule
-- ----------------------------
INSERT INTO `ship_schedule` VALUES (1, '东海明珠', 'CARGO', '上海港', '宁波港', NULL, '2023-10-10 08:00:00', '2023-10-10 16:00:00', '航行中', 1, '电子产品', 800, '王海洋', '18', NULL, '宁波港入口拥堵', '优先卸货', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (2, '舟山快运', 'CARGO', '宁波港', '舟山港', NULL, '2023-10-11 09:30:00', '2023-10-11 12:30:00', '已到达', 2, '原油', 5000, '陈建国', '12', '浪高1.5米', NULL, '油轮安全检查', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (3, '温州客轮', 'PASSENGER', '舟山港', '温州港', NULL, '2023-10-12 07:00:00', '2023-10-12 19:00:00', '待发', 3, NULL, NULL, '李娜', '30', '台风外围影响', '温州港限流', '载客600人', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (4, '福远号', 'CARGO', '温州港', '福州港', NULL, '2023-10-09 20:00:00', '2023-10-10 11:00:00', '已取消', 4, '煤炭', 12000, '张勇', '22', '大雾能见度低', NULL, '天气原因取消', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (5, '厦渔88', 'FISHING', '福州港', '厦门港', NULL, '2023-10-13 05:00:00', '2023-10-13 15:00:00', '航行中', 5, '海鲜', 50, '林大渔', '8', NULL, '渔船作业区', '带冰200吨', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (6, '南洋之星', 'CARGO', '厦门港', '汕头港', NULL, '2023-10-14 14:00:00', '2023-10-15 02:00:00', '待发', 6, '建材', 3000, '郑成功', '15', '阵风7级', '航道维护', '钢卷防潮处理', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (7, '深港快递', 'CARGO', '汕头港', '深圳港', NULL, '2023-10-08 18:00:00', '2023-10-09 09:00:00', '已到达', 7, '快递包裹', 200, '马晓峰', '10', '暴雨红色预警', '盐田港排队', '双11备货', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (8, '珠江女王', 'PASSENGER', '深圳港', '广州港', NULL, '2023-10-15 10:00:00', '2023-10-15 15:00:00', '航行中', 8, NULL, NULL, '赵天佑', '25', NULL, '虎门大桥高峰', 'VIP观光团', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 1);
INSERT INTO `ship_schedule` VALUES (9, '南海油龙', 'CARGO', '广州港', '湛江港', NULL, '2023-10-16 08:00:00', '2023-10-17 02:00:00', '待发', 9, '液化气', 10000, '周大福', '20', '雷暴天气', '军事演习区域', '危险品运输', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (10, '琼州海峡', 'CARGO', '湛江港', '海口港', NULL, '2023-10-17 06:00:00', '2023-10-17 18:00:00', '待发', 10, '热带水果', 1500, '吴海南', '15', '海上大风', '渔船密集', '冷链运输', '2025-05-14 09:13:20', '2025-05-14 09:13:20', 0);
INSERT INTO `ship_schedule` VALUES (11, '远洋巨人1', 'PASSENGER', '武汉港', '澳门港', NULL, '2025-05-14 05:36:59', '2025-05-21 16:00:00', 'PENDING', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 13:37:07', '2025-05-14 13:37:07', 0);
INSERT INTO `ship_schedule` VALUES (12, '远洋巨人1', 'PASSENGER', '仁川港', '舟山港', NULL, '2025-05-14 06:32:38', '2025-05-21 16:00:00', 'PENDING', 1, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 14:32:43', '2025-05-14 14:32:43', 0);
INSERT INTO `ship_schedule` VALUES (13, '远洋巨人1', 'PASSENGER', '仁川港', '海口港', '上海港→宁波港;上海港→东京港', '2025-05-14 06:38:58', '2025-05-22 16:00:00', 'PENDING', 1, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 14:39:42', '2025-05-14 14:39:42', 0);
INSERT INTO `ship_schedule` VALUES (14, '远洋巨人1', 'PASSENGER', '武汉港', '澳门港', '武汉港→九江港;九江港→南京港;南京港→南通港;南通港→上海港;上海港→宁波港;宁波港→舟山港;舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港', '2025-05-14 06:40:14', '2025-05-21 16:00:00', 'PENDING', 47, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 14:40:19', '2025-05-14 14:40:19', 0);
INSERT INTO `ship_schedule` VALUES (21, '远洋巨人1', 'PASSENGER', '舟山港', '澳门港', '舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港', '2025-05-14 13:26:49', '2025-05-21 16:00:00', 'PENDING', 23, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 21:26:53', '2025-05-14 21:26:53', 0);
INSERT INTO `ship_schedule` VALUES (22, '远洋巨人1', 'PASSENGER', '仁川港', '青岛港', '上海港→宁波港;上海港→东京港', '2025-05-14 13:33:57', '2025-05-15 16:00:00', 'PENDING', 1, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 21:34:01', '2025-05-14 21:34:01', 0);
INSERT INTO `ship_schedule` VALUES (23, '东方货轮', 'CARGO', '仁川港', '舟山港', '上海港→宁波港;上海港→东京港', '2025-05-14 13:34:22', '2025-05-21 16:00:00', 'PENDING', 1, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 21:34:27', '2025-05-14 21:34:27', 0);
INSERT INTO `ship_schedule` VALUES (24, '远洋巨人1', 'PASSENGER', '舟山港', '澳门港', '', '2025-05-14 13:57:04', '2025-05-22 16:00:00', 'PENDING', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 21:57:09', '2025-05-14 21:57:09', 0);
INSERT INTO `ship_schedule` VALUES (25, '远洋巨人1', 'PASSENGER', '仁川港', '舟山港', '仁川港→釜山港;上海港→东京港;上海港→宁波港', '2025-05-14 14:00:40', '2025-05-15 16:00:00', 'PENDING', 28, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 22:00:44', '2025-05-14 22:00:44', 0);
INSERT INTO `ship_schedule` VALUES (26, '远洋巨人1', 'PASSENGER', '舟山港', '澳门港', '舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港', '2025-05-14 14:10:00', '2025-05-21 16:00:00', 'PENDING', 23, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 22:10:04', '2025-05-14 22:10:04', 0);
INSERT INTO `ship_schedule` VALUES (27, '远洋巨人1', 'PASSENGER', '舟山港', '澳门港', '舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港', '2025-05-14 14:14:22', '2025-05-22 16:00:00', 'PENDING', 23, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 22:14:25', '2025-05-14 22:14:25', 0);
INSERT INTO `ship_schedule` VALUES (28, '东方货轮', 'CARGO', '仁川港', '武汉港', '仁川港→釜山港;上海港→宁波港;上海港→东京港', '2025-05-14 14:14:43', '2025-05-14 14:14:40', 'PENDING', 28, NULL, NULL, NULL, NULL, NULL, NULL, '', '2025-05-14 22:14:45', '2025-05-14 22:14:45', 0);

-- ----------------------------
-- Table structure for system_log
-- ----------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE `system_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '操作用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作用户名',
  `operation` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求参数',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '操作状态（0正常 1异常）',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '错误消息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 448 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_log
-- ----------------------------
INSERT INTO `system_log` VALUES (1, NULL, 'anonymous', '查看船舶调度', 'com.shipping.controller.ShipScheduleController.page', 'current=1; size=10; shipName=; startPort=; endPort=; status=; ', '0:0:0:0:0:0:0:1', '2025-05-14 15:35:40', 0, NULL);
INSERT INTO `system_log` VALUES (2, NULL, 'anonymous', '查看船舶调度', 'com.shipping.controller.ShipScheduleController.page', 'current=1; size=10; shipName=; startPort=; endPort=; status=; ', '0:0:0:0:0:0:0:1', '2025-05-14 15:38:13', 0, NULL);
INSERT INTO `system_log` VALUES (3, NULL, 'anonymous', '查看船舶调度', 'com.shipping.controller.ShipScheduleController.page', 'current=1; size=10; shipName=; startPort=; endPort=; status=; ', '0:0:0:0:0:0:0:1', '2025-05-14 15:48:23', 0, NULL);
INSERT INTO `system_log` VALUES (4, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:00:02', 0, NULL);
INSERT INTO `system_log` VALUES (5, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:00:02', 0, NULL);
INSERT INTO `system_log` VALUES (6, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:02:31', 0, NULL);
INSERT INTO `system_log` VALUES (7, 4, 'admin', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 16:04:56', 0, NULL);
INSERT INTO `system_log` VALUES (8, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:04:59', 0, NULL);
INSERT INTO `system_log` VALUES (9, 4, 'admin', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:05:03', 0, NULL);
INSERT INTO `system_log` VALUES (10, 4, 'admin', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:05:03', 0, NULL);
INSERT INTO `system_log` VALUES (11, 4, 'admin', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 16:05:03', 0, NULL);
INSERT INTO `system_log` VALUES (12, 4, 'admin', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:05:03', 0, NULL);
INSERT INTO `system_log` VALUES (13, 4, 'admin', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:05:04', 0, NULL);
INSERT INTO `system_log` VALUES (14, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:05:05', 0, NULL);
INSERT INTO `system_log` VALUES (15, 4, 'admin', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:05:27', 0, NULL);
INSERT INTO `system_log` VALUES (16, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:06:05', 0, NULL);
INSERT INTO `system_log` VALUES (17, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:11:26', 0, NULL);
INSERT INTO `system_log` VALUES (18, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:12:52', 0, NULL);
INSERT INTO `system_log` VALUES (19, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:15:06', 0, NULL);
INSERT INTO `system_log` VALUES (20, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:16:30', 0, NULL);
INSERT INTO `system_log` VALUES (21, 4, 'admin', 'com.shipping.controller.UserController.changePassword', 'PUT', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"newPassword\":\"admin1\",\"oldPassword\":\"1222222\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:30:20', 1, '原密码错误');
INSERT INTO `system_log` VALUES (22, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:30:29', 0, NULL);
INSERT INTO `system_log` VALUES (23, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:30:29', 0, NULL);
INSERT INTO `system_log` VALUES (24, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:30:30', 0, NULL);
INSERT INTO `system_log` VALUES (25, 4, 'admin', 'com.shipping.controller.UserController.changePassword', 'PUT', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"newPassword\":\"admin1\",\"oldPassword\":\"123456\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:30:47', 0, NULL);
INSERT INTO `system_log` VALUES (26, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:31:06', 0, NULL);
INSERT INTO `system_log` VALUES (27, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:31:06', 0, NULL);
INSERT INTO `system_log` VALUES (28, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:31:06', 0, NULL);
INSERT INTO `system_log` VALUES (29, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:31:17', 1, '用户名或密码错误');
INSERT INTO `system_log` VALUES (30, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:31:21', 0, NULL);
INSERT INTO `system_log` VALUES (31, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:31:21', 0, NULL);
INSERT INTO `system_log` VALUES (32, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:31:21', 0, NULL);
INSERT INTO `system_log` VALUES (33, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:32:26', 0, NULL);
INSERT INTO `system_log` VALUES (34, 4, 'admin', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 16:32:28', 0, NULL);
INSERT INTO `system_log` VALUES (35, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:32:29', 0, NULL);
INSERT INTO `system_log` VALUES (36, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:32:33', 0, NULL);
INSERT INTO `system_log` VALUES (37, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"admin\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:32:40', 0, NULL);
INSERT INTO `system_log` VALUES (38, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:32:47', 0, NULL);
INSERT INTO `system_log` VALUES (39, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",\"2025-05-14 00:00:00\",\"2025-05-17 00:00:00\"]', '0:0:0:0:0:0:0:1', '2025-05-14 16:32:57', 0, NULL);
INSERT INTO `system_log` VALUES (40, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:33:02', 0, NULL);
INSERT INTO `system_log` VALUES (41, 4, 'admin', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:33:04', 0, NULL);
INSERT INTO `system_log` VALUES (42, 4, 'admin', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:33:05', 0, NULL);
INSERT INTO `system_log` VALUES (43, 4, 'admin', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:33:05', 0, NULL);
INSERT INTO `system_log` VALUES (44, 4, 'admin', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 16:33:05', 0, NULL);
INSERT INTO `system_log` VALUES (45, 4, 'admin', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:33:05', 0, NULL);
INSERT INTO `system_log` VALUES (46, 4, 'admin', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 16:33:08', 0, NULL);
INSERT INTO `system_log` VALUES (47, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:36:56', 0, NULL);
INSERT INTO `system_log` VALUES (48, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:36:56', 0, NULL);
INSERT INTO `system_log` VALUES (49, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:36:56', 0, NULL);
INSERT INTO `system_log` VALUES (50, 4, 'admin', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 16:36:58', 0, NULL);
INSERT INTO `system_log` VALUES (51, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:49:22', 0, NULL);
INSERT INTO `system_log` VALUES (52, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:56:00', 0, NULL);
INSERT INTO `system_log` VALUES (53, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:56:00', 0, NULL);
INSERT INTO `system_log` VALUES (54, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:56:12', 1, '用户名或密码错误');
INSERT INTO `system_log` VALUES (55, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:56:19', 0, NULL);
INSERT INTO `system_log` VALUES (56, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:56:40', 0, NULL);
INSERT INTO `system_log` VALUES (57, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:56:40', 0, NULL);
INSERT INTO `system_log` VALUES (58, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 16:57:49', 0, NULL);
INSERT INTO `system_log` VALUES (59, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 16:57:49', 0, NULL);
INSERT INTO `system_log` VALUES (60, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:02:49', 0, NULL);
INSERT INTO `system_log` VALUES (61, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:02:49', 0, NULL);
INSERT INTO `system_log` VALUES (62, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:04:47', 0, NULL);
INSERT INTO `system_log` VALUES (63, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:04:47', 0, NULL);
INSERT INTO `system_log` VALUES (64, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:04:59', 0, NULL);
INSERT INTO `system_log` VALUES (65, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:13', 0, NULL);
INSERT INTO `system_log` VALUES (66, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:13', 0, NULL);
INSERT INTO `system_log` VALUES (67, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:13', 0, NULL);
INSERT INTO `system_log` VALUES (68, 4, 'admin', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:17', 0, NULL);
INSERT INTO `system_log` VALUES (69, 4, 'admin', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:19', 0, NULL);
INSERT INTO `system_log` VALUES (70, 4, 'admin', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:21', 0, NULL);
INSERT INTO `system_log` VALUES (71, 4, 'admin', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:21', 0, NULL);
INSERT INTO `system_log` VALUES (72, 4, 'admin', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:21', 0, NULL);
INSERT INTO `system_log` VALUES (73, 4, 'admin', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:21', 0, NULL);
INSERT INTO `system_log` VALUES (74, 4, 'admin', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:06:23', 0, NULL);
INSERT INTO `system_log` VALUES (75, 4, 'admin', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:08:40', 0, NULL);
INSERT INTO `system_log` VALUES (76, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:09:16', 0, NULL);
INSERT INTO `system_log` VALUES (77, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:19:51', 0, NULL);
INSERT INTO `system_log` VALUES (78, 4, 'admin', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:19:51', 0, NULL);
INSERT INTO `system_log` VALUES (79, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:19:51', 0, NULL);
INSERT INTO `system_log` VALUES (80, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:20:01', 0, NULL);
INSERT INTO `system_log` VALUES (81, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:20:10', 0, NULL);
INSERT INTO `system_log` VALUES (82, 4, 'admin', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:21:18', 0, NULL);
INSERT INTO `system_log` VALUES (83, 4, 'admin', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:28', 0, NULL);
INSERT INTO `system_log` VALUES (84, 4, 'admin', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:29', 0, NULL);
INSERT INTO `system_log` VALUES (85, 4, 'admin', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:30', 0, NULL);
INSERT INTO `system_log` VALUES (86, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:31', 0, NULL);
INSERT INTO `system_log` VALUES (87, 4, 'admin', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:40', 0, NULL);
INSERT INTO `system_log` VALUES (88, 4, 'admin', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:41', 0, NULL);
INSERT INTO `system_log` VALUES (89, 4, 'admin', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:42', 0, NULL);
INSERT INTO `system_log` VALUES (90, 4, 'admin', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:42', 0, NULL);
INSERT INTO `system_log` VALUES (91, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:23:55', 0, NULL);
INSERT INTO `system_log` VALUES (92, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:24:07', 0, NULL);
INSERT INTO `system_log` VALUES (93, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:43:51', 0, NULL);
INSERT INTO `system_log` VALUES (94, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:43:51', 1, 'class java.lang.String cannot be cast to class org.springframework.security.core.userdetails.UserDetails (java.lang.String is in module java.base of loader \'bootstrap\'; org.springframework.security.core.userdetails.UserDetails is in unnamed module of loader \'app\')');
INSERT INTO `system_log` VALUES (95, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:47:33', 0, NULL);
INSERT INTO `system_log` VALUES (96, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:47:33', 1, 'Cannot invoke \"com.shipping.entity.User.setPassword(String)\" because \"user\" is null');
INSERT INTO `system_log` VALUES (97, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:50:02', 0, NULL);
INSERT INTO `system_log` VALUES (98, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:50:02', 0, NULL);
INSERT INTO `system_log` VALUES (99, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:50:02', 0, NULL);
INSERT INTO `system_log` VALUES (100, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:59:46', 0, NULL);
INSERT INTO `system_log` VALUES (101, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:59:46', 0, NULL);
INSERT INTO `system_log` VALUES (102, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:59:46', 0, NULL);
INSERT INTO `system_log` VALUES (103, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 17:59:57', 0, NULL);
INSERT INTO `system_log` VALUES (104, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 17:59:57', 0, NULL);
INSERT INTO `system_log` VALUES (105, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 18:04:22', 0, NULL);
INSERT INTO `system_log` VALUES (106, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:04:22', 0, NULL);
INSERT INTO `system_log` VALUES (107, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 18:04:33', 0, NULL);
INSERT INTO `system_log` VALUES (108, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:04:33', 0, NULL);
INSERT INTO `system_log` VALUES (109, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:04:34', 0, NULL);
INSERT INTO `system_log` VALUES (110, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 18:05:19', 0, NULL);
INSERT INTO `system_log` VALUES (111, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:05:19', 0, NULL);
INSERT INTO `system_log` VALUES (112, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:11', 0, NULL);
INSERT INTO `system_log` VALUES (113, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:11', 0, NULL);
INSERT INTO `system_log` VALUES (114, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:14', 0, NULL);
INSERT INTO `system_log` VALUES (115, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:14', 0, NULL);
INSERT INTO `system_log` VALUES (116, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:15', 0, NULL);
INSERT INTO `system_log` VALUES (117, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:15', 0, NULL);
INSERT INTO `system_log` VALUES (118, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:15', 0, NULL);
INSERT INTO `system_log` VALUES (119, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:15', 0, NULL);
INSERT INTO `system_log` VALUES (120, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:19', 0, NULL);
INSERT INTO `system_log` VALUES (121, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:19', 0, NULL);
INSERT INTO `system_log` VALUES (122, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:19', 0, NULL);
INSERT INTO `system_log` VALUES (123, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 18:07:19', 0, NULL);
INSERT INTO `system_log` VALUES (124, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:16:13', 0, NULL);
INSERT INTO `system_log` VALUES (125, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:16:14', 0, NULL);
INSERT INTO `system_log` VALUES (126, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:16:14', 0, NULL);
INSERT INTO `system_log` VALUES (127, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:16:15', 0, NULL);
INSERT INTO `system_log` VALUES (128, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:40:12', 0, NULL);
INSERT INTO `system_log` VALUES (129, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:40:26', 0, NULL);
INSERT INTO `system_log` VALUES (130, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:40:37', 0, NULL);
INSERT INTO `system_log` VALUES (131, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 18:40:37', 0, NULL);
INSERT INTO `system_log` VALUES (132, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:40:37', 0, NULL);
INSERT INTO `system_log` VALUES (133, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:40:37', 0, NULL);
INSERT INTO `system_log` VALUES (134, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:40:38', 0, NULL);
INSERT INTO `system_log` VALUES (135, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:12', 0, NULL);
INSERT INTO `system_log` VALUES (136, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:12', 0, NULL);
INSERT INTO `system_log` VALUES (137, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:12', 0, NULL);
INSERT INTO `system_log` VALUES (138, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:12', 0, NULL);
INSERT INTO `system_log` VALUES (139, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:13', 0, NULL);
INSERT INTO `system_log` VALUES (140, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:14', 0, NULL);
INSERT INTO `system_log` VALUES (141, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:14', 0, NULL);
INSERT INTO `system_log` VALUES (142, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:27', 0, NULL);
INSERT INTO `system_log` VALUES (143, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:27', 0, NULL);
INSERT INTO `system_log` VALUES (144, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:29', 0, NULL);
INSERT INTO `system_log` VALUES (145, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:29', 0, NULL);
INSERT INTO `system_log` VALUES (146, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:29', 0, NULL);
INSERT INTO `system_log` VALUES (147, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:29', 0, NULL);
INSERT INTO `system_log` VALUES (148, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:29', 0, NULL);
INSERT INTO `system_log` VALUES (149, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:30', 0, NULL);
INSERT INTO `system_log` VALUES (150, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:30', 0, NULL);
INSERT INTO `system_log` VALUES (151, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:41:30', 0, NULL);
INSERT INTO `system_log` VALUES (152, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:34', 0, NULL);
INSERT INTO `system_log` VALUES (153, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:35', 0, NULL);
INSERT INTO `system_log` VALUES (154, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:48', 0, NULL);
INSERT INTO `system_log` VALUES (155, NULL, 'anonymous', 'com.shipping.controller.ShipController.update', 'PUT', '[{\"createTime\":\"2025-05-14T08:48:52\",\"draft\":17.5,\"id\":1,\"length\":400.0,\"name\":\"远洋巨人1\",\"status\":\"SAILING\",\"tonnage\":220001.0,\"type\":\"PASSENGER\",\"updateTime\":\"2025-05-14T08:48:52\",\"width\":59.8}]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:53', 0, NULL);
INSERT INTO `system_log` VALUES (156, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:53', 0, NULL);
INSERT INTO `system_log` VALUES (157, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:56', 0, NULL);
INSERT INTO `system_log` VALUES (158, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:56', 0, NULL);
INSERT INTO `system_log` VALUES (159, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:56', 0, NULL);
INSERT INTO `system_log` VALUES (160, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:56', 0, NULL);
INSERT INTO `system_log` VALUES (161, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:57', 0, NULL);
INSERT INTO `system_log` VALUES (162, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:58', 0, NULL);
INSERT INTO `system_log` VALUES (163, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:58', 0, NULL);
INSERT INTO `system_log` VALUES (164, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:54:59', 0, NULL);
INSERT INTO `system_log` VALUES (165, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:56:35', 0, NULL);
INSERT INTO `system_log` VALUES (166, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 18:56:43', 0, NULL);
INSERT INTO `system_log` VALUES (167, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:50:00', 0, NULL);
INSERT INTO `system_log` VALUES (168, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:50:00', 0, NULL);
INSERT INTO `system_log` VALUES (169, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:50:00', 0, NULL);
INSERT INTO `system_log` VALUES (170, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:50:39', 1, '用户名或密码错误');
INSERT INTO `system_log` VALUES (171, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:51:17', 0, NULL);
INSERT INTO `system_log` VALUES (172, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:51:17', 0, NULL);
INSERT INTO `system_log` VALUES (173, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:51:17', 0, NULL);
INSERT INTO `system_log` VALUES (174, NULL, 'anonymous', 'com.shipping.controller.UserController.updatePassword', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"newPassword\":\"123456\",\"oldPassword\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:54:36', 0, NULL);
INSERT INTO `system_log` VALUES (175, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:54:47', 0, NULL);
INSERT INTO `system_log` VALUES (176, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:54:47', 0, NULL);
INSERT INTO `system_log` VALUES (177, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:54:47', 0, NULL);
INSERT INTO `system_log` VALUES (178, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:06', 0, NULL);
INSERT INTO `system_log` VALUES (179, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:06', 0, NULL);
INSERT INTO `system_log` VALUES (180, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:06', 0, NULL);
INSERT INTO `system_log` VALUES (181, NULL, 'anonymous', 'com.shipping.controller.UserController.updatePassword', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"newPassword\":\"admin1\",\"oldPassword\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:31', 0, NULL);
INSERT INTO `system_log` VALUES (182, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:41', 0, NULL);
INSERT INTO `system_log` VALUES (183, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:41', 0, NULL);
INSERT INTO `system_log` VALUES (184, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:41', 0, NULL);
INSERT INTO `system_log` VALUES (185, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"11111111\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:53', 1, '用户名或密码错误');
INSERT INTO `system_log` VALUES (186, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:58', 0, NULL);
INSERT INTO `system_log` VALUES (187, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:58', 0, NULL);
INSERT INTO `system_log` VALUES (188, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:55:59', 0, NULL);
INSERT INTO `system_log` VALUES (189, NULL, 'anonymous', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:02', 0, NULL);
INSERT INTO `system_log` VALUES (190, NULL, 'anonymous', 'com.shipping.controller.CrewController.add', 'POST', '[{\"email\":\"1111@qq.com\",\"id\":7,\"password\":\"$2a$10$VWG9k5qVBQvteGaJH99xEuo5OCyYJP25m4dxrrEaRW9vxt6uDkgUq\",\"phone\":\"17356545678\",\"status\":1,\"username\":\"test2\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:24', 0, NULL);
INSERT INTO `system_log` VALUES (191, NULL, 'anonymous', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:24', 0, NULL);
INSERT INTO `system_log` VALUES (192, NULL, 'anonymous', 'com.shipping.controller.CrewController.updateStatus', 'PUT', '[6,1]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:27', 0, NULL);
INSERT INTO `system_log` VALUES (193, NULL, 'anonymous', 'com.shipping.controller.CrewController.updateStatus', 'PUT', '[6,0]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:28', 0, NULL);
INSERT INTO `system_log` VALUES (194, NULL, 'anonymous', 'com.shipping.controller.CrewController.update', 'PUT', '[{\"deleted\":0,\"email\":\"1131@qq.com\",\"id\":7,\"phone\":\"17356545674\",\"status\":0,\"username\":\"test3\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:42', 0, NULL);
INSERT INTO `system_log` VALUES (195, NULL, 'anonymous', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:42', 0, NULL);
INSERT INTO `system_log` VALUES (196, NULL, 'anonymous', 'com.shipping.controller.CrewController.updateStatus', 'PUT', '[7,1]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:44', 0, NULL);
INSERT INTO `system_log` VALUES (197, NULL, 'anonymous', 'com.shipping.controller.CrewController.updateStatus', 'PUT', '[6,1]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:49', 0, NULL);
INSERT INTO `system_log` VALUES (198, NULL, 'anonymous', 'com.shipping.controller.CrewController.delete', 'DELETE', '[7]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:51', 0, NULL);
INSERT INTO `system_log` VALUES (199, NULL, 'anonymous', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:51', 0, NULL);
INSERT INTO `system_log` VALUES (200, NULL, 'anonymous', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"test\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:55', 0, NULL);
INSERT INTO `system_log` VALUES (201, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:57', 0, NULL);
INSERT INTO `system_log` VALUES (202, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:56:57', 0, NULL);
INSERT INTO `system_log` VALUES (203, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"荣耀\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:08', 0, NULL);
INSERT INTO `system_log` VALUES (204, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:11', 0, NULL);
INSERT INTO `system_log` VALUES (205, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",1]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:14', 0, NULL);
INSERT INTO `system_log` VALUES (206, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:15', 0, NULL);
INSERT INTO `system_log` VALUES (207, NULL, 'anonymous', 'com.shipping.controller.SafetyController.add', 'POST', '[{\"createTime\":\"2025-05-14T20:57:30.977528600\",\"direction\":2.0,\"id\":12,\"location\":\"测试\",\"shipName\":\"测试\",\"speed\":2.0,\"status\":1,\"updateTime\":\"2025-05-14T20:57:30.977528600\",\"weather\":\"多云\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:31', 0, NULL);
INSERT INTO `system_log` VALUES (208, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:31', 0, NULL);
INSERT INTO `system_log` VALUES (209, NULL, 'anonymous', 'com.shipping.controller.SafetyController.update', 'PUT', '[{\"createTime\":\"2025-05-14T20:57:31\",\"deleted\":false,\"direction\":3.0,\"id\":12,\"location\":\"测试1\",\"shipName\":\"测试1\",\"speed\":3.0,\"status\":0,\"updateTime\":\"2025-05-14T20:57:40.157466500\",\"weather\":\"多云1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:40', 0, NULL);
INSERT INTO `system_log` VALUES (210, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:40', 0, NULL);
INSERT INTO `system_log` VALUES (211, NULL, 'anonymous', 'com.shipping.controller.SafetyController.delete', 'DELETE', '[12]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:44', 0, NULL);
INSERT INTO `system_log` VALUES (212, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:44', 0, NULL);
INSERT INTO `system_log` VALUES (213, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:47', 0, NULL);
INSERT INTO `system_log` VALUES (214, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"蛟龙\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:57:58', 0, NULL);
INSERT INTO `system_log` VALUES (215, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:00', 0, NULL);
INSERT INTO `system_log` VALUES (216, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",\"CARGO\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:03', 0, NULL);
INSERT INTO `system_log` VALUES (217, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:05', 0, NULL);
INSERT INTO `system_log` VALUES (218, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,\"SAILING\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:07', 0, NULL);
INSERT INTO `system_log` VALUES (219, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:08', 0, NULL);
INSERT INTO `system_log` VALUES (220, NULL, 'anonymous', 'com.shipping.controller.ShipController.add', 'POST', '[{\"draft\":2.0,\"id\":12,\"length\":3.0,\"name\":\"测试\",\"status\":\"BERTHED\",\"tonnage\":2.0,\"type\":\"CARGO\",\"width\":3.0}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:22', 0, NULL);
INSERT INTO `system_log` VALUES (221, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:22', 0, NULL);
INSERT INTO `system_log` VALUES (222, NULL, 'anonymous', 'com.shipping.controller.ShipController.update', 'PUT', '[{\"createTime\":\"2025-05-14T20:58:21\",\"draft\":3.0,\"id\":12,\"length\":4.0,\"name\":\"测试1\",\"status\":\"SAILING\",\"tonnage\":3.0,\"type\":\"PASSENGER\",\"updateTime\":\"2025-05-14T20:58:21\",\"width\":4.0}]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:31', 0, NULL);
INSERT INTO `system_log` VALUES (223, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:31', 0, NULL);
INSERT INTO `system_log` VALUES (224, NULL, 'anonymous', 'com.shipping.controller.ShipController.delete', 'DELETE', '[12]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:34', 0, NULL);
INSERT INTO `system_log` VALUES (225, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:34', 0, NULL);
INSERT INTO `system_log` VALUES (226, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:37', 0, NULL);
INSERT INTO `system_log` VALUES (227, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:37', 0, NULL);
INSERT INTO `system_log` VALUES (228, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:37', 0, NULL);
INSERT INTO `system_log` VALUES (229, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:37', 0, NULL);
INSERT INTO `system_log` VALUES (230, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"巨人\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:45', 0, NULL);
INSERT INTO `system_log` VALUES (231, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:48', 0, NULL);
INSERT INTO `system_log` VALUES (232, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"PENDING\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:58:58', 0, NULL);
INSERT INTO `system_log` VALUES (233, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:59:00', 0, NULL);
INSERT INTO `system_log` VALUES (234, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 20:59:13', 0, NULL);
INSERT INTO `system_log` VALUES (235, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:06', 0, NULL);
INSERT INTO `system_log` VALUES (236, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:06', 0, NULL);
INSERT INTO `system_log` VALUES (237, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:06', 0, NULL);
INSERT INTO `system_log` VALUES (238, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:06', 0, NULL);
INSERT INTO `system_log` VALUES (239, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:24', 0, NULL);
INSERT INTO `system_log` VALUES (240, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:24', 0, NULL);
INSERT INTO `system_log` VALUES (241, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:24', 0, NULL);
INSERT INTO `system_log` VALUES (242, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:24', 0, NULL);
INSERT INTO `system_log` VALUES (243, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:42', 0, NULL);
INSERT INTO `system_log` VALUES (244, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-28T16:00:00\",\"createTime\":\"2025-05-14T21:01:47.767410900\",\"departureTime\":\"2025-05-14T13:01:44\",\"endPort\":\"澳门港\",\"id\":15,\"remark\":\"\",\"routeString\":\"\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:01:47.767410900\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:48', 0, NULL);
INSERT INTO `system_log` VALUES (245, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:48', 0, NULL);
INSERT INTO `system_log` VALUES (246, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:01:48', 0, NULL);
INSERT INTO `system_log` VALUES (247, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllRoutes', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:02:14', 0, NULL);
INSERT INTO `system_log` VALUES (248, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:05', 0, NULL);
INSERT INTO `system_log` VALUES (249, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:10:10.520560500\",\"departureTime\":\"2025-05-14T13:10:07\",\"endPort\":\"澳门港\",\"id\":16,\"remark\":\"\",\"routeString\":\"\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:10:10.520560500\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:11', 0, NULL);
INSERT INTO `system_log` VALUES (250, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:11', 0, NULL);
INSERT INTO `system_log` VALUES (251, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:11', 0, NULL);
INSERT INTO `system_log` VALUES (252, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:25', 0, NULL);
INSERT INTO `system_log` VALUES (253, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:25', 0, NULL);
INSERT INTO `system_log` VALUES (254, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:25', 0, NULL);
INSERT INTO `system_log` VALUES (255, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:10:25', 0, NULL);
INSERT INTO `system_log` VALUES (256, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:36', 0, NULL);
INSERT INTO `system_log` VALUES (257, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:36', 0, NULL);
INSERT INTO `system_log` VALUES (258, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:36', 0, NULL);
INSERT INTO `system_log` VALUES (259, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:36', 0, NULL);
INSERT INTO `system_log` VALUES (260, NULL, 'anonymous', '取消船舶调度', 'DELETE', '[16]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:37', 0, NULL);
INSERT INTO `system_log` VALUES (261, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:37', 0, NULL);
INSERT INTO `system_log` VALUES (262, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:37', 0, NULL);
INSERT INTO `system_log` VALUES (263, NULL, 'anonymous', '取消船舶调度', 'DELETE', '[16]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:42', 0, NULL);
INSERT INTO `system_log` VALUES (264, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:42', 0, NULL);
INSERT INTO `system_log` VALUES (265, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:42', 0, NULL);
INSERT INTO `system_log` VALUES (266, NULL, 'anonymous', '取消船舶调度', 'DELETE', '[15]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:47', 0, NULL);
INSERT INTO `system_log` VALUES (267, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:47', 0, NULL);
INSERT INTO `system_log` VALUES (268, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:47', 0, NULL);
INSERT INTO `system_log` VALUES (269, NULL, 'anonymous', '取消船舶调度', 'DELETE', '[16]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:50', 0, NULL);
INSERT INTO `system_log` VALUES (270, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:50', 0, NULL);
INSERT INTO `system_log` VALUES (271, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:11:50', 0, NULL);
INSERT INTO `system_log` VALUES (272, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:12:26', 0, NULL);
INSERT INTO `system_log` VALUES (273, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:12:31.463055800\",\"departureTime\":\"2025-05-14T13:12:28\",\"endPort\":\"澳门港\",\"id\":17,\"remark\":\"\",\"routeString\":\"\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:12:31.463055800\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:12:31', 0, NULL);
INSERT INTO `system_log` VALUES (274, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:12:32', 0, NULL);
INSERT INTO `system_log` VALUES (275, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:12:32', 0, NULL);
INSERT INTO `system_log` VALUES (276, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:13:19', 0, NULL);
INSERT INTO `system_log` VALUES (277, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:14:49', 0, NULL);
INSERT INTO `system_log` VALUES (278, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:14:49', 0, NULL);
INSERT INTO `system_log` VALUES (279, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:14:49', 0, NULL);
INSERT INTO `system_log` VALUES (280, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:14:49', 0, NULL);
INSERT INTO `system_log` VALUES (281, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:16:14', 0, NULL);
INSERT INTO `system_log` VALUES (282, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:16:19.597072300\",\"departureTime\":\"2025-05-14T13:16:15\",\"endPort\":\"澳门港\",\"id\":18,\"remark\":\"\",\"routeString\":\"舟山港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:16:19.597072300\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:16:20', 0, NULL);
INSERT INTO `system_log` VALUES (283, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:16:20', 0, NULL);
INSERT INTO `system_log` VALUES (284, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:16:20', 0, NULL);
INSERT INTO `system_log` VALUES (285, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:17:43', 0, NULL);
INSERT INTO `system_log` VALUES (286, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:17:48.804968200\",\"departureTime\":\"2025-05-14T13:17:45\",\"endPort\":\"澳门港\",\"id\":19,\"remark\":\"\",\"routeString\":\"舟山港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:17:48.804968200\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:17:49', 0, NULL);
INSERT INTO `system_log` VALUES (287, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:17:49', 0, NULL);
INSERT INTO `system_log` VALUES (288, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:17:49', 0, NULL);
INSERT INTO `system_log` VALUES (289, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:20:26', 0, NULL);
INSERT INTO `system_log` VALUES (290, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:20:26', 0, NULL);
INSERT INTO `system_log` VALUES (291, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:20:26', 0, NULL);
INSERT INTO `system_log` VALUES (292, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:20:26', 0, NULL);
INSERT INTO `system_log` VALUES (293, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:31', 0, NULL);
INSERT INTO `system_log` VALUES (294, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:31', 0, NULL);
INSERT INTO `system_log` VALUES (295, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:31', 0, NULL);
INSERT INTO `system_log` VALUES (296, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:31', 0, NULL);
INSERT INTO `system_log` VALUES (297, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:54', 0, NULL);
INSERT INTO `system_log` VALUES (298, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:54', 0, NULL);
INSERT INTO `system_log` VALUES (299, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:54', 0, NULL);
INSERT INTO `system_log` VALUES (300, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:22:54', 0, NULL);
INSERT INTO `system_log` VALUES (301, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:31', 0, NULL);
INSERT INTO `system_log` VALUES (302, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:31', 0, NULL);
INSERT INTO `system_log` VALUES (303, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:31', 0, NULL);
INSERT INTO `system_log` VALUES (304, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:31', 0, NULL);
INSERT INTO `system_log` VALUES (305, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:46', 0, NULL);
INSERT INTO `system_log` VALUES (306, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:24:51.979947500\",\"departureTime\":\"2025-05-14T13:24:48\",\"endPort\":\"澳门港\",\"id\":20,\"remark\":\"\",\"routeString\":\"\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:24:51.979947500\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:52', 0, NULL);
INSERT INTO `system_log` VALUES (307, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:52', 0, NULL);
INSERT INTO `system_log` VALUES (308, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:24:52', 0, NULL);
INSERT INTO `system_log` VALUES (309, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:31', 0, NULL);
INSERT INTO `system_log` VALUES (310, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:31', 0, NULL);
INSERT INTO `system_log` VALUES (311, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:31', 0, NULL);
INSERT INTO `system_log` VALUES (312, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:31', 0, NULL);
INSERT INTO `system_log` VALUES (313, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"武汉港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:41', 0, NULL);
INSERT INTO `system_log` VALUES (314, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:25:46.969216200\",\"departureTime\":\"2025-05-14T13:25:44\",\"endPort\":\"澳门港\",\"id\":21,\"remark\":\"\",\"routeId\":47,\"routeString\":\"武汉港→九江港;九江港→南京港;南京港→南通港;南通港→上海港;上海港→宁波港;宁波港→舟山港;舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"武汉港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:25:46.969216200\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:47', 0, NULL);
INSERT INTO `system_log` VALUES (315, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:47', 0, NULL);
INSERT INTO `system_log` VALUES (316, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:47', 0, NULL);
INSERT INTO `system_log` VALUES (317, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:57', 0, NULL);
INSERT INTO `system_log` VALUES (318, NULL, 'anonymous', '更新船舶调度', 'PUT', '[{\"arrivalTime\":\"2025-05-21T08:00:00\",\"createTime\":\"2025-05-14T21:25:47\",\"deleted\":false,\"departureTime\":\"2025-05-14T05:25:44\",\"endPort\":\"澳门港\",\"id\":21,\"remark\":\"\",\"routeId\":23,\"routeString\":\"舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:25:59.287781400\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:59', 0, NULL);
INSERT INTO `system_log` VALUES (319, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:59', 0, NULL);
INSERT INTO `system_log` VALUES (320, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:25:59', 0, NULL);
INSERT INTO `system_log` VALUES (321, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:26:46', 0, NULL);
INSERT INTO `system_log` VALUES (322, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:26:52.967756200\",\"deleted\":false,\"departureTime\":\"2025-05-14T13:26:49\",\"endPort\":\"澳门港\",\"id\":21,\"remark\":\"\",\"routeId\":23,\"routeString\":\"舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:26:52.967756200\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:26:53', 0, NULL);
INSERT INTO `system_log` VALUES (323, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:26:53', 0, NULL);
INSERT INTO `system_log` VALUES (324, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:26:53', 0, NULL);
INSERT INTO `system_log` VALUES (325, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"青岛港\",\"武汉港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:27:05', 0, NULL);
INSERT INTO `system_log` VALUES (326, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllRoutes', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:27:06', 0, NULL);
INSERT INTO `system_log` VALUES (327, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-22T16:00:00\",\"createTime\":\"2025-05-14T21:27:18.093975100\",\"deleted\":false,\"departureTime\":\"2025-05-14T13:27:14\",\"endPort\":\"武汉港\",\"id\":21,\"remark\":\"\",\"routeId\":11,\"routeString\":\"青岛港→天津港;上海港→宁波港;上海港→东京港\",\"shipName\":\"东方货轮\",\"shipType\":\"CARGO\",\"startPort\":\"青岛港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:27:18.093975100\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:27:18', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'\r\n### The error may exist in com/shipping/mapper/ShipScheduleMapper.java (best guess)\r\n### The error may involve com.shipping.mapper.ShipScheduleMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO ship_schedule  ( id, ship_name, ship_type, start_port, end_port, route_string, departure_time, arrival_time, status, route_id,       remark, create_time, update_time, deleted )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,       ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'\n; Duplicate entry \'21\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'');
INSERT INTO `system_log` VALUES (328, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllRoutes', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:30:28', 0, NULL);
INSERT INTO `system_log` VALUES (329, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-15T16:00:00\",\"createTime\":\"2025-05-14T21:30:36.443426100\",\"deleted\":false,\"departureTime\":\"2025-05-14T13:30:32\",\"endPort\":\"青岛港\",\"id\":21,\"remark\":\"\",\"routeId\":1,\"routeString\":\"上海港→宁波港;上海港→东京港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"仁川港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:30:36.443426100\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:30:36', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'\r\n### The error may exist in com/shipping/mapper/ShipScheduleMapper.java (best guess)\r\n### The error may involve com.shipping.mapper.ShipScheduleMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO ship_schedule  ( id, ship_name, ship_type, start_port, end_port, route_string, departure_time, arrival_time, status, route_id,       remark, create_time, update_time, deleted )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,       ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'\n; Duplicate entry \'21\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'');
INSERT INTO `system_log` VALUES (330, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-15T16:00:00\",\"createTime\":\"2025-05-14T21:32:04.140951400\",\"deleted\":false,\"departureTime\":\"2025-05-14T13:30:32\",\"endPort\":\"青岛港\",\"id\":21,\"remark\":\"\",\"routeId\":1,\"routeString\":\"上海港→宁波港;上海港→东京港\",\"shipName\":\"东方货轮\",\"shipType\":\"CARGO\",\"startPort\":\"仁川港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:32:04.140951400\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:32:04', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'\r\n### The error may exist in com/shipping/mapper/ShipScheduleMapper.java (best guess)\r\n### The error may involve com.shipping.mapper.ShipScheduleMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO ship_schedule  ( id, ship_name, ship_type, start_port, end_port, route_string, departure_time, arrival_time, status, route_id,       remark, create_time, update_time, deleted )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,       ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'\n; Duplicate entry \'21\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'21\' for key \'PRIMARY\'');
INSERT INTO `system_log` VALUES (331, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:33:42', 0, NULL);
INSERT INTO `system_log` VALUES (332, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:33:42', 0, NULL);
INSERT INTO `system_log` VALUES (333, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:33:42', 0, NULL);
INSERT INTO `system_log` VALUES (334, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:33:42', 0, NULL);
INSERT INTO `system_log` VALUES (335, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllRoutes', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:33:53', 0, NULL);
INSERT INTO `system_log` VALUES (336, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-15T16:00:00\",\"createTime\":\"2025-05-14T21:34:00.775676300\",\"departureTime\":\"2025-05-14T13:33:57\",\"endPort\":\"青岛港\",\"id\":22,\"remark\":\"\",\"routeId\":1,\"routeString\":\"上海港→宁波港;上海港→东京港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"仁川港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:34:00.775676300\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:01', 0, NULL);
INSERT INTO `system_log` VALUES (337, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:01', 0, NULL);
INSERT INTO `system_log` VALUES (338, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:01', 0, NULL);
INSERT INTO `system_log` VALUES (339, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllRoutes', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:18', 0, NULL);
INSERT INTO `system_log` VALUES (340, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T21:34:26.922960300\",\"departureTime\":\"2025-05-14T13:34:22\",\"endPort\":\"舟山港\",\"id\":23,\"remark\":\"\",\"routeId\":1,\"routeString\":\"上海港→宁波港;上海港→东京港\",\"shipName\":\"东方货轮\",\"shipType\":\"CARGO\",\"startPort\":\"仁川港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:34:26.922960300\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:27', 0, NULL);
INSERT INTO `system_log` VALUES (341, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:27', 0, NULL);
INSERT INTO `system_log` VALUES (342, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:27', 0, NULL);
INSERT INTO `system_log` VALUES (343, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"仁川港\",\"舟山港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:32', 0, NULL);
INSERT INTO `system_log` VALUES (344, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"青岛港\",\"钦州港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:38', 0, NULL);
INSERT INTO `system_log` VALUES (345, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"上海港\",\"温州港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:45', 0, NULL);
INSERT INTO `system_log` VALUES (346, NULL, 'anonymous', '更新船舶调度', 'PUT', '[{\"arrivalTime\":\"2025-05-21T08:00:00\",\"createTime\":\"2025-05-14T21:34:27\",\"deleted\":false,\"departureTime\":\"2025-05-14T05:34:22\",\"endPort\":\"温州港\",\"remark\":\"\",\"routeId\":1,\"routeString\":\"上海港→宁波港;宁波港→舟山港;舟山港→温州港\",\"shipName\":\"东方货轮\",\"shipType\":\"CARGO\",\"startPort\":\"上海港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:34:48.294655000\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:48', 0, NULL);
INSERT INTO `system_log` VALUES (347, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:48', 0, NULL);
INSERT INTO `system_log` VALUES (348, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:34:48', 0, NULL);
INSERT INTO `system_log` VALUES (349, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:00', 0, NULL);
INSERT INTO `system_log` VALUES (350, NULL, 'anonymous', 'com.shipping.controller.CargoController.add', 'POST', '[{\"address\":\"上盖\",\"cargoType\":\"CONTAINER\",\"date\":\"2025-05-14T21:35:35\",\"destination\":\"上海\",\"id\":4,\"loadingTime\":\"2025-05-14T21:35:27\",\"origin\":\"北京\",\"price\":1,\"shipName\":\"ces\",\"status\":\"PENDING\",\"username\":\"大道\",\"volume\":1,\"weight\":1}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:42', 0, NULL);
INSERT INTO `system_log` VALUES (351, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:42', 0, NULL);
INSERT INTO `system_log` VALUES (352, NULL, 'anonymous', 'com.shipping.controller.CargoController.update', 'PUT', '[{\"address\":\"上盖\",\"cargoType\":\"BULK\",\"createTime\":\"2025-05-14T21:35:42\",\"date\":\"2025-05-14T21:35:35\",\"deleted\":false,\"destination\":\"上海\",\"id\":4,\"loadingTime\":\"2025-05-14T21:35:27\",\"origin\":\"北京\",\"price\":1,\"shipName\":\"ces\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:35:42\",\"username\":\"大道\",\"volume\":1,\"weight\":1}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:48', 0, NULL);
INSERT INTO `system_log` VALUES (353, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:48', 0, NULL);
INSERT INTO `system_log` VALUES (354, NULL, 'anonymous', 'com.shipping.controller.CargoController.update', 'PUT', '[{\"address\":\"上盖\",\"cargoType\":\"BULK\",\"createTime\":\"2025-05-14T21:35:42\",\"date\":\"2025-05-14T21:35:35\",\"deleted\":false,\"destination\":\"上海\",\"id\":4,\"loadingTime\":\"2025-05-14T21:35:27\",\"origin\":\"北京\",\"price\":1,\"shipName\":\"ces\",\"status\":\"SHIPPING\",\"updateTime\":\"2025-05-14T21:35:42\",\"username\":\"大道\",\"volume\":1,\"weight\":1}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:53', 0, NULL);
INSERT INTO `system_log` VALUES (355, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:53', 0, NULL);
INSERT INTO `system_log` VALUES (356, NULL, 'anonymous', 'com.shipping.controller.CargoController.update', 'PUT', '[{\"address\":\"上盖\",\"cargoType\":\"BULK\",\"createTime\":\"2025-05-14T21:35:42\",\"date\":\"2025-05-14T21:35:35\",\"deleted\":false,\"destination\":\"上海\",\"id\":4,\"loadingTime\":\"2025-05-14T21:35:27\",\"origin\":\"北京\",\"price\":1,\"shipName\":\"ces\",\"status\":\"ARRIVED\",\"updateTime\":\"2025-05-14T21:35:42\",\"username\":\"大道\",\"volume\":1,\"weight\":1}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:58', 0, NULL);
INSERT INTO `system_log` VALUES (357, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:35:58', 0, NULL);
INSERT INTO `system_log` VALUES (358, NULL, 'anonymous', 'com.shipping.controller.CargoController.update', 'PUT', '[{\"address\":\"上盖\",\"cargoType\":\"BULK\",\"createTime\":\"2025-05-14T21:35:42\",\"date\":\"2025-05-14T21:35:35\",\"deleted\":false,\"destination\":\"上海\",\"id\":4,\"loadingTime\":\"2025-05-14T21:35:27\",\"origin\":\"北京\",\"price\":1,\"shipName\":\"ces\",\"status\":\"ARRIVED\",\"updateTime\":\"2025-05-14T21:35:42\",\"username\":\"大道\",\"volume\":1,\"weight\":1}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:36:03', 0, NULL);
INSERT INTO `system_log` VALUES (359, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:36:03', 0, NULL);
INSERT INTO `system_log` VALUES (360, NULL, 'anonymous', 'com.shipping.controller.CargoController.update', 'PUT', '[{\"address\":\"上盖\",\"cargoType\":\"BULK\",\"createTime\":\"2025-05-14T21:35:42\",\"date\":\"2025-05-14T21:35:35\",\"deleted\":false,\"destination\":\"上海\",\"id\":4,\"loadingTime\":\"2025-05-14T21:35:27\",\"origin\":\"北京\",\"price\":1,\"shipName\":\"ces\",\"status\":\"CANCELLED\",\"updateTime\":\"2025-05-14T21:35:42\",\"username\":\"大道\",\"volume\":1,\"weight\":1}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:36:08', 0, NULL);
INSERT INTO `system_log` VALUES (361, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:36:08', 0, NULL);
INSERT INTO `system_log` VALUES (362, NULL, 'anonymous', 'com.shipping.controller.CargoController.delete', 'DELETE', '[4]', '0:0:0:0:0:0:0:1', '2025-05-14 21:36:11', 0, NULL);
INSERT INTO `system_log` VALUES (363, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:36:11', 0, NULL);
INSERT INTO `system_log` VALUES (364, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:36:12', 0, NULL);
INSERT INTO `system_log` VALUES (365, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:55:47', 0, NULL);
INSERT INTO `system_log` VALUES (366, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:55:47', 0, NULL);
INSERT INTO `system_log` VALUES (367, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:43', 0, NULL);
INSERT INTO `system_log` VALUES (368, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:43', 0, NULL);
INSERT INTO `system_log` VALUES (369, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:43', 0, NULL);
INSERT INTO `system_log` VALUES (370, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:45', 0, NULL);
INSERT INTO `system_log` VALUES (371, NULL, 'anonymous', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:49', 0, NULL);
INSERT INTO `system_log` VALUES (372, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:50', 0, NULL);
INSERT INTO `system_log` VALUES (373, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:52', 0, NULL);
INSERT INTO `system_log` VALUES (374, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:52', 0, NULL);
INSERT INTO `system_log` VALUES (375, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:52', 0, NULL);
INSERT INTO `system_log` VALUES (376, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:56:52', 0, NULL);
INSERT INTO `system_log` VALUES (377, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"青岛港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:57:00', 0, NULL);
INSERT INTO `system_log` VALUES (378, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-22T16:00:00\",\"createTime\":\"2025-05-14T21:57:08.701916200\",\"departureTime\":\"2025-05-14T13:57:04\",\"endPort\":\"澳门港\",\"id\":24,\"remark\":\"\",\"routeString\":\"\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:57:08.701916200\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:57:09', 0, NULL);
INSERT INTO `system_log` VALUES (379, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:57:09', 0, NULL);
INSERT INTO `system_log` VALUES (380, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:57:09', 0, NULL);
INSERT INTO `system_log` VALUES (381, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:59:14', 0, NULL);
INSERT INTO `system_log` VALUES (382, NULL, 'anonymous', '更新船舶调度', 'PUT', '[{\"arrivalTime\":\"2025-05-22T08:00:00\",\"createTime\":\"2025-05-14T21:57:09\",\"deleted\":false,\"departureTime\":\"2025-05-14T05:57:04\",\"endPort\":\"澳门港\",\"remark\":\"\",\"routeId\":23,\"routeString\":\"舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T21:59:16.825255400\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 21:59:17', 0, NULL);
INSERT INTO `system_log` VALUES (383, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 21:59:17', 0, NULL);
INSERT INTO `system_log` VALUES (384, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 21:59:17', 0, NULL);
INSERT INTO `system_log` VALUES (385, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllRoutes', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:00:35', 0, NULL);
INSERT INTO `system_log` VALUES (386, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-15T16:00:00\",\"createTime\":\"2025-05-14T22:00:43.643531700\",\"deleted\":false,\"departureTime\":\"2025-05-14T14:00:40\",\"endPort\":\"舟山港\",\"id\":25,\"remark\":\"\",\"routeId\":28,\"routeString\":\"仁川港→釜山港;上海港→东京港;上海港→宁波港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"仁川港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T22:00:43.643531700\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:00:44', 0, NULL);
INSERT INTO `system_log` VALUES (387, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:00:44', 0, NULL);
INSERT INTO `system_log` VALUES (388, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:00:44', 0, NULL);
INSERT INTO `system_log` VALUES (389, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:03:46', 0, NULL);
INSERT INTO `system_log` VALUES (390, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:03:46', 0, NULL);
INSERT INTO `system_log` VALUES (391, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:03:46', 0, NULL);
INSERT INTO `system_log` VALUES (392, NULL, 'anonymous', 'com.shipping.controller.UserController.updatePassword', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"newPassword\":\"123456\",\"oldPassword\":\"admin\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:21', 1, '旧密码错误');
INSERT INTO `system_log` VALUES (393, NULL, 'anonymous', 'com.shipping.controller.UserController.updatePassword', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"newPassword\":\"123456\",\"oldPassword\":\"admin1\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:36', 0, NULL);
INSERT INTO `system_log` VALUES (394, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:39', 0, NULL);
INSERT INTO `system_log` VALUES (395, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:40', 0, NULL);
INSERT INTO `system_log` VALUES (396, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:40', 0, NULL);
INSERT INTO `system_log` VALUES (397, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:40', 0, NULL);
INSERT INTO `system_log` VALUES (398, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:40', 0, NULL);
INSERT INTO `system_log` VALUES (399, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:09:57', 0, NULL);
INSERT INTO `system_log` VALUES (400, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-21T16:00:00\",\"createTime\":\"2025-05-14T22:10:03.567249600\",\"departureTime\":\"2025-05-14T14:10:00\",\"endPort\":\"澳门港\",\"id\":26,\"remark\":\"\",\"routeId\":23,\"routeString\":\"舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T22:10:03.567249600\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:10:04', 0, NULL);
INSERT INTO `system_log` VALUES (401, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:10:04', 0, NULL);
INSERT INTO `system_log` VALUES (402, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:10:04', 0, NULL);
INSERT INTO `system_log` VALUES (403, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:11:02', 0, NULL);
INSERT INTO `system_log` VALUES (404, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:11:09', 0, NULL);
INSERT INTO `system_log` VALUES (405, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:12:59', 0, NULL);
INSERT INTO `system_log` VALUES (406, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:09', 0, NULL);
INSERT INTO `system_log` VALUES (407, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:09', 0, NULL);
INSERT INTO `system_log` VALUES (408, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:09', 0, NULL);
INSERT INTO `system_log` VALUES (409, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:10', 0, NULL);
INSERT INTO `system_log` VALUES (410, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:13', 0, NULL);
INSERT INTO `system_log` VALUES (411, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:15', 0, NULL);
INSERT INTO `system_log` VALUES (412, NULL, 'anonymous', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"test1\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:59', 0, NULL);
INSERT INTO `system_log` VALUES (413, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:13:59', 0, NULL);
INSERT INTO `system_log` VALUES (414, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:03', 0, NULL);
INSERT INTO `system_log` VALUES (415, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:03', 0, NULL);
INSERT INTO `system_log` VALUES (416, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:04', 0, NULL);
INSERT INTO `system_log` VALUES (417, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:05', 0, NULL);
INSERT INTO `system_log` VALUES (418, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:05', 0, NULL);
INSERT INTO `system_log` VALUES (419, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:05', 0, NULL);
INSERT INTO `system_log` VALUES (420, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:05', 0, NULL);
INSERT INTO `system_log` VALUES (421, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:06', 0, NULL);
INSERT INTO `system_log` VALUES (422, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:10', 0, NULL);
INSERT INTO `system_log` VALUES (423, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:10', 0, NULL);
INSERT INTO `system_log` VALUES (424, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:10', 0, NULL);
INSERT INTO `system_log` VALUES (425, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:10', 0, NULL);
INSERT INTO `system_log` VALUES (426, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"舟山港\",\"澳门港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:19', 0, NULL);
INSERT INTO `system_log` VALUES (427, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-22T16:00:00\",\"createTime\":\"2025-05-14T22:14:25.014105700\",\"departureTime\":\"2025-05-14T14:14:22\",\"endPort\":\"澳门港\",\"id\":27,\"remark\":\"\",\"routeId\":23,\"routeString\":\"舟山港→福州港;福州港→厦门港;厦门港→汕头港;汕头港→深圳港;深圳港→广州港;广州港→珠海港;珠海港→香港港;香港港→澳门港\",\"shipName\":\"远洋巨人1\",\"shipType\":\"PASSENGER\",\"startPort\":\"舟山港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T22:14:25.014105700\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:25', 0, NULL);
INSERT INTO `system_log` VALUES (428, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:25', 0, NULL);
INSERT INTO `system_log` VALUES (429, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:25', 0, NULL);
INSERT INTO `system_log` VALUES (430, NULL, 'anonymous', 'com.shipping.controller.RouteController.getRouteRecommendation', 'GET', '[\"仁川港\",\"武汉港\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:36', 0, NULL);
INSERT INTO `system_log` VALUES (431, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllRoutes', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:36', 0, NULL);
INSERT INTO `system_log` VALUES (432, NULL, 'anonymous', '添加船舶调度', 'POST', '[{\"arrivalTime\":\"2025-05-14T14:14:40\",\"createTime\":\"2025-05-14T22:14:44.822931800\",\"departureTime\":\"2025-05-14T14:14:43\",\"endPort\":\"武汉港\",\"id\":28,\"remark\":\"\",\"routeId\":28,\"routeString\":\"仁川港→釜山港;上海港→宁波港;上海港→东京港\",\"shipName\":\"东方货轮\",\"shipType\":\"CARGO\",\"startPort\":\"仁川港\",\"status\":\"PENDING\",\"updateTime\":\"2025-05-14T22:14:44.822931800\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:45', 0, NULL);
INSERT INTO `system_log` VALUES (433, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:45', 0, NULL);
INSERT INTO `system_log` VALUES (434, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:14:45', 0, NULL);
INSERT INTO `system_log` VALUES (435, 4, 'admin', 'com.shipping.controller.UserController.login', 'POST', '[{\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true,\"enabled\":true,\"password\":\"123456\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2025-05-14 22:16:01', 0, NULL);
INSERT INTO `system_log` VALUES (436, NULL, 'anonymous', 'com.shipping.controller.UserController.getCurrentUser', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:16:01', 0, NULL);
INSERT INTO `system_log` VALUES (437, NULL, 'anonymous', 'com.shipping.controller.DashboardController.getStatistics', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:16:01', 0, NULL);
INSERT INTO `system_log` VALUES (438, NULL, 'anonymous', 'com.shipping.controller.SystemLogController.page', 'GET', '[1,10,\"\",\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:16:04', 0, NULL);
INSERT INTO `system_log` VALUES (439, NULL, 'anonymous', 'com.shipping.controller.CargoController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:03', 0, NULL);
INSERT INTO `system_log` VALUES (440, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,null,null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:05', 0, NULL);
INSERT INTO `system_log` VALUES (441, NULL, 'anonymous', 'com.shipping.controller.RouteController.getAllPorts', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:05', 0, NULL);
INSERT INTO `system_log` VALUES (442, NULL, 'anonymous', '查看船舶调度', 'GET', '[1,10,\"\",\"\",\"\",\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:05', 0, NULL);
INSERT INTO `system_log` VALUES (443, NULL, 'anonymous', 'com.shipping.controller.ShipScheduleController.getScheduleStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:05', 0, NULL);
INSERT INTO `system_log` VALUES (444, NULL, 'anonymous', 'com.shipping.controller.ShipController.page', 'GET', '[1,10,\"\",null,null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:11', 0, NULL);
INSERT INTO `system_log` VALUES (445, NULL, 'anonymous', 'com.shipping.controller.SafetyController.page', 'GET', '[1,10,\"\",null]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:13', 0, NULL);
INSERT INTO `system_log` VALUES (446, NULL, 'anonymous', 'com.shipping.controller.SafetyMonitorController.getDeviceStatusStats', 'GET', '[]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:13', 0, NULL);
INSERT INTO `system_log` VALUES (447, NULL, 'anonymous', 'com.shipping.controller.CrewController.page', 'GET', '[1,10,\"\"]', '0:0:0:0:0:0:0:1', '2025-05-14 22:19:15', 0, NULL);

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `table_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表名',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色',
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'token',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expirated_time` datetime NOT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_token`(`token`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (1, 1, 'admin', 'user', 'ADMIN', 'fake-token-admin-123', '2025-05-13 10:49:59', '2025-05-14 10:49:59');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'ADMIN' COMMENT '角色',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (4, 'admin', '$2a$10$.0I4.KfipMl1iGd9GlmjfOYVdjT1fzwbInjsCi7tqurMTl4Y4o/Hm', 'https://example.com/admin.png', 'ADMIN', '2025-05-13 10:49:59', '2025-05-13 22:24:16', 0);
INSERT INTO `user` VALUES (5, 'manager', '$2a$10$x3t.3gpXkEIWxmKGysBkaO4cqZD0dyqh/U/70AIxxyIer0W80zzH6', 'https://example.com/manager.png', 'MANAGER', '2025-05-13 10:49:59', '2025-05-14 16:35:05', 0);

SET FOREIGN_KEY_CHECKS = 1;
