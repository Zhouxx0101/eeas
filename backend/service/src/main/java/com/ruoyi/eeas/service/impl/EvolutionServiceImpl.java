package com.ruoyi.eeas.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.eeas.mapper.EvolutionMapper;
import com.ruoyi.eeas.domain.Evolution;
import com.ruoyi.eeas.service.IEvolutionService;

/**
 * 疫情演化数据Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-11-03
 */
@Service
public class EvolutionServiceImpl implements IEvolutionService 
{
    @Autowired
    private EvolutionMapper evolutionMapper;

    /**
     * 查询疫情演化数据
     * 
     * @param id 疫情演化数据主键
     * @return 疫情演化数据
     */
    @Override
    public Evolution selectEvolutionById(Long id)
    {
        return evolutionMapper.selectEvolutionById(id);
    }

    /**
     * 查询疫情演化数据列表
     * 
     * @param evolution 疫情演化数据
     * @return 疫情演化数据
     */
    @Override
    public List<Evolution> selectEvolutionList(Evolution evolution)
    {
        return evolutionMapper.selectEvolutionList(evolution);
    }

}
