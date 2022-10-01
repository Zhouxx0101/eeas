package com.ruoyi.eeas.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.eeas.domain.Event;
import com.ruoyi.eeas.service.IEventService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 事件数据Controller
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
@RestController
@RequestMapping("/data/event")
public class EventController extends BaseController
{
    @Autowired
    private IEventService eventService;

    /**
     * 查询事件数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:event:list')")
    @GetMapping("/list")
    public TableDataInfo list(Event event)
    {
        startPage();
        List<Event> list = eventService.selectEventList(event);
        return getDataTable(list);
    }

    /**
     * 导出事件数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:event:export')")
    @Log(title = "事件数据", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Event event)
    {
        List<Event> list = eventService.selectEventList(event);
        ExcelUtil<Event> util = new ExcelUtil<Event>(Event.class);
        util.exportExcel(response, list, "事件数据数据");
    }

    /**
     * 获取事件数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('data:event:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(eventService.selectEventById(id));
    }

    /**
     * 新增事件数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:add')")
    @Log(title = "事件数据", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Event event)
    {
        return toAjax(eventService.insertEvent(event));
    }

    /**
     * 修改事件数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:edit')")
    @Log(title = "事件数据", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Event event)
    {
        return toAjax(eventService.updateEvent(event));
    }

    /**
     * 删除事件数据
     */
    @PreAuthorize("@ss.hasPermi('data:event:remove')")
    @Log(title = "事件数据", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(eventService.deleteEventByIds(ids));
    }
}
