import request from '@/utils/request'

// 根据日期以及任务ID查询注意力分数数据
export function getScore(date, taskId) {
    return request({
      url: '/data/score/list/' + date + '/' + taskId,
      method: 'get'
    })
  }