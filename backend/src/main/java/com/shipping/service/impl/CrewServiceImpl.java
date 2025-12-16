package com.shipping.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shipping.entity.Crew;
import com.shipping.mapper.CrewMapper;
import com.shipping.service.CrewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class CrewServiceImpl extends ServiceImpl<CrewMapper, Crew> implements CrewService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public IPage<Crew> page(Page<Crew> page, String username) {
        LambdaQueryWrapper<Crew> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(username)) {
            wrapper.like(Crew::getUsername, username);
        }
        wrapper.orderByDesc(Crew::getCreateTime);
        return page(page, wrapper);
    }

    @Override
    public void add(Crew crew) {
        // 检查用户名是否已存在
        if (lambdaQuery().eq(Crew::getUsername, crew.getUsername()).count() > 0) {
            throw new IllegalArgumentException("用户名已存在");
        }
        
        // 设置默认密码和状态
        crew.setPassword(passwordEncoder.encode("123456"));
        crew.setStatus(1);
        
        save(crew);
    }

    @Override
    public void update(Crew crew) {
        // 检查用户名是否已存在（排除自身）
        if (lambdaQuery()
                .eq(Crew::getUsername, crew.getUsername())
                .ne(Crew::getId, crew.getId())
                .count() > 0) {
            throw new IllegalArgumentException("用户名已存在");
        }
        
        // 不允许修改密码
        crew.setPassword(null);
        
        updateById(crew);
    }

    @Override
    public void delete(Long id) {
        removeById(id);
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        Crew crew = new Crew();
        crew.setId(id);
        crew.setStatus(status);
        updateById(crew);
    }

    @Override
    public void resetPassword(Long id) {
        Crew crew = new Crew();
        crew.setId(id);
        crew.setPassword(passwordEncoder.encode("123456"));
        updateById(crew);
    }
} 