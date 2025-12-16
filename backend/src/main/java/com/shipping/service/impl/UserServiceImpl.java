package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Crew;
import com.shipping.entity.User;
import com.shipping.mapper.CrewMapper;
import com.shipping.mapper.UserMapper;
import com.shipping.service.UserService;
import com.shipping.util.JwtUtil;
import com.shipping.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private CrewMapper crewMapper;

    private final JwtUtil jwtUtil;

    public UserServiceImpl(@Lazy PasswordEncoder passwordEncoder, JwtUtil jwtUtil) {
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
    }

    @Override
    public String login(String username, String password) {
        // 先查询用户表
        User user = userMapper.selectOne(
            new LambdaQueryWrapper<User>()
                .eq(User::getUsername, username)
        );
        
        if (user != null) {
            // 验证密码
            if (!passwordEncoder.matches(password, user.getPassword())) {
                throw new BadCredentialsException("用户名或密码错误");
            }
            // 将用户名存到Security上下文中
            SecurityContextHolder.getContext().setAuthentication(
                new org.springframework.security.authentication.UsernamePasswordAuthenticationToken(
                    user, null
                )
            );
            // 生成token
            return generateToken(user.getUsername(), "ADMIN");
        }
        
        // 如果用户表中没有，查询船员表
        Crew crew = crewMapper.selectOne(
            new LambdaQueryWrapper<Crew>()
                .eq(Crew::getUsername, username)
        );
        
        if (crew != null) {
            // 验证密码
            if (!passwordEncoder.matches(password, crew.getPassword())) {
                throw new BadCredentialsException("用户名或密码错误");
            }
            // 生成token，设置用户类型为CREW
            return generateToken(crew.getUsername(), "CREW");
        }
        
        throw new BadCredentialsException("用户名或密码错误");
    }

    private String generateToken(String username, String userType) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("username", username);
        claims.put("userType", userType);
        
        // 设置权限
        List<String> authorities = new ArrayList<>();
        if ("ADMIN".equals(userType)) {
            authorities.add("ROLE_ADMIN");
            authorities.add("crew:manage");
            authorities.add("ship:manage");
            authorities.add("system:manage");
        } else {
            // 船员权限
            authorities.add("ROLE_CREW");
            authorities.add("navigation:manage");
            authorities.add("schedule:manage");
            authorities.add("cargo:manage");
            authorities.add("monitor:manage");
        }
        claims.put("authorities", authorities);
        
        return jwtUtil.generateToken(claims);
    }

    @Override
    public void register(User user) {
        // 检查用户名是否已存在
        if (lambdaQuery().eq(User::getUsername, user.getUsername()).count() > 0) {
            throw new IllegalArgumentException("用户名已存在");
        }
        
        // 加密密码
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        // 设置默认角色为 ADMIN
        user.setRole("ADMIN");
        
        save(user);
    }

    @Override
    public User getCurrentUser() {
        String username = SecurityUtils.getCurrentUsername();
        String userType = SecurityUtils.getCurrentUserType();
        
        if ("ADMIN".equals(userType)) {
            return lambdaQuery().eq(User::getUsername, username).one();
        } else {
            // 如果是船员，创建一个临时的User对象
            Crew crew = crewMapper.selectOne(
                new LambdaQueryWrapper<Crew>()
                    .eq(Crew::getUsername, username)
            );
            if (crew != null) {
                User user = new User();
                user.setUsername(crew.getUsername());
                user.setRole("CREW");
                user.setId(crew.getId());
                return user;
            }
        }
        return null;
    }

    @Override
    public void updateUser(User user) {
        User currentUser = getCurrentUser();
        user.setId(currentUser.getId());
        user.setPassword(null); // 不允许通过此方法修改密码
        updateById(user);
    }

    @Override
    @Transactional
    public void updatePassword(User user) {
        // 获取当前用户
        String username = SecurityUtils.getCurrentUsername();
        User currentUser = findByUsername(username);
        
        // 验证旧密码
        if (!passwordEncoder.matches(user.getOldPassword(), currentUser.getPassword())) {
            throw new RuntimeException("旧密码错误");
        }
        
        // 更新密码
        currentUser.setPassword(passwordEncoder.encode(user.getNewPassword()));
        userMapper.updateById(currentUser);
    }

    @Override
    public User findByUsername(String username) {
        return userMapper.selectOne(
            new LambdaQueryWrapper<User>()
                .eq(User::getUsername, username)
        );
    }
} 