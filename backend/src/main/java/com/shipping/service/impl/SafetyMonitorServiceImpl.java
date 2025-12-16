package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.SafetyMonitor;
import com.shipping.mapper.SafetyMonitorMapper;
import com.shipping.service.SafetyMonitorService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SafetyMonitorServiceImpl extends ServiceImpl<SafetyMonitorMapper, SafetyMonitor> implements SafetyMonitorService {

    @Override
    public Map<String, Object> getDeviceStatusStats() {
        Map<String, Object> stats = new HashMap<>();
        
        // 获取设备总数
        long totalDevices = count();
        stats.put("totalDevices", totalDevices);
        
        // 获取异常设备数
        long abnormalDevices = count(new LambdaQueryWrapper<SafetyMonitor>()
                .eq(SafetyMonitor::getStatus, "异常"));
        stats.put("abnormalDevices", abnormalDevices);
        
        // 获取在线设备数
        long onlineDevices = count(new LambdaQueryWrapper<SafetyMonitor>()
                .eq(SafetyMonitor::getStatus, "正常"));
        stats.put("onlineDevices", onlineDevices);
        
        // 获取船舶状态
        long warningShips = count(new LambdaQueryWrapper<SafetyMonitor>()
                .eq(SafetyMonitor::getAlertLevel, "高"));
        stats.put("warningShips", warningShips);
        
        return stats;
    }

    @Override
    public Page<SafetyMonitor> pageDevices(Page<SafetyMonitor> page, String deviceName, String deviceType, String status) {
        LambdaQueryWrapper<SafetyMonitor> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(deviceName)) {
            wrapper.like(SafetyMonitor::getDeviceName, deviceName);
        }
        if (StringUtils.hasText(deviceType)) {
            wrapper.eq(SafetyMonitor::getDeviceType, deviceType);
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(SafetyMonitor::getStatus, status);
        }
        wrapper.orderByDesc(SafetyMonitor::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void refreshDeviceStatus() {
        // 模拟刷新设备状态
        List<SafetyMonitor> devices = list();
        for (SafetyMonitor device : devices) {
            // 随机更新设备状态和健康度
            String[] statuses = {"正常", "异常", "离线"};
            int randomStatus = (int) (Math.random() * 3);
            device.setStatus(statuses[randomStatus]);
            device.setHealthPercent((int) (Math.random() * 100));
            device.setUpdateTime(LocalDateTime.now());
            updateById(device);
        }
    }

    @Override
    public Page<SafetyMonitor> pageAlerts(Page<SafetyMonitor> page, String alertLevel, String alertStatus) {
        LambdaQueryWrapper<SafetyMonitor> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(alertLevel)) {
            wrapper.eq(SafetyMonitor::getAlertLevel, alertLevel);
        }
        if (StringUtils.hasText(alertStatus)) {
            wrapper.eq(SafetyMonitor::getAlertStatus, alertStatus);
        }
        wrapper.orderByDesc(SafetyMonitor::getAlertTime);
        return page(page, wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addAlert(SafetyMonitor alert) {
        alert.setAlertTime(LocalDateTime.now());
        alert.setAlertStatus("未处理");
        alert.setCreateTime(LocalDateTime.now());
        alert.setUpdateTime(LocalDateTime.now());
        save(alert);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void handleAlert(Long id, String handleResult) {
        SafetyMonitor alert = getById(id);
        if (alert != null) {
            alert.setAlertStatus("已处理");
            alert.setHandleResult(handleResult);
            alert.setHandleTime(LocalDateTime.now());
            alert.setUpdateTime(LocalDateTime.now());
            updateById(alert);
        }
    }

    @Override
    public Map<String, Object> getSafetyDataTrend(String timeRange) {
        Map<String, Object> trend = new HashMap<>();
        // 模拟生成安全数据趋势
        List<String> dates = List.of("2024-01-01", "2024-01-02", "2024-01-03", "2024-01-04", "2024-01-05");
        List<Integer> normalCounts = List.of(85, 88, 82, 90, 87);
        List<Integer> warningCounts = List.of(15, 12, 18, 10, 13);
        
        trend.put("dates", dates);
        trend.put("normalCounts", normalCounts);
        trend.put("warningCounts", warningCounts);
        
        return trend;
    }
} 