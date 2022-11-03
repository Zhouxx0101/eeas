package com.ruoyi.eeas.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.eeas.domain.Evolution;
import com.ruoyi.eeas.service.IEvolutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 疫情演化数据Controller
 * 
 * @author ruoyi
 * @date 2022-11-03
 */
@RestController
@RequestMapping("/evolution/datapredict")
public class EvolutionController extends BaseController
{
    @Autowired
    private IEvolutionService evolutionService;

    /**
     * 查询疫情演化数据列表
     */
    @PreAuthorize("@ss.hasPermi('evolution:datapredict:list')")
    @GetMapping("/list")
    public TableDataInfo list(Evolution evolution)
    {
        startPage();
        List<Evolution> list = evolutionService.selectEvolutionList(evolution);
        return getDataTable(list);
    }

    /**
     * 获取疫情演化数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('evolution:datapredict:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(evolutionService.selectEvolutionById(id));
    }

}
