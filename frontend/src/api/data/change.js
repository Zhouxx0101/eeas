import request from '@/utils/request'

// 查询病例变化数据列表
export function listChange(query) {
  return request({
    url: '/data/change/list',
    method: 'get',
    params: query
  })
}

// 查询病例变化数据详细
export function getChange(id) {
  return request({
    url: '/data/change/' + id,
    method: 'get'
  })
}

// 新增病例变化数据
export function addChange(data) {
  return request({
    url: '/data/change',
    method: 'post',
    data: data
  })
}

// 修改病例变化数据
export function updateChange(data) {
  return request({
    url: '/data/change',
    method: 'put',
    data: data
  })
}

// 删除病例变化数据
export function delChange(id) {
  return request({
    url: '/data/change/' + id,
    method: 'delete'
  })
}

// 查询每日新增和确诊数
export function getIncreaseAndDiagnosis(query) {
  return request({
    url: '/data/change/increaseAndDiagnosis',
    method: 'get',
    params: query
  })
}

// 查询每日密切接触者人数和正在接受医学观察人数
export function getCloseContactAndMedicalObservation(query) {
  return request({
    url: '/data/change/closeContactAndMedicalObservation',
    method: 'get',
    params: query
  })
}
