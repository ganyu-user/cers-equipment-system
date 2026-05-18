import request from '@/utils/request'

// 查询预约订单列表
export function listResOrder(query) {
  return request({
    url: '/system/resOrder/list',
    method: 'get',
    params: query
  })
}

// 查询我的预约订单
export function myResOrderList(query) {
  return request({
    url: '/system/resOrder/myList',
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

// 审批通过
export function approveOrder(orderId) {
  return request({
    url: '/system/resOrder/approve/' + orderId,
    method: 'put'
  })
}

// 审批拒绝
export function rejectOrder(orderId, rejectReason) {
  return request({
    url: '/system/resOrder/reject/' + orderId,
    method: 'put',
    data: { rejectReason }
  })
}

// 归还设备
export function returnOrder(orderId, returnStatus) {
  return request({
    url: '/system/resOrder/return/' + orderId,
    method: 'put',
    data: { returnStatus }
  })
}