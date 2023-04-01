<template>

  <div>
    <el-row >
      <el-col >
        <div class="BaiDuMap">
   
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

            <bm-control anchor="BMAP_ANCHOR_BOTTOM_RIGHT">
              <el-card class="box-card" shadow="always">
                <div>
                  <p class="mapLegend" style="background-color:red"/>
                  <span style="color:black">仅封控</span>
                </div>
                <div>
                  <p class="mapLegend" style="background-color:orange"/>
                  <span style="color:black">仅有患者经过</span>
                </div>
                <div>
                  <p class="mapLegend" style="background-color:blue"/>
                  <span style="color:black">封控且有患者经过</span>
                </div>
                <div>
                  <p class="mapLegend" style="background-color:yellow"/>
                  <span style="color:black">封控预测数据</span>
                </div>
                <!-- <div>
                  <p class="mapLegend" style="background-color:purple"/>
                  <span style="color:purple">仅封控</span>
                </div>
                <div>
                  <p class="mapLegend" style="background-color:green"/>
                  <span style="color:green">仅有患者经过</span>
                </div>
                <div>
                  <p class="mapLegend" style="background-color:red"/>
                  <span style="color:red">封控且有患者经过</span>
                </div> -->
            </el-card>
            </bm-control>
   
            <!-- 必须给容器指高度，不然地图将显示在一个高度为0的容器中，看不到 -->
            <!--bm-navigation表示缩放控件 anchor为停靠位置-->
            <bm-navigation anchor="BMAP_ANCHOR_TOP_RIGHT"></bm-navigation>
            <!--bm-geolocation表示地图定位控件 autoLocation表示用户点击控件时是否显示定位，需要获得用户的许可-->
            <!--bm-city-list 城市选择控件-->
            <bm-city-list anchor="BMAP_ANCHOR_TOP_LEFT"></bm-city-list>

            <!-- <bm-marker :position="{lng: 116.404, lat: 39.915}" :dragging="false"></bm-marker> -->

            <bm-marker v-for="(item, i) in onlyTrajectoryPoints" :key="i" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_org.png'), size: {width: 32, height: 32}}"></bm-marker>
            <bm-marker v-for="(item, i) in onlySealedPoints" :key="i+onlyTrajectoryPoints.length" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_red.png'), size: {width: 32, height: 32}}"></bm-marker>
            <bm-marker v-for="(item, i) in sealedAndTrajectoryPoints" :key="i+onlyTrajectoryPoints.length+onlySealedPoints.length" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_blue.png'), size: {width: 32, height: 32}}"></bm-marker>
            <bm-marker v-for="(item, i) in sealedPredictionPoints" :key="i+onlyTrajectoryPoints.length+onlySealedPoints.length+sealedAndTrajectoryPoints.length" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_yellow.png'), size: {width: 32, height: 32}}"></bm-marker>
            <!--海量点绘制-->
            <!--仅有患者经过-->
            <!-- <bm-point-collection :points="onlyTrajectoryPoints" shape="BMAP_POINT_SHAPE_STAR" color="green" size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection> -->
            <!--仅封控-->
            <!-- <bm-point-collection :points="onlySealedPoints" shape="BMAP_POINT_SHAPE_STAR" color="purple" size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection> -->
            <!--封控 & 有患者经过-->
            <!-- <bm-point-collection :points="sealedAndTrajectoryPoints" shape="BMAP_POINT_SHAPE_STAR" color="red" size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection> -->
            
          </baidu-map>
        </div>
        <!-- <ul>
 <li v-for="(item,i) in sealedAndTrajectoryPoints">索引：{{i}}---lng：{{item.lng}}---lat：{{item.lat}}---len:{{ sealedAndTrajectoryPoints.length }}</li>
 </ul> -->
      </el-col>
    </el-row>
     <Timeline :timelineList="timeLineArr" @refresh="refresh" id="timeline" />
    <div id="container"></div>
    </div>
    </template>
    <script >
    import { getByDateAndTaskId } from "@/api/data/event";
    import {getTask} from "@/api/data/task";
    import {getPredictionDataByDateAndTaskId} from "@/api/data/predictionData";
    import { Timeline } from "@/components/TimeLine/index";
  
      
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
      
            // 封控 & 有患者经过
            sealedAndTrajectoryPoints:[],
            // 仅封控
            onlySealedPoints:[],
            // 仅有患者经过
            onlyTrajectoryPoints:[],
            // 封控小区预测数据
            sealedPredictionPoints:[],
            
            place1: ["中辛庄公交站", "高庄子小学"],

            timeLineArr:[],

            task: {
              taskID:1,
              name: null,
              startTime: null,
              endTime: null,
              timeInterval: null,
              place: null,
              dataSource: null
      },
      startPredictionFirstDay:null,
    
        };
      },
      methods: {
     async handler({ BMap, map }) {
          // this.center.lng = 116.404;
          // this.center.lat = 39.915;
          this.taskID=localStorage.getItem("taskid");
          console.log("taskID:"+this.taskID);
          // 获取任务配置信息
          await this.getTaskInfo(this.taskID);
          this.setStartPredictionFirstDay()
          // this.center.lng = 117.35267834853804;
          // this.center.lat = 38.99494446989348;
          this.center=this.task.place;
          this.zoom = this.zoom;
    
          // 海量点绘制点集合初始化
          //this.addPoints(this.points1)
          //this.addPoints(this.points2)
          //this.addPoints(this.points3)
          //this.addPoints(this.points4)
    
    
          //this.initTimeLineArr();
           // 根据任务配置来初始化时间轴
          this.initTimeLineArrByTask()
        
          // 根据任务配置来取第一天的真实数据
          this.getPoints(this.task.startTime);
         
          
        },
        setStartPredictionFirstDay(){
          var dayStr=this.task.startTime;
          for(var i=0;i<this.task.timeInterval-1;i++){
            var day=new Date(dayStr);
            // 获取后一天日期
            day.setDate(day.getDate() + 1);
            var y = day.getFullYear();
            var m = day.getMonth() + 1 < 10 ? "0" + (day.getMonth() + 1) : day.getMonth() + 1;
            var d = day.getDate() < 10 ? "0" + day.getDate() : day.getDate();
            dayStr=y+"-"+m+"-"+d;
            console.log(dayStr)
          }
          this.startPredictionFirstDay=dayStr;
          console.log("startPredictionFirstDay:"+this.startPredictionFirstDay);

        },
        async getTaskInfo(id){
          await getTask(id).then(response =>{
            console.log("getTask called")
            console.log(response)
            if (response.code===200){
            var data=response.data
            console.log("data:"+data)
            this.task.name=data.name
            this.task.startTime=data.startTime
            this.task.endTime=data.endTime
            this.task.timeInterval=data.timeInterval
            this.task.place=data.place
            this.task.dataSource=data.dataSource
            }

          })

        },
        initTimeLineArrByTask() {
          // 根据任务起止时间造时间轴数据
          console.log("task.endTime:"+this.task.endTime)
          if (this.task.endTime!=="0"){
            console.log("任务有截止时间");
            // 转换成为日期数据类型
          var dayStr=this.task.startTime
          const timeNode = {date: dayStr, content: dayStr, isShow: true};
          this.timeLineArr.push(timeNode);
          while(dayStr!==this.task.endTime){
            var day=new Date(dayStr)
            // 获取后一天日期
            day.setDate(day.getDate() + 1);
            var y = day.getFullYear();
            var m = day.getMonth() + 1 < 10 ? "0" + (day.getMonth() + 1) : day.getMonth() + 1;
            var d = day.getDate() < 10 ? "0" + day.getDate() : day.getDate();
            dayStr=y+"-"+m+"-"+d
            const timeNode = {date: dayStr, content: dayStr, isShow: true};
            this.timeLineArr.push(timeNode);
          }
          }
        },
          initTimeLineArr() {
            getTimeListFromTask().then(response => {
              console.log("getTimeList called")
              console.log(response)
              if(response.code===200) {
                console.log(response.data)
                for(let i = 0; i < response.data.length; i++) {
                  let date = response.data[i].substring(0, 10).replace(/-/g, "")
                  const timeNode = {date: date, content: date, isShow: true}
                  this.timeLineArr.push(timeNode)
                }
                console.log("timeLineArr")
                console.log(this.timeLineArr)
              }
            })
              // date = ["20220108"]
          },

        addPoints (p) {
          for (var i = 0; i < 100; i++) {
            const position = {lng: Math.random() * 40 + 85, lat: Math.random() * 30 + 21}
            p.push(position)
          }
          
        },
        async getPoints(date){
          await getByDateAndTaskId(date,this.task.taskID).then(response => {
              console.log("getByDateAndTaskId called")
              console.log("date:"+date)
              console.log(response)
              if (response.code===200){
                  console.log("1")
                  console.log(response.data.sealedAndTrajectoryList)
                  this.sealedAndTrajectoryPoints = []
                  for (let i = 0; i < response.data.sealedAndTrajectoryList.length; i++) {
                      const position = {lng: response.data.sealedAndTrajectoryList[i].longitude, lat: response.data.sealedAndTrajectoryList[i].latitude}
                      this.sealedAndTrajectoryPoints.push(position)
                  }
                  console.log(response.data.onlyTrajectoryList)
                  this.onlyTrajectoryPoints = []
                  for (let i = 0; i < response.data.onlyTrajectoryList.length; i++) {
                      const position = {lng: response.data.onlyTrajectoryList[i].longitude, lat: response.data.onlyTrajectoryList[i].latitude}
                      this.onlyTrajectoryPoints.push(position)
                  }
                  console.log(response.data.onlySealedList)
                  this.onlySealedPoints = []
                  for (let i = 0; i < response.data.onlySealedList.length; i++) {
                      const position = {lng: response.data.onlySealedList[i].longitude, lat: response.data.onlySealedList[i].latitude}
                      this.onlySealedPoints.push(position)
                  }
                  console.log(this.sealedAndTrajectoryPoints)
              } 
          });
          
        },
        async getPredictionPoints(date){
          await getPredictionDataByDateAndTaskId(date,this.task.taskID).then(response => {
              console.log("getPredictionDataByDate called")
              console.log("pppppp:"+date)
              console.log(response)
              if (response.code===200){
                  console.log("getPredictionDataByDate success!")
                  console.log(response.data.sealedPredictionList)
                  this.sealedPredictionPoints = []
                  for (let i = 0; i < response.data.sealedPredictionList.length; i++) {
                      const position = {lng: response.data.sealedPredictionList[i].longitude, lat: response.data.sealedPredictionList[i].latitude}
                      this.sealedPredictionPoints.push(position)
                  }
                  console.log(response.data.sealedPredictionList)
              } 
          });
          
        },
        addPic(map){
          console.log("addPic called")
          var point = new BMap.Point(this.center.lng, this.center.lat);
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
        //时间轴更新地图
        async refresh(date) {
          console.log("refresh called")
          console.log(date)
          this.getPoints(date);
          // 拿预测数据时进行限制，开始日期：2022-01-08，只有在距开始日期task.TimeInterVal后才有预测数据
          // 例如：需要7天数据才能预测
          // 那么只有在已知20220108-20220114的数据时才知道20220115那一天的预测数据
          // 在20220114画这个预测数据
          var dateStr=date.substr(0,4)+date.substr(5,2)+date.substr(8,2)
          var predictionDayStr=this.startPredictionFirstDay.substr(0,4)+this.startPredictionFirstDay.substr(5,2)+this.startPredictionFirstDay.substr(8,2)
          if (dateStr>=predictionDayStr){
            console.log("可以拿到预测数据")
            var nextday=this.getNextDayStr(date)
            console.log(nextday)
            this.getPredictionPoints(nextday);
          }else{
            console.log("没有预测数据")
            this.sealedPredictionPoints=[]
          }  
       
          },
          getNextDayStr(date){
          console.log("getNextDayStr called")
          // 转换成为日期数据类型
          var day=new Date(date)
          // 获取后一天日期
          day.setDate(day.getDate() + 1);
          var y = day.getFullYear();
          var m = day.getMonth() + 1 < 10 ? "0" + (day.getMonth() + 1) : day.getMonth() + 1;
          var d = day.getDate() < 10 ? "0" + day.getDate() : day.getDate();
          return y+"-" + m +"-"+ d;
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

      .box-card {
        /* min-height: 100%;
        height: 100%; */
        height: 130px;
        width: 200px;
        /* height: 50px;
        width: 400px; */
      }

      .mapLegend{
        margin:8px 0 8px 10px;
        display:inline-block;
        vertical-align:middle;
        height:12px;
        width:12px;
        border-radius:6px
      }
    
    </style>