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
