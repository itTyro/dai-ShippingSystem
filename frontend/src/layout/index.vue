<template>
  <div class="app-wrapper">
    <!-- 侧边栏 -->
    <div class="sidebar-container">
      <div class="logo">
        <!-- <img src="@/assets/logo.png" alt="logo"> -->
        <span>航运管理系统</span>
      </div>
      <el-menu
        :default-active="route.path"
        class="sidebar-menu"
        :router="true"
        :collapse="isCollapse"
      >
        <el-menu-item v-for="item in filteredRoutes" :key="item.path" :index="item.path">
          <el-icon><component :is="item.meta.icon" /></el-icon>
          <template #title>{{ item.meta.title }}</template>
        </el-menu-item>
      </el-menu>
    </div>

    <!-- 主要内容区 -->
    <div class="main-container">
      <!-- 头部 -->
      <div class="navbar">
        <div class="left">
          <el-icon class="fold-btn" @click="toggleSidebar">
            <component :is="isCollapse ? 'Expand' : 'Fold'" />
          </el-icon>
          <breadcrumb />
        </div>
        <div class="right">
          <el-dropdown trigger="click">
            <span class="user-info">
              <el-avatar :size="32" :src="userInfo.image" />
              <span class="username">{{ userInfo.username }}</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <!-- <el-dropdown-item @click="goToProfile">个人中心</el-dropdown-item> -->
                <el-dropdown-item divided @click="handleLogout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>

      <!-- 内容区 -->
      <div class="app-main">
        <router-view v-slot="{ Component }">
          <transition name="fade-transform" mode="out-in">
            <component :is="Component" />
          </transition>
        </router-view>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessageBox } from 'element-plus'
import Breadcrumb from './components/Breadcrumb.vue'

const route = useRoute()
const router = useRouter()
const isCollapse = ref(false)
const userInfo = ref({
  username: JSON.parse(localStorage.getItem('userInfo') || '{}').username || '用户',
  image: localStorage.getItem('avatar') || ''
})

// 获取用户类型
const userType = computed(() => localStorage.getItem('userType'))

// 获取路由配置并根据用户类型过滤
const filteredRoutes = computed(() => {
  const allRoutes = router.options.routes.find(r => r.path === '/home').children
  if (userType.value === 'CREW') {
    return allRoutes.filter(route => 
      !['dashboard', 'crew', 'system'].includes(route.name?.toLowerCase())
    )
  }
  return allRoutes
})

// 切换侧边栏
const toggleSidebar = () => {
  isCollapse.value = !isCollapse.value
}

// 跳转到个人中心
const goToProfile = () => {
  router.push('/profile')
}

// 退出登录
const handleLogout = () => {
  ElMessageBox.confirm('确定要退出登录吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    localStorage.removeItem('token')
    localStorage.removeItem('username')
    localStorage.removeItem('avatar')
    router.push('/login')
  })
}
</script>

<style lang="scss" scoped>
.app-wrapper {
  display: flex;
  height: 100%;
  
  .sidebar-container {
    width: 210px;
    height: 100%;
    background-color: #304156;
    transition: width 0.3s;
    
    &.collapse {
      width: 64px;
    }
    
    .logo {
      height: 60px;
      display: flex;
      align-items: center;
      padding: 0 16px;
      color: #fff;
      
      img {
        width: 32px;
        height: 32px;
        margin-right: 12px;
      }
      
      span {
        font-size: 16px;
        font-weight: 600;
      }
    }
    
    .sidebar-menu {
      border: none;
      background-color: transparent;
    }
  }
  
  .main-container {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    
    .navbar {
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 16px;
      box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
      
      .left {
        display: flex;
        align-items: center;
        
        .fold-btn {
          font-size: 20px;
          cursor: pointer;
          margin-right: 16px;
        }
      }
      
      .right {
        .user-info {
          display: flex;
          align-items: center;
          cursor: pointer;
          
          .username {
            margin-left: 8px;
          }
        }
      }
    }
    
    .app-main {
      flex: 1;
      padding: 16px;
      overflow-y: auto;
    }
  }
}

// 路由切换动画
.fade-transform-enter-active,
.fade-transform-leave-active {
  transition: all 0.3s;
}

.fade-transform-enter-from {
  opacity: 0;
  transform: translateX(-30px);
}

.fade-transform-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
</style> 