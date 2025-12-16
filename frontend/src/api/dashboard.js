import request from '@/utils/request'

export function getStatistics() {
  return request({
    url: '/api/dashboard/statistics',
    method: 'get'
  })
} 