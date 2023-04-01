package com.ruoyi.eeas.service;

import java.util.List;
import com.ruoyi.eeas.domain.EventSealedPrediction;

/**
 * 封控小区预测数据Service接口
 * 
 * @author smj
 * @date 2023-03-31
 */
public interface IEventSealedPredictionService 
{
    /**
     * 查询封控小区预测数据
     * 
     * @param id 封控小区预测数据主键
     * @return 封控小区预测数据
     */
    public EventSealedPrediction selectEventSealedPredictionById(Long id);

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
     * 批量删除封控小区预测数据
     * 
     * @param ids 需要删除的封控小区预测数据主键集合
     * @return 结果
     */
    public int deleteEventSealedPredictionByIds(Long[] ids);

    /**
     * 删除封控小区预测数据信息
     * 
     * @param id 封控小区预测数据主键
     * @return 结果
     */
    public int deleteEventSealedPredictionById(Long id);

    public String getPlacesByDateAndTaskId(String date,String taskId);
}
