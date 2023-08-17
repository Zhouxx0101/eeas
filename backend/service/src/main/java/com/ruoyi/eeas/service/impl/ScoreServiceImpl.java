package com.ruoyi.eeas.service.impl;

import com.ruoyi.eeas.mapper.EventSealedPredictionMapper;
import com.ruoyi.eeas.mapper.ScoreMapper;
import com.ruoyi.eeas.service.IEventSealedPredictionService;
import com.ruoyi.eeas.service.IScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 注意力分数数据Service业务层处理
 *
 * @author zhouxinxing
 * @date 2023-04-14
 */
@Service
public class ScoreServiceImpl implements IScoreService {
    @Autowired
    private ScoreMapper scoreMapper;

    /**
     * 查询注意力分数
     *
     * @param date 日期
     * @param taskId 任务id
     * @return 注意力分数
     */
    @Override
    public List<Map<String, Object>> listScore(String date, Integer taskId) {
        return scoreMapper.listScore(date, taskId);
    }

    @Override
    public String getHeatmapDataOfCertainPlace(String date, Integer taskId,String place,String table) {
        System.out.println("date = " + date + ", taskId = " + taskId + ", place = " + place + ", table = " + table);
        switch (table){
            case "1":
                return scoreMapper.getHeatmapDataOfCertainPlace1(date, taskId,place);
            case "2":
                System.out.println("date = " + date + ", taskId = " + taskId + ", place = " + place + ", table = " + table);
                return scoreMapper.getHeatmapDataOfCertainPlace2(date,taskId,place);
            case "3":
                return scoreMapper.getHeatmapDataOfCertainPlace3(date, taskId,place);
            case "4":
                return scoreMapper.getHeatmapDataOfCertainPlace4(date,taskId,place);
            default: return scoreMapper.getHeatmapDataOfCertainPlace1(date, taskId,place);

        }

    }
}
