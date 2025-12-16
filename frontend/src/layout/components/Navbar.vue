<template>
  <div class="navbar">
    <div class="right-menu">
      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <el-avatar :size="40" :src="avatar" />
          <span class="username">{{ username }}</span>
          <el-icon><CaretBottom /></el-icon>
        </div>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item @click="handleProfile">
              <el-icon><User /></el-icon>
              个人中心
            </el-dropdown-item>
            <el-dropdown-item divided @click="handleLogout">
              <el-icon><SwitchButton /></el-icon>
              退出登录
            </el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessageBox, ElMessage } from 'element-plus'
import { CaretBottom, User, SwitchButton } from '@element-plus/icons-vue'

const router = useRouter()
const username = ref(localStorage.getItem('username') || '')
const avatar = ref(localStorage.getItem('avatar') || '')

const handleProfile = () => {
  router.push('/home/profile')
}

const handleLogout = () => {
  ElMessageBox.confirm('确定要退出登录吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    // 清除所有存储数据
    localStorage.clear()
    sessionStorage.clear()
    
    // 清除路由缓存
    router.replace('/login')
    
    ElMessage.success('退出登录成功')
  }).catch(() => {
    // 取消退出
  })
}
</script>

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
  display: flex;
  justify-content: flex-end;
  align-items: center;
  padding: 0 20px;

  .right-menu {
    display: flex;
    align-items: center;

    .avatar-container {
      .avatar-wrapper {
        display: flex;
        align-items: center;
        cursor: pointer;
        padding: 0 8px;

        .username {
          margin: 0 8px;
          font-size: 14px;
          color: #606266;
        }

        .el-icon {
          color: #909399;
          font-size: 12px;
        }
      }
    }
  }
}
</style> 