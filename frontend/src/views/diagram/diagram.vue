<template>

  <div>
    <div class="navHome">
      <div class="nav">
        <el-tooltip class="item" effect="dark" content="真实数据展示" placement="top-start">
          <div ref="nav0" class="navbox0" @click="goToRealData()" v-on:mouseover="changeActive0($event)" v-on:mouseout="removeActive0($event)"></div>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="预测数据展示" placement="top-start">
          <div ref="nav1" class="navbox1" @click="goToPredictionData()" v-on:mouseover="changeActive1($event)" v-on:mouseout="removeActive1($event)"></div>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="热力图展示" placement="top-start">
          <div ref="nav2" class="navbox2" @click="goToHeatMap()" v-on:mouseover="changeActive2($event)" v-on:mouseout="removeActive2($event)"></div>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="集群交互展示" placement="top-start">
          <div ref="nav1" class="navbox3" @click="goToCluster()" v-on:mouseover="changeActive3($event)" v-on:mouseout="removeActive3($event)"></div>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="集群影响力展示" placement="top-start">
          <div ref="nav2" class="navbox4" @click="goToClusterInfluence()" v-on:mouseover="changeActive4($event)" v-on:mouseout="removeActive4($event)"></div>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="预测地点影响力展示" placement="top-start">
          <div ref="nav2" class="navbox5" @click="goToPredictionHeatmap()" v-on:mouseover="changeActive5($event)" v-on:mouseout="removeActive5($event)"></div>
        </el-tooltip>
      </div>
    </div>
    <!--<el-row>
      <div>
    <el-checkbox v-model="checked1" label="备选项1" border></el-checkbox>
    <el-checkbox v-model="checked2" label="备选项2" border></el-checkbox>
    <el-checkbox v-model="checked2" label="备选项3" border></el-checkbox>
  </div>
    </el-row>-->
    <!--<el-row>
      <el-col>
        <div>
          <input type="checkbox" id="realData" name="realData" checked onclick="checkRealData(this.checked)">
          <label for="realData">真实数据展示</label>
        </div>
      </el-col>

      <el-col>
        <div>
          <input type="checkbox" id="predictionData" name="predictionData" onclick="checkPredictionData(this.checked)">
          <label for="predictionData">预测数据展示</label>
        </div>
      </el-col>

      <el-col>
        <div>
          <input type="checkbox" id="heatMap" name="heatMap" onclick="checkHeatMap(this.checked)">
          <label for="heatMap">热力图展示</label>
        </div>
      </el-col>

    </el-row>-->
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
                  <!-- <el-checkbox v-model="checked1" label="" ></el-checkbox> -->
                  <p class="mapLegend" style="background-color:red"/>
                  <span style="color:black">仅封控({{ onlySealedPoints.length }}例)</span>
                </div>
                <div>
                  <!-- <el-checkbox v-model="checked1" label="" ></el-checkbox> -->
                  <p class="mapLegend" style="background-color:orange"/>
                  <span style="color:black">仅有患者经过({{ onlyTrajectoryPoints.length }}例)</span>
                </div>
                <div>
                  <!-- <el-checkbox v-model="checked1" label="" ></el-checkbox> -->
                  <p class="mapLegend" style="background-color:blue"/>
                  <span style="color:black">封控且有患者经过({{ sealedAndTrajectoryPoints.length }}例)</span>
                </div>
                <!-- <div>
                  <el-checkbox v-model="checked1" label="" ></el-checkbox>
                  <p class="mapLegend" style="background-color:yellow"/>
                  <span style="color:black">封控预测数据</span>
                </div>
                <div>
                <el-checkbox v-model="checked1" label="" ></el-checkbox> 
                  <p class="mapLegend" style="background-color:brown"/>
                  <span style="color:black">封控预测数据</span>
                </div> -->


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

            <bm-info-window
              class="info"
              :show="showFlag"
              :position="clickPoint"
            >
              <div class="window">
                <div v-if="placeInfo.name">场所名称：<span>{{this.placeInfo.name}}</span></div>
                <div v-if="placeInfo.type">场所类型：<span>{{this.placeInfo.type}}</span></div>
                <div v-if="placeInfo.type == '小区'">居民数：<span>{{this.placeInfo.households * 3}}</span></div>
                <div v-if="placeInfo.type == '小区'">封控状态：<span>{{this.placeInfo.sealedStatus == 1 ? '封控' : '未封控'}}</span></div>
                <div v-if="placeInfo.type == '小区'">当天患者经过数：<span>{{this.placeInfo.appear}}</span></div>
                <div v-if="placeInfo.type == '小区'">历史患者经过数：<span>{{this.placeInfo.history}}</span></div>
              </div>
            </bm-info-window>

            <!-- <bm-marker v-for="(item, i) in onlyTrajectoryPoints" :key="i" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_org.png'), size: {width: 32, height: 32}}" @click="clickHandler(item)"></bm-marker>
            <bm-marker v-for="(item, i) in onlySealedPoints" :key="i+onlyTrajectoryPoints.length" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_red.png'), size: {width: 32, height: 32}}" @click="clickHandler(item)"></bm-marker>
            <bm-marker v-for="(item, i) in sealedAndTrajectoryPoints" :key="i+onlyTrajectoryPoints.length+onlySealedPoints.length" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_blue.png'), size: {width: 32, height: 32}}" @click="clickHandler(item)"></bm-marker> -->
            
            <bm-marker v-for="(item, i) in onlyTrajectoryPoints" :key="curDate + 'onlyTrajectoryPoints' + i" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_org.png'), size: {width: 32, height: 32}}" @click="clickHandler(i, 0)"></bm-marker>
            <bm-marker v-for="(item, i) in onlySealedPoints" :key="curDate + 'onlySealedPoints' + i" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_red.png'), size: {width: 32, height: 32}}" @click="clickHandler(i, 1)"></bm-marker>
            <bm-marker v-for="(item, i) in sealedAndTrajectoryPoints" :key="curDate + 'sealedAndTrajectoryPoints' + i" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_blue.png'), size: {width: 32, height: 32}}" @click="clickHandler(i, 2)"></bm-marker>
            
            <!-- <bm-marker v-for="(item, i) in onlyTrajectoryPoints" :key="i" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_org.png'), size: {width: 32, height: 32}}" @click="clickHandler(i, 0)"></bm-marker>
            <bm-marker v-for="(item2, i2) in onlySealedPoints" :key="i2+onlyTrajectoryPoints.length" :position="{lng: item2.lng, lat: item2.lat}" :icon="{url:require('./img/markers_red.png'), size: {width: 32, height: 32}}" @click="clickHandler(i2, 1)"></bm-marker>
            <bm-marker v-for="(item3, i3) in sealedAndTrajectoryPoints" :key="i3+onlyTrajectoryPoints.length+onlySealedPoints.length" :position="{lng: item3.lng, lat: item3.lat}" :icon="{url:require('./img/markers_blue.png'), size: {width: 32, height: 32}}" @click="clickHandler(i3, 2)"></bm-marker> -->

            <!-- <bm-marker v-for="(item, i) in sealedPredictionPoints" :key="i+onlyTrajectoryPoints.length+onlySealedPoints.length+sealedAndTrajectoryPoints.length" :position="{lng: item.lng, lat: item.lat}" :icon="{url:require('./img/markers_yellow.png'), size: {width: 32, height: 32}}"></bm-marker> -->
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

  </div>

    </template>
    <script >
    import { getByDateAndTaskId, getPlaceInfo } from "@/api/data/event";
    import {getTask} from "@/api/data/task";
    import {getPredictionDataByDateAndTaskId} from "@/api/data/predictionData";
    import { Timeline } from "@/components/TimeLine/index";
    import $ from 'jquery'
    // import { timeline } from "@/components/TimeLine2/index";
  
      
    export default {
      data() {
        return {
            // 地址信息
            address: null,
            // center通过经纬度或城市名均可?
            center: { lng: 0, lat: 0 },
            clickPoint: { lng: 0, lat: 0 },
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

            placeInfo:{name: null, type: null, households: 0, sealedStatus: 0, appear: 0, history: 0},
            
            place1: ["中辛庄公交站", "高庄子小学"],

            timeLineArr:[],
            curDate: "",

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
      
      showFlag: false,
      curButton: 0,

      // 展示什么数据
      showRealData:true,
      showPredictionData:false,
      showHeatMap:false,

      checked1:true,
      checked2:false,
      option: {
          itemWidth: 30,
          itemHeight: 30,
          useBgImg:true,
          bgActive:'red',
          bg:'yellow',
          useBtnBgImg:true,
          btnActiveBg:'red',
          btnBg:'yellow',
          fontSize:10,
          color:'#00F1FB',
          timelineWidth:20,
          autoPlay:false,
          loop:true,
          goSpeed:1000,
          txtLength:2,
          btnWidth:85,
          btnHeight:30,
          showPlayBtn:false,
        },
        apiData:[
          {
            id: 1,
            text: "2020-09-28",
          },
          {
            id: 2,
            text: "2020-09-30 12:00:002020-09-28 12:00:00",
          },
          {
            id: 3,
            text: "2020-10-2 ",
          },
          {
            id: 4,
            text: "2020-10-3",
          },
          {
            id: 5,
            text: "2020-10-4",
          },
          {
            id: 6,
            text: "2020-10-5",
          },
          {
            id: 7,
            text: "2020-10-6",
          },
          {
            id: 8,
            text: "2020-10-7",
          },
          {
            id: 9,
            text: "2020-10-8",
          },
          {
            id: 10,
            text: "2020-10-9",
          },
        ],
    
        };
      },
      methods: {
        // TODO:在时序交互图界面已经有了任务信息，后续页面都不需要再去后端拿，只需要前端页面传递就行
        goToRealData(){
          this.$router.push("/diagram")
          localStorage.setItem("taskid",item.id);
         
        },
        goToPredictionData(){
          this.$router.push("/prediction")
          localStorage.setItem("taskid",item.id);
      

        },
        goToHeatMap(){
          this.$router.push("/heatmap")
          localStorage.setItem("taskid",item.id);
        },
        goToCluster(){
          this.$router.push("/cluster")
          localStorage.setItem("taskid",item.id);
         
        },
        goToClusterInfluence(){
          this.$router.push("/influence")
          localStorage.setItem("taskid",item.id);
         
        },
        goToPredictionHeatmap(){
          this.$router.push("/predictionHeatmap")
          localStorage.setItem("taskid",item.id);
         
        },
        changeActive0 ($event) {
      $event.target.className = 'navbox0change'
    },
    removeActive0 ($event) {
      
        $event.target.className = 'navbox0'
    
     
    },
    changeActive1 ($event) {
      $event.target.className = 'navbox1change'
    },
    removeActive1 ($event) {
     
        $event.target.className = 'navbox1'
      
    },
    changeActive2 ($event) {
      $event.target.className = 'navbox2change'
    },
    removeActive2 ($event) {
     
        $event.target.className = 'navbox2'
     
    },
    changeActive3 ($event) {
      $event.target.className = 'navbox3change'
    },
    removeActive3 ($event) {
     
        $event.target.className = 'navbox3'
      
    },
    changeActive4 ($event) {
      $event.target.className = 'navbox4change'
    },
    removeActive4 ($event) {
     
        $event.target.className = 'navbox4'
     
    },
    changeActive5 ($event) {
      $event.target.className = 'navbox5change'
    },
    removeActive5 ($event) {
     
        $event.target.className = 'navbox5'
     
    },
        checkRealData(isChecked){
          console.log("isChecked:"+isChecked)

        },
        checkPredictionData(isChecked){
          console.log("isChecked:"+isChecked)
        },
        checkHeatMap(isChecked){
          console.log("isChecked:"+isChecked)
        },
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
          this.curDate = this.task.startTime;
          let timer = setInterval(() => {
            //需要定时执行的代码
            // console.log("定时器")
            console.log(this.curButton);
            $($("button")[this.curButton]).addClass("is-plain");
            this.curButton = this.curButton++ > ($("button").length-1) ? 1 : this.curButton;
            $($("button")[this.curButton]).removeClass("is-plain");
            this.refresh($("button")[this.curButton].innerText)
          },2000)

          
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
                      const position = {lng: response.data.sealedAndTrajectoryList[i].longitude, lat: response.data.sealedAndTrajectoryList[i].latitude, place: response.data.sealedAndTrajectoryList[i].place}
                      this.sealedAndTrajectoryPoints.push(position)
                  }
                  console.log(response.data.onlyTrajectoryList)
                  this.onlyTrajectoryPoints = []
                  for (let i = 0; i < response.data.onlyTrajectoryList.length; i++) {
                      const position = {lng: response.data.onlyTrajectoryList[i].longitude, lat: response.data.onlyTrajectoryList[i].latitude, place: response.data.onlyTrajectoryList[i].place}
                      this.onlyTrajectoryPoints.push(position)
                  }
                  console.log(response.data.onlySealedList)
                  this.onlySealedPoints = []
                  for (let i = 0; i < response.data.onlySealedList.length; i++) {
                      const position = {lng: response.data.onlySealedList[i].longitude, lat: response.data.onlySealedList[i].latitude, place: response.data.onlySealedList[i].place}
                      this.onlySealedPoints.push(position)
                  }
                  console.log(this.sealedAndTrajectoryPoints)
              } 
          });
          this.$forceUpdate();
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
          // this.clickPoint.lng = e.point.lng;
          // this.clickPoint.lat = e.point.lat;
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
        async clickHandler (i, type) {
          console.log("i")
          console.log(i)
          console.log("type")
          console.log(type)
          var item
          if (type == 0) {
            console.log(this.onlyTrajectoryPoints)
            item = this.onlyTrajectoryPoints[i]
          } else if (type == 1) {
            console.log(this.onlySealedPoints)
            // console.log(i - this.onlyTrajectoryPoints.length)
            // item = this.onlySealedPoints[i - this.onlyTrajectoryPoints.length]
            item = this.onlySealedPoints[i]
          }else {
            console.log(this.sealedAndTrajectoryPoints)
            // console.log(i - this.onlyTrajectoryPoints.length - this.onlySealedPoints.length)
            // item = this.sealedAndTrajectoryPoints[i - this.onlyTrajectoryPoints.length - this.onlySealedPoints.length]
            item = this.sealedAndTrajectoryPoints[i]
          }
          
          // alert(`单击点的坐标为：${e.point.lng}, ${e.point.lat}`);
          console.log("item")
          console.log(item)
          console.log("place")
          console.log(item.place)
          this.showFlag = false
          this.clickPoint.lng = item.lng;
          this.clickPoint.lat = item.lat;
          // console.log(e.point)
          await getPlaceInfo(this.curDate, item.place, this.task.taskID).then(response => {
            console.log("getPlaceInfo called")
            console.log(response)
            if (response.code===200){
              console.log("2")
              this.placeInfo.name = item.place;
              this.placeInfo.type = response.data.type;
              this.placeInfo.households = response.data.households;
              this.placeInfo.sealedStatus = response.data.sealed;
              this.placeInfo.appear = response.data.appear;
              this.placeInfo.history = response.data.history;
              console.log(this.placeInfo)
              console.log("3")
            } 
          });  
          this.showFlag = true
        },
        //时间轴更新地图
        async refresh(date) {
          console.log("refresh called")
          console.log(date)
          this.showFlag = false
          this.curDate = date;
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
            //this.getPredictionPoints(nextday);
          }else{
            console.log("没有预测数据")
            this.sealedPredictionPoints=[]
          }  
          // console.log($("button"));
       
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
        height: 100px;
        width: 240px;
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

      .navHome{
    width: 100%;
    display: flex;
    position: fixed;
    justify-content: center;
    z-index: 999;
    left: 0px;
  }
  .nav{
    width:480px;
    height: 100px;
    /* background-color: white; */
    /* position: fixed; */
    /* bottom: 0px; */
    /* top: 0px; */
    z-index: 999;
    display: flex;
    flex-direction: row;
  }
  .navbox0{
    width:65px;
    height: 65px;
    margin: 12px;
    /* background-color: gray; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/discover.png");
    background-size: 90% 90%;
    background-position:center ;
    background-repeat: no-repeat;
  }
  .navbox0change{
    width:90px;
    height: 90px;
    margin: 3px;
    /* background-color: green; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/discover.png");
    background-size: 90% 90%;
    background-position:center ;
    background-repeat: no-repeat;
  }
  .navbox1{
    width:60px;
    height: 60px;
    margin: 13px;
    /* background-color: red; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/bangzhu_gray.png");
    background-size: 100% 100%;
  }
  .navbox1change{
    width:80px;
    height: 80px;
    margin: 5px;
    /* background-color: green; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/bangzhu_gray.png");
    background-size: 100% 100%;
  }
  .navbox2{
    width:60px;
    height: 60px;
    margin: 13px;
    /* background-color: red; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/circle-plus-outline_gray.png");
    background-size:100% 100%;
  }
  .navbox2change{
    width:80px;
    height: 80px;
    margin: 5px;
    /* background-color: green; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/circle-plus-outline_gray.png");
    background-size: 100% 100%;
  }

  .navbox3{
    width:65px;
    height: 65px;
    margin: 12px;
    /* background-color: gray; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/stopwatch_gray.png");
    background-size: 90% 90%;
    background-position:center ;
    background-repeat: no-repeat;
  }
  .navbox3change{
    width:90px;
    height: 90px;
    margin: 3px;
    /* background-color: green; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/stopwatch_gray.png");
    background-size: 90% 90%;
    background-position:center ;
    background-repeat: no-repeat;
  }
  .navbox4{
    width:55px;
    height: 55px;
    margin: 16px;
    /* background-color: red; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/icon-kfckfc_gray.png");
    background-size: 100% 100%;
  }
  .navbox4change{
    width:80px;
    height: 80px;
    margin: 5px;
    /* background-color: green; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/icon-kfckfc_gray.png");
    background-size: 100% 100%;
  }
  .navbox5{
    width:55px;
    height: 55px;
    margin: 16px;
    /* background-color: red; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/remove-outline_gray.png");
    background-size: 100% 100%;
  }
  .navbox5change{
    width:80px;
    height: 80px;
    margin: 5px;
    /* background-color: green; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/remove-outline_gray.png");
    background-size: 100% 100%;
  }
    
    </style>