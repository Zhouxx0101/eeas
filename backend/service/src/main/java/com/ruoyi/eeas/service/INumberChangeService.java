package com.ruoyi.eeas.service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.eeas.domain.NumberChange;

/**
 * 病例变化数据Service接口
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public interface INumberChangeService extends IService<NumberChange>
{
    /**
     * 查询病例变化数据
     * 
     * @param id 病例变化数据主键
     * @return 病例变化数据
     */
    NumberChange selectNumberChangeById(Long id);

    /**
     * 查询病例变化数据列表
     * 
     * @param numberChange 病例变化数据
     * @return 病例变化数据集合
     */
    List<NumberChange> selectNumberChangeList(NumberChange numberChange);

    /**
     * 新增病例变化数据
     * 
     * @param numberChange 病例变化数据
     * @return 结果
     */
    int insertNumberChange(NumberChange numberChange);

    /**
     * 修改病例变化数据
     * 
     * @param numberChange 病例变化数据
     * @return 结果
     */
    int updateNumberChange(NumberChange numberChange);

    /**
     * 批量删除病例变化数据
     * 
     * @param ids 需要删除的病例变化数据主键集合
     * @return 结果
     */
    int deleteNumberChangeByIds(Long[] ids);

    /**
     * 删除病例变化数据信息
     * 
     * @param id 病例变化数据主键
     * @return 结果
     */
    int deleteNumberChangeById(Long id);

    /**
     * 查询每日新增数
     *
     * @return 结果
     */
    List<Map<Object, Object>> getIncrease();

    /**
     * 查询每日确诊数
     *
     * @return 结果
     */
    List<Map<Object, Object>> getDiagnosis();

    /**
     * 查询每日密切接触者人数
     *
     * @return 结果
     */
    List<Map<Object, Object>> getCloseContact();

    /**
     * 查询每日正在接受医学观察人数
     *
     * @return 结果
     */
    List<Map<Object, Object>> getMedicalObservation();

    /**
     * 查询每日新增和确诊数
     *
     * @return 结果
     */
    List<Map<Object, Object>> getIncreaseAndDiagnosis();

    /**
     * 查询每日密切接触者人数和正在接受医学观察人数
     *
     * @return 结果
     */
    List<Map<Object, Object>> getCloseContactAndMedicalObservation();
}
