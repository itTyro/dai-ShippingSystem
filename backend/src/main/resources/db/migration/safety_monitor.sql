CREATE TABLE `safety_monitor` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                  `device_name` varchar(255) NOT NULL COMMENT '设备名称',
                                  `device_type` varchar(100) NOT NULL COMMENT '设备类型',
                                  `status` varchar(20) NOT NULL DEFAULT '正常' COMMENT '设备状态：正常、异常、离线',
                                  `health_percent` int(3) DEFAULT NULL COMMENT '健康度百分比',
                                  `location` varchar(200) NOT NULL COMMENT '设备位置',
                                  `ship_name` varchar(100) NOT NULL COMMENT '所属船舶',
                                  `last_check_time` varchar(20) DEFAULT NULL COMMENT '最后检查时间',
                                  `next_check_time` varchar(20) DEFAULT NULL COMMENT '下次检查时间',
                                  `alert_level` varchar(10) DEFAULT NULL COMMENT '预警级别：高、中、低',
                                  `alert_content` text COMMENT '预警内容',
                                  `alert_status` varchar(20) DEFAULT '未处理' COMMENT '预警状态：未处理、处理中、已处理',
                                  `alert_time` datetime DEFAULT NULL COMMENT '预警时间',
                                  `handler` varchar(100) DEFAULT NULL COMMENT '处理人',
                                  `handle_result` text COMMENT '处理结果',
                                  `handle_time` datetime DEFAULT NULL COMMENT '处理时间',
                                  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除：0-未删除，1-已删除',
                                  PRIMARY KEY (`id`),
                                  KEY `idx_ship_name` (`ship_name`),
                                  KEY `idx_status` (`status`),
                                  KEY `idx_alert_time` (`alert_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='船舶设备安全监控表';

INSERT INTO `safety_monitor` (
    `device_name`, `device_type`, `status`, `health_percent`, `location`, `ship_name`,
    `last_check_time`, `next_check_time`, `alert_level`, `alert_content`, `alert_status`,
    `alert_time`, `handler`, `handle_result`, `handle_time`, `deleted`
) VALUES
-- 正常设备（无预警）
('雷达-001', '导航雷达', '正常', 95, '驾驶舱顶部', '东方之星',
 '2023-10-01 08:00', '2024-01-01 08:00', NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, 0),

-- 异常设备（高预警未处理）
('引擎-002', '主机引擎', '异常', 30, '机舱A区', '南海之光',
 '2023-09-28 14:00', '2023-12-28 14:00', '高', '润滑油压力过低', '未处理',
 '2023-10-02 15:30:00', NULL, NULL, NULL, 0),

-- 处理中的预警
('消防泵-003', '消防系统', '正常', 85, '船尾泵房', '远航号',
 '2023-10-01 09:00', '2024-01-01 09:00', '中', '水泵流量异常', '处理中',
 '2023-10-03 10:15:00', '张三', '更换进水阀门', NULL, 0),

-- 已处理的预警
('GPS-004', '导航系统', '正常', 90, '驾驶舱', '海神号',
 '2023-10-05 11:20', '2024-01-05 11:20', '低', '卫星信号不稳定', '已处理',
 '2023-10-05 12:00:00', '李四', '重启GPS模块', '2023-10-05 13:30:00', 0),

-- 离线设备
('摄像头-005', '监控系统', '离线', NULL, '货舱C区', '和平使者',
 '2023-09-20 16:00', '2023-12-20 16:00', NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, 0),

-- 健康度低的设备
('发电机-006', '电力系统', '异常', 25, '机舱B区', '蓝鲸号',
 '2023-10-04 08:45', '2024-01-04 08:45', '高', '输出电压波动', '未处理',
 '2023-10-04 09:10:00', NULL, NULL, NULL, 0),

-- 删除的记录
('声呐-007', '探测设备', '正常', 88, '船底龙骨', '探索者',
 '2023-10-06 14:30', '2024-01-06 14:30', NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, 1),

-- 多预警设备
('空调-008', '生活设施', '异常', 60, '船员休息区', '星辰号',
 '2023-10-07 10:00', '2024-01-07 10:00', '中', '制冷剂泄漏', '处理中',
 '2023-10-07 11:20:00', '王五', '补充制冷剂', NULL, 0),

-- 无健康度设备
('救生艇-009', '安全设备', '正常', NULL, '甲板右舷', '荣耀号',
 '2023-10-08 09:00', '2024-04-08 09:00', NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, 0),

-- 复杂预警内容
('舵机-010', '操控系统', '异常', 40, '船尾舵机舱', '海鸥号',
 '2023-10-09 13:00', '2024-01-09 13:00', '高', '液压油温过高（当前温度：85°C）', '未处理',
 '2023-10-09 14:05:00', NULL, NULL, NULL, 0);