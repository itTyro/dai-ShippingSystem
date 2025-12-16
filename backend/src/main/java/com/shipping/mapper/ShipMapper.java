package com.shipping.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shipping.entity.Ship;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShipMapper extends BaseMapper<Ship> {
} 