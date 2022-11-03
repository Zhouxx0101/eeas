package com.ruoyi.eeas.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 疫情演化数据对象 eeas_evolution
 * 
 * @author ruoyi
 * @date 2022-11-03
 */
public class Evolution extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    private Long id;

    /** 预测时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预测时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date predictTime;

    /** 新增数 */
    @Excel(name = "新增数")
    private Long increase;

    /** 确诊数 */
    @Excel(name = "确诊数")
    private Long diagnosis;

    /** 治愈数 */
    @Excel(name = "治愈数")
    private Long cure;

    /** 死亡数 */
    @Excel(name = "死亡数")
    private Long dead;

    /** 密切接触者人数 */
    @Excel(name = "密切接触者人数")
    private Long closeContact;

    /** 医学观察人数 */
    @Excel(name = "医学观察人数")
    private Long medicalObservation;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setPredictTime(Date predictTime) 
    {
        this.predictTime = predictTime;
    }

    public Date getPredictTime() 
    {
        return predictTime;
    }
    public void setIncrease(Long increase) 
    {
        this.increase = increase;
    }

    public Long getIncrease() 
    {
        return increase;
    }
    public void setDiagnosis(Long diagnosis) 
    {
        this.diagnosis = diagnosis;
    }

    public Long getDiagnosis() 
    {
        return diagnosis;
    }
    public void setCure(Long cure) 
    {
        this.cure = cure;
    }

    public Long getCure() 
    {
        return cure;
    }
    public void setDead(Long dead) 
    {
        this.dead = dead;
    }

    public Long getDead() 
    {
        return dead;
    }
    public void setCloseContact(Long closeContact) 
    {
        this.closeContact = closeContact;
    }

    public Long getCloseContact() 
    {
        return closeContact;
    }
    public void setMedicalObservation(Long medicalObservation) 
    {
        this.medicalObservation = medicalObservation;
    }

    public Long getMedicalObservation() 
    {
        return medicalObservation;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("predictTime", getPredictTime())
            .append("increase", getIncrease())
            .append("diagnosis", getDiagnosis())
            .append("cure", getCure())
            .append("dead", getDead())
            .append("closeContact", getCloseContact())
            .append("medicalObservation", getMedicalObservation())
            .toString();
    }
}
