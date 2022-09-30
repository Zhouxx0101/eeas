package com.ruoyi.eeas.service;

import java.util.List;
import com.ruoyi.eeas.domain.NumberChange;

/**
 * 病例变化数据Service接口
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public interface INumberChangeService 
{
    /**
     * 查询病例变化数据
     * 
     * @param id 病例变化数据主键
     * @return 病例变化数据
     */
    public NumberChange selectNumberChangeById(Long id);

    /**
     * 查询病例变化数据列表
     * 
     * @param numberChange 病例变化数据
     * @return 病例变化数据集合
     */
    public List<NumberChange> selectNumberChangeList(NumberChange numberChange);

    /**
     * 新增病例变化数据
     * 
     * @param numberChange 病例变化数据
     * @return 结果
     */
    public int insertNumberChange(NumberChange numberChange);

    /**
     * 修改病例变化数据
     * 
     * @param numberChange 病例变化数据
     * @return 结果
     */
    public int updateNumberChange(NumberChange numberChange);

    /**
     * 批量删除病例变化数据
     * 
     * @param ids 需要删除的病例变化数据主键集合
     * @return 结果
     */
    public int deleteNumberChangeByIds(Long[] ids);

    /**
     * 删除病例变化数据信息
     * 
     * @param id 病例变化数据主键
     * @return 结果
     */
    public int deleteNumberChangeById(Long id);
}
