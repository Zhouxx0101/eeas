## 项目运行

```bash
# 克隆项目
git clone https://gitee.com/y_project/RuoYi-Vue

# 进入项目目录
cd ruoyi-ui

# 安装依赖
npm install

# 建议不要直接使用 cnpm 安装依赖，会有各种诡异的 bug。可以通过如下操作解决 npm 下载速度慢的问题
npm install --registry=https://registry.npmmirror.com

# 启动服务
npm run dev
```

浏览器访问 http://localhost:80

## 发布

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod

```
## 前端页面记录：
/fronted/src/views/下：
diagram:时序交互图（真实数据）
prediction:预测时序交互图
heatmap:热力图

## TODO：
在时序交互图界面已经有了任务信息，后续页面切换时都不需要再去后端拿，只需要前端页面传递就行
梳理预测页面数据显示逻辑
热力图页面编写