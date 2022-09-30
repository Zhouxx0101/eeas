package com.ruoyi.eeas.mapper;

import java.util.List;
import com.ruoyi.eeas.domain.Event;

/**
 * 事件数据Mapper接口
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
public interface EventMapper
{
    /**
     * 查询事件数据
     *
     * @param id 事件数据主键
     * @return 事件数据
     */
    public Event selectEventById(Long id);

    /**
     * 查询事件数据列表
     *
     * @param event 事件数据
     * @return 事件数据集合
     */
    public List<Event> selectEventList(Event event);

    /**
     * 新增事件数据
     *
     * @param event 事件数据
     * @return 结果
     */
    public int insertEvent(Event event);

    /**
     * 修改事件数据
     *
     * @param event 事件数据
     * @return 结果
     */
    public int updateEvent(Event event);

    /**
     * 删除事件数据
     *
     * @param id 事件数据主键
     * @return 结果
     */
    public int deleteEventById(Long id);

    /**
     * 批量删除事件数据
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEventByIds(Long[] ids);
}
