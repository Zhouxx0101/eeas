<template>

<div style="height:100%;" ref="Screen">
    <div class="left" id="viz1" ref="viz1"></div>
 </div> 

  </template>
  
  <script >
    // import NeoVis, {NEOVIS_ADVANCED_CONFIG} from 'neovis.js/dist/neovis.js';
    import NeoVis from 'neovis.js';

      
    export default {
      data() {
        return {
          viz: {} //定义一个viz对象
        };
      },
      mounted() {
     this.draw();
    },
    //neovis.js画图
    methods:{
     draw() {
       //获取dom元素
      var viz1 = this.$refs.viz1;
      
      //创建veovis实例
      var viz;
      
      //配置项
      var config = {
        container_id: "viz",
        //neo4j服务器地址，用户名 和 密码
        server_url: "bolt://localhost:7687",
        server_user: "neo4j",
        server_password: "SYXsyx03040304",

        ///labels是节点央样式的配置：**
        /// caption ：节点显示的文字对应内容
        /// community： 节点颜色**
        /// size：节点大小**
        /// font：节点字体大小设置****
        //没有在这个地方配置的节点将会是默认样式**
        labels: {
          "Node": { caption: "name", community: "#5496FF", size: 200, font: { size: 35, color: "#606266", }, },
          // "基本待遇政策": { caption: "name", community: "#5496FF", size: 95, font: { size: 25, color: "#606266", } },
          // "基本筹资政策": { caption: "name", community: "#5496FF", size: 95, font: { size: 25, color: "#606266", }, },
        },
        
        ///relationships是关系线段样式的配置：**
        /// caption ：线段显示的文字对应内容
        /// thickness： 线段粗细**
        /// font：节点字体大小设置****
        //没有在这个地方配置的线段将会是默认样式**
        relationships: {
          "连接": { thickness: 1, caption: true, font: { size: 15, color: "#606266", }, },
          // "待遇主体类别": { thickness: "count", caption: true, font: { size: 15, color: "#606266", }, },
        },
        
        //是否显示箭头
        arrows: true,

        hierarchical: true,
        
        // 分层结构或者默认 "hubsize"（默认）和"directed".
        // hierarchical_sort_method: 'hubsize',
        hierarchical_sort_method: 'directed',

        //配置数据库查询语句，MATCH n RETURN n,尝试过不对，必须用 MATCH p=()-->() RETURN p
        initial_cypher: 'MATCH p=()-->() RETURN p',
      };

      viz = new NeoVis(config);
      viz._container = viz1;
      viz.render();
     },
    }

    };
      
  </script>
  
  <style scoped>
  .myDiv {
      width: 100%;
      height: 853px;
  }
  #viz {
      width: 100%;
      height: 100%;
      border: 1px solid #f1f3f4;
      font: 22pt arial;
  }
  </style>