package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.ShipSchedule;

import java.util.List;
import java.util.Map;

public interface ShipScheduleService extends IService<ShipSchedule> {
    
    /**
     * 分页查询船舶调度列表
     */
    Page<ShipSchedule> page(Page<ShipSchedule> page, String shipName, String startPort, String endPort, String status);
    
    /**
     * 添加船舶调度
     */
    void add(ShipSchedule schedule);
    
    /**
     * 更新船舶调度
     */
    void update(ShipSchedule schedule);
    
    /**
     * 取消船舶调度
     */
    void cancel(Long id);
    
    /**
     * 获取船舶调度状态统计
     */
    Map<String, Object> getScheduleStats();
    
    /**
     * 获取船舶实时位置
     */
    Map<String, Object> getShipLocation(Long scheduleId);
    
    /**
     * 获取推荐航线
     */
    List<Map<String, Object>> getRecommendedRoutes(String startPort, String endPort, String shipType);
    
    /**
     * 更新船舶调度状态
     */
    void updateScheduleStatus(Long id, String status);
}