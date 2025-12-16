CREATE TABLE `ship_schedule` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ship_name` varchar(100) NOT NULL COMMENT '船舶名称',
  `ship_type` varchar(50) NOT NULL COMMENT '船舶类型',
  `start_port` varchar(100) NOT NULL COMMENT '起始港口',
  `end_port` varchar(100) NOT NULL COMMENT '目的港口',
  `departure_time` datetime NOT NULL COMMENT '计划出发时间',
  `arrival_time` datetime NOT NULL COMMENT '预计到达时间',
  `status` varchar(20) NOT NULL DEFAULT '待发' COMMENT '状态：待发、航行中、已到达、已取消',
  `route_id` bigint DEFAULT NULL COMMENT '航线ID',
  `cargo_type` varchar(50) DEFAULT NULL COMMENT '货物类型',
  `cargo_weight` double DEFAULT NULL COMMENT '货物重量',
  `captain` varchar(50) DEFAULT NULL COMMENT '船长',
  `crew_count` varchar(20) DEFAULT NULL COMMENT '船员数量',
  `weather_warning` varchar(200) DEFAULT NULL COMMENT '天气预警',
  `traffic_warning` varchar(200) DEFAULT NULL COMMENT '交通预警',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_ship_name` (`ship_name`),
  KEY `idx_status` (`status`),
  KEY `idx_route_id` (`route_id`),
  CONSTRAINT `fk_ship_schedule_route` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  COMMENT='船舶调度表';

INSERT INTO ship_schedule
(ship_name, ship_type, start_port, end_port, departure_time, arrival_time,
 status, route_id, cargo_type, cargo_weight, captain, crew_count,
 weather_warning, traffic_warning, remark, deleted)
VALUES
-- route_id=1 (上海港→宁波港，8小时航程)
('东海明珠', 'CARGO', '上海港', '宁波港', '2023-10-10 08:00:00', '2023-10-10 16:00:00',
 '航行中', 1, '电子产品', 800, '王海洋', '18',
 NULL, '宁波港入口拥堵', '优先卸货', 0),

-- route_id=2 (宁波港→舟山港，3小时航程)
('舟山快运', 'CARGO', '宁波港', '舟山港', '2023-10-11 09:30:00', '2023-10-11 12:30:00',
 '已到达', 2, '原油', 5000, '陈建国', '12',
 '浪高1.5米', NULL, '油轮安全检查', 0),

-- route_id=3 (舟山港→温州港，12小时航程)
('温州客轮', 'PASSENGER', '舟山港', '温州港', '2023-10-12 07:00:00', '2023-10-12 19:00:00',
 '待发', 3, NULL, NULL, '李娜', '30',
 '台风外围影响', '温州港限流', '载客600人', 0),

-- route_id=4 (温州港→福州港，15小时航程)
('福远号', 'CARGO', '温州港', '福州港', '2023-10-09 20:00:00', '2023-10-10 11:00:00',
 '已取消', 4, '煤炭', 12000, '张勇', '22',
 '大雾能见度低', NULL, '天气原因取消', 0),

-- route_id=5 (福州港→厦门港，10小时航程)
('厦渔88', 'FISHING', '福州港', '厦门港', '2023-10-13 05:00:00', '2023-10-13 15:00:00',
 '航行中', 5, '海鲜', 50, '林大渔', '8',
 NULL, '渔船作业区', '带冰200吨', 0),

-- route_id=6 (厦门港→汕头港，12小时航程)
('南洋之星', 'CARGO', '厦门港', '汕头港', '2023-10-14 14:00:00', '2023-10-15 02:00:00',
 '待发', 6, '建材', 3000, '郑成功', '15',
 '阵风7级', '航道维护', '钢卷防潮处理', 0),

-- route_id=7 (汕头港→深圳港，15小时航程)
('深港快递', 'CARGO', '汕头港', '深圳港', '2023-10-08 18:00:00', '2023-10-09 09:00:00',
 '已到达', 7, '快递包裹', 200, '马晓峰', '10',
 '暴雨红色预警', '盐田港排队', '双11备货', 0),

-- route_id=8 (深圳港→广州港，5小时航程)
('珠江女王', 'PASSENGER', '深圳港', '广州港', '2023-10-15 10:00:00', '2023-10-15 15:00:00',
 '航行中', 8, NULL, NULL, '赵天佑', '25',
 NULL, '虎门大桥高峰', 'VIP观光团', 1),  -- 软删除测试

-- route_id=9 (广州港→湛江港，18小时航程)
('南海油龙', 'CARGO', '广州港', '湛江港', '2023-10-16 08:00:00', '2023-10-17 02:00:00',
 '待发', 9, '液化气', 10000, '周大福', '20',
 '雷暴天气', '军事演习区域', '危险品运输', 0),

-- route_id=10 (湛江港→海口港，12小时航程)
('琼州海峡', 'CARGO', '湛江港', '海口港', '2023-10-17 06:00:00', '2023-10-17 18:00:00',
 '待发', 10, '热带水果', 1500, '吴海南', '15',
 '海上大风', '渔船密集', '冷链运输', 0);