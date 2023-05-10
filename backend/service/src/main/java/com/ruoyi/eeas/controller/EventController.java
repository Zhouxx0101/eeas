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
import java.io.UnsupportedEncodingException;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
    @GetMapping("/getByDate/{date}/{taskId}")
    public AjaxResult getByDate(@PathVariable("date") String date, @PathVariable("taskId") String taskId)
    {
        String places = eventService.getByDateAndTaskId(date, taskId);
        List<String> listTrajectoryPlaces = trajectoryService.getPlacesByDateAndTaskId(date,taskId);
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

    // 集群数量
    public int clusterNum=5;
    /**
     * 根据日期以及任务ID返回集群对应下的地区列表
     * 目前集群暂定为5个
     * 集群根据地区聚类值进行划分
     * 但是目前各个地区的聚类值是随机的
     * @param date
     * @param taskId
     * @return
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/getClusterByDate/{date}/{taskId}")
    public AjaxResult getClusterByDate(@PathVariable("date") String date, @PathVariable("taskId") String taskId)
    {
        String eventPlaces = eventService.getByDateAndTaskId(date, taskId);
        List<String> listTrajectoryPlaces = trajectoryService.getPlacesByDateAndTaskId(date,taskId);
        Map<String, List<List<Map<String, String>>>> map = new HashMap<>();
        if (eventPlaces == null && listTrajectoryPlaces.size() == 0) {
            map.put("cluster", new ArrayList<>());
            return AjaxResult.error("集群地点为空！");
        }
        List<String> listSealedPlaces=new ArrayList<>();
        if (eventPlaces != null) {
            eventPlaces = eventPlaces.replace('{', '[').replace('}', ']');
            listSealedPlaces = JSONArray.parseArray(eventPlaces, String.class);
        }
        // 求封控地点以及轨迹地点并集
        List<String> listAllPlaces =new ArrayList<>();
        if (listSealedPlaces.size()!=0 && listTrajectoryPlaces.size()==0){
            listAllPlaces=listSealedPlaces;
        }
        if (listSealedPlaces.size()==0 && listTrajectoryPlaces.size()!=0){
            listAllPlaces=listTrajectoryPlaces;
        }
        if (listSealedPlaces.size()!=0 && listTrajectoryPlaces.size()!=0){
            listAllPlaces= Stream.of(listSealedPlaces, listTrajectoryPlaces)
                    .flatMap(Collection::stream)
                    .distinct()
                    .collect(Collectors.toList());
        }
        // 遍历所有地点，给他们随机加入数组中,即代表给地点随机赋值聚类值
        Random r=new Random();
        List<List<String>> places=new ArrayList<>(clusterNum);
        for(int i=0;i<clusterNum;i++){
            places.add(new ArrayList<>());
        }
        for(int i=0;i<listAllPlaces.size();i++){
            int j=r.nextInt(clusterNum);
            places.get(r.nextInt(clusterNum)).add(listAllPlaces.get(i));
        }
        List<List<Map<String, String>>> cluster=new ArrayList<>(clusterNum);
        for(int i=0;i<clusterNum;i++){
            cluster.add(getLongitudeAndLatitudeByPlaces(places.get(i)));
        }
        map.put("cluster",cluster);
        return AjaxResult.success(map);

    }

    /**
     * 根据日期以及任务ID查询预测地点集合，查询eeas_prediction_influence_place表
     * @param date
     * @param taskId
     * @return
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/getPredictionPlace/{date}/{taskId}")
    public AjaxResult getPredictionPlace(@PathVariable("date") String date, @PathVariable("taskId") String taskId)
    {
        List<String> places=eventService.getPredictionPlace(date,taskId);
        Map<String,List<String>> map=new HashMap<>();
        map.put("predictionPlace",places);
        return AjaxResult.success(map);

    }

    public int influencePlace=5;
    /**
     * 根据日期以及任务ID查询对于某个预测地点有影响力的地点，查询eeas_prediction_influence_place
     * 暂定是5个
     * @param date
     * @param taskId
     * @return
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/getInfluencePlace/{date}/{taskId}/{place}")
    public AjaxResult getInfluencePlace(@PathVariable("date") String date, @PathVariable("taskId") String taskId,@PathVariable("place") String place)
    {
        List<Map<String,Object>> placesAndScore=eventService.getInfluencePlace(date,taskId,place,influencePlace);
        System.out.println("placesAndScore："+placesAndScore);
        return AjaxResult.success(placesAndScore);

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
                map.put("place", place);
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
                    map.put("place", place);
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

    /**
     * 根据日期和地点获取具体信息（弹窗）
     * @param date 日期
     * @param place 地点
     * @return
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/getPlaceInfo/{date}/{place}/{taskId}")
    public AjaxResult getPlaceInfo(@PathVariable("date") String date, @PathVariable("place") String place, @PathVariable("taskId") String taskId) throws UnsupportedEncodingException {
        // 返回：场所名称、场所类型、如果是小区类型就显示居民、封控状态、当天患者经过数、历史患者经过数
        // 场所类型、小区户数
        Map<String, Object> map = eventService.getTypeAndHouseholds(place);
        // 封控状态
        String sealedPlaces = eventService.getByDateAndTaskId(date, taskId);
        if(sealedPlaces != null) {
            sealedPlaces = sealedPlaces.replace('{', '[').replace('}', ']');
            List<String> listSealedPlaces = JSONArray.parseArray(sealedPlaces, String.class);
            if(listSealedPlaces.contains(place)) {
                map.put("sealed", 1);
            } else {
                map.put("sealed", 0);
            }
        } else {
            map.put("sealed", 0);
        }
        // 当天患者经过数
        Integer appear = eventService.getAppear(date, place, taskId);
        map.put("appear", appear);
        // 历史患者经过数
        Integer history = eventService.getHistory(date, place, taskId);
        map.put("history", history);
        return AjaxResult.success(map);
    }

}
