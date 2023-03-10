<template>
  <div>
    <div id="multipleXAxes1" :style="{ width: '100%', height: '600px' }"></div>
    <div id="multipleXAxes" :style="{ width: '100%', height: '600px' }"></div>
  </div>

</template>

<script>

import * as echarts from "echarts";
import { getIncreaseAndDiagnosis, getCloseContactAndMedicalObservation } from "@/api/data/change";
import { color } from 'echarts/lib/export';

  export default {
    data() {
      return {
        date1: [],
        increase: [],
        diagnosis: [],
        pred_increase: [],
        pred_diagnosis: [],
        date2: [],
        closeContact: [],
        medicalObservation: []
      }
    },
    mounted() {
      this.drawLine1();
      this.drawLine();
    },
    methods: {

      async drawLine1() {
      var app = {};
      var option = null;
      // Generate data
      await getIncreaseAndDiagnosis().then(response => {
        console.log("get1 called")
        console.log(response)
        // if (response.code===200){
          console.log("1")
          for (let i = 0; i < response.length; i++) {
            this.date1.push(response[i].start_time.slice(0, 10))
            if(response[i].start_time.slice(0, 10) > "2022-03-24") {
              this.increase.push(null)
              this.diagnosis.push(null)
            } else {
              this.increase.push(response[i].increase)
              this.diagnosis.push(response[i].diagnosis)
            }
            this.pred_increase.push(response[i].pred_increase)
            this.pred_diagnosis.push(response[i].pred_diag)
              }
            // } 
            });
      
      
      let myChart = this.$echarts.init(
        document.getElementById("multipleXAxes1")
      );
      // 绘制图表
      option = {
        backgroundColor: "transparent",
        title: {
          text: "新增与确诊人数演化统计",
          x: "center",
          y: 0,
          textStyle: {
            color: "#B4B4B4",
            fontSize: 16,
            fontWeight: "normal"
          }
        },
        tooltip: {
          trigger: "axis",
          backgroundColor: "transparent",
          axisPointer: {
            type: "shadow",
            label: {
              show: true,
              backgroundColor: "transparent"
            }
          }
        },
        legend: {
          data: ["新增数", "确诊数", "预测确诊数", "预测新增数"],
          textStyle: {
            color: "#B4B4B4"
          },
          top: "7%"
        },
        grid: {
          x: "12%",
          width: "82%",
          y: "12%"
        },
        xAxis: {
          // data: category,
          data: this.date1,
          axisLine: {
            lineStyle: {
              color: "#B4B4B4"
            }
          },
          axisTick: {
            show: false
          }
        },
        yAxis: [
          {
            splitLine: { show: false },
            axisLine: {
              lineStyle: {
                color: "#B4B4B4"
              }
            },

            axisLabel: {
              formatter: "{value} "
            }
          },
          {
            splitLine: { show: false },
            axisLine: {
              lineStyle: {
                color: "#B4B4B4"
              }
            },
            axisLabel: {
              formatter: "{value} "
            }
          }
        ],

        series: [
          {
            name: "预测确诊数",
            type: "line",
            smooth: true,
            showAllSymbol: true,
            symbol: "emptyCircle",
            symbolSize: 8,
            // yAxisIndex: 1,
            itemStyle: {
              normal: {
                color: "#F02FC2"
              }
            },
            data: this.pred_diagnosis
          },

          {
            name: "预测新增数",
            type: "line",
            smooth: true,
            showAllSymbol: true,
            symbol: "emptyCircle",
            symbolSize: 8,
            yAxisIndex: 1,
            itemStyle: {
              normal: {
                color: "#A000A0"
              }
            },
            data: this.pred_increase
          },

          {
            name: "新增数",
            type: "bar",
            barWidth: 10,
            yAxisIndex: 1,
            itemStyle: {
              normal: {
                barBorderRadius: 5,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: "#956FD4" },
                  { offset: 1, color: "#3EACE5" }
                  // { offset: 0, color: "rgba(156,107,211,0.5)" },
                  // { offset: 0.2, color: "rgba(156,107,211,0.3)" },
                  // { offset: 1, color: "rgba(156,107,211,0)" }
                ])
              }
            },
            data: this.increase
            // data: barData
          },

          {
            name: "确诊数",
            type: "bar",
            barGap: "-100%",
            barWidth: 10,
            itemStyle: {
              normal: {
                barBorderRadius: 5,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: "rgba(156,107,211,0.5)" },
                  { offset: 0.2, color: "rgba(156,107,211,0.3)" },
                  { offset: 1, color: "rgba(156,107,211,0)" }
                  // { offset: 0, color: "#956FD4" },
                  // { offset: 1, color: "#3EACE5" }
                ])
              }
            },
            z: -12,

            data: this.diagnosis
            // data: lineData
          }
        ]
      };
      var app = {
        currentIndex: -1
      };
      setInterval(function() {
        var dataLen = option.series[0].data.length;

        // 取消之前高亮的图形
        myChart.dispatchAction({
          type: "downplay",
          seriesIndex: 0,
          dataIndex: app.currentIndex
        });
        app.currentIndex = (app.currentIndex + 1) % dataLen;
        //console.log(app.currentIndex);
        // 高亮当前图形
        myChart.dispatchAction({
          type: "highlight",
          seriesIndex: 0,
          dataIndex: app.currentIndex
        });
        // 显示 tooltip
        myChart.dispatchAction({
          type: "showTip",
          seriesIndex: 0,
          dataIndex: app.currentIndex
        });
      }, 3000);
      if (option && typeof option === "object") {
        myChart.setOption(option, true);
      }
      window.onresize = function() {
        myChart.resize();
      };
    },

      async drawLine() {
      var app = {};
      var option = null;
      // Generate data
      await getCloseContactAndMedicalObservation().then(response => {
        console.log("get2 called")
        console.log(response)
        // if (response.code===200){
          console.log("1")
          for (let i = 0; i < response.length; i++) {
            this.date2.push(response[i].start_time.slice(0, 10))
            this.closeContact.push(response[i].close_contact)
            this.medicalObservation.push(response[i].medical_observation)
            //const position = {lng: response.rows[i].longitude, lat: response.rows[i].latitude}
            //this.points1.push(position)
              }
            // } 
            });

      
      var rateData = [];
      for (var i = 0; i < this.medicalObservation.length; i++) {
        // var date = i+2001;
        // category.push(date)
        var rate = this.medicalObservation[i] / this.closeContact[i];
        rateData[i] = rate.toFixed(2);
      }

      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(
        document.getElementById("multipleXAxes")
      );
      // 绘制图表
      option = {
        backgroundColor: "transparent",
        title: {
          text: "密接与隔离者演化统计",
          x: "center",
          y: 0,
          textStyle: {
            color: "#B4B4B4",
            fontSize: 16,
            fontWeight: "normal"
          }
        },
        tooltip: {
          trigger: "axis",
          backgroundColor: "transparent",
          axisPointer: {
            type: "shadow",
            label: {
              show: true,
              backgroundColor: "transparent"
            }
          }
        },
        legend: {
          data: ["密切接触者人数", "正在接受医学观察人数", "比率"],
          textStyle: {
            color: "#B4B4B4"
          },
          top: "7%"
        },
        grid: {
          x: "12%",
          width: "82%",
          y: "12%"
        },
        xAxis: {
          // data: category,
          data: this.date2,
          axisLine: {
            lineStyle: {
              color: "#B4B4B4"
            }
          },
          axisTick: {
            show: false
          }
        },
        yAxis: [
          {
            splitLine: { show: false },
            axisLine: {
              lineStyle: {
                color: "#B4B4B4"
              }
            },

            axisLabel: {
              formatter: "{value} "
            }
          },
          {
            splitLine: { show: false },
            axisLine: {
              lineStyle: {
                color: "#B4B4B4"
              }
            },
            axisLabel: {
              formatter: "{value} "
            }
          }
        ],

        series: [
          {
            name: "比率",
            type: "line",
            smooth: true,
            showAllSymbol: true,
            symbol: "emptyCircle",
            symbolSize: 8,
            yAxisIndex: 1,
            itemStyle: {
              normal: {
                color: "#F02FC2"
              }
            },
            data: rateData
          },

          {
            name: "正在接受医学观察人数",
            type: "bar",
            barWidth: 10,
            itemStyle: {
              normal: {
                barBorderRadius: 5,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: "#956FD4" },
                  { offset: 1, color: "#3EACE5" }
                ])
              }
            },
            // data: barData
            data: this.medicalObservation
          },

          {
            name: "密切接触者人数",
            type: "bar",
            barGap: "-100%",
            barWidth: 10,
            itemStyle: {
              normal: {
                barBorderRadius: 5,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: "rgba(156,107,211,0.5)" },
                  { offset: 0.2, color: "rgba(156,107,211,0.3)" },
                  { offset: 1, color: "rgba(156,107,211,0)" }
                ])
              }
            },
            z: -12,

            // data: lineData
            data: this.closeContact
          }
        ]
      };
      var app = {
        currentIndex: -1
      };
      setInterval(function() {
        var dataLen = option.series[0].data.length;

        // 取消之前高亮的图形
        myChart.dispatchAction({
          type: "downplay",
          seriesIndex: 0,
          dataIndex: app.currentIndex
        });
        app.currentIndex = (app.currentIndex + 1) % dataLen;
        //console.log(app.currentIndex);
        // 高亮当前图形
        myChart.dispatchAction({
          type: "highlight",
          seriesIndex: 0,
          dataIndex: app.currentIndex,
          // color: "#000000"
        });
        // 显示 tooltip
        myChart.dispatchAction({
          type: "showTip",
          seriesIndex: 0,
          dataIndex: app.currentIndex,
          // color: "#000000"
        });
      }, 3000);
      if (option && typeof option === "object") {
        myChart.setOption(option, true);
      }
      window.onresize = function() {
        myChart.resize();
      };
    }
     
 
    },
    watch: {},
    created() {
    }
  }
</script>

<!-- <style>
  .multipleXAxes1 {
    color: #000000   
  }
  
</style> -->
