package com.shipping.utils;

import com.shipping.entity.User;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityUtils {
    
    /**
     * 获取当前登录用户ID
     */
    public static Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof User) {
            User user = (User) authentication.getPrincipal();
            return user.getId();
        }
        return null;
    }

    /**
     * 获取当前登录用户名
     */
    public static String getCurrentUsername() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() != null) {
            return authentication.getName();
        }
        return null;
    }

    /**
     * 获取当前登录用户
     */
    public static User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof User) {
            return (User) authentication.getPrincipal();
        }
        return null;
    }

    public static String getCurrentUserType() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() != null) {
            // 从权限中判断用户类型
            return authentication.getAuthorities().stream()
                .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN")) ? "ADMIN" : "CREW";
        }
        return null;
    }
} 