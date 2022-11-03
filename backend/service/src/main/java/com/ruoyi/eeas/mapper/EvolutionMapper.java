package com.ruoyi.eeas.mapper;

import java.util.List;
import com.ruoyi.eeas.domain.Evolution;

/**
 * 疫情演化数据Mapper接口
 * 
 * @author ruoyi
 * @date 2022-11-03
 */
public interface EvolutionMapper 
{
    /**
     * 查询疫情演化数据
     * 
     * @param id 疫情演化数据主键
     * @return 疫情演化数据
     */
    public Evolution selectEvolutionById(Long id);

    /**
     * 查询疫情演化数据列表
     * 
     * @param evolution 疫情演化数据
     * @return 疫情演化数据集合
     */
    public List<Evolution> selectEvolutionList(Evolution evolution);


}
