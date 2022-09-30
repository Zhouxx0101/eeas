import request from '@/utils/request'

// 查询新闻数据列表
export function listNews(query) {
  return request({
    url: '/data/news/list',
    method: 'get',
    params: query
  })
}

// 查询新闻数据详细
export function getNews(id) {
  return request({
    url: '/data/news/' + id,
    method: 'get'
  })
}

// 新增新闻数据
export function addNews(data) {
  return request({
    url: '/data/news',
    method: 'post',
    data: data
  })
}

// 修改新闻数据
export function updateNews(data) {
  return request({
    url: '/data/news',
    method: 'put',
    data: data
  })
}

// 删除新闻数据
export function delNews(id) {
  return request({
    url: '/data/news/' + id,
    method: 'delete'
  })
}
