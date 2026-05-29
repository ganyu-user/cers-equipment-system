import request from '@/utils/request'

export function getMsgList(query) {
  return request({
    url: '/system/msg/myList',
    method: 'get',
    params: query
  })
}

export function getUnreadCount() {
  return request({
    url: '/system/msg/unreadCount',
    method: 'get'
  })
}

export function readMsgs(msgIds) {
  return request({
    url: '/system/msg/read',
    method: 'put',
    data: msgIds
  })
}

export function readAllMsgs() {
  return request({
    url: '/system/msg/readAll',
    method: 'put'
  })
}