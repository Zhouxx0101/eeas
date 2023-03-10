<template>

 <div>
    <el-row >
      <el-col >
    <div class="BaiDuMap">
    <!-- <div class="app-container"> -->
      <!--添加近几天的提示，与前端显示对应-->

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

      <!--自定义控件-->
      <!--
      <bm-control>
      <button >缩放至最大</button>
      <button >还原</button>
      <button >缩放至最小</button>
    </bm-control>
    -->
        <!-- 必须给容器指高度，不然地图将显示在一个高度为0的容器中，看不到 -->
        <!--bm-navigation表示缩放控件 anchor为停靠位置-->
        <bm-navigation anchor="BMAP_ANCHOR_TOP_RIGHT"></bm-navigation>
        <!--bm-geolocation表示地图定位控件 autoLocation表示用户点击控件时是否显示定位，需要获得用户的许可-->
        <!--
        <bm-geolocation
          anchor="BMAP_ANCHOR_BOTTOM_RIGHT"
          :showAddressBar="true"
          :autoLocation="true"
        ></bm-geolocation>
        -->
        <!--bm-city-list 城市选择控件-->
        <bm-city-list anchor="BMAP_ANCHOR_TOP_LEFT"></bm-city-list>

        <!--海量点绘制-->
        <!--近一天-->
        <bm-point-collection :points="points1" shape="BMAP_POINT_SHAPE_STAR" color="red" size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection>
        <!--小于等于7天-->
        <bm-point-collection :points="points2" shape="BMAP_POINT_SHAPE_STAR" color="purple" size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection>
        <!--小于等于14天-->
        <bm-point-collection :points="points3" shape="BMAP_POINT_SHAPE_STAR" color="green" size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection>
        <!--大于14天-->
        <bm-point-collection :points="points4" shape="BMAP_POINT_SHAPE_STAR" color="brown" size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection>
        <!--
        
        <bm-marker :position="{lng: 116.404, lat: 39.915}" :dragging="true" animation="BMAP_ANIMATION_BOUNCE">
          <bm-label content="我爱北京天安门" :labelStyle="{color: 'red', fontSize : '24px'}" :offset="{width: -35, height: 30}"/>
        </bm-marker>
      
        <bm-marker :position="{lng: 116.404, lat: 39.925}" :dragging="true" animation="BMAP_ANIMATION_BOUNCE" :icon="{url: 'http://developer.baidu.com/map/jsdemo/img/fox.gif', size: {width: 300, height: 157}}"></bm-marker>
        
        <bm-marker :position="{lng: 116.404, lat: 39.935}" :dragging="true" @click="infoWindowOpen">
          <bm-info-window :show="show" @close="infoWindowClose" @open="infoWindowOpen">我爱北京天安门</bm-info-window>
        </bm-marker>
        -->
    
        <!-- 绘制点4 - failed -->
        <!-- 推测：只能通过经纬度来进行点标注？ -->
        <!-- <bm-marker :position="故宫" :dragging="true" @click="infoWindowOpen">
          <bm-info-window :show="show" @close="infoWindowClose" @open="infoWindowOpen">test1</bm-info-window>
        </bm-marker> -->
      </baidu-map>
    </div>
  </el-col>
  </el-row>
  <div id="container"></div>
  <el-row :gutter="100">
    <el-col :span="100"><div class="circle1"></div><div>一日内</div></el-col>
    <el-col :span="100"><div class="circle2"></div><div>一日到七日</div></el-col>
    <el-col :span="100"><div class="circle3"></div><div>七日到十四日</div></el-col>
    <el-col :span="100"><div class="circle4"></div><div>十四日以上</div></el-col>
</el-row>
</div>
</template>
<script >
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

      points:[],

     // 1日内轨迹数据
      points1:[],
      // 1日至7日轨迹数据
      points2:[],
       // 7日至14日轨迹数据
      points3:[],
      // 14日以上轨迹数据
      points4:[],
      
      place1: ["中辛庄公交站", "高庄子小学"],

    };
  },
  methods: {
    handler({ BMap, map }) {
      // this.center.lng = 116.404;
      // this.center.lat = 39.915;
      this.center.lng = 117.35267834853804;
      this.center.lat = 38.99494446989348;
      this.zoom = this.zoom;

      // 海量点绘制点集合初始化
      //this.addPoints(this.points1)
      //this.addPoints(this.points2)
      //this.addPoints(this.points3)
      //this.addPoints(this.points4)

      // 从后端取数据
      // TODO:将串行执行的方法改为并行执行
      this.getPoints()

      // 添加地图图例
      // 方式一：添加自定义控件
      // TODO:在控件上添加图标
      //this.addPic(map)
      // 方式二：添加图片
     // this.addPic2(map)
     // 方式三：添加自定义控件但是在控件上添加图片，但是该种方式运行会出错
     //this.addPic3(map,"<div style='font-size:12px; color:gray; width:140px; padding:5px; background:white; text-align:center; border:solid 1px gray;'>总部：<img src='head.png' style='width:16px; vertical-align:middle;' />&nbsp;&nbsp;设备：<img src='machine.png'  style='width:16px; vertical-align:middle;' /></div>")
    },
    addPoints (p) {
      for (var i = 0; i < 100; i++) {
        const position = {lng: Math.random() * 40 + 85, lat: Math.random() * 30 + 21}
        p.push(position)
      }
      
    },
    async getPoints(){
      // console.log("getPoints called")
      await get1().then(response => {
        console.log("get1 called")
        console.log(response)
        if (response.code===200){
          console.log("1")
          for (let i = 0; i < response.data.length; i++) {
            const position = {lng: response.data[i].longitude, lat: response.data[i].latitude}
            this.points1.push(position)
              }
            } 
            });
      await get1To7().then(response => {
        console.log("get1To7 called")
        console.log(response)
        if (response.code===200){
            // console.log("2")
            for (let i = 0; i < response.data.length; i++) {
              const position = {lng: response.data[i].longitude, lat: response.data[i].latitude}
              this.points2.push(position)
              }
            } 
            });
         
      await get7To14().then(response => {
        console.log("get7To4 called")
        console.log(response)
        if (response.code===200){
          // console.log("1")
          for (let i = 0; i < response.data.length; i++) {
            const position = {lng: response.data[i].longitude, lat: response.data[i].latitude}
            this.points3.push(position)
              }
            } 
            });            
      await get14().then(response => {
        console.log("get14 called")
        console.log(response)
        if (response.code===200){
            // console.log("1")
            for (let i = 0; i < response.data.length; i++) {
              const position = {lng: response.data[i].longitude, lat: response.data[i].latitude}
              this.points4.push(position)
              }
            } 
            });            
                
    },
    addPic(map){
      console.log("addPic called")
      //var map = new BMapGL.Map('container');
      //console.log("map:"+map)
      var point = new BMap.Point(this.center.lng, this.center.lat);
      //map.centerAndZoom(new BMapGL.Point(116.404, 39.915), 11);
      map.centerAndZoom(point, this.zoom);

        //定义一个控件类
        function ZoomControl() {
            this.defaultAnchor = BMAP_ANCHOR_BOTTOM_RIGHT;
           this.defaultOffset = new BMap.Size(20, 20)
        }
        //通过JavaScript的prototype属性继承于BMap.Control
        ZoomControl.prototype = new BMap.Control();

        //自定义控件必须实现自己的initialize方法，并且将控件的DOM元素返回
        //在本方法中创建个div元素作为控件的容器，并将其添加到地图容器中
        ZoomControl.prototype.initialize = function(map) {
             //创建一个dom元素
            var div = document.createElement('div');
             //添加文字说明
            //var le = $(html)[0];
            //map.getContainer().appendChild(le);
            div.appendChild(document.createTextNode('放大2级'));
           // div.appendChild(le)
              // 设置样式
            div.style.cursor = "pointer";
            div.style.padding = "7px 10px";
            div.style.boxShadow = "0 2px 6px 0 rgba(27, 142, 236, 0.5)";
            div.style.borderRadius = "5px";
            div.style.backgroundColor = "white";
            // 添加DOM元素到地图中
            map.getContainer().appendChild(div);
            // 将DOM元素返回
            return div;
        }
        //创建控件元素
        var myZoomCtrl = new ZoomControl();
        //添加到地图中
        map.addControl(myZoomCtrl);

    },
    addPic2(map){
      //自定义图标
      var icon = new BMap.Icon('./example.png', new BMap.Size(32, 32));
      var points = new BMap.Point(120.092508,30.236078);//创建坐标点
      var markers = new BMap.Marker(points);
      markers.setIcon(icon);
      map.addOverlay(markers);

    },
    addPic3(map,html){
      var LegendControl = function () {
            this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
            this.defaultOffset = new BMap.Size(10, 10);
        }

        LegendControl.prototype = new BMap.Control();
        LegendControl.prototype.initialize = function (map) {
            var le = $(html)[0];
            map.getContainer().appendChild(le);
            return le;
        };

        var legendCtrl = new LegendControl();
        map.addControl(legendCtrl);
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
      // console.log(e.target, 'e.target-->>>>')
      const { lng, lat } = e.target.getCenter();
      this.zoom = e.target.getZoom();
    },
    infoWindowClose () {
      this.show = false
    },
    infoWindowOpen () {
      this.show = true
    },
    // 海量点绘制出来后，单击某点所触发的事件
    clickHandler (e) {
      alert(`单击点的坐标为：${e.point.lng}, ${e.point.lat}`);
    },
  },
};

</script>

<style scoped>
.BaiDuMap {
  width: 100%;
  height: 781px;
}

.star {
    width:10px;
    height:10px;
    margin: 200px auto 0;
    position: relative;
    width: 0px;
    height: 0px;
    border-color: red transparent transparent transparent;
    border-width: 41.41px 57.06px;
    border-style: solid;
  }

  .star::before {
    content: '';
    display: block;
    position: absolute;
    left: -57.06px;
    top: -41.41px;
    border-color: red transparent transparent transparent;
    border-width: 41.41px 57.06px;
    border-style: solid;
    transform: rotate(72deg);
    transform-origin: 50% 22.5%;
  }


  .star::after {
    content: '';
    display: block;
    position: absolute;
    left: -25px;
    top: -25px;
    border-color: red transparent transparent transparent;
    border-width: 35px 25px;
    border-style: solid;
    transform: rotate(-72deg);
    transform-origin: 50% 22.5%;
  }

  .circle1 {
    width:35px;
    height:35px;
    background: red;
    -moz-border-radius: 50px;
    -webkit-border-radius: 50px;
    border-radius: 50px;
 }
  .circle2 {
    width:35px;
    height:35px;
    background: purple;
    -moz-border-radius: 50px;
    -webkit-border-radius: 50px;
    border-radius: 50px;
 }
 .circle3 {
    width:35px;
    height:35px;
    background: green;
    -moz-border-radius: 50px;
    -webkit-border-radius: 50px;
    border-radius: 50px;
 }
 .circle4 {
    width:35px;
    height:35px;
    background: brown;
    -moz-border-radius: 50px;
    -webkit-border-radius: 50px;
    border-radius: 50px;
 }

</style>