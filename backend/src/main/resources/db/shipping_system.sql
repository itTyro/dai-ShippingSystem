CREATE DATABASE IF NOT EXISTS shipping_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE shipping_system;

-- 用户表
CREATE TABLE IF NOT EXISTS `user` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `password` varchar(100) NOT NULL COMMENT '密码',
    `image` varchar(255) DEFAULT NULL COMMENT '头像',
    `role` varchar(20) DEFAULT 'ADMIN' COMMENT '角色',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 船员表
CREATE TABLE IF NOT EXISTS `crew` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `password` varchar(100) NOT NULL COMMENT '密码',
    `phone` varchar(20) DEFAULT NULL COMMENT '电话',
    `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
    `status` tinyint(1) DEFAULT '1' COMMENT '状态：0-禁用，1-启用',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='船员表';

-- 船舶信息表
CREATE TABLE IF NOT EXISTS `ship` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL COMMENT '船名',
    `type` varchar(50) NOT NULL COMMENT '船型',
    `size` varchar(50) NOT NULL COMMENT '尺寸',
    `capacity` decimal(10,2) NOT NULL COMMENT '载重能力',
    `identification_code` varchar(50) NOT NULL COMMENT '识别码',
    `certification` varchar(255) DEFAULT NULL COMMENT '持证情况',
    `status` tinyint(1) DEFAULT '1' COMMENT '状态：0-停用，1-启用',
    `location` varchar(255) DEFAULT NULL COMMENT '停靠地址',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='船舶信息表';

-- 港口表
CREATE TABLE IF NOT EXISTS `port` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL COMMENT '港口名称',
    `latitude` decimal(10,6) NOT NULL COMMENT '纬度',
    `longitude` decimal(10,6) NOT NULL COMMENT '经度',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='港口表';

-- 航线节点关系表
CREATE TABLE IF NOT EXISTS `route_node` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `port_id` bigint(20) NOT NULL COMMENT '港口ID',
    `next_port_id` bigint(20) NOT NULL COMMENT '下一个港口ID',
    `distance` decimal(10,2) NOT NULL COMMENT '距离(海里)',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`),
    KEY `idx_port_id` (`port_id`),
    KEY `idx_next_port_id` (`next_port_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='航线节点关系表';

-- 船舶调度表
CREATE TABLE IF NOT EXISTS `ship_dispatch` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `ship_name` varchar(100) NOT NULL COMMENT '船名',
    `ship_type` varchar(50) NOT NULL COMMENT '船型',
    `ship_size` varchar(50) NOT NULL COMMENT '尺寸',
    `dispatch_arrangement` text NOT NULL COMMENT '调度安排',
    `loading_order` varchar(255) DEFAULT NULL COMMENT '装载顺序',
    `route` text NOT NULL COMMENT '分配航线',
    `dispatch_details` text DEFAULT NULL COMMENT '调度详情',
    `dispatch_date` datetime NOT NULL COMMENT '调度日期',
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `longitude` decimal(10,6) NOT NULL COMMENT '经度',
    `latitude` decimal(10,6) NOT NULL COMMENT '纬度',
    `address` varchar(255) NOT NULL COMMENT '地址',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='船舶调度表';

-- 航运货物表
CREATE TABLE IF NOT EXISTS `cargo` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `ship_name` varchar(100) NOT NULL COMMENT '船名',
    `origin` varchar(255) NOT NULL COMMENT '始发地',
    `destination` varchar(255) NOT NULL COMMENT '目的地',
    `loading_time` datetime NOT NULL COMMENT '预装时间',
    `cargo_type` varchar(50) NOT NULL COMMENT '货物种类',
    `weight` decimal(10,2) NOT NULL COMMENT '货物吨数',
    `volume` decimal(10,2) NOT NULL COMMENT '货物体积',
    `price` decimal(10,2) NOT NULL COMMENT '运输价格',
    `status` varchar(20) NOT NULL COMMENT '运输状态',
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `date` datetime NOT NULL COMMENT '日期',
    `address` varchar(255) NOT NULL COMMENT '地址',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='航运货物表';

-- 航运安全监控表
CREATE TABLE IF NOT EXISTS `safety_monitor` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `ship_name` varchar(100) NOT NULL COMMENT '船名',
    `ship_type` varchar(50) NOT NULL COMMENT '船型',
    `speed` decimal(10,2) NOT NULL COMMENT '航行速度',
    `direction` varchar(50) NOT NULL COMMENT '航向',
    `danger_zone` text DEFAULT NULL COMMENT '附近危险区',
    `warning_measures` text DEFAULT NULL COMMENT '预警措施',
    `safety_risk` text DEFAULT NULL COMMENT '安全风险',
    `time` datetime NOT NULL COMMENT '时间',
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `address` varchar(255) NOT NULL COMMENT '地址',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='航运安全监控表';

-- 航行安全表
CREATE TABLE IF NOT EXISTS `navigation_safety` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `ship_name` varchar(100) NOT NULL COMMENT '船只名称',
    `navigation_status` varchar(50) NOT NULL COMMENT '航行状态',
    `safety_status` text NOT NULL COMMENT '航运安全',
    `publish_time` datetime NOT NULL COMMENT '发布时间',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='航行安全表';

-- Token表
CREATE TABLE IF NOT EXISTS `token` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) NOT NULL COMMENT '用户ID',
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `table_name` varchar(50) NOT NULL COMMENT '表名',
    `role` varchar(20) NOT NULL COMMENT '角色',
    `token` varchar(100) NOT NULL COMMENT 'token',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `expirated_time` datetime NOT NULL COMMENT '过期时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Token表';

-- 系统日志表
CREATE TABLE IF NOT EXISTS `system_log` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `operation` varchar(50) NOT NULL COMMENT '操作',
    `method` varchar(200) NOT NULL COMMENT '方法',
    `params` text DEFAULT NULL COMMENT '参数',
    `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志表'; 