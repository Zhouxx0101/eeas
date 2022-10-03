import request from '@/utils/request'

// 查询轨迹数据列表
export function listTrajectory(query) {
  return request({
    url: '/data/trajectory/list',
    method: 'get',
    params: query
  })
}

// 查询轨迹数据详细
export function getTrajectory(id) {
  return request({
    url: '/data/trajectory/' + id,
    method: 'get'
  })
}

// 新增轨迹数据
export function addTrajectory(data) {
  return request({
    url: '/data/trajectory',
    method: 'post',
    data: data
  })
}

// 修改轨迹数据
export function updateTrajectory(data) {
  return request({
    url: '/data/trajectory',
    method: 'put',
    data: data
  })
}

// 删除轨迹数据
export function delTrajectory(id) {
  return request({
    url: '/data/trajectory/' + id,
    method: 'delete'
  })
}
