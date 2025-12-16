package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.SystemConfig;
import com.shipping.mapper.SystemConfigMapper;
import com.shipping.service.SystemConfigService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SystemConfigServiceImpl extends ServiceImpl<SystemConfigMapper, SystemConfig> implements SystemConfigService {

    @Override
    public Page<SystemConfig> page(Page<SystemConfig> page, String key) {
        LambdaQueryWrapper<SystemConfig> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(key)) {
            wrapper.like(SystemConfig::getConfigKey, key);
        }
        wrapper.orderByDesc(SystemConfig::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    public void add(SystemConfig config) {
        save(config);
    }

    @Override
    public void update(SystemConfig config) {
        updateById(config);
    }

    @Override
    public void delete(Long id) {
        removeById(id);
    }

    @Override
    public Map<String, String> getAllConfigs() {
        List<SystemConfig> configs = list();
        return configs.stream()
            .collect(Collectors.toMap(
                SystemConfig::getConfigKey,
                SystemConfig::getConfigValue
            ));
    }

    @Override
    public String getConfigValue(String key) {
        LambdaQueryWrapper<SystemConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SystemConfig::getConfigKey, key);
        SystemConfig config = getOne(wrapper);
        return config != null ? config.getConfigValue() : null;
    }

    @Override
    @Transactional
    public void updateConfigs(Map<String, String> configs) {
        configs.forEach((key, value) -> {
            LambdaQueryWrapper<SystemConfig> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(SystemConfig::getConfigKey, key);
            SystemConfig config = getOne(wrapper);
            
            if (config != null) {
                config.setConfigValue(value);
                updateById(config);
            } else {
                config = new SystemConfig();
                config.setConfigKey(key);
                config.setConfigValue(value);
                save(config);
            }
        });
    }
} 