package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Permission;
import com.shipping.mapper.PermissionMapper;
import com.shipping.service.PermissionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {

    @Override
    public Page<Permission> page(Page<Permission> page, String name) {
        LambdaQueryWrapper<Permission> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(name)) {
            wrapper.like(Permission::getName, name);
        }
        wrapper.orderByAsc(Permission::getSort);
        return page(page, wrapper);
    }

    @Override
    public void add(Permission permission) {
        save(permission);
    }

    @Override
    public void update(Permission permission) {
        updateById(permission);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        // 删除子权限
        LambdaQueryWrapper<Permission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Permission::getParentId, id);
        remove(wrapper);
        // 删除当前权限
        removeById(id);
    }

    @Override
    public List<Permission> getPermissionTree() {
        // 获取所有权限
        List<Permission> allPermissions = list(new LambdaQueryWrapper<Permission>()
            .orderByAsc(Permission::getSort));
        
        // 构建树形结构
        Map<Long, List<Permission>> parentMap = allPermissions.stream()
            .collect(Collectors.groupingBy(Permission::getParentId));
        
        return buildTree(0L, parentMap);
    }

    @Override
    public List<Permission> getUserPermissions(Long userId) {
        return baseMapper.selectPermissionsByUserId(userId);
    }

    /**
     * 递归构建树形结构
     */
    private List<Permission> buildTree(Long parentId, Map<Long, List<Permission>> parentMap) {
        List<Permission> children = parentMap.get(parentId);
        if (children == null) {
            return new ArrayList<>();
        }
        
        for (Permission child : children) {
            List<Permission> grandChildren = buildTree(child.getId(), parentMap);
            if (!grandChildren.isEmpty()) {
                // 设置子节点
                child.setChildren(grandChildren);
            }
        }
        
        return children;
    }
} 