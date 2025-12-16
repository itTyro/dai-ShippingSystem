package com.shipping.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.entity.Route;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface RouteMapper extends BaseMapper<Route> {
    
    /**
     * 分页查询航线列表
     */
    @Select("<script>" +
            "SELECT * FROM route " +
            "WHERE deleted = 0 " +
            "<if test='startPort != null and startPort != \"\"'>" +
            "AND start_port LIKE CONCAT('%', #{startPort}, '%') " +
            "</if>" +
            "<if test='endPort != null and endPort != \"\"'>" +
            "AND end_port LIKE CONCAT('%', #{endPort}, '%') " +
            "</if>" +
            "<if test='status != null and status != \"\"'>" +
            "AND status = #{status} " +
            "</if>" +
            "ORDER BY create_time DESC" +
            "</script>")
    IPage<Route> selectRoutePage(Page<Route> page, 
                               @Param("startPort") String startPort,
                               @Param("endPort") String endPort,
                               @Param("status") String status);

    /**
     * 根据起始港口和目的港口查询航线
     */
    @Select("SELECT * FROM route " +
            "WHERE deleted = 0 " +
            "AND start_port = #{startPort} " +
            "AND end_port = #{endPort}")
    Route selectByPorts(@Param("startPort") String startPort, 
                       @Param("endPort") String endPort);

    /**
     * 查询所有可用的航线
     */
    @Select("SELECT * FROM route WHERE deleted = 0 AND status = '可用'")
    List<Route> selectAvailableRoutes();

    /**
     * 更新航线状态
     */
    @Update("UPDATE route SET status = #{status} WHERE id = #{id}")
    int updateStatus(@Param("id") Long id, @Param("status") String status);

    /**
     * 根据风险等级查询航线
     */
    @Select("SELECT * FROM route " +
            "WHERE deleted = 0 " +
            "AND risk_level = #{riskLevel}")
    List<Route> selectByRiskLevel(@Param("riskLevel") String riskLevel);

    /**
     * 更新航线天气状况
     */
    @Update("UPDATE route SET " +
            "weather_condition = #{weatherCondition}, " +
            "sea_condition = #{seaCondition}, " +
            "traffic_density = #{trafficDensity}, " +
            "risk_level = #{riskLevel} " +
            "WHERE id = #{id}")
    int updateWeatherInfo(@Param("id") Long id,
                         @Param("weatherCondition") String weatherCondition,
                         @Param("seaCondition") String seaCondition,
                         @Param("trafficDensity") String trafficDensity,
                         @Param("riskLevel") String riskLevel);

    @Select("SELECT DISTINCT start_port FROM route WHERE deleted = 0 AND status = '可用'")
    List<String> getAllStartPorts();
    
    @Select("SELECT DISTINCT end_port FROM route WHERE deleted = 0 AND status = '可用'")
    List<String> getAllEndPorts();
    
    @Select("SELECT * FROM route WHERE deleted = 0 AND status = '可用' AND start_port = #{startPort} AND end_port = #{endPort}")
    List<Route> getRoutesByPorts(String startPort, String endPort);
}