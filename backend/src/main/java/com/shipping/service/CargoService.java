package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.Cargo;

public interface CargoService extends IService<Cargo> {
    /**
     * 分页查询
     */
    Page<Cargo> page(Page<Cargo> page, String shipName, String cargoType, String status);

    /**
     * 添加货物
     */
    void add(Cargo cargo);

    /**
     * 更新货物
     */
    void update(Cargo cargo);

    /**
     * 删除货物
     */
    void delete(Long id);

    /**
     * 获取详情
     */
    Cargo detail(Long id);
} 