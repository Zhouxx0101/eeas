package com.ruoyi.eeas.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 事件数据对象 eeas_event
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
public class Event extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 事件id */
    private Long id;

    /** 时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date time;

    /** 场所 */
    @Excel(name = "场所")
    private String place;

    /** 事件，一一枚举 */
    @Excel(name = "事件，一一枚举")
    private Long event;

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
    public void setTime(Date time)
    {
        this.time = time;
    }

    public Date getTime()
    {
        return time;
    }
    public void setPlace(String place)
    {
        this.place = place;
    }

    public String getPlace()
    {
        return place;
    }
    public void setEvent(Long event)
    {
        this.event = event;
    }

    public Long getEvent()
    {
        return event;
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
                .append("time", getTime())
                .append("place", getPlace())
                .append("event", getEvent())
                .append("source", getSource())
                .toString();
    }
}
