import request from '@/utils/request'

// 查询患者数据列表
export function listPatient(query) {
  return request({
    url: '/data/patient/list',
    method: 'get',
    params: query
  })
}

// 查询患者数据详细
export function getPatient(id) {
  return request({
    url: '/data/patient/' + id,
    method: 'get'
  })
}

// 新增患者数据
export function addPatient(data) {
  return request({
    url: '/data/patient',
    method: 'post',
    data: data
  })
}

// 修改患者数据
export function updatePatient(data) {
  return request({
    url: '/data/patient',
    method: 'put',
    data: data
  })
}

// 删除患者数据
export function delPatient(id) {
  return request({
    url: '/data/patient/' + id,
    method: 'delete'
  })
}
