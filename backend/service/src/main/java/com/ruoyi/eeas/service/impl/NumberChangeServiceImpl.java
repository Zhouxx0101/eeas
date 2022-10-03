package com.ruoyi.eeas.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.eeas.mapper.NumberChangeMapper;
import com.ruoyi.eeas.domain.NumberChange;
import com.ruoyi.eeas.service.INumberChangeService;

/**
 * 病例变化数据Service业务层处理
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
@Service
public class NumberChangeServiceImpl extends ServiceImpl<NumberChangeMapper, NumberChange> implements INumberChangeService
{
    @Autowired
    private NumberChangeMapper numberChangeMapper;

    /**
     * 查询病例变化数据
     * 
     * @param id 病例变化数据主键
     * @return 病例变化数据
     */
    @Override
    public NumberChange selectNumberChangeById(Long id)
    {
        return numberChangeMapper.selectNumberChangeById(id);
    }

    /**
     * 查询病例变化数据列表
     * 
     * @param numberChange 病例变化数据
     * @return 病例变化数据
     */
    @Override
    public List<NumberChange> selectNumberChangeList(NumberChange numberChange)
    {
        return numberChangeMapper.selectNumberChangeList(numberChange);
    }

    /**
     * 新增病例变化数据
     * 
     * @param numberChange 病例变化数据
     * @return 结果
     */
    @Override
    public int insertNumberChange(NumberChange numberChange)
    {
        return numberChangeMapper.insert(numberChange);
    }

    /**
     * 修改病例变化数据
     * 
     * @param numberChange 病例变化数据
     * @return 结果
     */
    @Override
    public int updateNumberChange(NumberChange numberChange)
    {
        return numberChangeMapper.updateNumberChange(numberChange);
    }

    /**
     * 批量删除病例变化数据
     * 
     * @param ids 需要删除的病例变化数据主键
     * @return 结果
     */
    @Override
    public int deleteNumberChangeByIds(Long[] ids)
    {
        return numberChangeMapper.deleteNumberChangeByIds(ids);
    }

    /**
     * 删除病例变化数据信息
     * 
     * @param id 病例变化数据主键
     * @return 结果
     */
    @Override
    public int deleteNumberChangeById(Long id)
    {
        return numberChangeMapper.deleteNumberChangeById(id);
    }
}
