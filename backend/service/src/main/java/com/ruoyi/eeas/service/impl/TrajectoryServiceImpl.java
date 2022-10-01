package com.ruoyi.eeas.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.eeas.mapper.TrajectoryMapper;
import com.ruoyi.eeas.domain.Trajectory;
import com.ruoyi.eeas.service.ITrajectoryService;

/**
 * 轨迹数据Service业务层处理
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
@Service
public class TrajectoryServiceImpl extends ServiceImpl<TrajectoryMapper, Trajectory> implements ITrajectoryService
{
    @Autowired
    private TrajectoryMapper trajectoryMapper;

    /**
     * 查询轨迹数据
     * 
     * @param id 轨迹数据主键
     * @return 轨迹数据
     */
    @Override
    public Trajectory selectTrajectoryById(Long id)
    {
        return trajectoryMapper.selectTrajectoryById(id);
    }

    /**
     * 查询轨迹数据列表
     * 
     * @param trajectory 轨迹数据
     * @return 轨迹数据
     */
    @Override
    public List<Trajectory> selectTrajectoryList(Trajectory trajectory)
    {
        return trajectoryMapper.selectTrajectoryList(trajectory);
    }

    /**
     * 新增轨迹数据
     * 
     * @param trajectory 轨迹数据
     * @return 结果
     */
    @Override
    public int insertTrajectory(Trajectory trajectory)
    {
        return trajectoryMapper.insert(trajectory);
    }

    /**
     * 修改轨迹数据
     * 
     * @param trajectory 轨迹数据
     * @return 结果
     */
    @Override
    public int updateTrajectory(Trajectory trajectory)
    {
        return trajectoryMapper.updateTrajectory(trajectory);
    }

    /**
     * 批量删除轨迹数据
     * 
     * @param ids 需要删除的轨迹数据主键
     * @return 结果
     */
    @Override
    public int deleteTrajectoryByIds(Long[] ids)
    {
        return trajectoryMapper.deleteTrajectoryByIds(ids);
    }

    /**
     * 删除轨迹数据信息
     * 
     * @param id 轨迹数据主键
     * @return 结果
     */
    @Override
    public int deleteTrajectoryById(Long id)
    {
        return trajectoryMapper.deleteTrajectoryById(id);
    }
}
