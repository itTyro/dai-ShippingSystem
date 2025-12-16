package com.shipping.service;

import java.util.Map;

public interface DashboardService {
    /**
     * 获取首页统计数据
     */
    Map<String, Object> getStatistics();
} 