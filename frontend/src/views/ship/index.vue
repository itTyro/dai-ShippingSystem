<template>
  <div class="ship-container">
    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="船名">
          <el-input v-model="queryParams.name" placeholder="请输入船名" clearable />
        </el-form-item>
        <el-form-item label="类型">
          <el-select v-model="queryParams.type" placeholder="请选择类型" clearable>
            <el-option label="货船" value="CARGO" />
            <el-option label="客船" value="PASSENGER" />
            <el-option label="渔船" value="FISHING" />
            <el-option label="其他" value="OTHER" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
            <el-option label="在航" value="SAILING" />
            <el-option label="停泊" value="BERTHED" />
            <el-option label="维修" value="MAINTENANCE" />
            <el-option label="其他" value="OTHER" />
          </el-select>
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
          <span>船舶列表</span>
          <el-button type="primary" @click="handleAdd">添加船舶</el-button>
        </div>
      </template>

      <!-- 数据表格 -->
      <el-table v-loading="loading" :data="shipList" border>
        <el-table-column type="index" label="序号" width="50" />
        <el-table-column prop="name" label="船名" />
        <el-table-column prop="type" label="类型">
          <template #default="{ row }">
            <el-tag>{{ getShipTypeLabel(row.type) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="length" label="船长(米)" />
        <el-table-column prop="width" label="船宽(米)" />
        <el-table-column prop="draft" label="吃水(米)" />
        <el-table-column prop="tonnage" label="吨位(吨)" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="getStatusType(row.status)">
              {{ getStatusLabel(row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link @click="handleUpdate(row)">编辑</el-button>
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
        ref="shipFormRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="船名" prop="name">
          <el-input v-model="form.name" placeholder="请输入船名" />
        </el-form-item>
        <el-form-item label="类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择类型">
            <el-option label="货船" value="CARGO" />
            <el-option label="客船" value="PASSENGER" />
            <el-option label="渔船" value="FISHING" />
            <el-option label="其他" value="OTHER" />
          </el-select>
        </el-form-item>
        <el-form-item label="船长" prop="length">
          <el-input-number v-model="form.length" :min="0" :precision="2" placeholder="请输入船长" />
        </el-form-item>
        <el-form-item label="船宽" prop="width">
          <el-input-number v-model="form.width" :min="0" :precision="2" placeholder="请输入船宽" />
        </el-form-item>
        <el-form-item label="吃水" prop="draft">
          <el-input-number v-model="form.draft" :min="0" :precision="2" placeholder="请输入吃水" />
        </el-form-item>
        <el-form-item label="吨位" prop="tonnage">
          <el-input-number v-model="form.tonnage" :min="0" :precision="2" placeholder="请输入吨位" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="在航" value="SAILING" />
            <el-option label="停泊" value="BERTHED" />
            <el-option label="维修" value="MAINTENANCE" />
            <el-option label="其他" value="OTHER" />
          </el-select>
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
import { getShipList, addShip, updateShip, deleteShip } from '@/api/ship'

// 查询参数
const queryParams = reactive({
  current: 1,
  size: 10,
  name: '',
  type: undefined,
  status: undefined
})

// 数据列表
const shipList = ref([])
const total = ref(0)
const loading = ref(false)

// 表单参数
const form = reactive({
  id: undefined,
  name: '',
  type: '',
  length: 0,
  width: 0,
  draft: 0,
  tonnage: 0,
  status: ''
})

// 表单校验规则
const rules = {
  name: [{ required: true, message: '请输入船名', trigger: 'blur' }],
  type: [{ required: true, message: '请选择类型', trigger: 'change' }],
  length: [{ required: true, message: '请输入船长', trigger: 'blur' }],
  width: [{ required: true, message: '请输入船宽', trigger: 'blur' }],
  draft: [{ required: true, message: '请输入吃水', trigger: 'blur' }],
  tonnage: [{ required: true, message: '请输入吨位', trigger: 'blur' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }]
}

// 对话框控制
const dialog = reactive({
  visible: false,
  title: ''
})

// 表单引用
const shipFormRef = ref()

// 获取船舶类型标签
const getShipTypeLabel = (type) => {
  const typeMap = {
    'CARGO': '货船',
    'PASSENGER': '客船',
    'FISHING': '渔船',
    'OTHER': '其他'
  }
  return typeMap[type] || type
}

// 获取状态标签
const getStatusLabel = (status) => {
  const statusMap = {
    'SAILING': '在航',
    'BERTHED': '停泊',
    'MAINTENANCE': '维修',
    'OTHER': '其他'
  }
  return statusMap[status] || status
}

// 获取状态类型
const getStatusType = (status) => {
  const typeMap = {
    'SAILING': 'success',
    'BERTHED': 'info',
    'MAINTENANCE': 'warning',
    'OTHER': ''
  }
  return typeMap[status] || ''
}

// 获取列表数据
const getList = async () => {
  loading.value = true
  try {
    const res = await getShipList(queryParams)
    if (res.code === 200) {
      shipList.value = res.data.records || []
      total.value = res.data.total || 0
    } else {
      ElMessage.error(res.message || '获取船舶列表失败')
    }
  } catch (error) {
    console.error('获取船舶列表失败:', error)
    ElMessage.error('获取船舶列表失败')
  } finally {
    loading.value = false
  }
}

// 查询按钮操作
const handleQuery = () => {
  queryParams.current = 1
  getList()
}

// 重置按钮操作
const resetQuery = () => {
  queryParams.name = ''
  queryParams.type = undefined
  queryParams.status = undefined
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
  dialog.title = '添加船舶'
  dialog.visible = true
  Object.assign(form, {
    id: undefined,
    name: '',
    type: '',
    length: 0,
    width: 0,
    draft: 0,
    tonnage: 0,
    status: ''
  })
}

// 修改按钮操作
const handleUpdate = (row) => {
  dialog.title = '修改船舶'
  dialog.visible = true
  Object.assign(form, row)
}

// 删除按钮操作
const handleDelete = (row) => {
  ElMessageBox.confirm('确认要删除该船舶吗？', '警告', {
    type: 'warning'
  }).then(async () => {
    try {
      await deleteShip(row.id)
      ElMessage.success('删除成功')
      getList()
    } catch (error) {
      console.error('删除船舶失败:', error)
      ElMessage.error('删除失败')
    }
  })
}

// 表单提交
const submitForm = async () => {
  if (!shipFormRef.value) return
  
  await shipFormRef.value.validate()
  try {
    if (form.id) {
      await updateShip(form)
      ElMessage.success('修改成功')
    } else {
      await addShip(form)
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
  shipFormRef.value?.resetFields()
}

// 初始化
onMounted(() => {
  getList()
})
</script>

<style scoped>
.ship-container {
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

.search-form :deep(.el-select) {
  width: 200px;
}

.search-form :deep(.el-input) {
  width: 200px;
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