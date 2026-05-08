import request from '@/utils/request'

// 查询设备预约单管理列表
export function listReserveOrder(query) {
  return request({
    url: '/system/reserveOrder/list',
    method: 'get',
    params: query
  })
}

// 查询设备预约单管理详细
export function getReserveOrder(orderId) {
  return request({
    url: '/system/reserveOrder/' + orderId,
    method: 'get'
  })
}

// 新增设备预约单管理
export function addReserveOrder(data) {
  return request({
    url: '/system/reserveOrder',
    method: 'post',
    data: data
  })
}

// 修改设备预约单管理
export function updateReserveOrder(data) {
  return request({
    url: '/system/reserveOrder',
    method: 'put',
    data: data
  })
}

// 删除设备预约单管理
export function delReserveOrder(orderId) {
  return request({
    url: '/system/reserveOrder/' + orderId,
    method: 'delete'
  })
}
