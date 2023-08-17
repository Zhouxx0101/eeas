package com.ruoyi.eeas.mapper;


import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 注意力分数数据Mapper接口
 *
 * @author smj
 * @date 2023-07-30
 */
public interface PlaceMapper {
    /**
     * 查询所有地点
     *
     *
     * @return 地点列表
     */
    public List<String> listPlace();

    public String getPlacesWithID(Integer id);
}
