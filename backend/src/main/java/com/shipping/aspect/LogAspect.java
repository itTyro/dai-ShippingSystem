package com.shipping.aspect;

import com.shipping.annotation.Log;
import com.shipping.entity.SystemLog;
import com.shipping.service.SystemLogService;
import com.shipping.utils.ServletUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.alibaba.fastjson.JSON;
import java.lang.reflect.Method;
import java.time.LocalDateTime;

@Aspect
@Component
public class LogAspect {

    @Autowired
    private SystemLogService systemLogService;

    // 定义切点
    @Pointcut("@annotation(com.shipping.annotation.Log)")
    public void logPointCut() {}

    // 定义切点 - 所有Controller方法
    @Pointcut("execution(* com.shipping.controller.*.*(..))")
    public void controllerPointCut() {}

    // 在方法执行后记录日志
    @AfterReturning(pointcut = "logPointCut() || controllerPointCut()", returning = "result")
    public void doAfterReturning(JoinPoint joinPoint, Object result) {
        handleLog(joinPoint, null, result);
    }

    // 在方法抛出异常后记录日志
    @AfterThrowing(pointcut = "logPointCut() || controllerPointCut()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Exception e) {
        handleLog(joinPoint, e, null);
    }

    protected void handleLog(JoinPoint joinPoint, Exception e, Object result) {
        try {
            // 获取注解
            MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            Method method = signature.getMethod();
            Log logAnnotation = method.getAnnotation(Log.class);
            
            // 创建日志对象
            SystemLog systemLog = new SystemLog();
            
            // 设置操作描述
            if (logAnnotation != null) {
                systemLog.setOperation(logAnnotation.value());
            } else {
                // 如果没有注解，使用类名+方法名作为操作描述
                String className = joinPoint.getTarget().getClass().getName();
                String methodName = method.getName();
                systemLog.setOperation(className + "." + methodName);
            }
            
            // 设置请求方法
            systemLog.setMethod(ServletUtils.getRequestMethod());
            
            // 设置请求参数
            Object[] args = joinPoint.getArgs();
            String params = JSON.toJSONString(args);
            systemLog.setParams(params);
            
            // 设置操作人
            systemLog.setUsername(ServletUtils.getCurrentUsername());
            
            // 设置操作人ID
            systemLog.setUserId(ServletUtils.getCurrentUserId());
            
            // 设置IP地址
            systemLog.setIp(ServletUtils.getClientIP());
            
            // 设置操作时间
            systemLog.setCreateTime(LocalDateTime.now());
            
            // 设置操作状态
            if (e != null) {
                systemLog.setStatus(1); // 失败
                systemLog.setErrorMsg(e.getMessage());
            } else {
                systemLog.setStatus(0); // 成功
            }
            
            // 保存日志
            systemLogService.save(systemLog);
        } catch (Exception exp) {
            // 记录日志失败不影响业务
            exp.printStackTrace();
        }
    }
} 