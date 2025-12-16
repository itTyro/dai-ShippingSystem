package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.Ship;
import com.shipping.service.ShipService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ships")
@RequiredArgsConstructor
public class ShipController {

    private final ShipService shipService;

    @GetMapping("/page")
    public Result<Page<Ship>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String status) {
        Page<Ship> page = new Page<>(current, size);
        return Result.success(shipService.page(page, name, type, status));
    }

    @PostMapping
    public Result<Void> add(@RequestBody Ship ship) {
        shipService.save(ship);
        return Result.success();
    }

    @PutMapping
    public Result<Void> update(@RequestBody Ship ship) {
        shipService.updateById(ship);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        shipService.removeById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<Ship> getById(@PathVariable Long id) {
        return Result.success(shipService.getById(id));
    }
} 