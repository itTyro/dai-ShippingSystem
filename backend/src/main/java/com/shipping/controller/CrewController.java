package com.shipping.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shipping.common.Result;
import com.shipping.entity.Crew;
import com.shipping.service.CrewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/crew")
public class CrewController {

    @Autowired
    private CrewService crewService;

    @GetMapping("/page")
    public Result<IPage<Crew>> page(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String username) {
        Page<Crew> page = new Page<>(current, size);
        return Result.success(crewService.page(page, username));
    }

    @PostMapping
    public Result<Void> add(@RequestBody Crew crew) {
        crewService.add(crew);
        return Result.success();
    }

    @PutMapping
    public Result<Void> update(@RequestBody Crew crew) {
        crewService.update(crew);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        crewService.delete(id);
        return Result.success();
    }

    @PutMapping("/{id}/status/{status}")
    public Result<Void> updateStatus(
            @PathVariable Long id,
            @PathVariable Integer status) {
        crewService.updateStatus(id, status);
        return Result.success();
    }

    @PutMapping("/{id}/reset-password")
    public Result<Void> resetPassword(@PathVariable Long id) {
        crewService.resetPassword(id);
        return Result.success();
    }
}