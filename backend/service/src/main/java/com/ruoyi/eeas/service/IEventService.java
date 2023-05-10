package com.ruoyi.eeas.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.eeas.domain.Event;

/**
 * 事件数据Service接口
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
public interface IEventService extends IService<Event>
{
    /**
     * 查询事件数据
     *
     * @param id 事件数据主键
     * @return 事件数据
     */
    Event selectEventById(Long id);

    /**
     * 查询事件数据列表
     *
     * @param event 事件数据
     * @return 事件数据集合
     */
    List<Event> selectEventList(Event event);

    /**
     * 查询风险区域列表
     *
     * @return 风险区域集合
     */
    List<String> selectAreaList(String time);

    /**
     * 新增事件数据
     *
     * @param event 事件数据
     * @return 结果
     */
    int insertEvent(Event event);

    /**
     * 修改事件数据
     *
     * @param event 事件数据
     * @return 结果
     */
    int updateEvent(Event event);

    /**
     * 批量删除事件数据
     *
     * @param ids 需要删除的事件数据主键集合
     * @return 结果
     */
    int deleteEventByIds(Long[] ids);

    /**
     * 删除事件数据信息
     *
     * @param id 事件数据主键
     * @return 结果
     */
    int deleteEventById(Long id);

    /**
     * 根据日期查询封控数据
     *
     * @return 轨迹数据
     */
    String getByDateAndTaskId(String date,String taskId);

    /**
     * 根据日期查询封控预测数据
     *
     * @return 预测封控小区列表
     */
    String getPredictionDataByDate(String date);

    /**
     * 根据地点查询经纬度
     *
     * @return 经纬度
     */
    List<Map<String, String>> selectLongitudeAndLatitudeByPlace(String place);

    /**
     * 查询时间列表
     * @return 时间列表
     */
    List<String> selectTimeList();

    /**
     * 获取场所类型和小区户数
     * @param place 地名
     * @return 场所类型和小区户数
     */
    Map<String, Object> getTypeAndHouseholds(String place);

    /**
     * 获取当天患者经过数
     * @param date 日期
     * @param place 地点
     * @param taskId 任务id
     * @return 当天患者经过数
     */
    Integer getAppear(String date, String place, String taskId);

    /**
     * 获取历史患者经过数
     * @param date 日期
     * @param place 地点
     * @param taskId 任务id
     * @return 历史患者经过数
     */
    Integer getHistory(String date, String place, String taskId);

}
