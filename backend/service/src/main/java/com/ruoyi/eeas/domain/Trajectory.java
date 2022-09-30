package com.ruoyi.eeas.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 轨迹数据对象 eeas_trajectory
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public class Trajectory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 轨迹id */
    private Long id;

    /** 患者id */
    @Excel(name = "患者id")
    private Long pid;

    /** 起始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "起始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 场所 */
    @Excel(name = "场所")
    private String place;

    /** 经度 */
    @Excel(name = "经度")
    private String longitude;

    /** 纬度 */
    @Excel(name = "纬度")
    private String latitude;

    /** 风险等级 */
    @Excel(name = "风险等级")
    private Long riskLevel;

    /** 原始文本 */
    @Excel(name = "原始文本")
    private String rawText;

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
    public void setPid(Long pid) 
    {
        this.pid = pid;
    }

    public Long getPid() 
    {
        return pid;
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
    public void setPlace(String place) 
    {
        this.place = place;
    }

    public String getPlace() 
    {
        return place;
    }
    public void setLongitude(String longitude) 
    {
        this.longitude = longitude;
    }

    public String getLongitude() 
    {
        return longitude;
    }
    public void setLatitude(String latitude) 
    {
        this.latitude = latitude;
    }

    public String getLatitude() 
    {
        return latitude;
    }
    public void setRiskLevel(Long riskLevel) 
    {
        this.riskLevel = riskLevel;
    }

    public Long getRiskLevel() 
    {
        return riskLevel;
    }
    public void setRawText(String rawText) 
    {
        this.rawText = rawText;
    }

    public String getRawText() 
    {
        return rawText;
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
            .append("pid", getPid())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("place", getPlace())
            .append("longitude", getLongitude())
            .append("latitude", getLatitude())
            .append("riskLevel", getRiskLevel())
            .append("rawText", getRawText())
            .append("source", getSource())
            .toString();
    }
}
