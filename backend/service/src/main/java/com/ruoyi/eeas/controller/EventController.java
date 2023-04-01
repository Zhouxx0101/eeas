package com.ruoyi.eeas.controller;

import com.alibaba.fastjson.JSONArray;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.eeas.config.RedisKeyUtil;
import com.ruoyi.eeas.domain.Event;
import com.ruoyi.eeas.service.IEventService;
import com.ruoyi.eeas.service.ITrajectoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.concurrent.TimeUnit;

import static java.util.stream.Collectors.toList;

/**
 * 事件数据Controller
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
@RestController
@RequestMapping("/data/event")
public class EventController extends BaseController {
    @Autowired
    private IEventService eventService;
    @Autowired
    private ITrajectoryService trajectoryService;
    @Autowired
    private RedisCache redisCache;

    /**
     * 查询事件数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/list")
    public TableDataInfo list(Event event) {
        startPage();
        List<Event> list = eventService.selectEventList(event);
        return getDataTable(list);
    }

    /**
     * 查询风险区域列表
     */

    @PreAuthorize("@ss.hasPermi('data:event:area')")
    @GetMapping("/area/{query}")
    public List<String> getArea(@PathVariable("query") String query) {
        System.out.println(query);
        return eventService.selectAreaList(query);
    }

    /**
     * 导出事件数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:event:export')")
    @Log(title = "事件数据", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Event event) {
        List<Event> list = eventService.selectEventList(event);
        ExcelUtil<Event> util = new ExcelUtil<Event>(Event.class);
        util.exportExcel(response, list, "事件数据数据");
    }

    /**
     * 获取事件数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('data:event:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(eventService.selectEventById(id));
    }

    /**
     * 新增事件数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:add')")
    @Log(title = "事件数据", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Event event) {
        return toAjax(eventService.insertEvent(event));
    }

    /**
     * 修改事件数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:edit')")
    @Log(title = "事件数据", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Event event) {
        return toAjax(eventService.updateEvent(event));
    }

    /**
     * 删除事件数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:remove')")
    @Log(title = "事件数据", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(eventService.deleteEventByIds(ids));
    }

    /**
     * 根据日期查询封控/患者经过/both列表
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/getByDate/{date}")
    public AjaxResult getByDate(@PathVariable("date") String date)
    {
        String places = eventService.getByDate(date);
        List<String> listTrajectoryPlaces = trajectoryService.getPlacesByDate(date);
        Map<String, List<Map<String, String>>> map = new HashMap<>();
        if (places == null && listTrajectoryPlaces.size() == 0) {
            map.put("sealedAndTrajectoryList", new ArrayList<>());
            map.put("onlySealedList", new ArrayList<>());
            map.put("onlyTrajectoryList", new ArrayList<>());
            return AjaxResult.error("地点为空！");
        }
        if (places == null) {
            map.put("sealedAndTrajectoryList", new ArrayList<>());
            map.put("onlySealedList", new ArrayList<>());
            map.put("onlyTrajectoryList", getLongitudeAndLatitudeByPlaces(listTrajectoryPlaces));
            return AjaxResult.success(map);
        }
        if (listTrajectoryPlaces.size() == 0) {
            places = places.replace('{', '[').replace('}', ']');
            List<String> listSealedPlaces = JSONArray.parseArray(places, String.class);
            map.put("sealedAndTrajectoryList", new ArrayList<>());
            map.put("onlySealedList", new ArrayList<>());
            map.put("onlyTrajectoryList", getLongitudeAndLatitudeByPlaces(listSealedPlaces));
            return AjaxResult.success(map);
        }
        if (places != null && listTrajectoryPlaces.size() > 0) {
            places = places.replace('{', '[').replace('}', ']');
            List<String> listSealedPlaces = JSONArray.parseArray(places, String.class);
            //取交集
            List<String> sealedAndTrajectory = listSealedPlaces.stream().filter(item -> listTrajectoryPlaces.contains(item)).collect(toList());
            //取差集
            List<String> OnlySealed = listSealedPlaces.stream().filter(item -> !listTrajectoryPlaces.contains(item)).collect(toList());
            List<String> OnlyTrajectory = listTrajectoryPlaces.stream().filter(item -> !listSealedPlaces.contains(item)).collect(toList());
            //根据地名获取经纬度
            List<Map<String, String>> sealedAndTrajectoryList = getLongitudeAndLatitudeByPlaces(sealedAndTrajectory);
            List<Map<String, String>> OnlySealedList = getLongitudeAndLatitudeByPlaces(OnlySealed);
            List<Map<String, String>> OnlyTrajectoryList = getLongitudeAndLatitudeByPlaces(OnlyTrajectory);
            map.put("sealedAndTrajectoryList", sealedAndTrajectoryList);
            map.put("onlySealedList", OnlySealedList);
            map.put("onlyTrajectoryList", OnlyTrajectoryList);
            return AjaxResult.success(map);
        }
        return AjaxResult.error();
    }

    /**
     * 根据日期查询封控小区预测数据
     */
     @PreAuthorize("@ss.hasPermi('data:event:list')")
     @GetMapping("/getPredictionDataByDate/{date}")
     public AjaxResult getPredictionDataByDate(@PathVariable("date") String date){
        String places= eventService.getPredictionDataByDate(date);
        if (places == null) {
            return AjaxResult.error("预测数据为空！");
        }
        places = places.replace('{', '[').replace('}', ']');
        List<String> sealedPredictionPlaces = JSONArray.parseArray(places, String.class);
        List<Map<String, String>> sealedPredictionPlacesWithLongitudeAndLatitude = getLongitudeAndLatitudeByPlaces(sealedPredictionPlaces);
        Map<String,List<Map<String,String>>> map=new HashMap<>();
        map.put("sealedPredictionList", sealedPredictionPlacesWithLongitudeAndLatitude);
        return AjaxResult.success(map);
    }

    /**
     * 根据地名查询经纬度
     * @param listPlaces
     * @return
     */
    public List<Map<String, String>> getLongitudeAndLatitudeByPlaces(List<String> listPlaces) {
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        for (int i = 0; i < listPlaces.size(); i++) {
            String place = listPlaces.get(i);
            Object val = redisCache.getCacheObject(RedisKeyUtil.REDIS_PLACE_LONGITUDE_LATITUDE+place);
            if(Objects.nonNull(val)) {
                Map<String, String> map = new HashMap<String, String>();
                String[] point = val.toString().split(",");
                map.put("longitude", point[0]);
                map.put("latitude", point[1]);
                list.add(map);
//                System.out.println("redis");
//                System.out.println("val: " + val);
//                System.out.println("point[0]: " + point[0]);
//                System.out.println("point[1]: " + point[1]);
            } else {
                List<Map<String, String>> res = eventService.selectLongitudeAndLatitudeByPlace(place);
//                System.out.println("mysql");
                if(res.size() > 0) {
//                    System.out.println("11");
                    Map<String, String> map = res.get(0);
                    list.add(map);
                    redisCache.setCacheObject(RedisKeyUtil.REDIS_PLACE_LONGITUDE_LATITUDE+place, map.get("longitude")+','+map.get("latitude"), RedisKeyUtil.REDIS_PLACE_LONGITUDE_LATITUDE_EXPIRATION, TimeUnit.DAYS);
//                    System.out.println("map: " + map);
//                    System.out.println("map.get(\"longitude\")+','+map.get(\"latitude\"): " + map.get("longitude")+','+map.get("latitude"));

                }
            }
        }
        return list;
    }

    /**
     * 查询时间列表
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/time")
    public AjaxResult timeList() {
        List<String> list = eventService.selectTimeList();
        return AjaxResult.success(list);
    }
}
