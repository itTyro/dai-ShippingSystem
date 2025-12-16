CREATE TABLE `route` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `start_port` varchar(100) NOT NULL COMMENT '起始港口',
  `end_port` varchar(100) NOT NULL COMMENT '目的港口',
  `distance` double NOT NULL COMMENT '航线距离（海里）',
  `estimated_time` int NOT NULL COMMENT '预计航行时间（小时）',
  `weather_condition` varchar(50) DEFAULT NULL COMMENT '天气状况',
  `sea_condition` varchar(50) DEFAULT NULL COMMENT '海况',
  `traffic_density` varchar(50) DEFAULT NULL COMMENT '交通密度',
  `risk_level` varchar(50) DEFAULT NULL COMMENT '风险等级',
  `status` varchar(20) NOT NULL DEFAULT '可用' COMMENT '状态：可用、维护中、关闭',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_start_end_port` (`start_port`,`end_port`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  COMMENT='航线表';