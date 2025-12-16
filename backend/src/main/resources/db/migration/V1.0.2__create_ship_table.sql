CREATE TABLE ship (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    name VARCHAR(100) NOT NULL COMMENT '船名',
    type VARCHAR(20) NOT NULL COMMENT '船舶类型：CARGO-货船, PASSENGER-客船, FISHING-渔船, OTHER-其他',
    length DOUBLE NOT NULL COMMENT '船长(米)',
    width DOUBLE NOT NULL COMMENT '船宽(米)',
    draft DOUBLE NOT NULL COMMENT '吃水(米)',
    tonnage DOUBLE NOT NULL COMMENT '吨位(吨)',
    status VARCHAR(20) NOT NULL COMMENT '状态：SAILING-在航, BERTHED-停泊, MAINTENANCE-维修, OTHER-其他',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_name (name)
) COMMENT '船舶信息表';

INSERT INTO ship
(name, type, length, width, draft, tonnage, status)
VALUES
-- 货船（CARGO）不同状态
('远洋巨人', 'CARGO', 399.0, 58.8, 16.5, 220000, 'SAILING'),
('东方货轮', 'CARGO', 200.0, 32.5, 12.0, 80000, 'BERTHED'),
('钢铁之帆', 'CARGO', 150.0, 25.0, 9.8, 50000, 'MAINTENANCE'),

-- 客船（PASSENGER）不同状态
('海洋交响曲', 'PASSENGER', 347.0, 41.0, 8.9, 150000, 'SAILING'),
('皇家之星', 'PASSENGER', 180.0, 28.0, 7.5, 30000, 'BERTHED'),
('维京荣耀', 'PASSENGER', 228.0, 32.0, 6.8, 65000, 'OTHER'),

-- 渔船（FISHING）不同状态
('渔夫之友', 'FISHING', 45.0, 8.5, 3.2, 180, 'SAILING'),
('丰收号', 'FISHING', 32.0, 6.8, 2.8, 120, 'BERTHED'),

-- 其他类型（OTHER）
('蛟龙号', 'OTHER', 8.2, 3.5, 1.2, 18, 'MAINTENANCE'),  -- 科考船
('海港卫士', 'OTHER', 65.0, 12.0, 4.5, 450, 'OTHER');   -- 巡逻船