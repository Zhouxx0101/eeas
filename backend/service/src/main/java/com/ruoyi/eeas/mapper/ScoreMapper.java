package com.ruoyi.eeas.mapper;


import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 注意力分数数据Mapper接口
 *
 * @author zhouxinxing
 * @date 2023-04-14
 */
public interface ScoreMapper {
    /**
     * 查询注意力分数
     *
     * @param date 日期
     * @param taskId 任务id
     * @return 注意力分数
     */
    List<Map<String, Object>> listScore(@Param("date") String date, @Param("taskId") Integer taskId);

    String getHeatmapDataOfCertainPlace1(@Param("date") String date, @Param("taskId") Integer taskId,@Param("place") String place);

    String getHeatmapDataOfCertainPlace2(@Param("date") String date, @Param("taskId") Integer taskId,@Param("place") String place);

    String getHeatmapDataOfCertainPlace3(@Param("date") String date, @Param("taskId") Integer taskId,@Param("place") String place);

    String getHeatmapDataOfCertainPlace4(@Param("date") String date, @Param("taskId") Integer taskId,@Param("place") String place);

}
