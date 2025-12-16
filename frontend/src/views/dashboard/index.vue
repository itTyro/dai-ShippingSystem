<template>
  <div class="dashboard-container">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>船员总数</span>
            </div>
          </template>
          <div class="card-body">
            <h2>{{ statistics.crewCount }}</h2>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>船舶总数</span>
            </div>
          </template>
          <div class="card-body">
            <h2>{{ statistics.shipCount }}</h2>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>货物总数</span>
            </div>
          </template>
          <div class="card-body">
            <h2>{{ statistics.cargoCount }}</h2>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>航行任务</span>
            </div>
          </template>
          <div class="card-body">
            <h2>{{ statistics.taskCount }}</h2>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="mt-20">
      <el-col :span="12">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>船舶状态分布</span>
            </div>
          </template>
          <div class="chart-container">
            <div ref="shipStatusChart" style="width: 100%; height: 300px"></div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>货物类型分布</span>
            </div>
          </template>
          <div class="chart-container">
            <div ref="cargoTypeChart" style="width: 100%; height: 300px"></div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import * as echarts from 'echarts'
import { getStatistics } from '@/api/dashboard'

const statistics = ref({
  crewCount: 0,
  shipCount: 0,
  cargoCount: 0,
  taskCount: 0
})

const shipStatusChart = ref(null)
const cargoTypeChart = ref(null)

onMounted(async () => {
  try {
    const res = await getStatistics()
    if (res.code === 200) {
      statistics.value = {
        crewCount: res.data.crewCount,
        shipCount: res.data.shipCount,
        cargoCount: res.data.cargoCount,
        taskCount: res.data.taskCount
      }
      
      // 渲染船舶状态分布图表
      renderShipStatusChart(res.data.shipStatus)
      
      // 渲染货物类型分布图表
      renderCargoTypeChart(res.data.cargoType)
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
})

const renderShipStatusChart = (data) => {
  const chart = echarts.init(shipStatusChart.value)
  const option = {
    title: {
      text: '船舶状态分布',
      left: 'center',
      top: 10,
      textStyle: {
        fontSize: 16
      }
    },
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} ({d}%)'
    },
    legend: {
      orient: 'vertical',
      left: 'left',
      top: 'middle',
      itemWidth: 10,
      itemHeight: 10,
      textStyle: {
        fontSize: 12
      }
    },
    series: [
      {
        type: 'pie',
        radius: ['40%', '70%'],
        center: ['60%', '50%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderRadius: 4,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: true,
          formatter: '{b}\n{d}%',
          fontSize: 12
        },
        emphasis: {
          label: {
            show: true,
            fontSize: 14,
            fontWeight: 'bold'
          }
        },
        data: Object.entries(data).map(([name, value]) => ({ name, value }))
      }
    ]
  }
  chart.setOption(option)
}

const renderCargoTypeChart = (data) => {
  const chart = echarts.init(cargoTypeChart.value)
  const option = {
    title: {
      text: '货物类型分布',
      left: 'center',
      top: 10,
      textStyle: {
        fontSize: 16
      }
    },
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} ({d}%)'
    },
    legend: {
      orient: 'vertical',
      left: 'left',
      top: 'middle',
      itemWidth: 10,
      itemHeight: 10,
      textStyle: {
        fontSize: 12
      }
    },
    series: [
      {
        type: 'pie',
        radius: ['40%', '70%'],
        center: ['60%', '50%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderRadius: 4,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: true,
          formatter: '{b}\n{d}%',
          fontSize: 12
        },
        emphasis: {
          label: {
            show: true,
            fontSize: 14,
            fontWeight: 'bold'
          }
        },
        data: Object.entries(data).map(([name, value]) => ({ name, value }))
      }
    ]
  }
  chart.setOption(option)
}
</script>

<style scoped>
.dashboard-container {
  padding: 20px;
}

.mt-20 {
  margin-top: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-body {
  text-align: center;
}

.chart-container {
  padding: 10px;
}
</style>