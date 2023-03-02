package com.ruoyi.eeas.controller;

import java.util.List;
import java.util.Map;
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
import com.ruoyi.eeas.domain.Trajectory;
import com.ruoyi.eeas.service.ITrajectoryService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 轨迹数据Controller
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
@RestController
@RequestMapping("/data/trajectory")
public class TrajectoryController extends BaseController
{
    @Autowired
    private ITrajectoryService trajectoryService;

    /**
     * 查询轨迹数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:list')")
    @GetMapping("/list")
    public TableDataInfo list(Trajectory trajectory)
    {
        startPage();
        List<Trajectory> list = trajectoryService.selectTrajectoryList(trajectory);
        return getDataTable(list);
    }

    /**
     * 导出轨迹数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:export')")
    @Log(title = "轨迹数据", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Trajectory trajectory)
    {
        List<Trajectory> list = trajectoryService.selectTrajectoryList(trajectory);
        ExcelUtil<Trajectory> util = new ExcelUtil<Trajectory>(Trajectory.class);
        util.exportExcel(response, list, "轨迹数据数据");
    }

    /**
     * 获取轨迹数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(trajectoryService.selectTrajectoryById(id));
    }

    /**
     * 新增轨迹数据
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:add')")
    @Log(title = "轨迹数据", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Trajectory trajectory)
    {
        return toAjax(trajectoryService.insertTrajectory(trajectory));
    }

    /**
     * 修改轨迹数据
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:edit')")
    @Log(title = "轨迹数据", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Trajectory trajectory)
    {
        return toAjax(trajectoryService.updateTrajectory(trajectory));
    }

    /**
     * 删除轨迹数据
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:remove')")
    @Log(title = "轨迹数据", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(trajectoryService.deleteTrajectoryByIds(ids));
    }

    /**
     * 查询近1天轨迹数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:list')")
    @GetMapping("/get1")
    public TableDataInfo get1()
    {
        startPage();
        List<Map<String, String>> list = trajectoryService.get1();
        return getDataTable(list);
    }

    /**
     * 查询1天至7天轨迹数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:list')")
    @GetMapping("/get1To7")
    public TableDataInfo get1To7()
    {
        startPage();
        List<Map<String, String>> list = trajectoryService.get1To7();
        return getDataTable(list);
    }

    /**
     * 查询7天至14天轨迹数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:list')")
    @GetMapping("/get7To14")
    public TableDataInfo get7To14()
    {
        startPage();
        List<Map<String, String>> list = trajectoryService.get7To14();
        return getDataTable(list);
    }

    /**
     * 查询14天以上轨迹数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:trajectory:list')")
    @GetMapping("/get14")
    public TableDataInfo get14()
    {
        startPage();
        List<Map<String, String>> list = trajectoryService.get14();
        return getDataTable(list);
    }
}
