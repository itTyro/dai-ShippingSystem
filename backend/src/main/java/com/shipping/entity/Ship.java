package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("ship")
public class Ship {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    /**
     * 船名
     */
    private String name;
    
    /**
     * 船舶类型：CARGO-货船, PASSENGER-客船, FISHING-渔船, OTHER-其他
     */
    private String type;
    
    /**
     * 船长(米)
     */
    private Double length;
    
    /**
     * 船宽(米)
     */
    private Double width;
    
    /**
     * 吃水(米)
     */
    private Double draft;
    
    /**
     * 吨位(吨)
     */
    private Double tonnage;
    
    /**
     * 状态：SAILING-在航, BERTHED-停泊, MAINTENANCE-维修, OTHER-其他
     */
    private String status;
    
    /**
     * 创建时间
     */
    private LocalDateTime createTime;
    
    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
} 