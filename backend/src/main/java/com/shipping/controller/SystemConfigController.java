package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.SystemConfig;
import com.shipping.service.SystemConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/system/configs")
public class SystemConfigController {
    @Autowired
    private SystemConfigService systemConfigService;

    @GetMapping("/page")
    public Result<Page<SystemConfig>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String key) {
        Page<SystemConfig> page = new Page<>(current, size);
        return Result.success(systemConfigService.page(page, key));
    }

    @PostMapping
    public Result<Void> add(@RequestBody SystemConfig config) {
        systemConfigService.add(config);
        return Result.success();
    }

    @PutMapping
    public Result<Void> update(@RequestBody SystemConfig config) {
        systemConfigService.update(config);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        systemConfigService.delete(id);
        return Result.success();
    }

    @GetMapping("/all")
    public Result<Map<String, String>> getAllConfigs() {
        return Result.success(systemConfigService.getAllConfigs());
    }

    @GetMapping("/{key}")
    public Result<String> getConfigValue(@PathVariable String key) {
        return Result.success(systemConfigService.getConfigValue(key));
    }

    @PutMapping("/batch")
    public Result<Void> updateConfigs(@RequestBody Map<String, String> configs) {
        systemConfigService.updateConfigs(configs);
        return Result.success();
    }
} 