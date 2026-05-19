import request from '@/utils/request'

export function listEquipment(query) {
  return request({
    url: '/system/equipment/userList',
    method: 'get',
    params: query
  })
}

export function getEquipment(equipmentId) {
  return request({
    url: '/system/equipment/userDetail/' + equipmentId,
    method: 'get'
  })
}

export function listCategory(query) {
  return request({
    url: '/system/category/userList',
    method: 'get',
    params: query
  })
}

export function getCategoryTree() {
  return request({
    url: '/system/category/treeselect',
    method: 'get'
  })
}
