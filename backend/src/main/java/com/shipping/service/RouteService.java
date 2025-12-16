package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.Route;

import java.util.List;
import java.util.Map;

public interface RouteService extends IService<Route> {

    /**
     * 分页查询航线列表
     */
    Page<Route> page(Page<Route> page, String startPort, String endPort);

    /**
     * 添加航线
     */
    void add(Route route);

    /**
     * 更新航线
     */
    void update(Route route);

    /**
     * 删除航线
     */
    void delete(Long id);

    /**
     * 获取两点间的最短航线
     */
    List<Route> getShortestRoute(String startPort, String endPort);

    /**
     * 获取航线风险评估
     */
    Map<String, Object> getRouteRiskAssessment(Long routeId);

    /**
     * 更新航线状态
     */
    void updateRouteStatus(Long routeId, String status);

    List<String> getAllPorts();
    
    List<Route> getRoutesByPorts(String startPort, String endPort);
    
    List<Route> getRouteRecommendation(String startPort, String endPort);

    /**
     * 获取所有可用航线
     */
    List<Route> getAllRoutes();
}
 