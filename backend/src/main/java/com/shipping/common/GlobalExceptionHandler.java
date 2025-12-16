package com.shipping.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public Result<String> handleException(Exception e) {
        log.error("系统异常", e);
        return Result.error("系统异常，请联系管理员");
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public Result<String> handleIllegalArgumentException(IllegalArgumentException e) {
        log.error("参数异常", e);
        return Result.error(400, e.getMessage());
    }

    @ExceptionHandler(BadCredentialsException.class)
    public Result<String> handleBadCredentialsException(BadCredentialsException e) {
        log.error("认证异常", e);
        return Result.error(401, e.getMessage());
    }

    @ExceptionHandler(AuthenticationException.class)
    public Result<String> handleAuthenticationException(AuthenticationException e) {
        log.error("认证异常", e);
        return Result.error(401, "认证失败");
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<String> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        List<FieldError> fieldErrors = e.getBindingResult().getFieldErrors();
        String message = fieldErrors.stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining(", "));
        log.error("参数校验失败: {}", message);
        return Result.error(400, message);
    }

    @ExceptionHandler(BindException.class)
    public Result<String> handleBindException(BindException e) {
        List<FieldError> fieldErrors = e.getBindingResult().getFieldErrors();
        String message = fieldErrors.stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining(", "));
        log.error("参数绑定失败: {}", message);
        return Result.error(400, message);
    }
}