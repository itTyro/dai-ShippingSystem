package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.Safety;
import com.shipping.service.SafetyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/safety")
public class SafetyController {

    @Autowired
    private SafetyService safetyService;

    @GetMapping("/page")
    public Result<Page<Safety>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String shipName,
            @RequestParam(required = false) Integer status) {
        Page<Safety> page = new Page<>(current, size);
        return Result.success(safetyService.page(page, shipName, status));
    }

    @PostMapping
    public Result<Void> add(@RequestBody Safety safety) {
        safetyService.add(safety);
        return Result.success();
    }

    @PutMapping
    public Result<Void> update(@RequestBody Safety safety) {
        safetyService.update(safety);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        safetyService.delete(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<Safety> detail(@PathVariable Long id) {
        return Result.success(safetyService.detail(id));
    }
} 