package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("ship_schedule")
public class ShipSchedule {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String shipName; // 船舶名称
    
    private String shipType; // 船舶类型
    
    private String startPort; // 起始港口
    
    private String endPort; // 目的港口

    private String routeString; // 航线
    
    private LocalDateTime departureTime; // 计划出发时间
    
    private LocalDateTime arrivalTime; // 预计到达时间
    
    private String status; // 状态：待发、航行中、已到达、已取消
    
    private Long routeId; // 航线ID
    
    private String cargoType; // 货物类型
    
    private Double cargoWeight; // 货物重量
    
    private String captain; // 船长
    
    private String crewCount; // 船员数量
    
    private String weatherWarning; // 天气预警
    
    private String trafficWarning; // 交通预警
    
    private String remark; // 备注
    
    private LocalDateTime createTime;
    
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
}