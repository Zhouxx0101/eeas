package com.ruoyi.eeas.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.eeas.domain.Trajectory;

/**
 * 轨迹数据Service接口
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public interface ITrajectoryService extends IService<Trajectory>
{
    /**
     * 查询轨迹数据
     * 
     * @param id 轨迹数据主键
     * @return 轨迹数据
     */
    Trajectory selectTrajectoryById(Long id);

    /**
     * 查询轨迹数据列表
     * 
     * @param trajectory 轨迹数据
     * @return 轨迹数据集合
     */
    List<Trajectory> selectTrajectoryList(Trajectory trajectory);

    /**
     * 新增轨迹数据
     * 
     * @param trajectory 轨迹数据
     * @return 结果
     */
    int insertTrajectory(Trajectory trajectory);

    /**
     * 修改轨迹数据
     * 
     * @param trajectory 轨迹数据
     * @return 结果
     */
    int updateTrajectory(Trajectory trajectory);

    /**
     * 批量删除轨迹数据
     * 
     * @param ids 需要删除的轨迹数据主键集合
     * @return 结果
     */
    int deleteTrajectoryByIds(Long[] ids);

    /**
     * 删除轨迹数据信息
     * 
     * @param id 轨迹数据主键
     * @return 结果
     */
    int deleteTrajectoryById(Long id);

    /**
     * 查询近1天的轨迹数据
     *
     * @return 轨迹数据
     */
    List<Map<String, String>> get1();

    /**
     * 查询1天至7天的轨迹数据
     *
     * @return 轨迹数据
     */
    List<Map<String, String>> get1To7();

    /**
     * 查询7天至14天的轨迹数据
     *
     * @return 轨迹数据
     */
    List<Map<String, String>> get7To14();

    /**
     * 查询14天以上的轨迹数据
     *
     * @return 轨迹数据
     */
    List<Map<String, String>> get14();
}
