package com.shipping.controller;

import com.shipping.common.Result;
import com.shipping.entity.Route;
import com.shipping.service.RouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/routes")
public class RouteController {

    @Autowired
    private RouteService routeService;

    @GetMapping("/ports")
    public Result<List<String>> getAllPorts() {
        return Result.success(routeService.getAllPorts());
    }

    @GetMapping
    public Result<List<Route>> getRoutesByPorts(
            @RequestParam String startPort,
            @RequestParam String endPort) {
        return Result.success(routeService.getRoutesByPorts(startPort, endPort));
    }

    @GetMapping("/route-recommendation")
    public Result<List<Route>> getRouteRecommendation(
            @RequestParam String startPort,
            @RequestParam String endPort) {
        return Result.success(routeService.getRouteRecommendation(startPort, endPort));
    }

    @GetMapping("/all")
    public Result<List<Route>> getAllRoutes() {
        return Result.success(routeService.getAllRoutes());
    }
} 