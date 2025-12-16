CREATE TABLE system_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT COMMENT '操作用户ID',
    username VARCHAR(50) COMMENT '操作用户名',
    operation VARCHAR(50) COMMENT '操作类型',
    method VARCHAR(100) COMMENT '请求方法',
    params TEXT COMMENT '请求参数',
    ip VARCHAR(64) COMMENT 'IP地址',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    status TINYINT COMMENT '操作状态（0正常 1异常）',
    error_msg TEXT COMMENT '错误消息'
) COMMENT '系统日志表'; 