package com.shipping.controller;

import com.shipping.common.Result;
import com.shipping.entity.User;
import com.shipping.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result<String> login(@RequestBody User user) {
        String token = userService.login(user.getUsername(), user.getPassword());
        return Result.success(token);
    }

    @PostMapping("/register")
    public Result<Void> register(@RequestBody User user) {
        userService.register(user);
        return Result.success();
    }

    @GetMapping("/current")
    public Result<User> getCurrentUser() {
        User user = userService.getCurrentUser();
        // 清除敏感信息
        user.setPassword(null);
        return Result.success(user);
    }

    @PutMapping("/update")
    public Result<Void> updateUser(@RequestBody User user) {
        userService.updateUser(user);
        return Result.success();
    }

//    @PutMapping("/password")
//    public Result<Void> changePassword(@RequestBody User user) {
//        userService.changePassword(user.getOldPassword(), user.getNewPassword());
//        return Result.success();
//    }

    @PostMapping("/updatePassword")
    public Result<?> updatePassword(@RequestBody User user) {
        userService.updatePassword(user);
        return Result.success();
    }
}