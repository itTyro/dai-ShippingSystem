package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.Safety;

public interface SafetyService extends IService<Safety> {
    
    /**
     * 分页查询航行安全记录
     */
    Page<Safety> page(Page<Safety> page, String shipName, Integer status);
    
    /**
     * 添加航行安全记录
     */
    void add(Safety safety);
    
    /**
     * 更新航行安全记录
     */
    void update(Safety safety);
    
    /**
     * 删除航行安全记录
     */
    void delete(Long id);
    
    /**
     * 获取航行安全详情
     */
    Safety detail(Long id);
} 