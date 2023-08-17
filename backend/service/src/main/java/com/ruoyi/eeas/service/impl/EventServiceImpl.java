package com.ruoyi.eeas.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.eeas.domain.Event;
import com.ruoyi.eeas.mapper.EventMapper;
import com.ruoyi.eeas.service.IEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 事件数据Service业务层处理
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
@Service
public class EventServiceImpl extends ServiceImpl<EventMapper, Event> implements IEventService {
    @Autowired
    private EventMapper eventMapper;

    /**
     * 查询事件数据
     *
     * @param id 事件数据主键
     * @return 事件数据
     */
    @Override
    public Event selectEventById(Long id) {
        return eventMapper.selectEventById(id);
    }

    /**
     * 查询事件数据列表
     *
     * @param event 事件数据
     * @return 事件数据
     */
    @Override
    public List<Event> selectEventList(Event event) {
        return eventMapper.selectEventList(event);
    }

    /**
     * 查询风险区域列表
     *
     * @return 风险区域集合
     */
    public List<String> selectAreaList(String time) {
        time += '%';
        System.out.println(time);
        List<String> res = eventMapper.selectAreaList(time);
        System.out.println(res);
        return res;
    }

    /**
     * 新增事件数据
     *
     * @param event 事件数据
     * @return 结果
     */
    @Override
    public int insertEvent(Event event) {
        return eventMapper.insert(event);
    }

    /**
     * 修改事件数据
     *
     * @param event 事件数据
     * @return 结果
     */
    @Override
    public int updateEvent(Event event) {
        return eventMapper.updateEvent(event);
    }

    /**
     * 批量删除事件数据
     *
     * @param ids 需要删除的事件数据主键
     * @return 结果
     */
    @Override
    public int deleteEventByIds(Long[] ids) {
        return eventMapper.deleteEventByIds(ids);
    }

    /**
     * 删除事件数据信息
     *
     * @param id 事件数据主键
     * @return 结果
     */
    @Override
    public int deleteEventById(Long id) {
        return eventMapper.deleteEventById(id);
    }

    /**
     * 根据日期查询封控数据
     *
     * @return 轨迹数据
     */
    @Override
    public String getByDateAndTaskId(String date,String taskId) {
        return eventMapper.getByDateAndTaskId(date,taskId);
    }

    @Override
    public List<String> getPredictionPlace(String date,String taskID){
        return eventMapper.getPredictionPlace(date,taskID);
    }

    @Override
    public String  getInfluencePlace(String date,String taskID,String place){
        return eventMapper.getInfluencePlace(date,taskID,place);
    }
    /**
     * 根据日期查询封控预测数据
     *
     * @return 轨迹数据
     */
    @Override
    public String getPredictionDataByDate(String date) {
        return eventMapper.getPredictionDataByDate(date);
    }

    /**
     * 根据地点查询经纬度
     *
     * @return 经纬度
     */
    @Override
    public List<Map<String, String>> selectLongitudeAndLatitudeByPlace(String place) {
        return eventMapper.selectLongitudeAndLatitudeByPlace(place);
    }

    /**
     * 查询时间列表
     * @return 时间列表
     */
    @Override
    public List<String> selectTimeList() {
        return eventMapper.selectTimeList();
    }

    /**
     * 获取场所类型和小区户数
     * @param place 地名
     * @return
     */
    @Override
    public Map<String, Object> getTypeAndHouseholds(String place) {
        return eventMapper.getTypeAndHouseholds(place);
    }

    /**
     * 获取当天患者经过数
     * @param date 日期
     * @param place 地点
     * @param taskId 任务id
     * @return 当天患者经过数
     */
    @Override
    public Integer getAppear(String date, String place, String taskId) {
        return eventMapper.getAppear(date, place, taskId);
    }

    /**
     * 获取历史患者经过数
     * @param date 日期
     * @param place 地点
     * @param taskId 任务id
     * @return 历史患者经过数
     */
    @Override
    public Integer getHistory(String date, String place, String taskId) {
        return eventMapper.getHistory(date, place, taskId);
    }
}
