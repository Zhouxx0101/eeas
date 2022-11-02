import request from '@/utils/request'

// 查询事件数据列表
export function listArea() {
    return request({
        url: '/area/list',
        method: 'get'
    })
}