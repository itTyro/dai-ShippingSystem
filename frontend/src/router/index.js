import { createRouter, createWebHistory } from 'vue-router'

// 白名单路由
const whiteList = ['/login', '/register', '/404', '/403']

const routes = [
  {
    path: '/',
    redirect: '/home/dashboard'
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/login/index.vue'),
    meta: { title: '登录', requiresAuth: false }
  },
  {
    path: '/home',
    component: () => import('@/layout/index.vue'),
    redirect: '/home/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        meta: { title: '首页', icon: 'House', requiresAuth: true }
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('@/views/profile/index.vue'),
        meta: { title: '个人中心', icon: 'User', requiresAuth: true }
      },
      {
        path: 'crew',
        name: 'Crew',
        component: () => import('@/views/crew/index.vue'),
        meta: { title: '船员管理', icon: 'User', roles: ['ADMIN'], requiresAuth: true }
      },
      {
        path: 'navigation-safety',
        name: 'NavigationSafety',
        component: () => import('@/views/navigation-safety/index.vue'),
        meta: { title: '航行安全管理', icon: 'Ship', requiresAuth: true }
      },
      {
        path: 'ship',
        name: 'Ship',
        component: () => import('@/views/ship/index.vue'),
        meta: { title: '船舶信息管理', icon: 'Ship', requiresAuth: true }
      },
      {
        path: 'ship-schedule',
        name: 'ShipSchedule',
        component: () => import('@/views/ship-schedule/index.vue'),
        meta: { title: '船舶调度管理', icon: 'Operation', requiresAuth: true }
      },
      {
        path: 'cargo',
        name: 'Cargo',
        component: () => import('@/views/cargo/index.vue'),
        meta: { title: '航运货物管理', icon: 'Box', requiresAuth: true }
      },
      // {
      //   path: 'monitor',
      //   name: 'Monitor',
      //   component: () => import('@/views/monitor/index.vue'),
      //   meta: { title: '航运安全监控管理', icon: 'Monitor', requiresAuth: true }
      // },
      {
        path: 'system',
        component: () => import('@/views/system/log/index.vue'),
        name: 'System',
        meta: { title: '系统管理', icon: 'Setting', roles: ['ADMIN'], requiresAuth: true }
      }
    ]
  },
  // 404页面
  {
    path: '/404',
    name: '404',
    component: () => import('@/views/error/404.vue'),
    meta: { title: '404', requiresAuth: false }
  },
  // 403页面
  {
    path: '/403',
    name: '403',
    component: () => import('@/views/error/403.vue'),
    meta: { title: '403', requiresAuth: false }
  },
  // 捕获所有未匹配的路由
  {
    path: '/:pathMatch(.*)*',
    redirect: '/404'
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  // 设置页面标题
  document.title = to.meta.title ? `${to.meta.title} - 航运管理系统` : '航运管理系统'
  
  // 获取token和用户信息
  const token = localStorage.getItem('token')
  const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}')
  const userType = localStorage.getItem('userType')
  
  if (to.meta.requiresAuth === false) {
    next()
    return
  }
  
  if (!token) {
    // 如果是白名单路由，直接放行
    if (whiteList.includes(to.path)) {
      next()
    } else {
      // 否则重定向到登录页
      next('/login')
    }
    return
  }
  
  // 已登录状态
  if (to.path === '/login') {
    // 如果访问登录页，重定向到首页
    if (userType === 'CREW') {
      next('/home/profile')
    } else {
      next('/home/dashboard')
    }
    return
  }
  
  // 检查角色权限
  if (to.meta.roles && !to.meta.roles.includes(userInfo.role)) {
    next('/403')
    return
  }
  
  // 如果是船员访问dashboard，重定向到profile
  if (userType === 'CREW' && to.path === '/home/dashboard') {
    next('/home/profile')
    return
  }
  
  next()
})

export default router 