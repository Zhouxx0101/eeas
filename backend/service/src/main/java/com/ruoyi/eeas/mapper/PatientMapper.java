package com.ruoyi.eeas.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.eeas.domain.Patient;

/**
 * 患者数据Mapper接口
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
public interface PatientMapper extends BaseMapper<Patient>
{
    /**
     * 查询患者数据
     *
     * @param id 患者数据主键
     * @return 患者数据
     */
    Patient selectPatientById(Long id);

    /**
     * 查询患者数据列表
     *
     * @param patient 患者数据
     * @return 患者数据集合
     */
    List<Patient> selectPatientList(Patient patient);

    /**
     * 新增患者数据
     *
     * @param patient 患者数据
     * @return 结果
     */
    int insertPatient(Patient patient);

    /**
     * 修改患者数据
     *
     * @param patient 患者数据
     * @return 结果
     */
    int updatePatient(Patient patient);

    /**
     * 删除患者数据
     *
     * @param id 患者数据主键
     * @return 结果
     */
    int deletePatientById(Long id);

    /**
     * 批量删除患者数据
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    int deletePatientByIds(Long[] ids);
}
