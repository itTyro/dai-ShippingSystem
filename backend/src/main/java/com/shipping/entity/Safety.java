package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("safety")
public class Safety {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String shipName; // 船名
    
    private String location; // 当前位置
    
    private Double speed; // 航速(节)
    
    private Double direction; // 航向(度)
    
    private String weather; // 天气状况
    
    private Integer status; // 状态：1-正常，0-异常
    
    private LocalDateTime createTime;
    
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
} 