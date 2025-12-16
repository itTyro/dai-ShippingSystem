package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.SafetyMonitor;
import com.shipping.service.SafetyMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/safety-monitor")
public class SafetyMonitorController {

    @Autowired
    private SafetyMonitorService safetyMonitorService;

    @GetMapping("/stats")
    public Result<Map<String, Object>> getDeviceStatusStats() {
        return Result.success(safetyMonitorService.getDeviceStatusStats());
    }

    @GetMapping("/devices")
    public Result<Page<SafetyMonitor>> pageDevices(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String deviceName,
            @RequestParam(required = false) String deviceType,
            @RequestParam(required = false) String status) {
        Page<SafetyMonitor> page = new Page<>(current, size);
        return Result.success(safetyMonitorService.pageDevices(page, deviceName, deviceType, status));
    }

    @PostMapping("/devices/refresh")
    public Result<Void> refreshDeviceStatus() {
        safetyMonitorService.refreshDeviceStatus();
        return Result.success();
    }

    @GetMapping("/alerts")
    public Result<Page<SafetyMonitor>> pageAlerts(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String alertLevel,
            @RequestParam(required = false) String alertStatus) {
        Page<SafetyMonitor> page = new Page<>(current, size);
        return Result.success(safetyMonitorService.pageAlerts(page, alertLevel, alertStatus));
    }

    @PostMapping("/alerts")
    public Result<Void> addAlert(@RequestBody SafetyMonitor alert) {
        safetyMonitorService.addAlert(alert);
        return Result.success();
    }

    @PostMapping("/alerts/{id}/handle")
    public Result<Void> handleAlert(@PathVariable Long id, @RequestParam String handleResult) {
        safetyMonitorService.handleAlert(id, handleResult);
        return Result.success();
    }

    @GetMapping("/trend")
    public Result<Map<String, Object>> getSafetyDataTrend(@RequestParam String timeRange) {
        return Result.success(safetyMonitorService.getSafetyDataTrend(timeRange));
    }
}