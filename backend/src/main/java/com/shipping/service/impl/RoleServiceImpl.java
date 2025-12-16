package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Role;
import com.shipping.entity.RolePermission;
import com.shipping.mapper.RoleMapper;
import com.shipping.mapper.RolePermissionMapper;
import com.shipping.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    @Autowired
    private RolePermissionMapper rolePermissionMapper;

    @Override
    public Page<Role> page(Page<Role> page, String name) {
        LambdaQueryWrapper<Role> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(name)) {
            wrapper.like(Role::getName, name);
        }
        wrapper.orderByDesc(Role::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    public void add(Role role) {
        save(role);
    }

    @Override
    public void update(Role role) {
        updateById(role);
    }

    @Override
    public void delete(Long id) {
        removeById(id);
        // 删除角色权限关联
        LambdaQueryWrapper<RolePermission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RolePermission::getRoleId, id);
        rolePermissionMapper.delete(wrapper);
    }

    @Override
    @Transactional
    public void assignPermissions(Long roleId, List<Long> permissionIds) {
        // 删除原有权限
        LambdaQueryWrapper<RolePermission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RolePermission::getRoleId, roleId);
        rolePermissionMapper.delete(wrapper);
        
        // 添加新权限
        if (permissionIds != null && !permissionIds.isEmpty()) {
            List<RolePermission> rolePermissions = permissionIds.stream()
                .map(permissionId -> {
                    RolePermission rolePermission = new RolePermission();
                    rolePermission.setRoleId(roleId);
                    rolePermission.setPermissionId(permissionId);
                    return rolePermission;
                })
                .collect(Collectors.toList());
            rolePermissionMapper.batchInsert(rolePermissions);
        }
    }

    @Override
    public List<Long> getRolePermissions(Long roleId) {
        LambdaQueryWrapper<RolePermission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RolePermission::getRoleId, roleId);
        List<RolePermission> rolePermissions = rolePermissionMapper.selectList(wrapper);
        return rolePermissions.stream()
            .map(RolePermission::getPermissionId)
            .collect(Collectors.toList());
    }
} 