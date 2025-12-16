<template>
  <div class="crew-container">
    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="用户名">
          <el-input v-model="queryParams.username" placeholder="请输入用户名" clearable />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleQuery">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 操作按钮 -->
    <el-card class="table-card">
      <template #header>
        <div class="card-header">
          <span>船员列表</span>
          <el-button type="primary" @click="handleAdd">添加船员</el-button>
        </div>
      </template>

      <!-- 数据表格 -->
      <el-table v-loading="loading" :data="crewList" border>
        <el-table-column type="index" label="序号" width="50" />
        <el-table-column prop="username" label="用户名" />
        <el-table-column prop="phone" label="联系电话" />
        <el-table-column prop="email" label="邮箱" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-switch
              v-model="row.status"
              :active-value="1"
              :inactive-value="0"
              @change="(val) => handleStatusChange(row)"
            />
          </template>
        </el-table-column>
        <el-table-column label="操作" width="250" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link @click="handleUpdate(row)">编辑</el-button>
            <el-button type="primary" link @click="handleResetPassword(row)">重置密码</el-button>
            <el-button type="danger" link @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          :current-page="queryParams.current"
          :page-size="queryParams.size"
          :total="total"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 添加/编辑对话框 -->
    <el-dialog
      :title="dialog.title"
      v-model="dialog.visible"
      width="500px"
      append-to-body
    >
      <el-form
        ref="crewFormRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="form.email" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getCrewList, addCrew, updateCrew, deleteCrew, updateCrewStatus, resetCrewPassword } from '@/api/crew'

// 查询参数
const queryParams = reactive({
  current: 1,
  size: 10,
  username: ''
})

// 数据列表
const crewList = ref([])
const total = ref(0)
const loading = ref(false)

// 表单参数
const form = reactive({
  id: undefined,
  username: '',
  phone: '',
  email: '',
  status: 1
})

// 表单校验规则
const rules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  phone: [{ required: true, message: '请输入联系电话', trigger: 'blur' }],
  email: [{ required: true, message: '请输入邮箱', trigger: 'blur' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }]
}

// 对话框控制
const dialog = reactive({
  visible: false,
  title: ''
})

// 表单引用
const crewFormRef = ref()

// 获取列表数据
const getList = async () => {
  loading.value = true
  try {
    const res = await getCrewList(queryParams)
    crewList.value = res.data.records
    total.value = res.data.total
  } catch (error) {
    console.error('获取船员列表失败:', error)
    ElMessage.error('获取船员列表失败')
  }
  loading.value = false
}

// 查询按钮操作
const handleQuery = () => {
  queryParams.current = 1
  getList()
}

// 重置按钮操作
const resetQuery = () => {
  queryParams.username = ''
  handleQuery()
}

// 分页大小改变
const handleSizeChange = (val) => {
  queryParams.size = val
  getList()
}

// 页码改变
const handleCurrentChange = (val) => {
  queryParams.current = val
  getList()
}

// 添加按钮操作
const handleAdd = () => {
  dialog.title = '添加船员'
  dialog.visible = true
  Object.assign(form, {
    id: undefined,
    username: '',
    phone: '',
    email: '',
    status: 1
  })
}

// 修改按钮操作
const handleUpdate = (row) => {
  dialog.title = '修改船员'
  dialog.visible = true
  Object.assign(form, row)
}

// 删除按钮操作
const handleDelete = (row) => {
  ElMessageBox.confirm('确认要删除该船员吗？', '警告', {
    type: 'warning'
  }).then(async () => {
    try {
      await deleteCrew(row.id)
      ElMessage.success('删除成功')
      getList()
    } catch (error) {
      console.error('删除船员失败:', error)
      ElMessage.error('删除失败')
    }
  })
}

// 更新状态
const handleStatusChange = async (row) => {
  try {
    await updateCrewStatus(row.id, row.status)
    ElMessage.success('状态更新成功')
  } catch (error) {
    console.error('更新状态失败:', error)
    ElMessage.error('更新状态失败')
    // 恢复原状态
    row.status = row.status === 1 ? 0 : 1
  }
}

// 重置密码
const handleResetPassword = (row) => {
  ElMessageBox.confirm('确认要重置该船员的密码吗？', '警告', {
    type: 'warning'
  }).then(async () => {
    try {
      await resetCrewPassword(row.id)
      ElMessage.success('密码重置成功')
    } catch (error) {
      console.error('重置密码失败:', error)
      ElMessage.error('重置密码失败')
    }
  })
}

// 表单提交
const submitForm = async () => {
  if (!crewFormRef.value) return
  
  await crewFormRef.value.validate()
  try {
    if (form.id) {
      await updateCrew(form)
      ElMessage.success('修改成功')
    } else {
      await addCrew(form)
      ElMessage.success('添加成功')
    }
    dialog.visible = false
    getList()
  } catch (error) {
    console.error('提交表单失败:', error)
    ElMessage.error('提交失败')
  }
}

// 取消按钮
const cancel = () => {
  dialog.visible = false
  crewFormRef.value?.resetFields()
}

// 初始化
onMounted(() => {
  getList()
})
</script>

<style scoped>
.crew-container {
  padding: 20px;
}

.search-card {
  margin-bottom: 20px;
}

.search-form {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.table-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

.dialog-footer {
  text-align: right;
}
</style> 