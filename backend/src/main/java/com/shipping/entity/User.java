package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

@Data
@TableName("user")
public class User implements UserDetails {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String username;
    
    private String password;
    
    private String image;
    
    private String role;
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    
    @TableLogic
    private Integer deleted;

    // 用于密码修改的字段，不映射到数据库
    @TableField(exist = false)
    private String oldPassword;

    @TableField(exist = false)
    private String newPassword;

    // 用户权限列表，不映射到数据库
    @TableField(exist = false)
    private List<GrantedAuthority> authorities;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
} 