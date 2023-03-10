package com.ruoyi.eeas.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.eeas.domain.Event;
import com.ruoyi.eeas.mapper.EventMapper;
import com.ruoyi.eeas.service.IEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
