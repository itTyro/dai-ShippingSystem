package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.annotation.Log;
import com.shipping.common.Result;
import com.shipping.entity.ShipSchedule;
import com.shipping.service.ShipScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/ship-schedules")
public class ShipScheduleController {

    @Autowired
    private ShipScheduleService shipScheduleService;

    @GetMapping("/stats")
    public Result<Map<String, Object>> getScheduleStats() {
        return Result.success(shipScheduleService.getScheduleStats());
    }

    @Log("查看船舶调度")
    @GetMapping("/page")
    public Result<Page<ShipSchedule>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String shipName,
            @RequestParam(required = false) String startPort,
            @RequestParam(required = false) String endPort,
            @RequestParam(required = false) String status) {
        Page<ShipSchedule> page = new Page<>(current, size);
        return Result.success(shipScheduleService.page(page, shipName, startPort, endPort, status));
    }

    @Log("添加船舶调度")
    @PostMapping("/add")
    public Result<?> add(@RequestBody ShipSchedule schedule) {
        shipScheduleService.add(schedule);
        return Result.success();
    }

    @Log("更新船舶调度")
    @PutMapping("/update")
    public Result<?> update(@RequestBody ShipSchedule schedule) {
        shipScheduleService.update(schedule);
        return Result.success();
    }

    @Log("取消船舶调度")
    @DeleteMapping("/{id}")
    public Result<?> cancel(@PathVariable Long id) {
        shipScheduleService.cancel(id);
        return Result.success();
    }

    @GetMapping("/{id}/location")
    public Result<Map<String, Object>> getShipLocation(@PathVariable Long id) {
        return Result.success(shipScheduleService.getShipLocation(id));
    }

    @GetMapping("/recommended-routes")
    public Result<List<Map<String, Object>>> getRecommendedRoutes(
            @RequestParam String startPort,
            @RequestParam String endPort,
            @RequestParam String shipType) {
        return Result.success(shipScheduleService.getRecommendedRoutes(startPort, endPort, shipType));
    }

    @PostMapping("/{id}/status")
    public Result<Void> updateScheduleStatus(
            @PathVariable Long id,
            @RequestParam String status) {
        shipScheduleService.updateScheduleStatus(id, status);
        return Result.success();
    }
} 