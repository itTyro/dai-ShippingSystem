package com.shipping.security;

import com.shipping.util.JwtUtil;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final ApplicationContext applicationContext;
    private UserDetailsService userDetailsService;

    public JwtAuthenticationFilter(JwtUtil jwtUtil, ApplicationContext applicationContext) {
        this.jwtUtil = jwtUtil;
        this.applicationContext = applicationContext;
    }

    private UserDetailsService getUserDetailsService() {
        if (userDetailsService == null) {
            userDetailsService = applicationContext.getBean(UserDetailsService.class);
        }
        return userDetailsService;
    }

    private String getTokenFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String token = getTokenFromRequest(request);
        
        if (StringUtils.hasText(token) && jwtUtil.validateToken(token)) {
            Claims claims = jwtUtil.getClaimsFromToken(token);
            String username = claims.get("username", String.class);
            String userType = claims.get("userType", String.class);
            @SuppressWarnings("unchecked")
            List<String> authorities = claims.get("authorities", List.class);
            
            // 创建认证信息
            List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
            if (authorities != null) {
                grantedAuthorities = authorities.stream()
                    .map(SimpleGrantedAuthority::new)
                    .collect(Collectors.toList());
            }
            
            // 如果没有权限，添加默认权限
            if (grantedAuthorities.isEmpty()) {
                if ("ADMIN".equals(userType)) {
                    grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
                } else {
                    grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_CREW"));
                }
            }
            
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                username, null, grantedAuthorities);
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        
        filterChain.doFilter(request, response);
    }
} 