package com.ruoyi.eeas.service;

import java.util.List;
import java.util.Map;

/**
 * 注意力分数数据Service接口
 *
 * @author zhouxinxing
 * @date 2023-04-14
 */
public interface IScoreService
{
    /**
     * 查询注意力分数
     *
     * @param date 日期
     * @param taskId 任务id
     * @return 注意力分数
     */
    List<Map<String, Object>> listScore(String date, Integer taskId);

    String getHeatmapDataOfCertainPlace(String date, Integer taskId,String place,String table);

}
