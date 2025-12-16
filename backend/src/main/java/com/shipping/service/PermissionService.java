package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.Permission;

import java.util.List;

public interface PermissionService extends IService<Permission> {
    /**
     * 分页查询权限列表
     */
    Page<Permission> page(Page<Permission> page, String name);

    /**
     * 添加权限
     */
    void add(Permission permission);

    /**
     * 更新权限
     */
    void update(Permission permission);

    /**
     * 删除权限
     */
    void delete(Long id);

    /**
     * 获取权限树
     */
    List<Permission> getPermissionTree();

    /**
     * 获取用户权限列表
     */
    List<Permission> getUserPermissions(Long userId);
} 