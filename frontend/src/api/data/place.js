import request from '@/utils/request'

// 查询所有地点
export function getPlace() {
    return request({
      url: '/data/place/list/',
      method: 'get'
    })
  }