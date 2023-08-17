package com.ruoyi.eeas.controller;

import com.alibaba.fastjson.JSONArray;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.eeas.service.IEventService;
import com.ruoyi.eeas.service.INewsService;
import com.ruoyi.eeas.service.IPlaceService;
import com.ruoyi.eeas.service.IScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Array;
import java.util.*;

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

    @Autowired
    private IPlaceService placeService;

    @Autowired
    private EventController eventController;

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

    /*
    获取某个节点的其他节点的注意力分数
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping(value = "/listScore/{date}/{taskId}/{place}/{table}")
    public AjaxResult getHeatmapDataOfCertainPlace(@PathVariable("date") String date, @PathVariable("taskId") Integer taskId,@PathVariable("place") String place,@PathVariable("table") String table)
    {
        String score = scoreService.getHeatmapDataOfCertainPlace(date, taskId,place,table);
        List<String> scoreList = JSONArray.parseArray(score, String.class);
        System.out.println("date = " + date + ", taskId = " + taskId + ", place = " + place);
        System.out.println(scoreList);
        // 获取所有地点经纬度
        List<String> places = placeService.listPlace();
        List<Map<String, String>> longitudeAndLatitudeByPlaces = eventController.getLongitudeAndLatitudeByPlaces(places);
        //Map<String, List<Map<String, String>>> map = new HashMap<>();
        for(int i=0;i<scoreList.size();i++){
            Map<String, String> stringStringMap = longitudeAndLatitudeByPlaces.get(i);
            stringStringMap.put("score",scoreList.get(i));
        }

        return AjaxResult.success(longitudeAndLatitudeByPlaces);
    }

    /**
     * 获取所有热力图分数前三十高的数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping(value = "/listTopXXPlaces/{date}/{taskId}/{place}/{table}")
    public AjaxResult listTopXXPlaces(@PathVariable("date") String date, @PathVariable("taskId") Integer taskId,@PathVariable("place") String place,@PathVariable("table") String table)
    {
        String score = scoreService.getHeatmapDataOfCertainPlace(date, taskId,place,table);
        List<String> scoreList = JSONArray.parseArray(score, String.class);
        List<Double> scoreFloat=JSONArray.parseArray(score, Double.class);
        List<Integer> index=getTopXXindex(scoreFloat);
        List<String> places=new ArrayList<>();
        // 获取地点名称
        if(index.size()==0){
            System.out.println("=========================");
            return AjaxResult.success(places);
        }
        places=placeService.getPlacesWithIDs(index);
        return AjaxResult.success(places);
    }

    public List<Integer> getTopXXindex(List<Double> scoreList){
        ArrayList<Double> originalList = new ArrayList<>(scoreList);
        List<Integer> re=new ArrayList<Integer>();
        if(scoreList==null){
            System.out.println("空list！！！");
            return re;
        }
        Set<Double> scoreSet=new HashSet<>(scoreList);
        List<Double> tempList=new ArrayList<>(scoreSet);
        Collections.sort(tempList);
        // 获取最高前几十分数对应的indexs
        int topnum=15;

        for(int i=tempList.size()-1;i>tempList.size()-topnum-1;i--){
            Double temp=tempList.get(i);
            System.out.println("====================="+temp);
            re.add(originalList.indexOf(temp)+4464);
        }
        System.out.println("=============="+re.size());
        return re;

    }
}
