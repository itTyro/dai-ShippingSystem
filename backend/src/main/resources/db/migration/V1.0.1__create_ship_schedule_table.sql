CREATE TABLE ship_schedule (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ship_name VARCHAR(100) NOT NULL,
    ship_type VARCHAR(50) NOT NULL,
    start_port VARCHAR(100) NOT NULL,
    end_port VARCHAR(100) NOT NULL,
    route_id BIGINT,
    route_string VARCHAR(500),
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    remark TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (route_id) REFERENCES route(id)
); 