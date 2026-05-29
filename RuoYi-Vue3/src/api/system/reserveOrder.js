import request from '@/utils/request'

export function listResOrder(query) {
  return request({
    url: '/system/resOrder/list',
    method: 'get',
    params: query
  })
}

export function myResOrderList(query) {
  return request({
    url: '/system/resOrder/myList',
    method: 'get',
    params: query
  })
}

export function getResOrder(orderId) {
  return request({
    url: '/system/resOrder/' + orderId,
    method: 'get'
  })
}

export function addResOrder(data) {
  return request({
    url: '/system/resOrder',
    method: 'post',
    data: data
  })
}

export function updateResOrder(data) {
  return request({
    url: '/system/resOrder',
    method: 'put',
    data: data
  })
}

export function delResOrder(orderId) {
  return request({
    url: '/system/resOrder/' + orderId,
    method: 'delete'
  })
}

export function approveOrder(orderId) {
  return request({
    url: '/system/resOrder/approve/' + orderId,
    method: 'put'
  })
}

export function rejectOrder(orderId, rejectReason) {
  return request({
    url: '/system/resOrder/reject/' + orderId,
    method: 'put',
    data: { rejectReason }
  })
}

export function returnOrder(orderId, returnStatus) {
  return request({
    url: '/system/resOrder/return/' + orderId,
    method: 'put',
    data: { returnStatus }
  })
}

export function initiateReturn(orderId) {
  return request({
    url: '/system/resOrder/initiateReturn/' + orderId,
    method: 'put'
  })
}

export function verifyReturn(orderId, verifyDetails) {
  return request({
    url: '/system/resOrder/verifyReturn/' + orderId,
    method: 'put',
    data: { verifyDetails }
  })
}

export function getReturnDetail(orderId) {
  return request({
    url: '/system/resOrder/returnDetail/' + orderId,
    method: 'get'
  })
}

export function urgeReturn(orderId) {
  return request({
    url: '/system/resOrder/urgeReturn/' + orderId,
    method: 'put'
  })
}
