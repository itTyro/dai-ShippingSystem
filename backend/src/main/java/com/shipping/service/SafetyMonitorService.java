package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.SafetyMonitor;

import java.util.List;
import java.util.Map;

public interface SafetyMonitorService extends IService<SafetyMonitor> {
    
    /**
     * 获取设备状态统计
     */
    Map<String, Object> getDeviceStatusStats();
    
    /**
     * 分页查询设备列表
     */
    Page<SafetyMonitor> pageDevices(Page<SafetyMonitor> page, String deviceName, String deviceType, String status);
    
    /**
     * 刷新设备状态
     */
    void refreshDeviceStatus();
    
    /**
     * 分页查询预警信息
     */
    Page<SafetyMonitor> pageAlerts(Page<SafetyMonitor> page, String alertLevel, String alertStatus);
    
    /**
     * 添加预警信息
     */
    void addAlert(SafetyMonitor alert);
    
    /**
     * 处理预警信息
     */
    void handleAlert(Long id, String handleResult);
    
    /**
     * 获取安全数据趋势
     */
    Map<String, Object> getSafetyDataTrend(String timeRange);
} 