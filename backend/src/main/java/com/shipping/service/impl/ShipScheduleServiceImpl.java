package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Route;
import com.shipping.entity.ShipSchedule;
import com.shipping.mapper.ShipScheduleMapper;
import com.shipping.service.RouteService;
import com.shipping.service.ShipScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class ShipScheduleServiceImpl extends ServiceImpl<ShipScheduleMapper, ShipSchedule> implements ShipScheduleService {

    @Autowired
    private RouteService routeService;

    @Override
    public Page<ShipSchedule> page(Page<ShipSchedule> page, String shipName, String startPort, String endPort, String status) {
        LambdaQueryWrapper<ShipSchedule> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(shipName)) {
            wrapper.like(ShipSchedule::getShipName, shipName);
        }
        if (StringUtils.hasText(startPort)) {
            wrapper.like(ShipSchedule::getStartPort, startPort);
        }
        if (StringUtils.hasText(endPort)) {
            wrapper.like(ShipSchedule::getEndPort, endPort);
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(ShipSchedule::getStatus, status);
        }
        wrapper.orderByDesc(ShipSchedule::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(ShipSchedule schedule) {
        schedule.setCreateTime(LocalDateTime.now());
        schedule.setUpdateTime(LocalDateTime.now());
        save(schedule);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(ShipSchedule schedule) {
        schedule.setUpdateTime(LocalDateTime.now());
        updateById(schedule);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancel(Long id) {
        ShipSchedule schedule = getById(id);
        if (schedule != null) {
            schedule.setStatus("已取消");
            schedule.setUpdateTime(LocalDateTime.now());
            updateById(schedule);
        }
    }

    @Override
    public Map<String, Object> getScheduleStats() {
        Map<String, Object> stats = new HashMap<>();
        
        // 获取待发船舶数
        long pendingShips = count(new LambdaQueryWrapper<ShipSchedule>()
                .eq(ShipSchedule::getStatus, "待发"));
        stats.put("pendingShips", pendingShips);
        
        // 获取航行中船舶数
        long sailingShips = count(new LambdaQueryWrapper<ShipSchedule>()
                .eq(ShipSchedule::getStatus, "航行中"));
        stats.put("sailingShips", sailingShips);
        
        // 获取已到达船舶数
        long arrivedShips = count(new LambdaQueryWrapper<ShipSchedule>()
                .eq(ShipSchedule::getStatus, "已到达"));
        stats.put("arrivedShips", arrivedShips);
        
        // 获取预警船舶数
        long warningShips = count(new LambdaQueryWrapper<ShipSchedule>()
                .eq(ShipSchedule::getStatus, "预警"));
        stats.put("warningShips", warningShips);
        
        return stats;
    }

    @Override
    public Map<String, Object> getShipLocation(Long scheduleId) {
        ShipSchedule schedule = getById(scheduleId);
        Map<String, Object> location = new HashMap<>();
        
        if (schedule != null && "航行中".equals(schedule.getStatus())) {
            // 模拟获取船舶位置
            location.put("latitude", 31.2304 + Math.random() * 0.1);
            location.put("longitude", 121.4737 + Math.random() * 0.1);
            location.put("speed", 20 + Math.random() * 10);
            location.put("direction", "东北");
            location.put("updateTime", LocalDateTime.now());
        }
        
        return location;
    }

    @Override
    public List<Map<String, Object>> getRecommendedRoutes(String startPort, String endPort, String shipType) {
        List<Map<String, Object>> recommendedRoutes = new ArrayList<>();
        
        // 获取最短航线
        List<Route> shortestRoute = routeService.getShortestRoute(startPort, endPort);
        
        if (!shortestRoute.isEmpty()) {
            // 计算总距离和预计时间
            double totalDistance = 0;
            int totalTime = 0;
            for (Route route : shortestRoute) {
                totalDistance += route.getDistance();
                totalTime += route.getEstimatedTime();
            }
            
            // 构建推荐航线信息
            Map<String, Object> routeInfo = new HashMap<>();
            routeInfo.put("routes", shortestRoute);
            routeInfo.put("totalDistance", totalDistance);
            routeInfo.put("estimatedTime", totalTime);
            routeInfo.put("shipType", shipType);
            
            // 获取航线风险评估
            Map<String, Object> riskAssessment = routeService.getRouteRiskAssessment(shortestRoute.get(0).getId());
            routeInfo.put("riskAssessment", riskAssessment);
            
            recommendedRoutes.add(routeInfo);
        }
        
        return recommendedRoutes;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateScheduleStatus(Long id, String status) {
        ShipSchedule schedule = getById(id);
        if (schedule != null) {
            schedule.setStatus(status);
            schedule.setUpdateTime(LocalDateTime.now());
            updateById(schedule);
        }
    }
} 