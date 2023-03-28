package com.ruoyi.eeas.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.eeas.mapper.TaskMapper;
import com.ruoyi.eeas.domain.Task;
import com.ruoyi.eeas.service.ITaskService;

/**
 * 任务Service业务层处理
 * 
 * @author zhouxinxing
 * @date 2023-03-26
 */
@Service
public class TaskServiceImpl implements ITaskService 
{
    @Autowired
    private TaskMapper taskMapper;

    /**
     * 查询任务
     * 
     * @param id 任务主键
     * @return 任务
     */
    @Override
    public Task selectTaskById(Long id)
    {
        return taskMapper.selectTaskById(id);
    }

    /**
     * 查询任务列表
     * 
     * @param task 任务
     * @return 任务
     */
    @Override
    public List<Task> selectTaskList(Task task)
    {
        return taskMapper.selectTaskList(task);
    }

    /**
     * 新增任务
     * 
     * @param task 任务
     * @return 结果
     */
    @Override
    public int insertTask(Task task)
    {
        return taskMapper.insertTask(task);
    }

    /**
     * 修改任务
     * 
     * @param task 任务
     * @return 结果
     */
    @Override
    public int updateTask(Task task)
    {
        return taskMapper.updateTask(task);
    }

    /**
     * 批量删除任务
     * 
     * @param ids 需要删除的任务主键
     * @return 结果
     */
    @Override
    public int deleteTaskByIds(Long[] ids)
    {
        return taskMapper.deleteTaskByIds(ids);
    }

    /**
     * 删除任务信息
     * 
     * @param id 任务主键
     * @return 结果
     */
    @Override
    public int deleteTaskById(Long id)
    {
        return taskMapper.deleteTaskById(id);
    }
}
