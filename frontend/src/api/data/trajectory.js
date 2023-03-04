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

// 查询1日内轨迹数据
export function get1() {
  return request({
    url: '/data/trajectory/get1',
    method: 'get',
    //params: query
  })
}

// 查询1日至7日轨迹数据
export function get1To7() {
  return request({
    url: '/data/trajectory/get1To7',
    method: 'get',
    //params: query
  })
}

// 查询7日至14日轨迹数据
export function get7To14() {
  return request({
    url: '/data/trajectory/get7To14',
    method: 'get',
    //params: query
  })
}

// 查询14日以上轨迹数据
export function get14() {
  return request({
    url: '/data/trajectory/get14',
    method: 'get',
    //params: query
  })
}
