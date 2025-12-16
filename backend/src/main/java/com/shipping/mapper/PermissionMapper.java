package com.shipping.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shipping.entity.Permission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PermissionMapper extends BaseMapper<Permission> {
    /**
     * 查询用户的权限列表
     */
    List<Permission> selectPermissionsByUserId(@Param("userId") Long userId);
} 