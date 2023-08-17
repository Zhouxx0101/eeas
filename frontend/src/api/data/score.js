import request from '@/utils/request'

// 根据日期以及任务ID查询注意力分数数据
export function getScore(date, taskId) {
    return request({
      url: '/data/score/list/' + date + '/' + taskId,
      method: 'get'
    })
  }

  
// 获取某个节点的热力图分数
  export function getHeatmapDataOfCertainPlace(date, taskId,place,table) {
    return request({
      url: '/data/score/listScore/' + date + '/' + taskId +'/'+place+'/'+table,
      method: 'get'
    })
  }

  // 获取前几十热力图高的节点
  export function getTopXXPlaces(date, taskId,place,table) {
    return request({
      url: '/data/score/listTopXXPlaces/' + date + '/' + taskId +'/'+place+'/'+table,
      method: 'get'
    })
  }
