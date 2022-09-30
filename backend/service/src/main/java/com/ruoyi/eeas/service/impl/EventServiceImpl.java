package com.ruoyi.eeas.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.eeas.mapper.EventMapper;
import com.ruoyi.eeas.domain.Event;
import com.ruoyi.eeas.service.IEventService;

/**
 * 事件数据Service业务层处理
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
@Service
public class EventServiceImpl implements IEventService 
{
    @Autowired
    private EventMapper eventMapper;

    /**
     * 查询事件数据
     * 
     * @param id 事件数据主键
     * @return 事件数据
     */
    @Override
    public Event selectEventById(Long id)
    {
        return eventMapper.selectEventById(id);
    }

    /**
     * 查询事件数据列表
     * 
     * @param event 事件数据
     * @return 事件数据
     */
    @Override
    public List<Event> selectEventList(Event event)
    {
        return eventMapper.selectEventList(event);
    }

    /**
     * 新增事件数据
     * 
     * @param event 事件数据
     * @return 结果
     */
    @Override
    public int insertEvent(Event event)
    {
        return eventMapper.insertEvent(event);
    }

    /**
     * 修改事件数据
     * 
     * @param event 事件数据
     * @return 结果
     */
    @Override
    public int updateEvent(Event event)
    {
        return eventMapper.updateEvent(event);
    }

    /**
     * 批量删除事件数据
     * 
     * @param ids 需要删除的事件数据主键
     * @return 结果
     */
    @Override
    public int deleteEventByIds(Long[] ids)
    {
        return eventMapper.deleteEventByIds(ids);
    }

    /**
     * 删除事件数据信息
     * 
     * @param id 事件数据主键
     * @return 结果
     */
    @Override
    public int deleteEventById(Long id)
    {
        return eventMapper.deleteEventById(id);
    }
}
