package com.ruoyi.eeas.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.eeas.domain.Event;
import io.lettuce.core.dynamic.annotation.Param;

import java.util.List;

/**
 * 事件数据Mapper接口
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
public interface EventMapper extends BaseMapper<Event> {
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
     * @param time_ 目标时间段
     * @return 风险区域集合
     */
    List<String> selectAreaList(String time_);

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
     * 删除事件数据
     *
     * @param id 事件数据主键
     * @return 结果
     */
    int deleteEventById(Long id);

    /**
     * 批量删除事件数据
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    int deleteEventByIds(Long[] ids);
}
