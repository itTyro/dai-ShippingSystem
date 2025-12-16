import request from '@/utils/request'

// 获取航行安全列表
export function getNavigationSafetyList(params) {
  return request({
    url: '/api/safety/page',
    method: 'get',
    params
  })
}

// 添加航行安全记录
export function addNavigationSafety(data) {
  return request({
    url: '/api/safety',
    method: 'post',
    data
  })
}

// 更新航行安全记录
export function updateNavigationSafety(data) {
  return request({
    url: '/api/safety',
    method: 'put',
    data
  })
}

// 删除航行安全记录
export function deleteNavigationSafety(id) {
  return request({
    url: `/api/safety/${id}`,
    method: 'delete'
  })
}

// 获取航行安全详情
export function getNavigationSafetyDetail(id) {
  return request({
    url: `/api/safety/${id}`,
    method: 'get'
  })
}

// 获取安全监控数据
export function getSafetyMonitorData(params) {
  return request({
    url: '/api/safety-monitor/stats',
    method: 'get',
    params
  })
}

// 更新安全监控状态
export function updateSafetyMonitorStatus(id, status) {
  return request({
    url: `/api/safety-monitor/devices/${id}/status/${status}`,
    method: 'put'
  })
} 