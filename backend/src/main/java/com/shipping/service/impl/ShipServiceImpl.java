package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Ship;
import com.shipping.mapper.ShipMapper;
import com.shipping.service.ShipService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class ShipServiceImpl extends ServiceImpl<ShipMapper, Ship> implements ShipService {
    @Override
    public Page<Ship> page(Page<Ship> page, String name, String type, String status) {
        LambdaQueryWrapper<Ship> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(name)) {
            wrapper.like(Ship::getName, name);
        }
        if (StringUtils.hasText(type)) {
            wrapper.eq(Ship::getType, type);
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(Ship::getStatus, status);
        }
        wrapper.orderByDesc(Ship::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    public void add(Ship ship) {
        save(ship);
    }

    @Override
    public void update(Ship ship) {
        updateById(ship);
    }

    @Override
    public void delete(Long id) {
        removeById(id);
    }

    @Override
    public Ship detail(Long id) {
        return getById(id);
    }
} 