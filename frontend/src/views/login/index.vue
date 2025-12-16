<template>
  <div class="login-container">
    <el-form
      ref="loginFormRef"
      :model="loginForm"
      :rules="loginRules"
      class="login-form"
      autocomplete="on"
      label-position="left"
    >
      <div class="title-container">
        <h3 class="title">船舶管理系统</h3>
      </div>

      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          placeholder="用户名"
          type="text"
          tabindex="1"
          autocomplete="on"
        >
          <template #prefix>
            <el-icon><User /></el-icon>
          </template>
        </el-input>
      </el-form-item>

      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          :type="passwordVisible ? 'text' : 'password'"
          placeholder="密码"
          tabindex="2"
          autocomplete="on"
        >
          <template #prefix>
            <el-icon><Lock /></el-icon>
          </template>
          <template #suffix>
            <el-icon
              class="cursor-pointer"
              @click="passwordVisible = !passwordVisible"
            >
              <View v-if="passwordVisible" />
              <Hide v-else />
            </el-icon>
          </template>
        </el-input>
      </el-form-item>

      <el-button
        :loading="loading"
        type="primary"
        style="width: 100%; margin-bottom: 30px"
        @click="handleLogin"
      >
        登录
      </el-button>
    </el-form>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Lock, View, Hide } from '@element-plus/icons-vue'
import { login, getCurrentUser } from '@/api/user'

const router = useRouter()
const loginFormRef = ref(null)
const loading = ref(false)
const passwordVisible = ref(false)

const loginForm = reactive({
  username: '',
  password: ''
})

const loginRules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

const handleLogin = async () => {
  if (!loginFormRef.value) return
  
  try {
    await loginFormRef.value.validate()
    const res = await login({
      username: loginForm.username,
      password: loginForm.password
    })
    
    if (res.code === 200) {
      // 保存token
      localStorage.setItem('token', res.data)
      
      // 解析token获取用户类型
      const tokenData = JSON.parse(atob(res.data.split('.')[1]))
      const userType = tokenData.userType
      
      // 保存用户类型
      localStorage.setItem('userType', userType)
      
      // 获取用户信息
      const userRes = await getCurrentUser()
      if (userRes.code === 200) {
        localStorage.setItem('userInfo', JSON.stringify(userRes.data))
      }
      
      ElMessage.success('登录成功')
      router.push('/')
    } else {
      ElMessage.error(res.message || '登录失败')
    }
  } catch (error) {
    ElMessage.error(error.response?.data?.message || '登录失败')
  }
}
</script>

<style lang="scss" scoped>
.login-container {
  min-height: 100vh;
  width: 100%;
  background-color: #2d3a4b;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;

  .login-form {
    position: relative;
    width: 520px;
    max-width: 100%;
    padding: 35px;
    margin: 0 auto;
    overflow: hidden;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);

    :deep(.el-form-item) {
      border: 1px solid #dcdfe6;
      background: #fff;
      border-radius: 5px;
      margin-bottom: 20px;
      padding: 0 !important;
      display: flex;

      :deep(.el-form-item__content) {
        margin: 0 !important;
        padding: 0 !important;
        flex: 1;
        display: flex;
      }

      .el-input {
        display: flex;
        flex: 1;
        height: 47px;

        :deep(.el-input__wrapper) {
          background: transparent;
          box-shadow: none;
          padding: 0;
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
        }

        :deep(.el-input__inner) {
          background: transparent;
          border: 0;
          -webkit-appearance: none;
          border-radius: 0;
          padding: 12px 5px 12px 15px;
          color: #000;
          height: 100%;
          flex: 1;
          caret-color: #000;

          &:-webkit-autofill {
            box-shadow: 0 0 0 1000px #fff inset !important;
            -webkit-text-fill-color: #000 !important;
          }
        }

        :deep(.el-input__prefix) {
          color: #889aa4;
          margin-left: 10px;
          display: flex;
          align-items: center;
        }

        :deep(.el-input__suffix) {
          color: #889aa4;
          margin-right: 10px;
          cursor: pointer;
          display: flex;
          align-items: center;
        }
      }
    }

    .title-container {
      position: relative;
      margin-bottom: 30px;

      .title {
        font-size: 26px;
        color: #fff;
        margin: 0 auto;
        text-align: center;
        font-weight: bold;
      }
    }

    .el-button {
      width: 100%;
      margin-top: 10px;
    }
  }
}
</style> 