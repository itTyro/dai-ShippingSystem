package com.shipping.security;

import com.shipping.entity.User;
import com.shipping.service.UserService;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserService userService;

    public UserDetailsServiceImpl(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userService.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("用户不存在");
        }

        // 根据用户角色设置权限
        String role = "ROLE_" + user.getRole().toUpperCase();
        
        // 设置用户权限
        user.setAuthorities(Collections.singletonList(new SimpleGrantedAuthority(role)));
        
        return user;
    }
} 