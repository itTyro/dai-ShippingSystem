<template>
  <div class="system-container">
    <el-tabs v-model="activeTab" class="system-tabs">
      <!-- 用户管理 -->
      <el-tab-pane label="用户管理" name="user">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>用户列表</span>
              <el-button type="primary" @click="handleAddUser">新增用户</el-button>
            </div>
          </template>

          <!-- 搜索表单 -->
          <el-form :inline="true" :model="userSearchForm" class="search-form">
            <el-form-item label="用户名">
              <el-input v-model="userSearchForm.username" placeholder="请输入用户名" clearable />
            </el-form-item>
            <el-form-item label="角色">
              <el-select v-model="userSearchForm.role" placeholder="请选择角色" clearable>
                <el-option label="管理员" value="ADMIN" />
                <el-option label="操作员" value="OPERATOR" />
                <el-option label="船员" value="CREW" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handleUserSearch">搜索</el-button>
              <el-button @click="resetUserSearch">重置</el-button>
            </el-form-item>
          </el-form>

          <!-- 用户列表 -->
          <el-table :data="userList" border style="width: 100%">
            <el-table-column prop="id" label="ID" width="80" />
            <el-table-column prop="username" label="用户名" width="120" />
            <el-table-column prop="realName" label="姓名" width="120" />
            <el-table-column prop="role" label="角色" width="100">
              <template #default="{ row }">
                <el-tag :type="getRoleType(row.role)">{{ getRoleText(row.role) }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="email" label="邮箱" />
            <el-table-column prop="phone" label="电话" width="120" />
            <el-table-column prop="status" label="状态" width="100">
              <template #default="{ row }">
                <el-tag :type="row.status === 'ENABLED' ? 'success' : 'danger'">
                  {{ row.status === 'ENABLED' ? '启用' : '禁用' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="200">
              <template #default="{ row }">
                <el-button type="primary" link @click="handleEditUser(row)">编辑</el-button>
                <el-button type="primary" link @click="handleResetPassword(row)">重置密码</el-button>
                <el-button
                  :type="row.status === 'ENABLED' ? 'danger' : 'success'"
                  link
                  @click="handleToggleUserStatus(row)"
                >
                  {{ row.status === 'ENABLED' ? '禁用' : '启用' }}
                </el-button>
              </template>
            </el-table-column>
          </el-table>

          <!-- 分页 -->
          <div class="pagination">
            <el-pagination
              v-model:current-page="userCurrentPage"
              v-model:page-size="userPageSize"
              :page-sizes="[10, 20, 50, 100]"
              :total="userTotal"
              layout="total, sizes, prev, pager, next, jumper"
              @size-change="handleUserSizeChange"
              @current-change="handleUserCurrentChange"
            />
          </div>
        </el-card>
      </el-tab-pane>

      <!-- 角色管理 -->
      <el-tab-pane label="角色管理" name="role">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>角色列表</span>
              <el-button type="primary" @click="handleAddRole">新增角色</el-button>
            </div>
          </template>

          <!-- 角色列表 -->
          <el-table :data="roleList" border style="width: 100%">
            <el-table-column prop="id" label="ID" width="80" />
            <el-table-column prop="name" label="角色名称" width="120" />
            <el-table-column prop="code" label="角色编码" width="120" />
            <el-table-column prop="description" label="描述" />
            <el-table-column prop="createTime" label="创建时间" width="180" />
            <el-table-column label="操作" width="200">
              <template #default="{ row }">
                <el-button type="primary" link @click="handleEditRole(row)">编辑</el-button>
                <el-button type="primary" link @click="handleAssignPermissions(row)">分配权限</el-button>
                <el-button type="danger" link @click="handleDeleteRole(row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>

      <!-- 权限管理 -->
      <el-tab-pane label="权限管理" name="permission">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>权限列表</span>
              <el-button type="primary" @click="handleAddPermission">新增权限</el-button>
            </div>
          </template>

          <!-- 权限树 -->
          <el-tree
            :data="permissionTree"
            :props="defaultProps"
            node-key="id"
            default-expand-all
            show-checkbox
          >
            <template #default="{ node, data }">
              <span class="custom-tree-node">
                <span>{{ node.label }}</span>
                <span class="node-operations">
                  <el-button type="primary" link @click="handleEditPermission(data)">编辑</el-button>
                  <el-button type="danger" link @click="handleDeletePermission(data)">删除</el-button>
                </span>
              </span>
            </template>
          </el-tree>
        </el-card>
      </el-tab-pane>

      <!-- 系统配置 -->
      <el-tab-pane label="系统配置" name="config">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>系统配置</span>
              <el-button type="primary" @click="handleSaveConfig">保存配置</el-button>
            </div>
          </template>

          <el-form :model="systemConfig" label-width="120px">
            <el-form-item label="系统名称">
              <el-input v-model="systemConfig.systemName" />
            </el-form-item>
            <el-form-item label="系统Logo">
              <el-upload
                class="avatar-uploader"
                action="/api/upload"
                :show-file-list="false"
                :on-success="handleLogoSuccess"
              >
                <img v-if="systemConfig.logo" :src="systemConfig.logo" class="avatar" />
                <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
              </el-upload>
            </el-form-item>
            <el-form-item label="系统主题">
              <el-select v-model="systemConfig.theme">
                <el-option label="默认主题" value="default" />
                <el-option label="暗色主题" value="dark" />
                <el-option label="蓝色主题" value="blue" />
              </el-select>
            </el-form-item>
            <el-form-item label="密码有效期">
              <el-input-number v-model="systemConfig.passwordExpireDays" :min="30" :max="365" />
              <span class="unit">天</span>
            </el-form-item>
            <el-form-item label="登录失败锁定">
              <el-switch v-model="systemConfig.loginLockEnabled" />
            </el-form-item>
            <el-form-item label="失败次数限制" v-if="systemConfig.loginLockEnabled">
              <el-input-number v-model="systemConfig.loginFailLimit" :min="3" :max="10" />
              <span class="unit">次</span>
            </el-form-item>
            <el-form-item label="锁定时间" v-if="systemConfig.loginLockEnabled">
              <el-input-number v-model="systemConfig.loginLockTime" :min="5" :max="60" />
              <span class="unit">分钟</span>
            </el-form-item>
          </el-form>
        </el-card>
      </el-tab-pane>
    </el-tabs>

    <!-- 用户表单对话框 -->
    <el-dialog
      v-model="userDialogVisible"
      :title="userDialogType === 'add' ? '新增用户' : '编辑用户'"
      width="500px"
    >
      <el-form
        ref="userFormRef"
        :model="userForm"
        :rules="userRules"
        label-width="80px"
      >
        <el-form-item label="用户名" prop="username">
          <el-input v-model="userForm.username" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="姓名" prop="realName">
          <el-input v-model="userForm.realName" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="角色" prop="role">
          <el-select v-model="userForm.role" placeholder="请选择角色">
            <el-option label="管理员" value="ADMIN" />
            <el-option label="操作员" value="OPERATOR" />
            <el-option label="船员" value="CREW" />
          </el-select>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="userForm.email" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="userForm.phone" placeholder="请输入电话" />
        </el-form-item>
        <el-form-item label="密码" prop="password" v-if="userDialogType === 'add'">
          <el-input v-model="userForm.password" type="password" placeholder="请输入密码" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="userDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleUserSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 角色表单对话框 -->
    <el-dialog
      v-model="roleDialogVisible"
      :title="roleDialogType === 'add' ? '新增角色' : '编辑角色'"
      width="500px"
    >
      <el-form
        ref="roleFormRef"
        :model="roleForm"
        :rules="roleRules"
        label-width="80px"
      >
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="roleForm.name" placeholder="请输入角色名称" />
        </el-form-item>
        <el-form-item label="角色编码" prop="code">
          <el-input v-model="roleForm.code" placeholder="请输入角色编码" />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            v-model="roleForm.description"
            type="textarea"
            rows="3"
            placeholder="请输入描述"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="roleDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleRoleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 权限分配对话框 -->
    <el-dialog
      v-model="permissionDialogVisible"
      title="分配权限"
      width="600px"
    >
      <el-tree
        ref="permissionTreeRef"
        :data="permissionTree"
        :props="defaultProps"
        show-checkbox
        node-key="id"
        :default-checked-keys="checkedPermissions"
      />
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="permissionDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handlePermissionSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'

// 当前激活的标签页
const activeTab = ref('user')

// 用户管理相关
const userSearchForm = reactive({
  username: '',
  role: ''
})

const userList = ref([
  {
    id: 1,
    username: 'admin',
    realName: '管理员',
    role: 'ADMIN',
    email: 'admin@example.com',
    phone: '13800138000',
    status: 'ENABLED'
  }
])

const userCurrentPage = ref(1)
const userPageSize = ref(10)
const userTotal = ref(1)

const userDialogVisible = ref(false)
const userDialogType = ref('add')
const userFormRef = ref()
const userForm = reactive({
  username: '',
  realName: '',
  role: '',
  email: '',
  phone: '',
  password: ''
})

const userRules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  realName: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  role: [{ required: true, message: '请选择角色', trigger: 'change' }],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
  ],
  phone: [{ required: true, message: '请输入电话', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

// 角色管理相关
const roleList = ref([
  {
    id: 1,
    name: '管理员',
    code: 'ADMIN',
    description: '系统管理员',
    createTime: '2024-01-01 00:00:00'
  }
])

const roleDialogVisible = ref(false)
const roleDialogType = ref('add')
const roleFormRef = ref()
const roleForm = reactive({
  name: '',
  code: '',
  description: ''
})

const roleRules = {
  name: [{ required: true, message: '请输入角色名称', trigger: 'blur' }],
  code: [{ required: true, message: '请输入角色编码', trigger: 'blur' }]
}

// 权限管理相关
const permissionTree = ref([
  {
    id: 1,
    label: '系统管理',
    children: [
      {
        id: 2,
        label: '用户管理',
        children: [
          { id: 3, label: '查看用户' },
          { id: 4, label: '新增用户' },
          { id: 5, label: '编辑用户' },
          { id: 6, label: '删除用户' }
        ]
      }
    ]
  }
])

const defaultProps = {
  children: 'children',
  label: 'label'
}

const permissionDialogVisible = ref(false)
const permissionTreeRef = ref()
const checkedPermissions = ref([])

// 系统配置相关
const systemConfig = reactive({
  systemName: '航运管理系统',
  logo: '',
  theme: 'default',
  passwordExpireDays: 90,
  loginLockEnabled: true,
  loginFailLimit: 5,
  loginLockTime: 30
})

// 获取角色类型
const getRoleType = (role) => {
  const map = {
    ADMIN: 'danger',
    OPERATOR: 'warning',
    CREW: 'info'
  }
  return map[role] || ''
}

// 获取角色文本
const getRoleText = (role) => {
  const map = {
    ADMIN: '管理员',
    OPERATOR: '操作员',
    CREW: '船员'
  }
  return map[role] || role
}

// 用户管理方法
const handleUserSearch = () => {
  // TODO: 实现用户搜索
}

const resetUserSearch = () => {
  userSearchForm.username = ''
  userSearchForm.role = ''
  handleUserSearch()
}

const handleAddUser = () => {
  userDialogType.value = 'add'
  userDialogVisible.value = true
  userForm.username = ''
  userForm.realName = ''
  userForm.role = ''
  userForm.email = ''
  userForm.phone = ''
  userForm.password = ''
}

const handleEditUser = (row) => {
  userDialogType.value = 'edit'
  userDialogVisible.value = true
  Object.assign(userForm, row)
}

const handleResetPassword = (row) => {
  ElMessageBox.confirm('确认重置该用户的密码吗？', '提示', {
    type: 'warning'
  }).then(() => {
    // TODO: 实现重置密码
    ElMessage.success('密码重置成功')
  })
}

const handleToggleUserStatus = (row) => {
  const action = row.status === 'ENABLED' ? '禁用' : '启用'
  ElMessageBox.confirm(`确认${action}该用户吗？`, '提示', {
    type: 'warning'
  }).then(() => {
    // TODO: 实现状态切换
    ElMessage.success(`用户已${action}`)
  })
}

const handleUserSubmit = async () => {
  await userFormRef.value.validate()
  // TODO: 实现用户提交
  ElMessage.success(userDialogType.value === 'add' ? '用户创建成功' : '用户更新成功')
  userDialogVisible.value = false
}

const handleUserSizeChange = (val) => {
  userPageSize.value = val
  handleUserSearch()
}

const handleUserCurrentChange = (val) => {
  userCurrentPage.value = val
  handleUserSearch()
}

// 角色管理方法
const handleAddRole = () => {
  roleDialogType.value = 'add'
  roleDialogVisible.value = true
  roleForm.name = ''
  roleForm.code = ''
  roleForm.description = ''
}

const handleEditRole = (row) => {
  roleDialogType.value = 'edit'
  roleDialogVisible.value = true
  Object.assign(roleForm, row)
}

const handleDeleteRole = (row) => {
  ElMessageBox.confirm('确认删除该角色吗？', '提示', {
    type: 'warning'
  }).then(() => {
    // TODO: 实现角色删除
    ElMessage.success('角色删除成功')
  })
}

const handleAssignPermissions = (row) => {
  permissionDialogVisible.value = true
  // TODO: 获取角色已有权限
  checkedPermissions.value = [3, 4]
}

const handleRoleSubmit = async () => {
  await roleFormRef.value.validate()
  // TODO: 实现角色提交
  ElMessage.success(roleDialogType.value === 'add' ? '角色创建成功' : '角色更新成功')
  roleDialogVisible.value = false
}

// 权限管理方法
const handleAddPermission = () => {
  // TODO: 实现权限添加
}

const handleEditPermission = (data) => {
  // TODO: 实现权限编辑
}

const handleDeletePermission = (data) => {
  ElMessageBox.confirm('确认删除该权限吗？', '提示', {
    type: 'warning'
  }).then(() => {
    // TODO: 实现权限删除
    ElMessage.success('权限删除成功')
  })
}

const handlePermissionSubmit = () => {
  const checkedKeys = permissionTreeRef.value.getCheckedKeys()
  // TODO: 实现权限分配
  ElMessage.success('权限分配成功')
  permissionDialogVisible.value = false
}

// 系统配置方法
const handleLogoSuccess = (response) => {
  systemConfig.logo = response.url
}

const handleSaveConfig = () => {
  // TODO: 实现配置保存
  ElMessage.success('配置保存成功')
}

// 初始化
onMounted(() => {
  handleUserSearch()
})
</script>

<style scoped>
.system-container {
  padding: 20px;
}

.system-tabs {
  background-color: var(--el-bg-color);
  padding: 20px;
  border-radius: 4px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}

.node-operations {
  display: none;
}

.custom-tree-node:hover .node-operations {
  display: inline-block;
}

.avatar-uploader {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  width: 178px;
  height: 178px;
}

.avatar-uploader:hover {
  border-color: var(--el-color-primary);
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  text-align: center;
  line-height: 178px;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}

.unit {
  margin-left: 10px;
  color: var(--el-text-color-secondary);
}
</style> 