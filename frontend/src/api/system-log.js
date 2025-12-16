import request from '@/utils/request'

export function getLogList(params) {
  return request({
    url: '/api/system/log/page',
    method: 'get',
    params
  })
} 