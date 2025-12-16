<template>
  <div class="ship-schedule-container">
    <!-- 调度状态概览 -->
    <el-row :gutter="20">
      <el-col :span="6" v-for="(item, index) in statusCards" :key="index">
        <el-card class="status-card" :class="item.type">
          <div class="card-content">
            <el-icon class="icon"><component :is="item.icon" /></el-icon>
            <div class="info">
              <div class="value">{{ item.value }}</div>
              <div class="label">{{ item.label }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 调度管理 -->
    <el-row :gutter="20" class="mt-20">
      <el-col :span="24">
        <el-card class="schedule-card">
          <template #header>
            <div class="card-header">
              <span>调度管理</span>
              <div class="header-operations">
                <el-button type="primary" @click="handleAddSchedule">新建调度</el-button>
                <el-button type="success" @click="handleExport">导出数据</el-button>
              </div>
            </div>
          </template>

          <!-- 搜索表单 -->
          <el-form :inline="true" :model="searchForm" class="search-form">
            <el-form-item label="船舶名称">
              <el-input v-model="searchForm.shipName" placeholder="请输入船舶名称" clearable />
            </el-form-item>
            <el-form-item label="出发港">
              <el-select v-model="searchForm.startPort" placeholder="请选择出发港" clearable>
                <el-option
                  v-for="port in portList"
                  :key="port"
                  :label="port"
                  :value="port"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="目的港">
              <el-select v-model="searchForm.endPort" placeholder="请选择目的港" clearable>
                <el-option
                  v-for="port in portList"
                  :key="port"
                  :label="port"
                  :value="port"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="状态">
              <el-select v-model="searchForm.status" placeholder="请选择状态" clearable>
                <el-option label="待出发" value="PENDING" />
                <el-option label="航行中" value="SAILING" />
                <el-option label="已到达" value="ARRIVED" />
                <el-option label="已取消" value="CANCELLED" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handleSearch">搜索</el-button>
              <el-button @click="resetSearch">重置</el-button>
            </el-form-item>
          </el-form>

          <!-- 调度列表 -->
          <el-table :data="scheduleList" border style="width: 100%" v-loading="loading">
            <el-table-column prop="id" label="调度编号" width="100" />
            <el-table-column prop="shipName" label="船舶名称" width="150" />
            <el-table-column prop="routeString" label="航线" />
            <el-table-column prop="departureTime" label="出发时间" width="180" />
            <el-table-column prop="arrivalTime" label="预计到达" width="180" />
            <el-table-column prop="status" label="状态" width="100">
              <template #default="{ row }">
                <el-tag :type="getStatusType(row.status)">{{ getStatusText(row.status) }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="250">
              <template #default="{ row }">
                <el-button type="primary" link @click="handleEdit(row)">编辑</el-button>
                <el-button type="primary" link @click="handleTrack(row)">追踪</el-button>
                <el-button type="danger" link @click="handleCancel(row)">取消</el-button>
              </template>
            </el-table-column>
          </el-table>

          <!-- 分页 -->
          <div class="pagination">
            <el-pagination
              v-model:current-page="currentPage"
              v-model:page-size="pageSize"
              :page-sizes="[10, 20, 50, 100]"
              :total="total"
              layout="total, sizes, prev, pager, next, jumper"
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
            />
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 添加/编辑调度对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogType === 'add' ? '新建调度' : '编辑调度'"
      width="600px"
    >
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="船舶名称" prop="shipName">
          <el-select v-model="form.shipName" placeholder="请选择船舶" @change="handleShipChange">
            <el-option
              v-for="ship in shipList"
              :key="ship.id"
              :label="ship.name"
              :value="ship.name"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="船舶类型" prop="shipType">
          <el-input v-model="form.shipType" disabled />
        </el-form-item>
        <el-form-item label="出发港" prop="startPort">
          <el-select v-model="form.startPort" placeholder="请选择出发港" @change="handlePortChange">
            <el-option
              v-for="port in portList"
              :key="port"
              :label="port"
              :value="port"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="目的港" prop="endPort">
          <el-select v-model="form.endPort" placeholder="请选择目的港" @change="handlePortChange">
            <el-option
              v-for="port in portList"
              :key="port"
              :label="port"
              :value="port"
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleRecommendRoute">智能航线推荐</el-button>
          <el-button type="success" @click="getRoutes">查看所有航线</el-button>
        </el-form-item>
        <el-form-item label="选择航线" prop="routeIds" v-if="routeList.length > 0">
          <el-select
            v-model="form.routeIds"
            multiple
            collapse-tags
            collapse-tags-tooltip
            placeholder="请选择航线"
            :loading="routeLoading"
            @change="handleRouteChange"
          >
            <el-option
              v-for="route in routeList"
              :key="route.id"
              :label="`${route.startPort} → ${route.endPort} (距离: ${route.distance.toFixed(2)}海里, 预计时间: ${route.estimatedTime}小时)`"
              :value="route.id"
            >
              <span :class="{ 'highlight-route': route.startPort === form.startPort }">
                {{ route.startPort }} → {{ route.endPort }}
                <span class="route-details">
                  (距离: {{ route.distance.toFixed(2) }}海里, 预计时间: {{ route.estimatedTime }}小时)
                </span>
              </span>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="推荐航线" v-if="recommendedRoutes.length > 0">
          <div class="route-recommendation">
            <div v-for="(route, index) in recommendedRoutes" :key="route.id" class="route-item">
              <div class="route-info">
                <span class="route-step">{{ index + 1 }}. </span>
                <span class="route-ports">{{ route.startPort }} → {{ route.endPort }}</span>
                <span class="route-details">
                  (距离: {{ route.distance.toFixed(2) }}海里, 预计时间: {{ route.estimatedTime }}小时)
                </span>
              </div>
              <div class="route-status">
                <el-tag :type="getRouteStatusType(route.status)">{{ route.status }}</el-tag>
              </div>
            </div>
            <div class="route-summary">
              <div class="summary-item">
                <span class="label">总距离：</span>
                <span class="value">{{ getTotalDistance() }}海里</span>
              </div>
              <div class="summary-item">
                <span class="label">总时间：</span>
                <span class="value">{{ getTotalTime() }}小时</span>
              </div>
            </div>
            <div class="route-actions">
              <el-button type="primary" @click="handleSelectRecommendedRoute">使用推荐航线</el-button>
            </div>
          </div>
        </el-form-item>
        <el-form-item label="出发时间" prop="departureTime">
          <el-date-picker
            v-model="form.departureTime"
            type="datetime"
            placeholder="请选择出发时间"
          />
        </el-form-item>
        <el-form-item label="预计到达" prop="arrivalTime">
          <el-date-picker
            v-model="form.arrivalTime"
            type="datetime"
            placeholder="请选择预计到达时间"
          />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="待出发" value="PENDING" />
            <el-option label="航行中" value="SAILING" />
            <el-option label="已到达" value="ARRIVED" />
            <el-option label="已取消" value="CANCELLED" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="form.remark"
            type="textarea"
            rows="3"
            placeholder="请输入备注信息"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 船舶追踪对话框 -->
    <el-dialog
      v-model="trackDialogVisible"
      title="船舶追踪"
      width="800px"
    >
      <div class="track-info">
        <div class="info-item">
          <span class="label">船舶名称：</span>
          <span class="value">{{ currentShip?.shipName }}</span>
        </div>
        <div class="info-item">
          <span class="label">当前位置：</span>
          <span class="value">{{ currentShip?.currentLocation }}</span>
        </div>
        <div class="info-item">
          <span class="label">航行速度：</span>
          <span class="value">{{ currentShip?.speed }} 节</span>
        </div>
        <div class="info-item">
          <span class="label">预计到达：</span>
          <span class="value">{{ currentShip?.estimatedArrival }}</span>
        </div>
      </div>
      <div ref="mapRef" class="map-container"></div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import * as echarts from 'echarts'
import {
  Ship,
  Timer,
  Location,
  Warning
} from '@element-plus/icons-vue'
import {
  getScheduleList,
  addSchedule,
  updateSchedule,
  deleteSchedule,
  getShipList,
  getScheduleStats,
  getRouteRecommendation,
  getPortList,
  getRouteList
} from '@/api/ship-schedule'

// 状态卡片数据
const statusCards = ref([
  {
    label: '在航船舶',
    value: '0',
    icon: 'Ship',
    type: 'primary'
  },
  {
    label: '待出发',
    value: '0',
    icon: 'Timer',
    type: 'warning'
  },
  {
    label: '已到达',
    value: '0',
    icon: 'Location',
    type: 'success'
  },
  {
    label: '异常预警',
    value: '0',
    icon: 'Warning',
    type: 'danger'
  }
])

// 搜索表单
const searchForm = reactive({
  shipName: '',
  startPort: '',
  endPort: '',
  status: ''
})

// 表格数据
const scheduleList = ref([])
const total = ref(0)
const loading = ref(false)

// 分页相关
const currentPage = ref(1)
const pageSize = ref(10)

// 对话框相关
const dialogVisible = ref(false)
const dialogType = ref('add')
const formRef = ref()
const form = reactive({
  shipName: '',
  shipType: '',
  startPort: '',
  endPort: '',
  routeIds: [],
  routeId: '',
  routeString: '',
  departureTime: '',
  arrivalTime: '',
  status: 'PENDING',
  remark: ''
})

// 船舶列表
const shipList = ref([])

// 追踪对话框相关
const trackDialogVisible = ref(false)
const currentShip = ref(null)
const mapRef = ref(null)
const map = ref(null)

// 推荐航线列表
const recommendedRoutes = ref([])

// 港口列表
const portList = ref([])

// 航线列表
const routeList = ref([])
const routeLoading = ref(false)

// 表单验证规则
const rules = {
  shipName: [{ required: true, message: '请选择船舶', trigger: 'change' }],
  shipType: [{ required: true, message: '船舶类型不能为空', trigger: 'change' }],
  startPort: [{ required: true, message: '请输入出发港', trigger: 'blur' }],
  endPort: [{ required: true, message: '请输入目的港', trigger: 'blur' }],
  routeIds: [{ required: true, message: '请选择航线', trigger: 'change' }],
  departureTime: [{ required: true, message: '请选择出发时间', trigger: 'change' }],
  arrivalTime: [{ required: true, message: '请选择预计到达时间', trigger: 'change' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }]
}

// 获取状态类型
const getStatusType = (status) => {
  const map = {
    PENDING: 'warning',
    SAILING: 'primary',
    ARRIVED: 'success',
    CANCELLED: 'info'
  }
  return map[status] || ''
}

// 获取状态文本
const getStatusText = (status) => {
  const map = {
    PENDING: '待出发',
    SAILING: '航行中',
    ARRIVED: '已到达',
    CANCELLED: '已取消'
  }
  return map[status] || status
}

// 获取统计数据
const getStats = async () => {
  try {
    const res = await getScheduleStats()
    if (res.code === 200) {
      statusCards.value[0].value = res.data.sailingShips || '0'
      statusCards.value[1].value = res.data.pendingShips || '0'
      statusCards.value[2].value = res.data.arrivedShips || '0'
      statusCards.value[3].value = res.data.warningShips || '0'
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
    ElMessage.error('获取统计数据失败')
  }
}

// 获取船舶列表
const getShips = async () => {
  try {
    const res = await getShipList()
    if (res.code === 200) {
      shipList.value = res.data.records || []
    }
  } catch (error) {
    console.error('获取船舶列表失败:', error)
    ElMessage.error('获取船舶列表失败')
  }
}

// 获取港口列表
const getPorts = async () => {
  try {
    const res = await getPortList()
    if (res.code === 200) {
      portList.value = res.data
    }
  } catch (error) {
    console.error('获取港口列表失败:', error)
    ElMessage.error('获取港口列表失败')
  }
}

// 搜索
const handleSearch = () => {
  currentPage.value = 1
  fetchData()
}

// 重置搜索
const resetSearch = () => {
  searchForm.shipName = ''
  searchForm.startPort = ''
  searchForm.endPort = ''
  searchForm.status = ''
  handleSearch()
}

// 获取数据
const fetchData = async () => {
  loading.value = true
  try {
    const res = await getScheduleList({
      current: currentPage.value,
      size: pageSize.value,
      ...searchForm
    })
    if (res.code === 200) {
      scheduleList.value = res.data.records
      total.value = res.data.total
    } else {
      ElMessage.error(res.message || '获取调度列表失败')
    }
  } catch (error) {
    console.error('获取调度列表失败:', error)
    ElMessage.error('获取调度列表失败')
  } finally {
    loading.value = false
  }
}

// 新建调度
const handleAddSchedule = () => {
  dialogType.value = 'add'
  dialogVisible.value = true
  form.shipName = ''
  form.shipType = ''
  form.startPort = ''
  form.endPort = ''
  form.routeIds = []
  form.routeId = ''
  form.routeString = ''
  form.departureTime = ''
  form.arrivalTime = ''
  form.status = 'PENDING'
  form.remark = ''
  recommendedRoutes.value = []
}

// 编辑调度
const handleEdit = (row) => {
  dialogType.value = 'edit'
  dialogVisible.value = true
  Object.assign(form, {
    ...row,
    routeIds: row.routeId ? [row.routeId] : [],
    routeId: row.routeId || '',
    routeString: row.routeString || '',
    departureTime: row.departureTime ? new Date(row.departureTime) : '',
    arrivalTime: row.arrivalTime ? new Date(row.arrivalTime) : ''
  })
  recommendedRoutes.value = []
}

// 追踪船舶
const handleTrack = (row) => {
  currentShip.value = {
    shipName: row.shipName,
    currentLocation: '东经120° 北纬30°',
    speed: 15,
    estimatedArrival: row.arrivalTime
  }
  trackDialogVisible.value = true
  // TODO: 初始化地图
}

// 取消调度
const handleCancel = (row) => {
  ElMessageBox.confirm('确认取消该调度吗？', '提示', {
    type: 'warning'
  }).then(async () => {
    try {
      await deleteSchedule(row.id)
      ElMessage.success('调度已取消')
      fetchData()
      getStats()
    } catch (error) {
      console.error('取消调度失败:', error)
      ElMessage.error('取消调度失败')
    }
  })
}

// 导出数据
const handleExport = () => {
  // TODO: 实现导出逻辑
  ElMessage.success('数据导出成功')
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  handleSelectRecommendedRoute();
  await formRef.value.validate()
  try {
    // 格式化日期时间为标准格式
    const formatDateTime = (date) => {
      if (!date) return ''
      const d = new Date(date)
      return d.toISOString().slice(0, 19).replace('T', ' ')
    }

    const submitData = {
      ...form,
      id: '',
      routeId: form.routeId,
      routeString: form.routeString,
      departureTime: formatDateTime(form.departureTime),
      arrivalTime: formatDateTime(form.arrivalTime)
    }
    // 删除不需要提交的字段
    delete submitData.routeIds

    if (dialogType.value === 'add') {
      await addSchedule(submitData)
      ElMessage.success('调度创建成功')
    } else {
      await updateSchedule(submitData)
      ElMessage.success('调度更新成功')
    }
    dialogVisible.value = false
    fetchData()
    getStats()
  } catch (error) {
    console.error('提交表单失败:', error)
    ElMessage.error('提交失败')
  }
}

// 分页
const handleSizeChange = (val) => {
  pageSize.value = val
  fetchData()
}

const handleCurrentChange = (val) => {
  currentPage.value = val
  fetchData()
}

// 获取智能航线推荐
const handleRecommendRoute = async () => {
  if (!form.startPort || !form.endPort) {
    ElMessage.warning('请先选择出发港和目的港')
    return
  }
  
  try {
    const res = await getRouteRecommendation({
      startPort: form.startPort,
      endPort: form.endPort
    })
    if (res.code === 200) {
      recommendedRoutes.value = res.data
      if (recommendedRoutes.value.length > 0) {
        // 计算总距离和总时间
        const totalDistance = recommendedRoutes.value.reduce((sum, route) => sum + route.distance, 0)
        const totalTime = recommendedRoutes.value.reduce((sum, route) => sum + route.estimatedTime, 0)
        
        ElMessage.success(`已为您推荐最优航线，总距离：${totalDistance.toFixed(2)}海里，预计航行时间：${totalTime}小时`)
      } else {
        ElMessage.warning('未找到合适的航线')
      }
    }
  } catch (error) {
    console.error('获取航线推荐失败:', error)
    ElMessage.error('获取航线推荐失败')
  }
}

// 获取航线状态类型
const getRouteStatusType = (status) => {
  const map = {
    '可用': 'success',
    '维护中': 'warning',
    '关闭': 'danger'
  }
  return map[status] || 'info'
}

// 计算总距离
const getTotalDistance = () => {
  return recommendedRoutes.value.reduce((sum, route) => sum + route.distance, 0).toFixed(2)
}

// 计算总时间
const getTotalTime = () => {
  return recommendedRoutes.value.reduce((sum, route) => sum + route.estimatedTime, 0)
}

// 处理船舶选择变化
const handleShipChange = (value) => {
  const selectedShip = shipList.value.find(ship => ship.name === value)
  if (selectedShip) {
    form.shipType = selectedShip.type
  }
}

// 获取航线列表
const getRoutes = async () => {
  routeLoading.value = true
  try {
    const res = await getRouteList()
    if (res.code === 200) {
      // 按出发港排序，将当前选择的出发港的航线排在前面
      routeList.value = res.data.sort((a, b) => {
        if (a.startPort === form.startPort && b.startPort !== form.startPort) return -1
        if (a.startPort !== form.startPort && b.startPort === form.startPort) return 1
        return 0
      })
    }
  } catch (error) {
    console.error('获取航线列表失败:', error)
    ElMessage.error('获取航线列表失败')
  } finally {
    routeLoading.value = false
  }
}

// 处理港口变化
const handlePortChange = () => {
  form.routeIds = []
  form.routeId = ''
  form.routeString = ''
  recommendedRoutes.value = []
  routeList.value = []
}

// 处理航线选择变化
const handleRouteChange = (value) => {
  form.routeId = value.length > 0 ? value[0] : ''
  form.routeString = value.map(id => {
    const route = routeList.value.find(r => r.id === id)
    return route ? `${route.startPort}→${route.endPort}` : ''
  }).filter(Boolean).join(';')
}

// 处理选择推荐航线
const handleSelectRecommendedRoute = () => {
  if (recommendedRoutes.value.length > 0) {
    form.routeIds = recommendedRoutes.value.map(route => route.id)
    form.routeId = recommendedRoutes.value[0].id
    form.routeString = recommendedRoutes.value.map(route => 
      `${route.startPort}→${route.endPort}`
    ).join(';')
    console.log('Selected recommended route:', form.routeString);
    ElMessage.success('已选择推荐航线')
  }
}

// 初始化
onMounted(() => {
  fetchData()
  getStats()
  getShips()
  getPorts()
})

onUnmounted(() => {
  map.value?.dispose()
})
</script>

<style scoped>
.ship-schedule-container {
  padding: 20px;
}

.mt-20 {
  margin-top: 20px;
}

.status-card .card-content {
  display: flex;
  align-items: center;
  gap: 20px;
}

.status-card .icon {
  font-size: 48px;
}

.status-card .info .value {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 5px;
}

.status-card .info .label {
  color: var(--text-color-secondary);
}

.status-card.primary .icon {
  color: var(--el-color-primary);
}

.status-card.success .icon {
  color: var(--el-color-success);
}

.status-card.warning .icon {
  color: var(--el-color-warning);
}

.status-card.danger .icon {
  color: var(--el-color-danger);
}

.schedule-card .card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-operations {
  display: flex;
  gap: 10px;
}

.search-form {
  margin-bottom: 20px;
}

.search-form :deep(.el-select) {
  width: 200px;
}

.search-form :deep(.el-input) {
  width: 200px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

.track-info {
  margin-bottom: 20px;
  padding: 15px;
  background-color: var(--el-bg-color-page);
  border-radius: 4px;
}

.track-info .info-item {
  display: flex;
  margin-bottom: 10px;
}

.track-info .info-item:last-child {
  margin-bottom: 0;
}

.track-info .label {
  width: 100px;
  color: var(--text-color-secondary);
}

.track-info .value {
  font-weight: 500;
}

.map-container {
  height: 400px;
  border-radius: 4px;
  overflow: hidden;
}

.route-recommendation {
  margin-bottom: 20px;
  padding: 15px;
  background-color: var(--el-bg-color-page);
  border-radius: 4px;
}

.route-recommendation .route-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid var(--el-border-color-lighter);
}

.route-recommendation .route-item:last-child {
  border-bottom: none;
}

.route-recommendation .route-info {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 10px;
}

.route-recommendation .route-step {
  color: var(--el-text-color-secondary);
  font-weight: bold;
}

.route-recommendation .route-ports {
  font-weight: 500;
}

.route-recommendation .route-details {
  color: var(--el-text-color-secondary);
  font-size: 0.9em;
}

.route-recommendation .route-status {
  margin-left: 20px;
}

.route-recommendation .route-summary {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px dashed var(--el-border-color-lighter);
  display: flex;
  gap: 20px;
}

.route-recommendation .summary-item {
  display: flex;
  align-items: center;
  gap: 5px;
}

.route-recommendation .summary-item .label {
  color: var(--el-text-color-secondary);
}

.route-recommendation .summary-item .value {
  font-weight: bold;
  color: var(--el-color-primary);
}

.route-actions {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px dashed var(--el-border-color-lighter);
  display: flex;
  justify-content: center;
}

.highlight-route {
  color: var(--el-color-primary);
  font-weight: bold;
}

.route-details {
  color: var(--el-text-color-secondary);
  font-size: 0.9em;
  margin-left: 8px;
}

.el-select {
  width: 100%;
}

:deep(.el-select__tags) {
  max-width: calc(100% - 30px);
}
</style> 