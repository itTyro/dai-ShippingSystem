import request from '@/utils/request'

// 获取船员列表
export function getCrewList(params) {
  return request({
    url: '/api/crew/page',
    method: 'get',
    params
  })
}

// 添加船员
export function addCrew(data) {
  return request({
    url: '/api/crew',
    method: 'post',
    data
  })
}

// 更新船员信息
export function updateCrew(data) {
  return request({
    url: '/api/crew',
    method: 'put',
    data
  })
}

// 删除船员
export function deleteCrew(id) {
  return request({
    url: `/api/crew/${id}`,
    method: 'delete'
  })
}

// 更新船员状态
export function updateCrewStatus(id, status) {
  return request({
    url: `/api/crew/${id}/status/${status}`,
    method: 'put'
  })
}

// 重置船员密码
export function resetCrewPassword(id) {
  return request({
    url: `/api/crew/${id}/reset-password`,
    method: 'put'
  })
}

// 获取船员详情
export function getCrewDetail(id) {
  return request({
    url: `/crew/detail/${id}`,
    method: 'get'
  })
} 