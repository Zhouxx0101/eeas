package com.ruoyi.eeas.service.impl;

import com.ruoyi.eeas.mapper.PlaceMapper;
import com.ruoyi.eeas.service.IPlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 地点Service业务层处理
 *
 * @author smj
 * @date 2023-07-30
 */
@Service
public class PlaceServiceImpl implements IPlaceService {
    @Autowired
    private PlaceMapper placeMapper;

    /**
     * 查询所有地点
     *
     * @return 注意力分数
     */
    @Override
    public List<String> listPlace() {

        return placeMapper.listPlace();
    }

    @Override
    public List<String> getPlacesWithIDs(List<Integer> ids){
        List<String> re=new ArrayList<String>();
        for(int i=0;i<ids.size();i++){
            re.add(placeMapper.getPlacesWithID(ids.get(i)));
        }
        return re;
    }
}
