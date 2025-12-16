package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.Permission;
import com.shipping.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/permissions")
public class PermissionController {
    @Autowired
    private PermissionService permissionService;

    @GetMapping("/page")
    public Result<Page<Permission>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String name) {
        Page<Permission> page = new Page<>(current, size);
        return Result.success(permissionService.page(page, name));
    }

    @PostMapping
    public Result<Void> add(@RequestBody Permission permission) {
        permissionService.add(permission);
        return Result.success();
    }

    @PutMapping
    public Result<Void> update(@RequestBody Permission permission) {
        permissionService.update(permission);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        permissionService.delete(id);
        return Result.success();
    }

    @GetMapping("/tree")
    public Result<List<Permission>> getPermissionTree() {
        return Result.success(permissionService.getPermissionTree());
    }

    @GetMapping("/user/{userId}")
    public Result<List<Permission>> getUserPermissions(@PathVariable Long userId) {
        return Result.success(permissionService.getUserPermissions(userId));
    }
}