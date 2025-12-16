package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Safety;
import com.shipping.mapper.SafetyMapper;
import com.shipping.service.SafetyService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;

@Service
public class SafetyServiceImpl extends ServiceImpl<SafetyMapper, Safety> implements SafetyService {

    @Override
    public Page<Safety> page(Page<Safety> page, String shipName, Integer status) {
        LambdaQueryWrapper<Safety> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(shipName)) {
            wrapper.like(Safety::getShipName, shipName);
        }
        if (status != null) {
            wrapper.eq(Safety::getStatus, status);
        }
        wrapper.orderByDesc(Safety::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(Safety safety) {
        safety.setCreateTime(LocalDateTime.now());
        safety.setUpdateTime(LocalDateTime.now());
        save(safety);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(Safety safety) {
        safety.setUpdateTime(LocalDateTime.now());
        updateById(safety);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(Long id) {
        removeById(id);
    }

    @Override
    public Safety detail(Long id) {
        return getById(id);
    }
} 