package com.ruoyi.eeas.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.eeas.service.IScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * 注意力分数数据Controller
 *
 * @author zhouxinxing
 * @date 2023-04-14
 */
@RestController
@RequestMapping("/data/score")
public class ScoreController extends BaseController {
    @Autowired
    private IScoreService scoreService;

    /**
     * 获取各时间及地点注意力分数
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping(value = "/list/{date}/{taskId}")
    public AjaxResult listScore(@PathVariable("date") String date, @PathVariable("taskId") Integer taskId)
    {
        List<Map<String, Object>> map = scoreService.listScore(date, taskId);
        return AjaxResult.success(map);
    }
}
