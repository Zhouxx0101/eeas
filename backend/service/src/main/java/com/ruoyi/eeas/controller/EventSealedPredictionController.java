package com.ruoyi.eeas.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.ruoyi.eeas.service.IEventService;
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
}
