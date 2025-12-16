package com.shipping.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("weather_info")
public class WeatherInfo {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String location; // 位置
    
    private String temperature; // 温度
    
    private String humidity; // 湿度
    
    private String windSpeed; // 风速
    
    private String windDirection; // 风向
    
    private String weather; // 天气状况
    
    private String visibility; // 能见度
    
    private String waveHeight; // 浪高
    
    private String warning; // 预警信息
    
    private LocalDateTime forecastTime; // 预报时间
    
    private LocalDateTime createTime;
    
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
} 