import request from '@/utils/request'

export function addOrder(data) {
  return request({
    url: '/system/resOrder/userAdd',
    method: 'post',
    data: data
  })
}

export function getMyProfile() {
  return request({
    url: '/system/resOrder/myProfile',
    method: 'get'
  })
}

export function myOrderList(query) {
  return request({
    url: '/system/resOrder/myList',
    method: 'get',
    params: query
  })
}

export function getOrderDetail(orderId) {
  return request({
    url: '/system/resOrder/userDetail/' + orderId,
    method: 'get'
  })
}

export function cancelOrder(orderId) {
  return request({
    url: '/system/resOrder/cancel/' + orderId,
    method: 'put'
  })
}

export function initiateReturn(orderId) {
  return request({
    url: '/system/resOrder/initiateReturn/' + orderId,
    method: 'put'
  })
}
