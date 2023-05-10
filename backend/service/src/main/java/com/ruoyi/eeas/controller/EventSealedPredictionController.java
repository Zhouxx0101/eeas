package com.ruoyi.eeas.controller;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.ruoyi.eeas.service.IEventService;
import com.ruoyi.eeas.service.ITrajectoryService;
import org.apache.commons.collections4.ListUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.eeas.domain.EventSealedPrediction;
import com.ruoyi.eeas.service.IEventSealedPredictionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

import static java.util.stream.Collectors.toList;

/**
 * 封控小区预测数据Controller
 * 
 * @author smj
 * @date 2023-03-31
 */
@RestController
@RequestMapping("/event/predictionData")
public class EventSealedPredictionController extends BaseController
{
    @Autowired
    private IEventSealedPredictionService eventSealedPredictionService;

    @Autowired
    private EventController eventController;

    @Autowired
    private IEventService eventService;
    @Autowired
    private ITrajectoryService trajectoryService;

    /**
     * 查询封控小区预测数据列表
     */
    @PreAuthorize("@ss.hasPermi('event:predictionData:list')")
    @GetMapping("/list")
    public TableDataInfo list(EventSealedPrediction eventSealedPrediction)
    {
        startPage();
        List<EventSealedPrediction> list = eventSealedPredictionService.selectEventSealedPredictionList(eventSealedPrediction);
        return getDataTable(list);
    }

    /**
     * 导出封控小区预测数据列表
     */
    @PreAuthorize("@ss.hasPermi('event:predictionData:export')")
    @Log(title = "封控小区预测数据", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EventSealedPrediction eventSealedPrediction)
    {
        List<EventSealedPrediction> list = eventSealedPredictionService.selectEventSealedPredictionList(eventSealedPrediction);
        ExcelUtil<EventSealedPrediction> util = new ExcelUtil<EventSealedPrediction>(EventSealedPrediction.class);
        util.exportExcel(response, list, "封控小区预测数据数据");
    }

    /**
     * 获取封控小区预测数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('event:predictionData:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(eventSealedPredictionService.selectEventSealedPredictionById(id));
    }

    /**
     * 新增封控小区预测数据
     */
    @PreAuthorize("@ss.hasPermi('event:predictionData:add')")
    @Log(title = "封控小区预测数据", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EventSealedPrediction eventSealedPrediction)
    {
        return toAjax(eventSealedPredictionService.insertEventSealedPrediction(eventSealedPrediction));
    }

    /**
     * 修改封控小区预测数据
     */
    @PreAuthorize("@ss.hasPermi('event:predictionData:edit')")
    @Log(title = "封控小区预测数据", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EventSealedPrediction eventSealedPrediction)
    {
        return toAjax(eventSealedPredictionService.updateEventSealedPrediction(eventSealedPrediction));
    }

    /**
     * 删除封控小区预测数据
     */
    @PreAuthorize("@ss.hasPermi('event:predictionData:remove')")
    @Log(title = "封控小区预测数据", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(eventSealedPredictionService.deleteEventSealedPredictionByIds(ids));
    }

    /**
     * 根据时间以及任务id获取封控小区预测数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('event:predictionData:query')")
    @GetMapping(value = "/query/{date}/{taskId}")
    public AjaxResult getInfo(@PathVariable("date") String date,@PathVariable("taskId") String taskId)
    {
        String places=eventSealedPredictionService.getPlacesByDateAndTaskId(date,taskId);
        if (places==null){
            return AjaxResult.error("预测数据为空");
        }
        places = places.replace('{', '[').replace('}', ']');
        List<String> sealedPredictionPlaces = JSONArray.parseArray(places, String.class);
        List<Map<String, String>> sealedPredictionPlacesWithLongitudeAndLatitude = eventController.getLongitudeAndLatitudeByPlaces(sealedPredictionPlaces);
        Map<String,List<Map<String,String>>> map=new HashMap<>();
        map.put("sealedPredictionList", sealedPredictionPlacesWithLongitudeAndLatitude);
        return AjaxResult.success(map);
    }

    /**
     * 根据时间以及任务id获取预测页数据详细信息
     * 分别有真实数据、预测命中数据以及预测未命中数据
     */
    @PreAuthorize("@ss.hasPermi('data:prediction:list')")
    @GetMapping(value = "/queryPageData/{date}/{taskId}")
    public AjaxResult getPrePageInfo(@PathVariable("date") String date,@PathVariable("taskId") String taskId)
    {
        // 封控地点
        String sealedPlaces = eventService.getByDateAndTaskId(date, taskId);
        List<String> listSealedPlaces=new ArrayList<>();
        if (sealedPlaces!=null){
            sealedPlaces=sealedPlaces.replace('{','[').replace('}',']');
            listSealedPlaces = JSONArray.parseArray(sealedPlaces, String.class);
        }

        // 轨迹地点
        List<String> listTrajectoryPlaces = trajectoryService.getPlacesByDateAndTaskId(date,taskId);

        // 封控预测地点
        String sealedPlacesPre=eventSealedPredictionService.getPlacesByDateAndTaskId(date,taskId);
        List<String> listPreSealedPlaces=new ArrayList<>();
        if (sealedPlacesPre!=null){
            sealedPlacesPre=sealedPlacesPre.replace('{','[').replace('}',']');
            listPreSealedPlaces = JSONArray.parseArray(sealedPlacesPre, String.class);
        }

        Map<String, List<Map<String, String>>> map = new HashMap<>();

        // 首先求真实数据并集
        List<String> listRealPlaces =new ArrayList<>();
        if (listSealedPlaces.size()!=0 && listTrajectoryPlaces.size()==0){
            listRealPlaces=listSealedPlaces;
        }
        if (listSealedPlaces.size()==0 && listTrajectoryPlaces.size()!=0){
            listRealPlaces=listTrajectoryPlaces;
        }
        if (listSealedPlaces.size()!=0 && listTrajectoryPlaces.size()!=0){
            listRealPlaces= Stream.of(listSealedPlaces, listTrajectoryPlaces)
                    .flatMap(Collection::stream)
                    .distinct()
                    .collect(Collectors.toList());
        }

        // 接下来求真实结果与预测结果的交集与差集
        if(listRealPlaces.size()==0 &&listPreSealedPlaces.size()==0){
            map.put("realData",new ArrayList<>());
            map.put("preHitData",new ArrayList<>());
            map.put("preUnhitData",new ArrayList<>());
            return AjaxResult.success(map);
        }

        if(listRealPlaces.size()!=0 &&listPreSealedPlaces.size()==0){
            map.put("realData",eventController.getLongitudeAndLatitudeByPlaces(listRealPlaces));
            map.put("preHitData",new ArrayList<>());
            map.put("preUnhitData",new ArrayList<>());
            return AjaxResult.success(map);
        }

        if(listRealPlaces.size()==0 &&listPreSealedPlaces.size()!=0){
            map.put("realData",new ArrayList<>());
            map.put("preHitData",new ArrayList<>());
            map.put("preUnhitData",eventController.getLongitudeAndLatitudeByPlaces(listPreSealedPlaces));
            return AjaxResult.success(map);
        }

        if(listRealPlaces.size()!=0 &&listPreSealedPlaces.size()!=0){
            map.put("realData",eventController.getLongitudeAndLatitudeByPlaces(listRealPlaces));
            //取预测数据与真实数据交集为预测命中
            List<String> finalListRealPlaces = listRealPlaces;
            List<String> preHitPlaces = listPreSealedPlaces.stream().filter(item -> finalListRealPlaces.contains(item)).collect(toList());
            //取预测数据-预测命中为预测未命中
            List<String> preUnhitPlaces = ListUtils.subtract(listPreSealedPlaces, preHitPlaces);

            map.put("preHitData",eventController.getLongitudeAndLatitudeByPlaces(preHitPlaces));
            map.put("preUnhitData",eventController.getLongitudeAndLatitudeByPlaces(preUnhitPlaces));
            return AjaxResult.success(map);
        }
        return AjaxResult.success(map);
    }

    /**
     * 根据日期和地点获取对该预测地点产生最高影响的5个场所名称及影响力（弹窗）
     * @param date 日期
     * @param place 地点
     * @param taskId 任务id
     * @return 场所名称及影响力
     */
    @PreAuthorize("@ss.hasPermi('data:prediction:list')")
    @GetMapping("/getPredictionPlaceInfo/{date}/{place}/{taskId}")
    public AjaxResult getPredictionPlaceInfo(@PathVariable("date") String date, @PathVariable("place") String place, @PathVariable("taskId") String taskId) {
        Integer num = 5;
        List<Map<String, Object>> influencePlaces = eventSealedPredictionService.getPredictionPlaceInfo(date, place, taskId, num);
        return AjaxResult.success(influencePlaces);
    }
}




