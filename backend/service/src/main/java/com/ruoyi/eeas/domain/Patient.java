package com.ruoyi.eeas.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 患者数据对象 eeas_patient
 * 
 * @author zhouxinxing
 * @date 2022-09-29
 */
public class Patient extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 患者id */
    private Long id;

    /** 性别，1、男 2、女 3、其他 */
    @Excel(name = "性别，1、男 2、女 3、其他")
    private Long sex;

    /** 年龄 */
    @Excel(name = "年龄")
    private Long age;

    /** 职业 */
    @Excel(name = "职业")
    private String occupation;

    /** 家庭住址 */
    @Excel(name = "家庭住址")
    private String address;

    /** 分型，1、无症状感染者 2、轻型 3、普通型 4、重型 */
    @Excel(name = "分型，1、无症状感染者 2、轻型 3、普通型 4、重型")
    private Long type;

    /** 来源1 */
    @Excel(name = "来源1")
    private Long source1;

    /** 来源2 */
    @Excel(name = "来源2")
    private Long source2;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setSex(Long sex) 
    {
        this.sex = sex;
    }

    public Long getSex() 
    {
        return sex;
    }
    public void setAge(Long age) 
    {
        this.age = age;
    }

    public Long getAge() 
    {
        return age;
    }
    public void setOccupation(String occupation) 
    {
        this.occupation = occupation;
    }

    public String getOccupation() 
    {
        return occupation;
    }
    public void setAddress(String address) 
    {
        this.address = address;
    }

    public String getAddress() 
    {
        return address;
    }
    public void setType(Long type) 
    {
        this.type = type;
    }

    public Long getType() 
    {
        return type;
    }
    public void setSource1(Long source1) 
    {
        this.source1 = source1;
    }

    public Long getSource1() 
    {
        return source1;
    }
    public void setSource2(Long source2) 
    {
        this.source2 = source2;
    }

    public Long getSource2() 
    {
        return source2;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("sex", getSex())
            .append("age", getAge())
            .append("occupation", getOccupation())
            .append("address", getAddress())
            .append("type", getType())
            .append("source1", getSource1())
            .append("source2", getSource2())
            .toString();
    }
}
