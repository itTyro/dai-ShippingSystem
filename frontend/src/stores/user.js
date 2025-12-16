import { defineStore } from 'pinia'
import { ref } from 'vue'
import { login, getCurrentUser } from '@/api/user'

export const useUserStore = defineStore('user', () => {
  const token = ref(localStorage.getItem('token') || '')
  const userInfo = ref(JSON.parse(localStorage.getItem('userInfo') || '{}'))
  const userType = ref(localStorage.getItem('userType') || '')

  // 登录
  async function loginAction(loginForm) {
    try {
      const res = await login(loginForm)
      if (res.code === 200) {
        token.value = res.data
        localStorage.setItem('token', res.data)
        
        // 解析token获取用户类型
        const tokenData = JSON.parse(atob(res.data.split('.')[1]))
        userType.value = tokenData.userType
        localStorage.setItem('userType', tokenData.userType)
        
        // 获取用户信息
        const userRes = await getCurrentUser()
        if (userRes.code === 200) {
          userInfo.value = userRes.data
          // 确保role字段与userType一致
          userInfo.value.role = tokenData.userType
          localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
        }
        
        return true
      }
      return false
    } catch (error) {
      return false
    }
  }

  // 登出
  function logoutAction() {
    token.value = ''
    userInfo.value = {}
    userType.value = ''
    localStorage.removeItem('token')
    localStorage.removeItem('userInfo')
    localStorage.removeItem('userType')
  }

  return {
    token,
    userInfo,
    userType,
    loginAction,
    logoutAction
  }
}) 