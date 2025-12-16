import request from '@/utils/request'

// 用户登录
export function login(data) {
  return request({
    url: '/api/user/login',
    method: 'post',
    data
  })
}

// 用户注册
export function register(data) {
  return request({
    url: '/api/user/register',
    method: 'post',
    data
  })
}

// 获取当前用户信息
export function getCurrentUser() {
  return request({
    url: '/api/user/current',
    method: 'get'
  })
}

// 更新用户信息
export function updateUser(data) {
  return request({
    url: '/api/user/update',
    method: 'put',
    data
  })
}

// 修改密码
export function changePassword(data) {
  return request({
    url: '/api/user/password',
    method: 'put',
    data
  })
}

export function updatePassword(data) {
  return request({
    url: '/api/user/updatePassword',
    method: 'post',
    data
  })
} 