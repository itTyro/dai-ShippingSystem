<template>
  <div class="profile-container">
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card class="user-card">
          <div class="user-info">
            <el-avatar :size="100" :src="userInfo.image || '/default-avatar.png'" />
            <h2>{{ userInfo.username }}</h2>
            <p>{{ userInfo.role }}</p>
          </div>
        </el-card>
      </el-col>
      <el-col :span="16">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>个人信息</span>
              <el-button type="primary" @click="handleEdit">编辑</el-button>
            </div>
          </template>
          <el-form
            ref="formRef"
            :model="form"
            :rules="rules"
            label-width="100px"
            :disabled="!isEditing"
          >
            <el-form-item label="用户名" prop="username">
              <el-input v-model="form.username" disabled />
            </el-form-item>
            <!-- <el-form-item label="头像">
              <el-upload
                class="avatar-uploader"
                action="/api/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload"
                :disabled="!isEditing"
              >
                <img v-if="form.image" :src="form.image" class="avatar" />
                <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
              </el-upload>
            </el-form-item> -->
            <el-form-item v-if="isEditing">
              <el-button type="primary" @click="handleSave">保存</el-button>
              <el-button @click="handleCancel">取消</el-button>
            </el-form-item>
          </el-form>
        </el-card>

        <el-card class="mt-20">
          <template #header>
            <div class="card-header">
              <span>修改密码</span>
            </div>
          </template>
          <el-form
            ref="passwordFormRef"
            :model="passwordForm"
            :rules="passwordRules"
            label-width="100px"
          >
            <el-form-item label="原密码" prop="oldPassword">
              <el-input
                v-model="passwordForm.oldPassword"
                type="password"
                show-password
              />
            </el-form-item>
            <el-form-item label="新密码" prop="newPassword">
              <el-input
                v-model="passwordForm.newPassword"
                type="password"
                show-password
              />
            </el-form-item>
            <el-form-item label="确认密码" prop="confirmPassword">
              <el-input
                v-model="passwordForm.confirmPassword"
                type="password"
                show-password
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handleChangePassword">
                修改密码
              </el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { updatePassword } from '@/api/user' // 导入 updatePassword

const userInfo = ref({
  username: JSON.parse(localStorage.getItem('userInfo') || '{}').username || '用户',
  role: localStorage.getItem('userType') === 'ADMIN' ? '管理员' : '船员',
  image: localStorage.getItem('avatar') || ''
})

const isEditing = ref(false)
const formRef = ref()
const passwordFormRef = ref()

const form = reactive({
  username: userInfo.value.username,
  image: userInfo.value.image
})

const passwordForm = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const rules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }]
}

const passwordRules = {
  oldPassword: [{ required: true, message: '请输入原密码', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, message: '密码长度不能小于6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        if (value !== passwordForm.newPassword) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
}

const handleEdit = () => {
  isEditing.value = true
}

const handleSave = async () => {
  await formRef.value.validate()
  // TODO: 调用更新用户信息的API
  ElMessage.success('保存成功')
  isEditing.value = false
}

const handleCancel = () => {
  formRef.value.resetFields()
  isEditing.value = false
}

const handleChangePassword = async () => {
  if (!passwordFormRef.value) return
  try {
    await passwordFormRef.value.validate()
    // 调用修改密码的API
    const res = await updatePassword({
      username: userInfo.value.username, // 后端接口可能需要用户名来确认用户
      oldPassword: passwordForm.oldPassword,
      newPassword: passwordForm.newPassword
    })

    if (res.code === 200) {
      ElMessage.success('密码修改成功')
      passwordFormRef.value.resetFields()
    } else {
      ElMessage.error(res.message || '密码修改失败')
    }
  } catch (error) {
    ElMessage.error(error.response?.data?.message || '操作失败')
  }
}

const handleAvatarSuccess = (response) => {
  form.image = response.data
}

const beforeAvatarUpload = (file) => {
  const isJPG = file.type === 'image/jpeg'
  const isPNG = file.type === 'image/png'
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isJPG && !isPNG) {
    ElMessage.error('上传头像图片只能是 JPG 或 PNG 格式!')
  }
  if (!isLt2M) {
    ElMessage.error('上传头像图片大小不能超过 2MB!')
  }
  return (isJPG || isPNG) && isLt2M
}
</script>

<style scoped>
.profile-container {
  padding: 20px;
}

.user-card {
  text-align: center;
}

.user-info {
  padding: 20px;
}

.user-info h2 {
  margin: 10px 0;
}

.mt-20 {
  margin-top: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avatar-uploader {
  text-align: center;
}

.avatar-uploader .avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
}

.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 50%;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
  border-radius: 50%;
}
</style> 