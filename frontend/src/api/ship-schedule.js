import request from '@/utils/request'

// 获取调度列表
export function getScheduleList(params) {
  return request({
    url: '/api/ship-schedules/page',
    method: 'get',
    params
  })
}

// 添加调度
export function addSchedule(data) {
  return request({
    url: '/api/ship-schedules/add',
    method: 'post',
    data
  })
}

// 更新调度
export function updateSchedule(data) {
  return request({
    url: '/api/ship-schedules/update',
    method: 'put',
    data
  })
}

// 删除调度
export function deleteSchedule(id) {
  return request({
    url: `/api/ship-schedules/${id}`,
    method: 'delete'
  })
}

// 获取调度详情
export function getScheduleDetail(id) {
  return request({
    url: `/api/ship-schedules/${id}`,
    method: 'get'
  })
}

// 获取船舶列表
export function getShipList() {
  return request({
    url: '/api/ships/page',
    method: 'get'
  })
}

// 获取调度统计数据
export function getScheduleStats() {
  return request({
    url: '/api/ship-schedules/stats',
    method: 'get'
  })
}

// 获取智能航线推荐
export function getRouteRecommendation(params) {
  return request({
    url: '/api/routes/route-recommendation',
    method: 'get',
    params: {
      startPort: params.startPort,
      endPort: params.endPort
    }
  })
}

// 获取所有港口列表
export function getPortList() {
  return request({
    url: '/api/routes/ports',
    method: 'get'
  })
}

// 获取航线列表
export function getRouteList() {
  return request({
    url: '/api/routes/all',
    method: 'get'
  })
} 