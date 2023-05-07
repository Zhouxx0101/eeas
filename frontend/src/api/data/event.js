import request from '@/utils/request'

// 查询风险区域列表
export function listArea(query) {
  return request({
    url: '/data/event/area/' + query,
    method: 'get'
  })
}

// 查询事件数据列表
export function listEvent(query) {
  return request({
    url: '/data/event/list',
    method: 'get',
    params: query
  })
}

// 查询事件数据详细
export function getEvent(id) {
  return request({
    url: '/data/event/' + id,
    method: 'get',
  })
}

// 新增事件数据
export function addEvent(data) {
  return request({
    url: '/data/event',
    method: 'post',
    data: data
  })
}

// 修改事件数据
export function updateEvent(data) {
  return request({
    url: '/data/event',
    method: 'put',
    data: data
  })
}

// 删除事件数据
export function delEvent(id) {
  return request({
    url: '/data/event/' + id,
    method: 'delete'
  })
}

// 根据日期以及任务ID查询封控/患者经过/both列表
export function getByDateAndTaskId(date,taskId) {
  return request({
    url: '/data/event/getByDate/' + date +"/" + taskId,
    method: 'get',
  })
}

// 根据日期以及任务ID查询不同集群下的地区列表，具有相同聚类值的地点为同一个集群
export function getClusterByDateAndTaskId(date,taskId) {
  return request({
    url: '/data/event/getClusterByDate/' + date +"/" + taskId,
    method: 'get',
  })
}

// 根据日期查询封控小区预测数据
export function getPredictionDataByDate(date) {
  return request({
    url: '/data/event/getPredictionDataByDate/' + date,
    method: 'get',
  })
}

// 查询时间列表
export function getTimeList() {
  return request({
    url: '/data/event/time',
    method: 'get',
  })
}
