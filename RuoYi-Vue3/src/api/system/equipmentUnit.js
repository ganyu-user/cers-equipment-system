import request from '@/utils/request'

export function listEquipmentUnit(query) {
  return request({
    url: '/system/equipment/unit/list',
    method: 'get',
    params: query
  })
}

export function updateEquipmentUnit(data) {
  return request({
    url: '/system/equipment/unit',
    method: 'put',
    data: data
  })
}

export function batchUpdateEquipmentUnit(data) {
  return request({
    url: '/system/equipment/unit/batch',
    method: 'put',
    data: data
  })
}