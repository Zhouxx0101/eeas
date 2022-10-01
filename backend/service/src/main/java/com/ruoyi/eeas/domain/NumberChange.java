package com.ruoyi.eeas.domain;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 病例变化数据对象 eeas_number_change
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
@TableName("eeas_number_change")
public class NumberChange extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /** 起始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "起始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 新增数 */
    @Excel(name = "新增数")
    private Integer increase;

    /** 确诊数 */
    @Excel(name = "确诊数")
    private Integer diagnosis;

    /** 密切接触者人数 */
    @Excel(name = "密切接触者人数")
    private Integer closeContact;

    /** 正在接受医学观察人数 */
    @Excel(name = "正在接受医学观察人数")
    private Integer medicalObservation;

    /** 来源 */
    @Excel(name = "来源")
    private Long source;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setStartTime(Date startTime) 
    {
        this.startTime = startTime;
    }

    public Date getStartTime() 
    {
        return startTime;
    }
    public void setEndTime(Date endTime) 
    {
        this.endTime = endTime;
    }

    public Date getEndTime() 
    {
        return endTime;
    }
    public void setIncrease(Integer increase)
    {
        this.increase = increase;
    }

    public Integer getIncrease()
    {
        return increase;
    }
    public void setDiagnosis(Integer diagnosis)
    {
        this.diagnosis = diagnosis;
    }

    public Integer getDiagnosis()
    {
        return diagnosis;
    }
    public void setCloseContact(Integer closeContact)
    {
        this.closeContact = closeContact;
    }

    public Integer getCloseContact()
    {
        return closeContact;
    }
    public void setMedicalObservation(Integer medicalObservation)
    {
        this.medicalObservation = medicalObservation;
    }

    public Integer getMedicalObservation()
    {
        return medicalObservation;
    }
    public void setSource(Long source) 
    {
        this.source = source;
    }

    public Long getSource() 
    {
        return source;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("increase", getIncrease())
            .append("diagnosis", getDiagnosis())
            .append("closeContact", getCloseContact())
            .append("medicalObservation", getMedicalObservation())
            .append("source", getSource())
            .toString();
    }
}
