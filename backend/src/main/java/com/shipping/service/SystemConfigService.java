package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.SystemConfig;

import java.util.Map;

public interface SystemConfigService extends IService<SystemConfig> {
    /**
     * 分页查询系统配置
     */
    Page<SystemConfig> page(Page<SystemConfig> page, String key);

    /**
     * 添加系统配置
     */
    void add(SystemConfig config);

    /**
     * 更新系统配置
     */
    void update(SystemConfig config);

    /**
     * 删除系统配置
     */
    void delete(Long id);

    /**
     * 获取所有系统配置
     */
    Map<String, String> getAllConfigs();

    /**
     * 获取指定配置项的值
     */
    String getConfigValue(String key);

    /**
     * 批量更新系统配置
     */
    void updateConfigs(Map<String, String> configs);
} 