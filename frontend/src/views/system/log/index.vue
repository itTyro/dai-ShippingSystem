<template>
  <div class="system-log-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>系统日志</span>
        </div>
      </template>

      <!-- 搜索表单 -->
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="用户名">
          <el-input v-model="searchForm.username" placeholder="请输入用户名" clearable />
        </el-form-item>
        <el-form-item label="操作类型">
          <el-input v-model="searchForm.operation" placeholder="请输入操作类型" clearable />
        </el-form-item>
        <el-form-item label="时间范围">
          <el-date-picker
            v-model="searchForm.timeRange"
            type="datetimerange"
            range-separator="至"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            value-format="YYYY-MM-DD HH:mm:ss"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>

      <!-- 日志列表 -->
      <el-table :data="logList" border style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="username" label="用户名" width="120" />
        <el-table-column prop="operation" label="操作类型" width="120" />
        <el-table-column prop="method" label="请求方法" width="180" />
        <el-table-column prop="params" label="请求参数" show-overflow-tooltip />
        <el-table-column prop="ip" label="IP地址" width="120" />
        <el-table-column prop="createTime" label="操作时间" width="180" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 0 ? 'success' : 'danger'">
              {{ row.status === 0 ? '正常' : '异常' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="errorMsg" label="错误信息" show-overflow-tooltip />
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
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { getLogList } from '@/api/system-log'

// 搜索表单
const searchForm = reactive({
  username: '',
  operation: '',
  timeRange: []
})

// 表格数据
const logList = ref([])
const total = ref(0)
const loading = ref(false)

// 分页相关
const currentPage = ref(1)
const pageSize = ref(10)

// 获取数据
const fetchData = async () => {
  loading.value = true
  try {
    const params = {
      current: currentPage.value,
      size: pageSize.value,
      username: searchForm.username,
      operation: searchForm.operation,
      startTime: searchForm.timeRange?.[0],
      endTime: searchForm.timeRange?.[1]
    }
    const res = await getLogList(params)
    if (res.code === 200) {
      logList.value = res.data.records
      total.value = res.data.total
    } else {
      ElMessage.error(res.message || '获取日志列表失败')
    }
  } catch (error) {
    console.error('获取日志列表失败:', error)
    ElMessage.error('获取日志列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  currentPage.value = 1
  fetchData()
}

// 重置搜索
const resetSearch = () => {
  searchForm.username = ''
  searchForm.operation = ''
  searchForm.timeRange = []
  handleSearch()
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

// 初始化
onMounted(() => {
  fetchData()
})
</script>

<style scoped>
.system-log-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.search-form {
  margin-bottom: 20px;
}

.search-form :deep(.el-input) {
  width: 200px;
}

.search-form :deep(.el-date-editor) {
  width: 360px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style> 