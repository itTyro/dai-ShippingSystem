package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.SystemLog;
import com.shipping.service.SystemLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/system/log")
public class SystemLogController {

    @Autowired
    private SystemLogService systemLogService;

    @GetMapping("/page")
    public Result<Page<SystemLog>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String username,
            @RequestParam(required = false) String operation,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        Page<SystemLog> page = new Page<>(current, size);
        return Result.success(systemLogService.page(page, username, operation, startTime, endTime));
    }
} 