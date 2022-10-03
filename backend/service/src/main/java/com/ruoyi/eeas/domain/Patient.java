package com.ruoyi.eeas.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 患者数据对象 eeas_patient
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
@TableName("eeas_patient")
public class Patient extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 患者id */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /** 性别，0、男 1、女 2、其他 */
    @Excel(name = "性别，0、男 1、女 2、其他")
    private Integer sex;

    /** 年龄 */
    @Excel(name = "年龄")
    private Integer age;

    /** 职业 */
    @Excel(name = "职业")
    private String occupation;

    /** 家庭住址 */
    @Excel(name = "家庭住址")
    private String address;

    /** 分型，0、无症状感染者 1、轻型 2、普通型 3、重型 */
    @Excel(name = "分型，0、无症状感染者 1、轻型 2、普通型 3、重型")
    private Integer type;

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
    public void setSex(Integer sex)
    {
        this.sex = sex;
    }

    public Integer getSex()
    {
        return sex;
    }
    public void setAge(Integer age)
    {
        this.age = age;
    }

    public Integer getAge()
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
    public void setType(Integer type)
    {
        this.type = type;
    }

    public Integer getType()
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
