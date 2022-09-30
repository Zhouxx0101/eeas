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
import com.ruoyi.eeas.domain.News;
import com.ruoyi.eeas.service.INewsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 新闻数据Controller
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
@RestController
@RequestMapping("/data/news")
public class NewsController extends BaseController
{
    @Autowired
    private INewsService newsService;

    /**
     * 查询新闻数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:news:list')")
    @GetMapping("/list")
    public TableDataInfo list(News news)
    {
        startPage();
        List<News> list = newsService.selectNewsList(news);
        return getDataTable(list);
    }

    /**
     * 导出新闻数据列表
     */
    @PreAuthorize("@ss.hasPermi('data:news:export')")
    @Log(title = "新闻数据", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, News news)
    {
        List<News> list = newsService.selectNewsList(news);
        ExcelUtil<News> util = new ExcelUtil<News>(News.class);
        util.exportExcel(response, list, "新闻数据数据");
    }

    /**
     * 获取新闻数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('data:news:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(newsService.selectNewsById(id));
    }

    /**
     * 新增新闻数据
     */
    @PreAuthorize("@ss.hasPermi('data:news:add')")
    @Log(title = "新闻数据", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody News news)
    {
        return toAjax(newsService.insertNews(news));
    }

    /**
     * 修改新闻数据
     */
    @PreAuthorize("@ss.hasPermi('data:news:edit')")
    @Log(title = "新闻数据", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody News news)
    {
        return toAjax(newsService.updateNews(news));
    }

    /**
     * 删除新闻数据
     */
    @PreAuthorize("@ss.hasPermi('data:news:remove')")
    @Log(title = "新闻数据", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(newsService.deleteNewsByIds(ids));
    }
}
