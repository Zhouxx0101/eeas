import request from '@/utils/request'

// 查询疫情演化数据列表
export function listDatapredict(query) {
    return request({
        url: '/evolution/datapredict/list',
        method: 'get',
        params: query
    })
}

// 查询疫情演化数据详细

// 新增疫情演化数据

// 修改疫情演化数据

// 删除疫情演化数据