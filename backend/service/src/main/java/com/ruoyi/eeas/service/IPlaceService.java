package com.ruoyi.eeas.service;

import java.util.List;
import java.util.Map;

/**
 * 地点数据Service接口
 *
 * @author smj
 *  * @date 2023-07-30
 */
public interface IPlaceService
{
    /**
     * 查询所有地点
     * @return 注意力分数
     */
    List<String> listPlace();

    List<String> getPlacesWithIDs(List<Integer> ids);
}
