package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Cargo;
import com.shipping.mapper.CargoMapper;
import com.shipping.service.CargoService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class CargoServiceImpl extends ServiceImpl<CargoMapper, Cargo> implements CargoService {
    @Override
    public Page<Cargo> page(Page<Cargo> page, String shipName, String cargoType, String status) {
        LambdaQueryWrapper<Cargo> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(shipName)) {
            wrapper.like(Cargo::getShipName, shipName);
        }
        if (StringUtils.hasText(cargoType)) {
            wrapper.eq(Cargo::getCargoType, cargoType);
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(Cargo::getStatus, status);
        }
        wrapper.orderByDesc(Cargo::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    public void add(Cargo cargo) {
        save(cargo);
    }

    @Override
    public void update(Cargo cargo) {
        updateById(cargo);
    }

    @Override
    public void delete(Long id) {
        removeById(id);
    }

    @Override
    public Cargo detail(Long id) {
        return getById(id);
    }
} 