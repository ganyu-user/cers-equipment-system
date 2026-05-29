import request from '@/utils/request'

export function listMsg(query) {
  return request({
    url: '/system/msg/list',
    method: 'get',
    params: query
  })
}

export function getMsg(msgId) {
  return request({
    url: '/system/msg/' + msgId,
    method: 'get'
  })
}

export function addMsg(data) {
  return request({
    url: '/system/msg',
    method: 'post',
    data: data
  })
}

export function updateMsg(data) {
  return request({
    url: '/system/msg',
    method: 'put',
    data: data
  })
}

export function delMsg(msgId) {
  return request({
    url: '/system/msg/' + msgId,
    method: 'delete'
  })
}