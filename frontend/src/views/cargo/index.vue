<template>
  <div class="cargo-container">
    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="船名">
          <el-input v-model="queryParams.shipName" placeholder="请输入船名" clearable />
        </el-form-item>
        <el-form-item label="货物种类">
          <el-select v-model="queryParams.cargoType" placeholder="请选择货物种类" clearable>
            <el-option label="散货" value="BULK" />
            <el-option label="集装箱" value="CONTAINER" />
            <el-option label="液体" value="LIQUID" />
            <el-option label="危险品" value="DANGEROUS" />
            <el-option label="其他" value="OTHER" />
          </el-select>
        </el-form-item>
        <el-form-item label="运输状态">
          <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
            <el-option label="待装货" value="PENDING" />
            <el-option label="运输中" value="SHIPPING" />
            <el-option label="已到达" value="ARRIVED" />
            <el-option label="已取消" value="CANCELLED" />
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
          <span>货物列表</span>
          <el-button type="primary" @click="handleAdd">添加货物</el-button>
        </div>
      </template>

      <!-- 数据表格 -->
      <el-table v-loading="loading" :data="cargoList" border>
        <el-table-column type="index" label="序号" width="50" />
        <el-table-column prop="shipName" label="船名" />
        <el-table-column prop="origin" label="始发地" />
        <el-table-column prop="destination" label="目的地" />
        <el-table-column prop="loadingTime" label="预装时间" width="180" />
        <el-table-column prop="cargoType" label="货物种类">
          <template #default="{ row }">
            <el-tag>{{ getCargoTypeLabel(row.cargoType) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="weight" label="重量(吨)" />
        <el-table-column prop="volume" label="体积(m³)" />
        <el-table-column prop="price" label="价格(元)" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="getStatusType(row.status)">
              {{ getStatusLabel(row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="username" label="用户名" />
        <el-table-column prop="date" label="日期" width="180" />
        <el-table-column prop="address" label="地址" show-overflow-tooltip />
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
      width="600px"
      append-to-body
    >
      <el-form
        ref="cargoFormRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="船名" prop="shipName">
          <el-input v-model="form.shipName" placeholder="请输入船名" />
        </el-form-item>
        <el-form-item label="始发地" prop="origin">
          <el-input v-model="form.origin" placeholder="请输入始发地" />
        </el-form-item>
        <el-form-item label="目的地" prop="destination">
          <el-input v-model="form.destination" placeholder="请输入目的地" />
        </el-form-item>
        <el-form-item label="预装时间" prop="loadingTime">
          <el-date-picker
            v-model="form.loadingTime"
            type="datetime"
            placeholder="请选择预装时间"
            value-format="YYYY-MM-DD HH:mm:ss"
          />
        </el-form-item>
        <el-form-item label="货物种类" prop="cargoType">
          <el-select v-model="form.cargoType" placeholder="请选择货物种类">
            <el-option label="散货" value="BULK" />
            <el-option label="集装箱" value="CONTAINER" />
            <el-option label="液体" value="LIQUID" />
            <el-option label="危险品" value="DANGEROUS" />
            <el-option label="其他" value="OTHER" />
          </el-select>
        </el-form-item>
        <el-form-item label="重量" prop="weight">
          <el-input-number v-model="form.weight" :min="0" :precision="2" placeholder="请输入重量" />
        </el-form-item>
        <el-form-item label="体积" prop="volume">
          <el-input-number v-model="form.volume" :min="0" :precision="2" placeholder="请输入体积" />
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input-number v-model="form.price" :min="0" :precision="2" placeholder="请输入价格" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="待装货" value="PENDING" />
            <el-option label="运输中" value="SHIPPING" />
            <el-option label="已到达" value="ARRIVED" />
            <el-option label="已取消" value="CANCELLED" />
          </el-select>
        </el-form-item>
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="日期" prop="date">
          <el-date-picker
            v-model="form.date"
            type="datetime"
            placeholder="请选择日期"
            value-format="YYYY-MM-DD HH:mm:ss"
          />
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="form.address" type="textarea" placeholder="请输入地址" />
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
import { getCargoList, addCargo, updateCargo, deleteCargo } from '@/api/cargo'

// 查询参数
const queryParams = reactive({
  current: 1,
  size: 10,
  shipName: '',
  cargoType: undefined,
  status: undefined
})

// 数据列表
const cargoList = ref([])
const total = ref(0)
const loading = ref(false)

// 表单参数
const form = reactive({
  id: undefined,
  shipName: '',
  origin: '',
  destination: '',
  loadingTime: '',
  cargoType: '',
  weight: 0,
  volume: 0,
  price: 0,
  status: '',
  username: '',
  date: '',
  address: ''
})

// 表单校验规则
const rules = {
  shipName: [{ required: true, message: '请输入船名', trigger: 'blur' }],
  origin: [{ required: true, message: '请输入始发地', trigger: 'blur' }],
  destination: [{ required: true, message: '请输入目的地', trigger: 'blur' }],
  loadingTime: [{ required: true, message: '请选择预装时间', trigger: 'change' }],
  cargoType: [{ required: true, message: '请选择货物种类', trigger: 'change' }],
  weight: [{ required: true, message: '请输入重量', trigger: 'blur' }],
  volume: [{ required: true, message: '请输入体积', trigger: 'blur' }],
  price: [{ required: true, message: '请输入价格', trigger: 'blur' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }],
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  date: [{ required: true, message: '请选择日期', trigger: 'change' }],
  address: [{ required: true, message: '请输入地址', trigger: 'blur' }]
}

// 对话框控制
const dialog = reactive({
  visible: false,
  title: ''
})

// 表单引用
const cargoFormRef = ref()

// 获取货物种类标签
const getCargoTypeLabel = (type) => {
  const typeMap = {
    'BULK': '散货',
    'CONTAINER': '集装箱',
    'LIQUID': '液体',
    'DANGEROUS': '危险品',
    'OTHER': '其他'
  }
  return typeMap[type] || type
}

// 获取状态标签
const getStatusLabel = (status) => {
  const statusMap = {
    'PENDING': '待装货',
    'SHIPPING': '运输中',
    'ARRIVED': '已到达',
    'CANCELLED': '已取消'
  }
  return statusMap[status] || status
}

// 获取状态类型
const getStatusType = (status) => {
  const typeMap = {
    'PENDING': 'warning',
    'SHIPPING': 'primary',
    'ARRIVED': 'success',
    'CANCELLED': 'danger'
  }
  return typeMap[status] || ''
}

// 获取列表数据
const getList = async () => {
  loading.value = true
  try {
    const res = await getCargoList(queryParams)
    if (res.code === 200) {
      cargoList.value = res.data.records || []
      total.value = res.data.total || 0
    } else {
      ElMessage.error(res.message || '获取货物列表失败')
    }
  } catch (error) {
    console.error('获取货物列表失败:', error)
    ElMessage.error('获取货物列表失败')
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
  queryParams.shipName = ''
  queryParams.cargoType = undefined
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
  dialog.title = '添加货物'
  dialog.visible = true
  Object.assign(form, {
    id: undefined,
    shipName: '',
    origin: '',
    destination: '',
    loadingTime: '',
    cargoType: '',
    weight: 0,
    volume: 0,
    price: 0,
    status: '',
    username: '',
    date: '',
    address: ''
  })
}

// 修改按钮操作
const handleUpdate = (row) => {
  dialog.title = '修改货物'
  dialog.visible = true
  Object.assign(form, row)
}

// 删除按钮操作
const handleDelete = (row) => {
  ElMessageBox.confirm('确认要删除该货物吗？', '警告', {
    type: 'warning'
  }).then(async () => {
    try {
      await deleteCargo(row.id)
      ElMessage.success('删除成功')
      getList()
    } catch (error) {
      console.error('删除货物失败:', error)
      ElMessage.error('删除失败')
    }
  })
}

// 表单提交
const submitForm = async () => {
  if (!cargoFormRef.value) return
  
  await cargoFormRef.value.validate()
  try {
    if (form.id) {
      await updateCargo(form)
      ElMessage.success('修改成功')
    } else {
      await addCargo(form)
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
  cargoFormRef.value?.resetFields()
}

// 初始化
onMounted(() => {
  getList()
})
</script>

<style scoped>
.cargo-container {
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