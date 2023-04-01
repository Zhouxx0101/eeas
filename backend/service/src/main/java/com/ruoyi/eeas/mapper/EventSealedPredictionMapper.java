package com.ruoyi.eeas.mapper;

import java.util.List;
import com.ruoyi.eeas.domain.EventSealedPrediction;
import org.apache.ibatis.annotations.Param;

/**
 * 封控小区预测数据Mapper接口
 * 
 * @author smj
 * @date 2023-03-31
 */
public interface EventSealedPredictionMapper 
{
    /**
     * 查询封控小区预测数据
     * 
     * @param id 封控小区预测数据主键
     * @return 封控小区预测数据
     */
    public EventSealedPrediction selectEventSealedPredictionById(Long id);

    /**
     * 查询指定任务指定日期封控小区
     *
     * @param date 查询日期
     * @param taskId,任务ID
     * @return 封控小区预测数据
     */
    public EventSealedPrediction selectEventSealedPredictionByDateAndTaskId(@Param("date") String date, @Param("taskId") String taskId);

    /**
     * 查询封控小区预测数据列表
     * 
     * @param eventSealedPrediction 封控小区预测数据
     * @return 封控小区预测数据集合
     */
    public List<EventSealedPrediction> selectEventSealedPredictionList(EventSealedPrediction eventSealedPrediction);

    /**
     * 新增封控小区预测数据
     * 
     * @param eventSealedPrediction 封控小区预测数据
     * @return 结果
     */
    public int insertEventSealedPrediction(EventSealedPrediction eventSealedPrediction);

    /**
     * 修改封控小区预测数据
     * 
     * @param eventSealedPrediction 封控小区预测数据
     * @return 结果
     */
    public int updateEventSealedPrediction(EventSealedPrediction eventSealedPrediction);

    /**
     * 删除封控小区预测数据
     * 
     * @param id 封控小区预测数据主键
     * @return 结果
     */
    public int deleteEventSealedPredictionById(Long id);

    /**
     * 批量删除封控小区预测数据
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEventSealedPredictionByIds(Long[] ids);
}
