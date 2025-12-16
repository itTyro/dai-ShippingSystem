import request from '@/utils/request'

// 获取货物列表
export function getCargoList(params) {
  return request({
    url: '/api/cargo/page',
    method: 'get',
    params
  })
}

// 添加货物
export function addCargo(data) {
  return request({
    url: '/api/cargo',
    method: 'post',
    data
  })
}

// 更新货物
export function updateCargo(data) {
  return request({
    url: '/api/cargo',
    method: 'put',
    data
  })
}

// 删除货物
export function deleteCargo(id) {
  return request({
    url: `/api/cargo/${id}`,
    method: 'delete'
  })
}

// 获取货物详情
export function getCargoDetail(id) {
  return request({
    url: `/api/cargo/${id}`,
    method: 'get'
  })
} 