package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.SystemLog;

public interface SystemLogService extends IService<SystemLog> {
    Page<SystemLog> page(Page<SystemLog> page, String username, String operation, String startTime, String endTime);
    void saveLog(SystemLog log);
} 