package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.Cargo;
import com.shipping.service.CargoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cargo")
public class CargoController {
    @Autowired
    private CargoService cargoService;

    @GetMapping("/page")
    public Result<Page<Cargo>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String shipName,
            @RequestParam(required = false) String cargoType,
            @RequestParam(required = false) String status) {
        Page<Cargo> page = new Page<>(current, size);
        return Result.success(cargoService.page(page, shipName, cargoType, status));
    }

    @PostMapping
    public Result<Void> add(@RequestBody Cargo cargo) {
        cargoService.add(cargo);
        return Result.success();
    }

    @PutMapping
    public Result<Void> update(@RequestBody Cargo cargo) {
        cargoService.update(cargo);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        cargoService.delete(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<Cargo> detail(@PathVariable Long id) {
        return Result.success(cargoService.detail(id));
    }
} 