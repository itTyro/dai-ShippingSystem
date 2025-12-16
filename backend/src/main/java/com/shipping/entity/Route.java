package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("route")
public class Route {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String startPort; // 起始港口
    
    private String endPort; // 目的港口
    
    private Double distance; // 航线距离（海里）
    
    private Integer estimatedTime; // 预计航行时间（小时）
    
    private String weatherCondition; // 天气状况
    
    private String seaCondition; // 海况
    
    private String trafficDensity; // 交通密度
    
    private String riskLevel; // 风险等级
    
    private String status; // 状态：可用、维护中、关闭
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
} 