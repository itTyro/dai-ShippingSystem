package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.Ship;

public interface ShipService extends IService<Ship> {
    
    /**
     * 分页查询船舶列表
     *
     * @param page 分页参数
     * @param name 船名
     * @param type 类型
     * @param status 状态
     * @return 分页结果
     */
    Page<Ship> page(Page<Ship> page, String name, String type, String status);
    void add(Ship ship);
    void update(Ship ship);
    void delete(Long id);
    Ship detail(Long id);
} 