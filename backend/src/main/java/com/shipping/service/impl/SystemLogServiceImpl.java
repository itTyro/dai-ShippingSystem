package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.SystemLog;
import com.shipping.mapper.SystemLogMapper;
import com.shipping.service.SystemLogService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class SystemLogServiceImpl extends ServiceImpl<SystemLogMapper, SystemLog> implements SystemLogService {

    @Override
    public Page<SystemLog> page(Page<SystemLog> page, String username, String operation, String startTime, String endTime) {
        LambdaQueryWrapper<SystemLog> wrapper = new LambdaQueryWrapper<>();
        
        if (StringUtils.hasText(username)) {
            wrapper.like(SystemLog::getUsername, username);
        }
        if (StringUtils.hasText(operation)) {
            wrapper.like(SystemLog::getOperation, operation);
        }
        if (StringUtils.hasText(startTime)) {
            wrapper.ge(SystemLog::getCreateTime, LocalDateTime.parse(startTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        }
        if (StringUtils.hasText(endTime)) {
            wrapper.le(SystemLog::getCreateTime, LocalDateTime.parse(endTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        }
        
        wrapper.orderByDesc(SystemLog::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    public void saveLog(SystemLog log) {
        save(log);
    }
} 