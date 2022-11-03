package com.ruoyi.eeas.utils;

import com.alibaba.fastjson2.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class LatitudeUtil {
    private static final Logger logger = LoggerFactory.getLogger(LatitudeUtil.class);
    private static final String BAIDU_APP_KEY = "k051GN3AgOdHPsUWEP6j84tZ9oivwOgz";

    /**
     * 传入中文地址，返回经纬度
     *
     * @return lng(经度), lat(纬度)
     */
    public static Map<String, Object> getLatitude(String address) {
        String res;
        try {
            String url = "http://api.map.baidu.com/geocoding/v3/?address=" + address + "&output=json&ak=" + BAIDU_APP_KEY;
            System.out.println(url);
            URL resJson = new URL(url);
            BufferedReader in = new BufferedReader(new InputStreamReader(resJson.openStream()));
            StringBuilder sb = new StringBuilder();
            while ((res = in.readLine()) != null) {
                sb.append(res.trim());
            }
            in.close();
            String str = sb.toString();
            if (!str.isEmpty()) {
                System.out.println(str);
                Map<String, Object> map = new HashMap<>();
                //字符串转成json格式
                JSONObject jsonObj = JSONObject.parseObject(str);
                //获取经度
                Object lng = jsonObj.getJSONObject("result").getJSONObject("location").get("lng");
                //获取纬度
                Object lat = jsonObj.getJSONObject("result").getJSONObject("location").get("lat");
                map.put("lng", lng);
                map.put("lat", lat);
                //返回经纬度
                return map;
            }
        } catch (Exception e) {
            logger.error("地址解析出现异常！", e);
        }
        return null;
    }

    public static void main(String[] args) {
        Map<String, Object> map = LatitudeUtil.getLatitude("南开大学津南校区");
        if (null != map) {
            System.out.println("经度：" + map.get("lng"));
            System.out.println("纬度：" + map.get("lat"));
        }
    }
}
