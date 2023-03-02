<template>
  <div class="BaiDuMap">
  <!-- <div class="app-container"> -->
    <baidu-map
      :center="center"
      :zoom="zoom"
      :scroll-wheel-zoom="true"
      style="width: 100%; height: 100%"
      @ready="handler"
      @click="getClickInfo"
      @moving="syncCenterAndZoom"
      @moveend="syncCenterAndZoom"
      @zoomend="syncCenterAndZoom"
    >
      <!-- 必须给容器指高度，不然地图将显示在一个高度为0的容器中，看不到 -->
      <bm-navigation anchor="BMAP_ANCHOR_TOP_RIGHT"></bm-navigation>
      <bm-geolocation
        anchor="BMAP_ANCHOR_BOTTOM_RIGHT"
        :showAddressBar="true"
        :autoLocation="true"
      ></bm-geolocation>
      <bm-city-list anchor="BMAP_ANCHOR_TOP_LEFT"></bm-city-list>
      <bm-marker :position="{lng: 116.404, lat: 39.915}" :dragging="false" animation="BMAP_ANIMATION_BOUNCE">
      </bm-marker>
      <!-- 绘制点1 -->
      <!-- <bm-marker :position="{lng: 116.404, lat: 39.915}" :dragging="true" animation="BMAP_ANIMATION_BOUNCE">
        <bm-label content="我爱北京天安门" :labelStyle="{color: 'red', fontSize : '24px'}" :offset="{width: -35, height: 30}"/>
      </bm-marker> -->
      <!-- 绘制点2 -->
      <!-- <bm-marker :position="{lng: 116.404, lat: 39.925}" :dragging="true" animation="BMAP_ANIMATION_BOUNCE" :icon="{url: 'http://developer.baidu.com/map/jsdemo/img/fox.gif', size: {width: 300, height: 157}}"></bm-marker> -->
      <!-- 绘制点3 -->
      <!-- <bm-marker :position="{lng: 116.404, lat: 39.935}" :dragging="true" @click="infoWindowOpen">
        <bm-info-window :show="show" @close="infoWindowClose" @open="infoWindowOpen">我爱北京天安门</bm-info-window>
      </bm-marker> -->
      <!-- 绘制点4 - failed -->
      <!-- 推测：只能通过经纬度来进行点标注？ -->
      <!-- <bm-marker :position="故宫" :dragging="true" @click="infoWindowOpen">
        <bm-info-window :show="show" @close="infoWindowClose" @open="infoWindowOpen">test1</bm-info-window>
      </bm-marker> -->
    </baidu-map>
  </div>
</template>
<script>

import { get1, get1To7, get7To14, get14 } from "@/api/data/trajectory";

export default {
  data() {
    return {
      // 地址信息
      address: null,
      // center通过经纬度或城市名均可?
      center: { lng: 0, lat: 0 },
      // center: "北京",
      //地图展示级别
      zoom: 11,
      show: false,
      point: null,
      place1: ["中辛庄公交站", "高庄子小学"],
    };
  },
  methods: {
    handler({ BMap, map }) {
      this.center.lng = 116.404;
      this.center.lat = 39.915;
      this.zoom = this.zoom;
    },
    getClickInfo(e) {
      // 创建地理编码实例
      const myGeo = new BMap.Geocoder();
      // 根据坐标逆解析地址
      myGeo.getLocation(new BMap.Point(e.point.lng, e.point.lat), (result) => {
        console.log(result, "result-->>>>");
        if (result) {
          this.address = result.address;
        }
      });
      this.center.lng = e.point.lng;
      this.center.lat = e.point.lat;
    },
    syncCenterAndZoom(e) {
      console.log(e.target, 'e.target-->>>>')
      const { lng, lat } = e.target.getCenter();
      this.zoom = e.target.getZoom();
    },
    infoWindowClose () {
      this.show = false
    },
    infoWindowOpen () {
      this.show = true
    },
  },
};
</script>
<style scoped>
.BaiDuMap {
  width: 100%;
  height: 781px;
}
</style>