package com.ruoyi.eeas.service;

import java.util.List;
import com.ruoyi.eeas.domain.Patient;

/**
 * 患者数据Service接口
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public interface IPatientService 
{
    /**
     * 查询患者数据
     * 
     * @param id 患者数据主键
     * @return 患者数据
     */
    public Patient selectPatientById(Long id);

    /**
     * 查询患者数据列表
     * 
     * @param patient 患者数据
     * @return 患者数据集合
     */
    public List<Patient> selectPatientList(Patient patient);

    /**
     * 新增患者数据
     * 
     * @param patient 患者数据
     * @return 结果
     */
    public int insertPatient(Patient patient);

    /**
     * 修改患者数据
     * 
     * @param patient 患者数据
     * @return 结果
     */
    public int updatePatient(Patient patient);

    /**
     * 批量删除患者数据
     * 
     * @param ids 需要删除的患者数据主键集合
     * @return 结果
     */
    public int deletePatientByIds(Long[] ids);

    /**
     * 删除患者数据信息
     * 
     * @param id 患者数据主键
     * @return 结果
     */
    public int deletePatientById(Long id);
}
