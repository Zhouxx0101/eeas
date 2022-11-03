<template>
  <div>
    <div ref="chart" style="width:50%;height:376px"></div>
    <!-- <div ref="chart1" style="width:50%;height:376px"></div> -->
    <div ref="chart1" style="width:60%;height:576px"></div>
  </div>

</template>

<script>
export default {
  name: "Datapredict",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 疫情演化数据表格数据
      datapredictList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        predictTime: null,
        increase: null,
        diagnosis: null,
        cure: null,
        dead: null,
        closeContact: null,
        medicalObservation: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    };
  },
  mounted() {
    this.getEchartData
    this.getEchartData1
  },
  methods: {
    getEchartData() {
        const chart = this.$refs.chart
        if (chart) {
          const myChart = this.$echarts.init(chart)
          const option = { legend: {},
            tooltip: {},
            dataset: {
              source: [
                [this.changeList[0].endTime,1,1],
                ['订单', 43.3, 85.8],
                ['订单1', 83.1, 73.4],
                ['订单2', 86.4, 65.2],
                ['订单3', 72.4, 53.9],
                ['订单4', 82.4, 53.9],
                ['订单5', 42.4, 53.9],
                ['订单6', 72.4, 53.9],
                ['订单7', 72.4, 53.9]
              ]
            },
            xAxis: { type: 'category' },
            yAxis: {},

            series: [ { type: 'bar' }, { type: 'bar' }]}
          myChart.setOption(option)
          window.addEventListener("resize", function() {
            myChart.resize()
          })
        }
        this.$on('hook:destroyed',()=>{
          window.removeEventListener("resize", function() {
            myChart.resize();
          });
        })
      },
    getEchartData1() {
        const chart1 = this.$refs.chart1
        if (chart1) {
          const myChart = this.$echarts.init(chart1)
          const option = {
            title: {
              text: 'Stacked Line'
            },
            tooltip: {
              trigger: 'axis'
            },
            legend: {
              data: ['Email', 'Union Ads', 'Video Ads', 'Direct', 'Search Engine']
            },
            
            grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
            },
            toolbox: {
              feature: {
                saveAsImage: {}
              }
            },
            xAxis: {
              type: 'category',
              boundaryGap: false,
              data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月','八月','九月','十月','十一月','十二月']
            },
            yAxis: {
              type: 'value'
            },
            series: [
              {
                name: 'Email',
                type: 'line',
                stack: 'Total',
                symbolSize: 8,
                symbol: 'circle',
                smooth: true,
                lineStyle: {
                  width: 1,
                  shadowColor: 'rgba(0,0,0,0.3)',
                  shadowBlur: 10,
                  shadowOffsetY: 8
                },
                data: [120, 132, 101, 134, 90, 230, 210,120, 132, 101, 134, 90, 230]
              },
              {
                name: 'Union Ads',
                type: 'line',
                stack: 'Total',
                symbolSize: 8,
                symbol: 'circle',
                smooth: true,
                lineStyle: {
                  width: 3,
                  shadowColor: 'rgba(0,0,0,0.3)',
                  shadowBlur: 5,
                  shadowOffsetY: 8
                },
                data: [220, 182, 191, 234, 290, 330, 310,220, 182, 191, 234, 290, 330]
              },
              {
                name: 'Video Ads',
                type: 'line',
                stack: 'Total',
                symbolSize: 8,
                symbol: 'circle',
                smooth: true,
                lineStyle: {
                  width: 3,
                  shadowColor: 'rgba(0,0,0,0.3)',
                  shadowBlur: 5,
                  shadowOffsetY: 8
                },
                data: [150, 232, 201, 154, 190, 330, 410,150, 232, 201, 154, 190, 330]
              },
              {
                name: 'Direct',
                type: 'line',
                stack: 'Total',
                symbolSize: 8,
                symbol: 'circle',
                smooth: true,
                lineStyle: {
                  width: 3,
                  shadowColor: 'rgba(0,0,0,0.3)',
                  shadowBlur: 5,
                  shadowOffsetY: 8
                },
                data: [320, 332, 301, 334, 390, 330, 320,320, 332, 301, 334, 390, 330]
              },
              {
                name: 'Search Engine',
                type: 'line',
                stack: 'Total',
                symbolSize: 10,

                smooth: true,
                lineStyle: {
                  width: 3,
                  shadowColor: 'rgba(0,0,0,0.3)',
                  shadowBlur: 6,
                  shadowOffsetY: 8
                },
                data: [820, 932, 901, 934, 1290, 1330, 1320,820, 932, 901, 934, 1290, 1330]
              }
            ]

          }
          myChart.setOption(option)
          window.addEventListener("resize", function() {
            myChart.resize()
          })
        }
        this.$on('hook:destroyed',()=>{
          window.removeEventListener("resize", function() {
            myChart.resize();
          });
        })
    },
  }
};
</script>
