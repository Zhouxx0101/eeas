<template>

    <div class="myDiv">
        <div id="viz"></div>
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
      created() {
        window.myData = this;//将变量全局化,这样浏览器可以查看当前data是什么情况::myData._data
      },
      mounted() {
        this.draw();
      },
      methods: {
        
        draw () {
          // config 配置项
          var config = {
            container_id: 'viz', //dom元素id
            // neo4j服务器地址，用户名 和 密码
            server_url: 'bolt://localhost:7687', //连接的地址是端口号为7687的不是7474
            server_user: 'neo4j',
            server_password: 'SYXsyx03040304',
    
            // labels是节点样式的配置
            // 没有在这个地方配置的节点将会是默认样式
            labels: {
                "Node": { caption: "name", community: "#5496FF", size: 200, font: { size: 35, color: "#606266", }, },
              // 候選人: {
              //   caption: '候選人',  // 节点显示的文字对应内容key
              //   community: 'community', //节点颜色 String：要用作社区（color）的属性名。默认为“按标签着色”。
              //   size: 'pagerank',  // 用作节点大小的属性名。默认为1。
              //   // image: 'https://visjs.org/images/visjs_logo.png',
              //   // 节点字体大小设置
              //   font: { size: 15, color: '#871F78' },
              //   title_properties: ['age'], //如果提供了title_properties，则工具提示中将只显示其中列出的属性。否则，所有属性都显示在工具提示中。
              //   // sizeCypher: "MATCH (n:`县市`) RETURN n LIMIT 25" //获取节点大小的Cypher查询。$id表示要查询大小的节点的id，Cypher查询应该返回Neo4jNumber。config.labels.sizeCypher的优先级高于config.labels.size，即sizeCypher将覆盖size字段的结果大小。
              // },
              // 县市: {
              //   caption: 'name',
              //   community: 'community',
              //   // group: 'community',
              //   size: 'pagerank',
              //   // image: 'https://visjs.org/images/visjs_logo.png',
              //   font: { size: 14, color: '#606266' },
              // },
            //   事件: {
            //     caption: '事件',
            //     // community: 'community',
            //     // community: '#606266',
            //     community: '縣市',
            //     color: "#871F78",
            //     group: '縣市',
            //     [NeoVis.NEOVIS_ADVANCED_CONFIG]: {
            //       function: {
            //       // **this causes error!**
            //         // color: (node) => (node.properties.縣市 === '臺北市' ? "white" : "black"),
            //         color: "green"
            //       },
            //     },
            //     size: 'pagerank',
            //     // image: 'https://visjs.org/images/visjs_logo.png',
            //     font: { size: 14, color: '#606266' },
            //     // sizeCypher: "MATCH (n:`事件`) RETURN n LIMIT 30"
            //   }
            },
            // relationships是关系线段样式的配置
            // 没有在这个地方配置的线段将会是默认样式
            relationships: {
            //   先于: { 
            //     // color: "green",
            //     // [NEOVIS_ADVANCED_CONFIG]: {
            //     //   static: {
            //     //       label: "Text on edge", 
            //     //       color: "#FF1CAE",
            //     //       font: {
            //     //           "background": "none",
            //     //           "strokeWidth": "0",
            //     //           "size": 20,
            //     //           "color": "#f9dc73"
            //     //       }
            //     //   }
            //     // }
            //     // color: {color: '#FF1CAE'},
            //     thickness: 'weight',  //String：线段粗细，用作边缘厚度的属性名。默认为1。
            //     caption: false,  //Boolean：如果设置为true，则关系类型将显示为边缘标题。或String：用作边缘标题的属性名。
            //     font: { size: 12, color: '#871F78' },  // 关系节点文字大小颜色
            //     edges: {color: 'red'},
            //     inherit:false,
            //     // line: { color: "#871F78" },
            //     // [NeoVis.NEOVIS_ADVANCED_CONFIG]: {
            //     //   static: {
            //     //     // label: "XXXXXX",     //content on edge
            //     //     color: "#871F78",   //edge color
            //     //     font: {
            //     //       "background": "none",
            //     //       "strokeWidth": "0",
            //     //       "size": 20,
            //     //       "color": "#FF1CAE"  //font color on edge
            //     //     }
            //     //   }
            //     // }
            //     color: 'red',
            //   },
              连接: { 
                thickness: 'weight', 
                caption: false, 
                // caption: false, 
                font: { size: 12, color: '#FF1CAE' } 
              }
            },
            // edges:{
            //   color: {
            //     highlight:'#848484',
            //     hover: '#d3d2cd',
            //     inherit: false,
            //     opacity:1.0
            //   }
            // },
    
            // 关系线段是否显示箭头
            arrows: true,
    
            hierarchical: false, // 节点显示方式 是否启用分层布局后
            // 分层结构或者默认 "hubsize"（默认）和"directed".
            hierarchical_sort_method: 'directed',
            encrypted: 'ENCRYPTION_OFF', // "ENCRYPTION_OFF" (default) or "ENCRYPTION_ON"
            trust: 'TRUST_ALL_CERTIFICATES', // "TRUST_ALL_CERTIFICATES" (default) or "TRUST_SYSTEM_CA_SIGNED_CERTIFICATES"
            // 配置数据库查询语句, 替换成自己的查询语句才可以显示
            // initial_cypher: 'MATCH p=()-[r:`先于`]->() RETURN p LIMIT 25'
            // initial_cypher: 'MATCH p=()-[r:`同城市`]->() RETURN p LIMIT 25'
            // initial_cypher: 'MATCH (n:`事件`) RETURN n LIMIT 25'
            initial_cypher: 'MATCH p=()-->() RETURN p limit 300',  // *
            // initial_cypher: 'MATCH p=()-->() RETURN p limit 30',
            // initial_cypher: 'MATCH p=(a:`候選人`{name: "蔡英文"})-->(n:`事件`)-[]->(m:`事件`) RETURN p limit 200',
            // initial_cypher: 'MATCH p=(n:`事件`{候選人: "蔡英文", 月份: "十一月", 縣市: "臺北市"})-[]->(m:`事件`) RETURN p limit 300',
            // initial_cypher: 'MATCH (a)--() RETURN a limit 25',
            // initial_cypher: 'MATCH (a)-[r]-(b) RETURN a,r,b limit 25',
            // initial_cypher: 'MATCH p=()-[r:`先于`]->() RETURN p LIMIT 100 union MATCH p=()-[r:`同城市`]->() RETURN p LIMIT 100'
          }
      
          this.viz = new NeoVis(config)
          this.viz.render() // 渲染
          // 注册点击事件，点击后执行函数 在nodeClick(自己编写的函数)函数中实现，如果不需要点击节点触发功能，则此方法省略
          this.viz.registerOnEvent('clickNode', this.nodeClick)
    
        },
      },
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