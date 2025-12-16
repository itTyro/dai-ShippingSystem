package com.shipping.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.Crew;

public interface CrewService extends IService<Crew> {
    // 分页查询船员列表
    IPage<Crew> page(Page<Crew> page, String username);
    
    // 添加船员
    void add(Crew crew);
    
    // 更新船员信息
    void update(Crew crew);
    
    // 删除船员
    void delete(Long id);
    
    // 启用/禁用船员
    void updateStatus(Long id, Integer status);
    
    // 重置密码
    void resetPassword(Long id);
} 