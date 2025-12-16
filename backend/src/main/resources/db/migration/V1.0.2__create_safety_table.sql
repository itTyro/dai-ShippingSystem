CREATE TABLE safety (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    ship_name VARCHAR(100) NOT NULL COMMENT '船名',
    location VARCHAR(200) NOT NULL COMMENT '当前位置',
    speed DOUBLE NOT NULL COMMENT '航速(节)',
    direction DOUBLE NOT NULL COMMENT '航向(度)',
    weather VARCHAR(50) NOT NULL COMMENT '天气状况',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '状态：1-正常，0-异常',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
    INDEX idx_ship_name (ship_name),
    INDEX idx_status (status),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='航行安全记录表';

INSERT INTO `safety` (
    `ship_name`,
    `location`,
    `speed`,
    `direction`,
    `weather`,
    `status`,
    `create_time`,
    `update_time`,
    `deleted`
) VALUES
      ('东方之星', '上海港', 12.5, 45, '晴朗', 1, '2023-10-01 08:00:00', '2023-10-01 08:00:00', 0),
      ('南海之光', '新加坡海峡', 24.0, 120, '多云', 1, '2023-10-01 09:15:00', '2023-10-01 09:15:00', 0),
      ('远航号', '马六甲海峡', 18.3, 270, '暴雨', 0, '2023-10-02 10:30:00', '2023-10-02 10:30:00', 0),
      ('海神号', '横滨港', 5.5, 180, '大雾', 1, '2023-10-02 12:45:00', '2023-10-02 12:45:00', 1),
      ('和平使者', '鹿特丹港', 30.0, 90, '大风', 1, '2023-10-03 14:00:00', '2023-10-03 14:00:00', 0),
      ('蓝鲸号', '好望角', 22.7, 210, '阴天', 1, '2023-10-04 16:20:00', '2023-10-04 16:20:00', 0),
      ('探索者', '巴拿马运河', 15.8, 300, '小雨', 1, '2023-10-05 18:35:00', '2023-10-05 18:35:00', 0),
      ('星辰号', '悉尼港', 0.0, 0, '台风', 0, '2023-10-06 20:50:00', '2023-10-06 20:50:00', 0),
      ('荣耀号', '洛杉矶港', 28.5, 45, '晴朗', 1, '2023-10-07 22:05:00', '2023-10-07 22:05:00', 0),
      ('海鸥号', '汉堡港', 8.9, 135, '多云', 1, '2023-10-08 23:15:00', '2023-10-08 23:15:00', 1);