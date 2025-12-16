package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("safety_monitor")
public class SafetyMonitor {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String deviceName; // 设备名称
    
    private String deviceType; // 设备类型
    
    private String status; // 设备状态：正常、异常、离线
    
    private Integer healthPercent; // 健康度百分比
    
    private String location; // 设备位置
    
    private String shipName; // 所属船舶
    
    private String lastCheckTime; // 最后检查时间
    
    private String nextCheckTime; // 下次检查时间
    
    private String alertLevel; // 预警级别：高、中、低
    
    private String alertContent; // 预警内容
    
    private String alertStatus; // 预警状态：未处理、处理中、已处理
    
    private LocalDateTime alertTime; // 预警时间
    
    private String handler; // 处理人
    
    private String handleResult; // 处理结果
    
    private LocalDateTime handleTime; // 处理时间
    
    private LocalDateTime createTime;
    
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
} 