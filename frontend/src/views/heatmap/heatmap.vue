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
        </div>
      </div>
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
  
              <!-- 必须给容器指高度，不然地图将显示在一个高度为0的容器中，看不到 -->
              <!--bm-navigation表示缩放控件 anchor为停靠位置-->
              <bm-navigation anchor="BMAP_ANCHOR_TOP_RIGHT"></bm-navigation>
              <!--bm-geolocation表示地图定位控件 autoLocation表示用户点击控件时是否显示定位，需要获得用户的许可-->
              <!--bm-city-list 城市选择控件-->
              <bm-city-list anchor="BMAP_ANCHOR_TOP_LEFT"></bm-city-list>
                
              <bml-heatmap :data="data" :max="1" :radius="20">
              </bml-heatmap>

            </baidu-map>
          </div>
        </el-col>
      </el-row>
       <Timeline :timelineList="timeLineArr" @refresh="refresh" id="timeline" />
      
  
    </div>
  
      </template>
      <script >
      import { getByDateAndTaskId } from "@/api/data/event";
      import {getTask} from "@/api/data/task";
      import {getScore} from "@/api/data/score";
      import {getPredictionDataByDateAndTaskId} from "@/api/data/predictionData";
      import { Timeline } from "@/components/TimeLine/index";
      import {BmlHeatmap} from 'vue-baidu-map'
    
        
      export default {
        components: {
          BmlHeatmap
        },
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
  
        // 展示什么数据
        showRealData:true,
        showPredictionData:false,
        showHeatMap:false,
  
        checked1:true,
        checked2:false,
      
        data: [],
          };
        },
        methods: {
          goToRealData(){
            this.$router.push("/diagram")
            //localStorage.setItem("taskid",item.id);
          },
          goToPredictionData(){
            this.$router.push("/prediction")
  
          },
          goToHeatMap(){
            this.$router.push("/heatmap")
  
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
            this.taskID=localStorage.getItem("taskid");
            console.log("taskID:"+this.taskID);
            // 获取任务配置信息
            await this.getTaskInfo(this.taskID);
            this.center=this.task.place;
            this.zoom = this.zoom;
            
             // 根据任务配置来初始化时间轴
            this.initTimeLineArrByTask()
          
            // 根据任务配置来取第一天的真实数据
            this.getScore(this.task.startTime);
            
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
  
          async getScore(date) {
            await getScore(date, this.task.taskID).then(response => {
              console.log("getScore called")
              console.log("date:"+date)
              console.log(response)
              if (response.code === 200) {
                console.log("1")
                this.data = []
                for (let i = 0; i < response.data.length; i++) {
                  const position = {lng: response.data[i].longitude, lat: response.data[i].latitude, count: response.data[i].score}
                  this.data.push(position)
                }
              }
            })
            console.log(this.data)
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
            this.getScore(date);
            // 拿预测数据时进行限制，开始日期：2022-01-08，只有在距开始日期task.TimeInterVal后才有预测数据
            // 例如：需要7天数据才能预测
            // 那么只有在已知20220108-20220114的数据时才知道20220115那一天的预测数据
            // 在20220114画这个预测数据
            // var dateStr=date.substr(0,4)+date.substr(5,2)+date.substr(8,2)
            // var predictionDayStr=this.startPredictionFirstDay.substr(0,4)+this.startPredictionFirstDay.substr(5,2)+this.startPredictionFirstDay.substr(8,2)
            // if (dateStr>=predictionDayStr){
            //   console.log("可以拿到预测数据")
            //   var nextday=this.getNextDayStr(date)
            //   console.log(nextday)
            //   //this.getPredictionPoints(nextday);
            // }else{
            //   console.log("没有预测数据")
            //   this.sealedPredictionPoints=[]
            // }  
         
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
  
        .navHome{
      width: 100%;
      display: flex;
      position: fixed;
      justify-content: center;
      z-index: 999;
      left: 0px;
    }
    .nav{
      width:270px;
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
      width:70px;
      height: 70px;
      margin: 10px;
      /* background-color: red; */
      transition-duration: 0.3s;
      background-image: url("../../assets/img/nav_chart.png");
      background-size: 90% 90%;
      background-position:center ;
      background-repeat: no-repeat;
    }
    .navbox0change{
      width:80px;
      height: 80px;
      margin: 5px;
      /* background-color: green; */
      transition-duration: 0.3s;
      background-image: url("../../assets/img/nav_chart.png");
      background-size: 90% 90%;
      background-position:center ;
      background-repeat: no-repeat;
    }
    .navbox1{
      width:70px;
      height: 70px;
      margin: 10px;
      /* background-color: red; */
      transition-duration: 0.3s;
      background-image: url("../../assets/img/nav_upchain.png");
      background-size: 100% 100%;
    }
    .navbox1change{
      width:80px;
      height: 80px;
      margin: 5px;
      /* background-color: green; */
      transition-duration: 0.3s;
      background-image: url("../../assets/img/nav_upchain.png");
      background-size: 100% 100%;
    }
    .navbox2{
      width:70px;
      height: 70px;
      margin: 10px;
      /* background-color: red; */
      transition-duration: 0.3s;
      background-image: url("../../assets/img/nav_mng.png");
      background-size: 100% 100%;
    }
    .navbox2change{
      width:80px;
      height: 80px;
      margin: 5px;
      /* background-color: green; */
      transition-duration: 0.3s;
      background-image: url("../../assets/img/nav_mng.png");
      background-size: 100% 100%;
    }
        
      
      </style>