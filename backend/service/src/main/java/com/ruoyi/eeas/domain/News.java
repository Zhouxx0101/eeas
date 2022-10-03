package com.ruoyi.eeas.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 新闻数据对象 eeas_news
 *
 * @author zhouxinxing
 * @date 2022-09-30
 */
@TableName("eeas_news")
public class News extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 新闻id */
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    /** 新闻类型：1、区域时空行为新闻 2、患者个人信息新闻 3、患者时空行为新闻 4、区域病例数据新闻 5、其他 */
    @Excel(name = "新闻类型：1、区域时空行为新闻 2、患者个人信息新闻 3、患者时空行为新闻 4、区域病例数据新闻 5、其他")
    private Integer type;

    /** 新闻标题 */
    @Excel(name = "新闻标题")
    private String title;

    /** 新闻链接 */
    @Excel(name = "新闻链接")
    private String link;

    /** 新闻全文 */
    @Excel(name = "新闻全文")
    private String content;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setType(Integer type)
    {
        this.type = type;
    }

    public Integer getType()
    {
        return type;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getTitle()
    {
        return title;
    }
    public void setLink(String link)
    {
        this.link = link;
    }

    public String getLink()
    {
        return link;
    }
    public void setContent(String content)
    {
        this.content = content;
    }

    public String getContent()
    {
        return content;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("type", getType())
                .append("title", getTitle())
                .append("link", getLink())
                .append("content", getContent())
                .toString();
    }
}
