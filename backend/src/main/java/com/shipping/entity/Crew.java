package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("crew")
public class Crew {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String username;
    
    private String password;
    
    private String phone;
    
    private String email;
    
    private Integer status;
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    
    @TableLogic
    private Integer deleted;
} 