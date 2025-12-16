<template>
  <div class="safety-monitor-container">
    <!-- 状态概览卡片 -->
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

    <!-- 监控内容 -->
    <el-row :gutter="20" class="mt-20">
      <!-- 设备状态监控 -->
      <el-col :span="12">
        <el-card class="monitor-card">
          <template #header>
            <div class="card-header">
              <span>设备状态监控</span>
              <el-button type="primary" @click="refreshDeviceStatus">刷新</el-button>
            </div>
          </template>
          <div class="device-list">
            <div v-for="(device, index) in deviceStatus" :key="index" class="device-item">
              <div class="device-info">
                <span class="device-name">{{ device.name }}</span>
                <el-tag :type="device.status === 'normal' ? 'success' : 'danger'" size="small">
                  {{ device.status === 'normal' ? '正常' : '异常' }}
                </el-tag>
              </div>
              <el-progress
                :percentage="device.health"
                :status="device.status === 'normal' ? 'success' : 'exception'"
                :stroke-width="10"
              />
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- 实时预警信息 -->
      <el-col :span="12">
        <el-card class="monitor-card">
          <template #header>
            <div class="card-header">
              <span>实时预警信息</span>
              <el-button type="primary" @click="handleAddAlert">添加预警</el-button>
            </div>
          </template>
          <el-table :data="alertList" style="width: 100%" height="400">
            <el-table-column prop="time" label="时间" width="180" />
            <el-table-column prop="level" label="级别" width="100">
              <template #default="{ row }">
                <el-tag :type="getAlertLevelType(row.level)">{{ row.level }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="content" label="内容" />
            <el-table-column prop="status" label="状态" width="100">
              <template #default="{ row }">
                <el-tag :type="row.status === '已处理' ? 'success' : 'warning'">
                  {{ row.status }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="120">
              <template #default="{ row }">
                <el-button type="primary" link @click="handleProcessAlert(row)">
                  {{ row.status === '已处理' ? '查看' : '处理' }}
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <!-- 安全数据图表 -->
    <el-row :gutter="20" class="mt-20">
      <el-col :span="24">
        <el-card class="monitor-card">
          <template #header>
            <div class="card-header">
              <span>安全数据趋势</span>
              <el-radio-group v-model="chartTimeRange" size="small">
                <el-radio-button label="day">24小时</el-radio-button>
                <el-radio-button label="week">7天</el-radio-button>
                <el-radio-button label="month">30天</el-radio-button>
              </el-radio-group>
            </div>
          </template>
          <div ref="chartRef" class="chart-container"></div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 添加预警对话框 -->
    <el-dialog
      v-model="dialogVisible"
      title="添加预警信息"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="预警级别" prop="level">
          <el-select v-model="form.level" placeholder="请选择预警级别">
            <el-option label="一般" value="一般" />
            <el-option label="重要" value="重要" />
            <el-option label="紧急" value="紧急" />
          </el-select>
        </el-form-item>
        <el-form-item label="预警内容" prop="content">
          <el-input
            v-model="form.content"
            type="textarea"
            rows="3"
            placeholder="请输入预警内容"
          />
        </el-form-item>
        <el-form-item label="处理状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择处理状态">
            <el-option label="未处理" value="未处理" />
            <el-option label="处理中" value="处理中" />
            <el-option label="已处理" value="已处理" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
import { ElMessage } from 'element-plus'
import * as echarts from 'echarts'
import {
  Warning,
  Monitor,
  Connection,
  Ship
} from '@element-plus/icons-vue'

// 状态卡片数据
const statusCards = [
  {
    label: '设备总数',
    value: '24',
    icon: 'Monitor',
    type: 'primary'
  },
  {
    label: '异常设备',
    value: '2',
    icon: 'Warning',
    type: 'danger'
  },
  {
    label: '在线设备',
    value: '22',
    icon: 'Connection',
    type: 'success'
  },
  {
    label: '船舶状态',
    value: '正常',
    icon: 'Ship',
    type: 'info'
  }
]

// 设备状态数据
const deviceStatus = ref([
  {
    name: 'GPS定位系统',
    status: 'normal',
    health: 95
  },
  {
    name: '雷达系统',
    status: 'normal',
    health: 88
  },
  {
    name: '通信系统',
    status: 'error',
    health: 45
  },
  {
    name: '动力系统',
    status: 'normal',
    health: 92
  }
])

// 预警列表数据
const alertList = ref([
  {
    time: '2024-01-20 10:30:00',
    level: '紧急',
    content: '通信系统异常，需要立即处理',
    status: '未处理'
  },
  {
    time: '2024-01-20 09:15:00',
    level: '重要',
    content: '雷达系统信号弱',
    status: '处理中'
  }
])

// 图表相关
const chartRef = ref(null)
const chart = ref(null)
const chartTimeRange = ref('day')

// 对话框相关
const dialogVisible = ref(false)
const formRef = ref()
const form = reactive({
  level: '',
  content: '',
  status: '未处理'
})

// 表单验证规则
const rules = {
  level: [{ required: true, message: '请选择预警级别', trigger: 'change' }],
  content: [{ required: true, message: '请输入预警内容', trigger: 'blur' }],
  status: [{ required: true, message: '请选择处理状态', trigger: 'change' }]
}

// 获取预警级别对应的标签类型
const getAlertLevelType = (level) => {
  const map = {
    '一般': 'info',
    '重要': 'warning',
    '紧急': 'danger'
  }
  return map[level] || ''
}

// 刷新设备状态
const refreshDeviceStatus = () => {
  // TODO: 实现刷新逻辑
  ElMessage.success('设备状态已更新')
}

// 添加预警
const handleAddAlert = () => {
  dialogVisible.value = true
  form.level = ''
  form.content = ''
  form.status = '未处理'
}

// 处理预警
const handleProcessAlert = (row) => {
  // TODO: 实现处理逻辑
  ElMessage.success('预警状态已更新')
}

// 提交表单
const handleSubmit = async () => {
  await formRef.value.validate()
  // TODO: 实现提交逻辑
  ElMessage.success('预警信息已添加')
  dialogVisible.value = false
}

// 初始化图表
const initChart = () => {
  if (chartRef.value) {
    chart.value = echarts.init(chartRef.value)
    const option = {
      tooltip: {
        trigger: 'axis'
      },
      legend: {
        data: ['设备异常', '预警数量']
      },
      xAxis: {
        type: 'category',
        data: ['00:00', '03:00', '06:00', '09:00', '12:00', '15:00', '18:00', '21:00']
      },
      yAxis: {
        type: 'value'
      },
      series: [
        {
          name: '设备异常',
          type: 'line',
          data: [2, 3, 1, 2, 1, 2, 1, 2]
        },
        {
          name: '预警数量',
          type: 'line',
          data: [3, 4, 2, 3, 2, 3, 2, 3]
        }
      ]
    }
    chart.value.setOption(option)
  }
}

// 监听窗口大小变化
const handleResize = () => {
  chart.value?.resize()
}

onMounted(() => {
  initChart()
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
  chart.value?.dispose()
})
</script>

<style scoped>
.safety-monitor-container {
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

.monitor-card .card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.device-list .device-item {
  margin-bottom: 20px;
}

.device-list .device-item:last-child {
  margin-bottom: 0;
}

.device-list .device-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.device-list .device-name {
  font-weight: 500;
}

.chart-container {
  height: 400px;
}
</style> 