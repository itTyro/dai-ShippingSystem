package com.shipping.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.Role;

import java.util.List;

public interface RoleService extends IService<Role> {
    Page<Role> page(Page<Role> page, String name);
    
    void add(Role role);
    
    void update(Role role);
    
    void delete(Long id);
    
    void assignPermissions(Long roleId, List<Long> permissionIds);
    
    List<Long> getRolePermissions(Long roleId);
} 