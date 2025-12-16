package com.shipping.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shipping.entity.User;

public interface UserService extends IService<User> {
    String login(String username, String password);
    void register(User user);
    User getCurrentUser();
    void updateUser(User user);
//    void changePassword(String oldPassword, String newPassword);
    User findByUsername(String username);
    /**
     * 修改密码
     * @param user 包含旧密码和新密码的用户对象
     */
    void updatePassword(User user);
}