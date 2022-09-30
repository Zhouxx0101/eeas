package com.ruoyi.eeas.mapper;

import java.util.List;
import com.ruoyi.eeas.domain.Trajectory;

/**
 * 轨迹数据Mapper接口
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public interface TrajectoryMapper 
{
    /**
     * 查询轨迹数据
     * 
     * @param id 轨迹数据主键
     * @return 轨迹数据
     */
    public Trajectory selectTrajectoryById(Long id);

    /**
     * 查询轨迹数据列表
     * 
     * @param trajectory 轨迹数据
     * @return 轨迹数据集合
     */
    public List<Trajectory> selectTrajectoryList(Trajectory trajectory);

    /**
     * 新增轨迹数据
     * 
     * @param trajectory 轨迹数据
     * @return 结果
     */
    public int insertTrajectory(Trajectory trajectory);

    /**
     * 修改轨迹数据
     * 
     * @param trajectory 轨迹数据
     * @return 结果
     */
    public int updateTrajectory(Trajectory trajectory);

    /**
     * 删除轨迹数据
     * 
     * @param id 轨迹数据主键
     * @return 结果
     */
    public int deleteTrajectoryById(Long id);

    /**
     * 批量删除轨迹数据
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTrajectoryByIds(Long[] ids);
}
