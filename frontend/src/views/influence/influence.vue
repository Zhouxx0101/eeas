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

            <!-- <bm-control anchor="BMAP_ANCHOR_BOTTOM_RIGHT">
              <el-card class="box-card" shadow="always">
                <div>
                  <p class="mapLegend" style="background-color:red"/>
                  <span style="color:black">当天预测确诊人数：{{ sum }}人</span>
                </div>
            </el-card>
            </bm-control> -->
  
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
      import { getClusterByDateAndTaskId } from "@/api/data/event";
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
              sum: Math.round(Math.random()*80+20),
  
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
            this.taskID=localStorage.getItem("taskid");
            console.log("taskID:"+this.taskID);
            // 获取任务配置信息
            await this.getTaskInfo(this.taskID);
            this.center=this.task.place;
            this.zoom = this.zoom;
            
             // 根据任务配置来初始化时间轴
            this.initTimeLineArrByTask()
          
            // 根据任务配置来取第一天的真实数据
            this.getInfluenceScore(this.task.startTime);
            
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
  
          async getInfluenceScore(date) {
            await getClusterByDateAndTaskId(date, this.task.taskID).then(response => {
              console.log("getClusterByDateAndTaskId called")
              console.log("date:"+date)
              console.log(response)
              if (response.code === 200) {
                console.log("getClusterByDateAndTaskId success!")
                  console.log(response.data.cluster)
                  for (let i = 0; i < response.data.cluster.length; i++) {
                    for(let j=0;j<response.data.cluster[i].length;j++){
                      const position = {lng: response.data.cluster[i][j].longitude, lat: response.data.cluster[i][j].latitude,count:i}
                      this.data.push(position)
                    }
                      
                  }
                
              }
            })
            console.log(this.data)
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
            this.getInfluenceScore(date);
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
              this.sum = Math.round(Math.random()*80+20);
              // this.sum = 1;
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
          height: 60px;
          width: 270px;
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
    background-image: url("../../assets/img/discover_gray.png");
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
    background-image: url("../../assets/img/discover_gray.png");
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
    background-image: url("../../assets/img/icon-kfckfc.png");
    background-size: 100% 100%;
  }
  .navbox4change{
    width:80px;
    height: 80px;
    margin: 5px;
    /* background-color: green; */
    transition-duration: 0.3s;
    background-image: url("../../assets/img/icon-kfckfc.png");
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