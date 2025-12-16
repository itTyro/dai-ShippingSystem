<template>
  <el-menu
    :default-active="activeMenu"
    class="sidebar-menu"
    :collapse="isCollapse"
    background-color="#304156"
    text-color="#bfcbd9"
    active-text-color="#409EFF"
  >
    <el-menu-item index="/home/dashboard" v-if="userType !== 'CREW'">
      <el-icon><House /></el-icon>
      <span>首页</span>
    </el-menu-item>

    <el-menu-item index="/home/profile">
      <el-icon><User /></el-icon>
      <span>个人中心</span>
    </el-menu-item>

    <el-menu-item index="/home/crew" v-if="userType !== 'CREW'">
      <el-icon><User /></el-icon>
      <span>船员管理</span>
    </el-menu-item>

    <el-menu-item index="/home/navigation-safety">
      <el-icon><Ship /></el-icon>
      <span>航行安全管理</span>
    </el-menu-item>

    <el-menu-item index="/home/ship">
      <el-icon><Ship /></el-icon>
      <span>船舶信息管理</span>
    </el-menu-item>

    <el-menu-item index="/home/ship-schedule">
      <el-icon><Operation /></el-icon>
      <span>船舶调度管理</span>
    </el-menu-item>

    <el-menu-item index="/home/cargo">
      <el-icon><Box /></el-icon>
      <span>航运货物管理</span>
    </el-menu-item>

    <el-menu-item index="/home/monitor">
      <el-icon><Monitor /></el-icon>
      <span>航运安全监控管理</span>
    </el-menu-item>

    <el-menu-item index="/home/system" v-if="userType !== 'CREW'">
      <el-icon><Setting /></el-icon>
      <span>系统管理</span>
    </el-menu-item>
  </el-menu>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useUserStore } from '@/stores/user'

const route = useRoute()
const userStore = useUserStore()

const isCollapse = ref(false)
const userType = computed(() => userStore.userType)

const activeMenu = computed(() => {
  return route.path
})
</script>

<style scoped>
.sidebar-menu {
  height: 100%;
  border-right: none;
}

.sidebar-menu:not(.el-menu--collapse) {
  width: 200px;
}
</style> 