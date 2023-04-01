import request from '@/utils/request'

// 查询封控小区预测数据列表
export function listPredictionData(query) {
  return request({
    url: '/event/predictionData/list',
    method: 'get',
    params: query
  })
}

// 查询封控小区预测数据详细
export function getPredictionData(id) {
  return request({
    url: '/event/predictionData/' + id,
    method: 'get'
  })
}

// 根据日期以及任务ID查询封控小区预测数据
export function getPredictionDataByDateAndTaskId(date,taskId) {
  return request({
    url: '/event/predictionData/query/' + date +'/'+taskId,
    method: 'get'
  })
}

// 新增封控小区预测数据
export function addPredictionData(data) {
  return request({
    url: '/event/predictionData',
    method: 'post',
    data: data
  })
}

// 修改封控小区预测数据
export function updatePredictionData(data) {
  return request({
    url: '/event/predictionData',
    method: 'put',
    data: data
  })
}

// 删除封控小区预测数据
export function delPredictionData(id) {
  return request({
    url: '/event/predictionData/' + id,
    method: 'delete'
  })
}
