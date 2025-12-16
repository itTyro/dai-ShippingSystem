<template>
  <div class="navigation-safety-container">
    <!-- 设备状态统计 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>设备总数</span>
            </div>
          </template>
          <div class="stats-value">{{ deviceStats.total }}</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>正常设备</span>
            </div>
          </template>
          <div class="stats-value success">{{ deviceStats.normal }}</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>异常设备</span>
            </div>
          </template>
          <div class="stats-value warning">{{ deviceStats.abnormal }}</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>预警船舶</span>
            </div>
          </template>
          <div class="stats-value danger">{{ deviceStats.warning }}</div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="船名">
          <el-input v-model="queryParams.shipName" placeholder="请输入船名" clearable />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
            <el-option label="正常" :value="1" />
            <el-option label="异常" :value="0" />
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
          <span>航行安全列表</span>
          <el-button type="primary" @click="handleAdd">添加记录</el-button>
        </div>
      </template>

      <!-- 数据表格 -->
      <el-table v-loading="loading" :data="safetyList" border>
        <el-table-column type="index" label="序号" width="50" />
        <el-table-column prop="shipName" label="船名" />
        <el-table-column prop="location" label="当前位置" />
        <el-table-column prop="speed" label="航速(节)" />
        <el-table-column prop="direction" label="航向(度)" />
        <el-table-column prop="weather" label="天气状况" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '正常' : '异常' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="记录时间" width="180" />
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
        ref="safetyFormRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="船名" prop="shipName">
          <el-input v-model="form.shipName" placeholder="请输入船名" />
        </el-form-item>
        <el-form-item label="当前位置" prop="location">
          <el-input v-model="form.location" placeholder="请输入当前位置" />
        </el-form-item>
        <el-form-item label="航速" prop="speed">
          <el-input-number v-model="form.speed" :min="0" :max="100" placeholder="请输入航速" />
        </el-form-item>
        <el-form-item label="航向" prop="direction">
          <el-input-number v-model="form.direction" :min="0" :max="360" placeholder="请输入航向" />
        </el-form-item>
        <el-form-item label="天气状况" prop="weather">
          <el-input v-model="form.weather" placeholder="请输入天气状况" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio :label="1">正常</el-radio>
            <el-radio :label="0">异常</el-radio>
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
import { 
  getNavigationSafetyList, 
  addNavigationSafety, 
  updateNavigationSafety, 
  deleteNavigationSafety,
  getSafetyMonitorData
} from '@/api/navigation-safety'

// 设备状态统计
const deviceStats = ref({
  total: 0,
  normal: 0,
  abnormal: 0,
  warning: 0
})

// 查询参数
const queryParams = reactive({
  current: 1,
  size: 10,
  shipName: '',
  status: undefined
})

// 数据列表
const safetyList = ref([])
const total = ref(0)
const loading = ref(false)

// 表单参数
const form = reactive({
  id: undefined,
  shipName: '',
  location: '',
  speed: 0,
  direction: 0,
  weather: '',
  status: 1
})

// 表单校验规则
const rules = {
  shipName: [{ required: true, message: '请输入船名', trigger: 'blur' }],
  location: [{ required: true, message: '请输入当前位置', trigger: 'blur' }],
  speed: [{ required: true, message: '请输入航速', trigger: 'blur' }],
  direction: [{ required: true, message: '请输入航向', trigger: 'blur' }],
  weather: [{ required: true, message: '请输入天气状况', trigger: 'blur' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }]
}

// 对话框控制
const dialog = reactive({
  visible: false,
  title: ''
})

// 表单引用
const safetyFormRef = ref()

// 获取列表数据
const getList = async () => {
  loading.value = true
  try {
    const res = await getNavigationSafetyList(queryParams)
    if (res.code === 200) {
      safetyList.value = res.data.records || []
      total.value = res.data.total || 0
    } else {
      ElMessage.error(res.message || '获取航行安全列表失败')
    }
  } catch (error) {
    console.error('获取航行安全列表失败:', error)
    ElMessage.error('获取航行安全列表失败')
  } finally {
    loading.value = false
  }
}

// 获取安全监控数据
const getMonitorData = async () => {
  try {
    const res = await getSafetyMonitorData()
    if (res.code === 200) {
      // 处理监控数据
      const stats = res.data
      // 更新设备状态统计
      deviceStats.value = {
        total: stats.totalDevices || 0,
        normal: stats.onlineDevices || 0,
        abnormal: stats.abnormalDevices || 0,
        warning: stats.warningShips || 0
      }
    } else {
      console.error('获取安全监控数据失败:', res.message)
    }
  } catch (error) {
    console.error('获取安全监控数据失败:', error)
  }
}

// 查询按钮操作
const handleQuery = () => {
  queryParams.current = 1
  getList()
}

// 重置按钮操作
const resetQuery = () => {
  queryParams.shipName = ''
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
  dialog.title = '添加航行安全记录'
  dialog.visible = true
  Object.assign(form, {
    id: undefined,
    shipName: '',
    location: '',
    speed: 0,
    direction: 0,
    weather: '',
    status: 1
  })
}

// 修改按钮操作
const handleUpdate = (row) => {
  dialog.title = '修改航行安全记录'
  dialog.visible = true
  Object.assign(form, row)
}

// 删除按钮操作
const handleDelete = (row) => {
  ElMessageBox.confirm('确认要删除该记录吗？', '警告', {
    type: 'warning'
  }).then(async () => {
    try {
      await deleteNavigationSafety(row.id)
      ElMessage.success('删除成功')
      getList()
    } catch (error) {
      console.error('删除记录失败:', error)
      ElMessage.error('删除失败')
    }
  })
}

// 表单提交
const submitForm = async () => {
  if (!safetyFormRef.value) return
  
  await safetyFormRef.value.validate()
  try {
    if (form.id) {
      await updateNavigationSafety(form)
      ElMessage.success('修改成功')
    } else {
      await addNavigationSafety(form)
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
  safetyFormRef.value?.resetFields()
}

// 初始化
onMounted(() => {
  getList()
  getMonitorData()
})
</script>

<style scoped>
.navigation-safety-container {
  padding: 20px;
}

.stats-row {
  margin-bottom: 20px;
}

.stats-value {
  font-size: 24px;
  font-weight: bold;
  text-align: center;
  color: #409EFF;
}

.stats-value.success {
  color: #67C23A;
}

.stats-value.warning {
  color: #E6A23C;
}

.stats-value.danger {
  color: #F56C6C;
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