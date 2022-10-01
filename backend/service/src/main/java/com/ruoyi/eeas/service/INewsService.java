package com.ruoyi.eeas.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.eeas.domain.News;

/**
 * 新闻数据Service接口
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
public interface INewsService extends IService<News>
{
    /**
     * 查询新闻数据
     *
     * @param id 新闻数据主键
     * @return 新闻数据
     */
    News selectNewsById(Long id);

    /**
     * 查询新闻数据列表
     *
     * @param news 新闻数据
     * @return 新闻数据集合
     */
    List<News> selectNewsList(News news);

    /**
     * 新增新闻数据
     *
     * @param news 新闻数据
     * @return 结果
     */
    int insertNews(News news);

    /**
     * 修改新闻数据
     *
     * @param news 新闻数据
     * @return 结果
     */
    int updateNews(News news);

    /**
     * 批量删除新闻数据
     *
     * @param ids 需要删除的新闻数据主键集合
     * @return 结果
     */
    int deleteNewsByIds(Long[] ids);

    /**
     * 删除新闻数据信息
     *
     * @param id 新闻数据主键
     * @return 结果
     */
    int deleteNewsById(Long id);
}
