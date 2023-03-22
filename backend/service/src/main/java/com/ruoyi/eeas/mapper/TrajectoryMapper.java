package com.ruoyi.eeas.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.eeas.domain.Trajectory;

/**
 * 轨迹数据Mapper接口
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public interface TrajectoryMapper extends BaseMapper<Trajectory>
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
     * 删除轨迹数据
     * 
     * @param id 轨迹数据主键
     * @return 结果
     */
    int deleteTrajectoryById(Long id);

    /**
     * 批量删除轨迹数据
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    int deleteTrajectoryByIds(Long[] ids);

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

    /**
     * 根据日期查询轨迹数据
     *
     * @return 轨迹数据
     */
    List<Map<String, String>> getByDate(String date);

    /**
     * 根据日期查询地点数据
     *
     * @return 轨迹数据
     */
    List<String> getPlacesByDate(String date);
}
