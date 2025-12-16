package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.shipping.entity.Cargo;
import com.shipping.entity.Crew;
import com.shipping.entity.Ship;
import com.shipping.entity.ShipSchedule;
import com.shipping.mapper.CargoMapper;
import com.shipping.mapper.CrewMapper;
import com.shipping.mapper.ShipMapper;
import com.shipping.mapper.ShipScheduleMapper;
import com.shipping.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    private CrewMapper crewMapper;

    @Autowired
    private ShipMapper shipMapper;

    @Autowired
    private CargoMapper cargoMapper;

    @Autowired
    private ShipScheduleMapper shipScheduleMapper;

    @Override
    public Map<String, Object> getStatistics() {
        Map<String, Object> result = new HashMap<>();

        // 获取船员总数
        Long crewCount = crewMapper.selectCount(new LambdaQueryWrapper<>());
        result.put("crewCount", crewCount);

        // 获取船舶总数
        Long shipCount = shipMapper.selectCount(new LambdaQueryWrapper<>());
        result.put("shipCount", shipCount);

        // 获取货物总数
        Long cargoCount = cargoMapper.selectCount(new LambdaQueryWrapper<>());
        result.put("cargoCount", cargoCount);

        // 获取航行任务总数
        Long taskCount = shipScheduleMapper.selectCount(new LambdaQueryWrapper<>());
        result.put("taskCount", taskCount);

        // 获取船舶状态分布
        List<Ship> ships = shipMapper.selectList(new LambdaQueryWrapper<>());
        Map<String, Long> shipStatusMap = ships.stream()
                .collect(Collectors.groupingBy(Ship::getStatus, Collectors.counting()));
        result.put("shipStatus", shipStatusMap);

        // 获取货物类型分布
        List<Cargo> cargos = cargoMapper.selectList(new LambdaQueryWrapper<>());
        Map<String, Long> cargoTypeMap = cargos.stream()
                .collect(Collectors.groupingBy(Cargo::getCargoType, Collectors.counting()));
        result.put("cargoType", cargoTypeMap);

        return result;
    }
} 