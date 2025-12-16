package com.shipping.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.Role;
import com.shipping.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/roles")
public class RoleController {
    @Autowired
    private RoleService roleService;

    @GetMapping("/page")
    public Result<Page<Role>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String name) {
        Page<Role> page = new Page<>(current, size);
        return Result.success(roleService.page(page, name));
    }

    @PostMapping
    public Result<Void> add(@RequestBody Role role) {
        roleService.add(role);
        return Result.success();
    }

    @PutMapping
    public Result<Void> update(@RequestBody Role role) {
        roleService.update(role);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        roleService.delete(id);
        return Result.success();
    }

    @PostMapping("/{roleId}/permissions")
    public Result<Void> assignPermissions(
            @PathVariable Long roleId,
            @RequestBody List<Long> permissionIds) {
        roleService.assignPermissions(roleId, permissionIds);
        return Result.success();
    }

    @GetMapping("/{roleId}/permissions")
    public Result<List<Long>> getRolePermissions(@PathVariable Long roleId) {
        return Result.success(roleService.getRolePermissions(roleId));
    }
} 