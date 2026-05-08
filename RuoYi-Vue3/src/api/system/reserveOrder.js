import request from '@/utils/request'

// 查询预约订单列表
export function listResOrder(query) {
  return request({
    url: '/system/resOrder/list',
    method: 'get',
    params: query
  })
}

// 查询预约订单详细
export function getResOrder(orderId) {
  return request({
    url: '/system/resOrder/' + orderId,
    method: 'get'
  })
}

// 新增预约订单
export function addResOrder(data) {
  return request({
    url: '/system/resOrder',
    method: 'post',
    data: data
  })
}

// 修改预约订单
export function updateResOrder(data) {
  return request({
    url: '/system/resOrder',
    method: 'put',
    data: data
  })
}

// 删除预约订单
export function delResOrder(orderId) {
  return request({
    url: '/system/resOrder/' + orderId,
    method: 'delete'
  })
}
