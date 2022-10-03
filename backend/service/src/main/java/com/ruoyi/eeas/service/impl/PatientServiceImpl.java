package com.ruoyi.eeas.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.eeas.mapper.PatientMapper;
import com.ruoyi.eeas.domain.Patient;
import com.ruoyi.eeas.service.IPatientService;

/**
 * 患者数据Service业务层处理
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
@Service
public class PatientServiceImpl extends ServiceImpl<PatientMapper, Patient> implements IPatientService
{
    @Autowired
    private PatientMapper patientMapper;

    /**
     * 查询患者数据
     *
     * @param id 患者数据主键
     * @return 患者数据
     */
    @Override
    public Patient selectPatientById(Long id)
    {
        return patientMapper.selectPatientById(id);
    }

    /**
     * 查询患者数据列表
     *
     * @param patient 患者数据
     * @return 患者数据
     */
    @Override
    public List<Patient> selectPatientList(Patient patient)
    {
        return patientMapper.selectPatientList(patient);
    }

    /**
     * 新增患者数据
     *
     * @param patient 患者数据
     * @return 结果
     */
    @Override
    public int insertPatient(Patient patient)
    {
        return patientMapper.insert(patient);
    }

    /**
     * 修改患者数据
     *
     * @param patient 患者数据
     * @return 结果
     */
    @Override
    public int updatePatient(Patient patient)
    {
        return patientMapper.updatePatient(patient);
    }

    /**
     * 批量删除患者数据
     *
     * @param ids 需要删除的患者数据主键
     * @return 结果
     */
    @Override
    public int deletePatientByIds(Long[] ids)
    {
        return patientMapper.deletePatientByIds(ids);
    }

    /**
     * 删除患者数据信息
     *
     * @param id 患者数据主键
     * @return 结果
     */
    @Override
    public int deletePatientById(Long id)
    {
        return patientMapper.deletePatientById(id);
    }
}
