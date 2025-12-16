package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName("sys_permission")
public class Permission {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long parentId;
    
    private String name;
    
    private String code;
    
    private String type;
    
    private String path;
    
    private String component;
    
    private String icon;
    
    private Integer sort;
    
    private Boolean enabled;
    
    private LocalDateTime createTime;
    
    private LocalDateTime updateTime;

    @TableField(exist = false)
    private List<Permission> children;
} 