package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("cargo")
public class Cargo {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String shipName;
    
    private String origin;
    
    private String destination;
    
    private LocalDateTime loadingTime;
    
    private String cargoType;
    
    private BigDecimal weight;
    
    private BigDecimal volume;
    
    private BigDecimal price;
    
    private String status;
    
    private String username;
    
    private LocalDateTime date;
    
    private String address;
    
    private LocalDateTime createTime;
    
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
}