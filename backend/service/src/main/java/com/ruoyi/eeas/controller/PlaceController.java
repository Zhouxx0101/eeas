package com.ruoyi.eeas.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.eeas.service.IPlaceService;
import com.ruoyi.eeas.service.IScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 地点数据Controller
 *
 * @author smj
 * @date 2023-07-30
 */
@RestController
@RequestMapping("/data/place")
public class PlaceController extends BaseController {
    @Autowired
    private IPlaceService placeService;

    /**
     * 获取所有地点数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping(value = "/list")
    public AjaxResult listPlace()
    {
        List<String> places = placeService.listPlace();
        Map<String,List<String>> map=new HashMap<>();
        map.put("place",places);
        return AjaxResult.success(map);
    }
}
