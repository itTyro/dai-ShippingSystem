package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("safety_alert")
public class SafetyAlert {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String title;
    
    private String content;
    
    private String level;  // 预警级别：高、中、低
    
    private String type;   // 预警类型：天气、设备、航行等
    
    private String status; // 状态：未处理、处理中、已处理
    
    private String location; // 预警位置
    
    private LocalDateTime alertTime;
    
    private String handler; // 处理人
    
    private String handleResult; // 处理结果
    
    private LocalDateTime handleTime;
    
    private LocalDateTime createTime;
    
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
} 