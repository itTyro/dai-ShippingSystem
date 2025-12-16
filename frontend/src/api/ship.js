import request from '@/utils/request'

// 获取船舶列表
export function getShipList(params) {
  return request({
    url: '/api/ships/page',
    method: 'get',
    params
  })
}

// 添加船舶
export function addShip(data) {
  return request({
    url: '/api/ships',
    method: 'post',
    data
  })
}

// 更新船舶
export function updateShip(data) {
  return request({
    url: '/api/ships',
    method: 'put',
    data
  })
}

// 删除船舶
export function deleteShip(id) {
  return request({
    url: `/api/ships/${id}`,
    method: 'delete'
  })
}

// 获取船舶详情
export function getShipDetail(id) {
  return request({
    url: `/api/ships/${id}`,
    method: 'get'
  })
} 