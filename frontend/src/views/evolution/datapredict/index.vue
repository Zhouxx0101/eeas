<template>
  <div>
    <div ref="chart1" style="width:100%;height:699px"></div>
  </div>

</template>

<script>
import { listDatapredict } from "@/api/evolution/datapredict";

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
      Xdata: [],
      Ydata: [],
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
  watch: {
    changeList() {
      this.$nextTick(() => {
        //此时就可以获取到在created赋值后的dataList了
      })
    }
  },
  created() {
  },
  mounted() {
    this.getList();
    setTimeout(this.getEchartData1, 300)
  },
  methods: {
    /** 查询疫情演化数据列表 */
    getList() {
      this.loading = true;
      listDatapredict(this.queryParams).then(response => {
        this.datapredictList = response.rows;
        this.total = response.total;
        this.loading = false;
        var temp_Y1 = [];
        var temp_Y2 = [];
        var temp_Y3 = [];
        var temp_Y4 = [];
        var temp_Y5 = [];
        for (let i = 0; i < this.total; i++) {
          this.Xdata.push(this.datapredictList[i].predictTime)
          temp_Y1.push(this.datapredictList[i].increase)
          temp_Y2.push(this.datapredictList[i].diagnosis)
          temp_Y3.push(this.datapredictList[i].cure)
          temp_Y4.push(this.datapredictList[i].dead)
          temp_Y5.push(this.datapredictList[i].medicalObservation)
          console.log(this.total)
        }
        this.Ydata.push(temp_Y1);
        this.Ydata.push(temp_Y2);
        this.Ydata.push(temp_Y3);
        this.Ydata.push(temp_Y4);
        this.Ydata.push(temp_Y5);
      });
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
            data: ['increase', 'diagnosis', 'cure', 'dead', 'medicalObservation']
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
            data: this.Xdata
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              name: 'increase',
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
              data: this.Ydata[0]
            },
            {
              name: 'diagnosis',
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
              data: this.Ydata[1]
            },
            {
              name: 'cure',
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
              data: this.Ydata[2]
            },
            {
              name: 'dead',
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
              data: this.Ydata[3]
            },
            {
              name: 'medicalObservation',
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
              data: this.Ydata[4]
            }
          ]

        }
        myChart.setOption(option)
        window.addEventListener("resize", function () {
          myChart.resize()
        })
      }
      this.$on('hook:destroyed', () => {
        window.removeEventListener("resize", function () {
          myChart.resize();
        });
      })
    },
  }
};
</script>
