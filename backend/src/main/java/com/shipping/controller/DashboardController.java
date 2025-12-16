package com.shipping.controller;

import com.shipping.common.Result;
import com.shipping.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/statistics")
    public Result<Map<String, Object>> getStatistics() {
        return Result.success(dashboardService.getStatistics());
    }
} 