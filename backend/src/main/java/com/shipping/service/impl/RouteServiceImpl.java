package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Route;
import com.shipping.mapper.RouteMapper;
import com.shipping.service.RouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class RouteServiceImpl extends ServiceImpl<RouteMapper, Route> implements RouteService {

    @Autowired
    private RouteMapper routeMapper;

    @Override
    public Page<Route> page(Page<Route> page, String startPort, String endPort) {
        LambdaQueryWrapper<Route> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(startPort)) {
            wrapper.like(Route::getStartPort, startPort);
        }
        if (StringUtils.hasText(endPort)) {
            wrapper.like(Route::getEndPort, endPort);
        }
        wrapper.orderByDesc(Route::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(Route route) {
        route.setCreateTime(LocalDateTime.now());
        route.setUpdateTime(LocalDateTime.now());
        save(route);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(Route route) {
        route.setUpdateTime(LocalDateTime.now());
        updateById(route);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(Long id) {
        removeById(id);
    }

    @Override
    public List<Route> getShortestRoute(String startPort, String endPort) {
        // 获取所有可用航线
        List<Route> allRoutes = list(new LambdaQueryWrapper<Route>()
                .eq(Route::getStatus, "可用"));
        
        // 构建图
        Map<String, Map<String, Double>> graph = new HashMap<>();
        for (Route route : allRoutes) {
            graph.computeIfAbsent(route.getStartPort(), k -> new HashMap<>())
                    .put(route.getEndPort(), route.getDistance());
            graph.computeIfAbsent(route.getEndPort(), k -> new HashMap<>())
                    .put(route.getStartPort(), route.getDistance());
        }
        
        // 使用Dijkstra算法求最短路径
        Map<String, Double> distances = new HashMap<>();
        Map<String, String> previous = new HashMap<>();
        Set<String> unvisited = new HashSet<>();
        
        // 初始化
        for (String port : graph.keySet()) {
            distances.put(port, Double.MAX_VALUE);
            unvisited.add(port);
        }
        distances.put(startPort, 0.0);
        
        while (!unvisited.isEmpty()) {
            // 找到未访问节点中距离最小的
            String current = null;
            double minDistance = Double.MAX_VALUE;
            for (String port : unvisited) {
                if (distances.get(port) < minDistance) {
                    minDistance = distances.get(port);
                    current = port;
                }
            }
            
            if (current == null || current.equals(endPort)) {
                break;
            }
            
            unvisited.remove(current);
            
            // 更新邻居节点的距离
            Map<String, Double> neighbors = graph.get(current);
            if (neighbors != null) {
                for (Map.Entry<String, Double> neighbor : neighbors.entrySet()) {
                    if (unvisited.contains(neighbor.getKey())) {
                        double newDistance = distances.get(current) + neighbor.getValue();
                        if (newDistance < distances.get(neighbor.getKey())) {
                            distances.put(neighbor.getKey(), newDistance);
                            previous.put(neighbor.getKey(), current);
                        }
                    }
                }
            }
        }
        
        // 构建最短路径
        List<Route> shortestRoute = new ArrayList<>();
        String current = endPort;
        while (current != null && !current.equals(startPort)) {
            final String prev = previous.get(current);
            if (prev == null) {
                return new ArrayList<>(); // 没有找到路径
            }
            
            // 找到对应的航线
            final String finalCurrent = current;
            Route route = allRoutes.stream()
                    .filter(r -> (r.getStartPort().equals(prev) && r.getEndPort().equals(finalCurrent)) ||
                            (r.getStartPort().equals(finalCurrent) && r.getEndPort().equals(prev)))
                    .findFirst()
                    .orElse(null);
            
            if (route != null) {
                shortestRoute.add(0, route);
            }
            
            current = prev;
        }
        
        return shortestRoute;
    }

    @Override
    public Map<String, Object> getRouteRiskAssessment(Long routeId) {
        Route route = getById(routeId);
        Map<String, Object> assessment = new HashMap<>();
        
        if (route != null) {
            // 根据天气状况、海况、交通密度等因素评估风险
            int riskScore = 0;
            
            // 天气状况评分
            switch (route.getWeatherCondition()) {
                case "晴朗":
                    riskScore += 1;
                    break;
                case "多云":
                    riskScore += 2;
                    break;
                case "阴天":
                    riskScore += 3;
                    break;
                case "雨天":
                    riskScore += 4;
                    break;
                case "风暴":
                    riskScore += 5;
                    break;
            }
            
            // 海况评分
            switch (route.getSeaCondition()) {
                case "平静":
                    riskScore += 1;
                    break;
                case "轻微":
                    riskScore += 2;
                    break;
                case "中等":
                    riskScore += 3;
                    break;
                case "大浪":
                    riskScore += 4;
                    break;
                case "巨浪":
                    riskScore += 5;
                    break;
            }
            
            // 交通密度评分
            switch (route.getTrafficDensity()) {
                case "稀疏":
                    riskScore += 1;
                    break;
                case "一般":
                    riskScore += 2;
                    break;
                case "密集":
                    riskScore += 3;
                    break;
                case "非常密集":
                    riskScore += 4;
                    break;
            }
            
            // 计算风险等级
            String riskLevel;
            if (riskScore <= 3) {
                riskLevel = "低风险";
            } else if (riskScore <= 6) {
                riskLevel = "中风险";
            } else if (riskScore <= 9) {
                riskLevel = "高风险";
            } else {
                riskLevel = "极高风险";
            }
            
            // 更新航线的风险等级
            route.setRiskLevel(riskLevel);
            updateById(route);
            
            // 返回评估结果
            assessment.put("riskScore", riskScore);
            assessment.put("riskLevel", riskLevel);
            assessment.put("weatherCondition", route.getWeatherCondition());
            assessment.put("seaCondition", route.getSeaCondition());
            assessment.put("trafficDensity", route.getTrafficDensity());
        }
        
        return assessment;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateRouteStatus(Long routeId, String status) {
        Route route = new Route();
        route.setId(routeId);
        route.setStatus(status);
        route.setUpdateTime(LocalDateTime.now());
        updateById(route);
    }

    @Override
    public List<String> getAllPorts() {
        Set<String> ports = new HashSet<>();
        ports.addAll(routeMapper.getAllStartPorts());
        ports.addAll(routeMapper.getAllEndPorts());
        return new ArrayList<>(ports);
    }

    @Override
    public List<Route> getRoutesByPorts(String startPort, String endPort) {
        return routeMapper.getRoutesByPorts(startPort, endPort);
    }

    @Override
    public List<Route> getRouteRecommendation(String startPort, String endPort) {
        // 获取所有可用航线
        List<Route> allRoutes = routeMapper.selectList(
            new QueryWrapper<Route>()
                .eq("status", "可用")
                .eq("deleted", false)
        );
        
        // 构建图
        Map<String, Map<String, Double>> graph = new HashMap<>();
        for (Route route : allRoutes) {
            graph.computeIfAbsent(route.getStartPort(), k -> new HashMap<>())
                .put(route.getEndPort(), route.getDistance());
        }
        
        // 使用Dijkstra算法找到最短路径
        Map<String, Double> distances = new HashMap<>();
        Map<String, String> previous = new HashMap<>();
        Set<String> unvisited = new HashSet<>();
        
        // 初始化
        for (String port : graph.keySet()) {
            distances.put(port, Double.MAX_VALUE);
            unvisited.add(port);
        }
        distances.put(startPort, 0.0);
        
        while (!unvisited.isEmpty()) {
            // 找到未访问节点中距离最小的
            String current = null;
            double minDistance = Double.MAX_VALUE;
            for (String port : unvisited) {
                Double distance = distances.get(port);
                if (distance != null && distance < minDistance) {
                    minDistance = distance;
                    current = port;
                }
            }
            
            if (current == null || current.equals(endPort)) break;
            unvisited.remove(current);
            
            // 更新邻居节点的距离
            Map<String, Double> neighbors = graph.get(current);
            if (neighbors != null) {
                for (Map.Entry<String, Double> entry : neighbors.entrySet()) {
                    String neighbor = entry.getKey();
                    Double distance = entry.getValue();
                    if (distance != null) {
                        Double currentDistance = distances.get(current);
                        if (currentDistance != null) {
                            double newDistance = currentDistance + distance;
                            Double neighborDistance = distances.get(neighbor);
                            if (neighborDistance != null && newDistance < neighborDistance) {
                                distances.put(neighbor, newDistance);
                                previous.put(neighbor, current);
                            }
                        }
                    }
                }
            }
        }
        
        // 构建推荐航线列表
        List<Route> recommendedRoutes = new ArrayList<>();
        String current = endPort;
        while (previous.containsKey(current)) {
            String prev = previous.get(current);
            List<Route> routes = routeMapper.getRoutesByPorts(prev, current);
            if (!routes.isEmpty()) {
                recommendedRoutes.add(0, routes.get(0));
            }
            current = prev;
        }
        
        return recommendedRoutes;
    }

    @Override
    public List<Route> getAllRoutes() {
        return list(new LambdaQueryWrapper<Route>()
                .eq(Route::getStatus, "可用")
                .eq(Route::getDeleted, false)
                .orderByAsc(Route::getStartPort));
    }
} 