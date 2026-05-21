<template>
  <view class="order-list">
    <view class="tab-bar">
      <view class="tab-item" :class="{ active: activeTab === '' }" @click="switchTab('')">全部</view>
      <view class="tab-item" :class="{ active: activeTab === '0' }" @click="switchTab('0')">待审批</view>
      <view class="tab-item" :class="{ active: activeTab === '1' }" @click="switchTab('1')">使用中</view>
    </view>

    <scroll-view class="list-scroll" scroll-y @scrolltolower="loadMore">
      <view v-if="loading" class="loading-tip">
        <uni-load-more status="loading"></uni-load-more>
      </view>
      <view v-else-if="orderList.length === 0" class="empty-tip">
        <uni-icons type="list" size="48" color="#ccc"></uni-icons>
        <text class="empty-text">暂无预约记录</text>
      </view>
      <view v-else class="card-list">
        <view class="order-card" v-for="item in orderList" :key="item.orderId" @click="goDetail(item)">
          <view class="card-header">
            <text class="card-equipment">{{ item.equipmentName || '设备' }}</text>
            <text class="card-quantity" v-if="item.quantity">x{{ item.quantity }}</text>
          </view>
          <view class="card-body">
            <view class="card-row">
              <text class="card-label">预约时间</text>
              <text class="card-value">{{ item.reserveTime || '-' }}</text>
            </view>
            <view class="card-row">
              <text class="card-label">预计归还</text>
              <text class="card-value">{{ item.expectReturnTime || '-' }}</text>
            </view>
            <view class="card-row">
              <text class="card-label">状态</text>
              <text class="card-status" :style="{ color: getStatusColor(item.orderStatus) }">{{ getStatusText(item.orderStatus) }}</text>
            </view>
          </view>
          <view class="card-footer">
            <text class="detail-link">查看详情</text>
            <text v-if="item.orderStatus === '0'" class="cancel-link" @click.stop="handleCancel(item)">取消</text>
          </view>
        </view>
      </view>
      <view v-if="orderList.length > 0 && !loading" class="load-more-tip">
        <uni-load-more :status="hasMore ? 'more' : 'noMore'"></uni-load-more>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
  import { ref } from 'vue'
  import { onShow } from '@dcloudio/uni-app'
  import { myOrderList, cancelOrder } from '@/api/order'

  const activeTab = ref('')
  const orderList = ref([])
  const page = ref(1)
  const total = ref(0)
  const loading = ref(false)
  const hasMore = ref(true)

  onShow(() => {
    page.value = 1
    loadOrders()
  })

  async function loadOrders() {
    loading.value = true
    try {
      const params = { pageNum: page.value, pageSize: 10 }
      if (activeTab.value) {
        params.orderStatus = activeTab.value
      }
      const res = await myOrderList(params)
      orderList.value = res.rows || []
      total.value = res.total || 0
      hasMore.value = orderList.value.length < total.value
    } catch (e) {
      // ignore
    } finally {
      loading.value = false
    }
  }

  function loadMore() {
    if (loading.value || !hasMore.value) return
    page.value++
    loadOrders()
  }

  function switchTab(tab) {
    activeTab.value = tab
    page.value = 1
    loadOrders()
  }

  function goDetail(item) {
    uni.navigateTo({ url: '/pages/order/detail?id=' + item.orderId })
  }

  async function handleCancel(item) {
    const res = await uni.showModal({ title: '提示', content: '确定取消该预约吗？' })
    if (res.confirm) {
      try {
        await cancelOrder(item.orderId)
        uni.showToast({ title: '已取消', icon: 'success' })
        loadOrders()
      } catch (e) {
        // ignore
      }
    }
  }

  function getStatusText(status) {
    const map = { '0': '待审批', '1': '使用中', '2': '已拒绝', '3': '已归还', '4': '已逾期', '5': '已取消', '6': '待归还核验' }
    return map[status] || '未知'
  }

  function getStatusColor(status) {
    const map = { '0': '#E6A23C', '1': '#67C23A', '2': '#F56C6C', '3': '#909399', '4': '#F56C6C', '5': '#909399', '6': '#E6A23C' }
    return map[status] || '#909399'
  }
</script>

<style lang="scss" scoped>
  page {
    background-color: #f5f5f5;
  }

  .order-list {
    display: flex;
    flex-direction: column;
    height: 100vh;
  }

  .tab-bar {
    display: flex;
    background-color: #fff;
    border-bottom: 1px solid #eee;
  }

  .tab-item {
    flex: 1;
    text-align: center;
    padding: 14px 0;
    font-size: 14px;
    color: #666;
    position: relative;
  }

  .tab-item.active {
    color: #409EFF;
    font-weight: 600;
  }

  .tab-item.active::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 30px;
    height: 3px;
    background-color: #409EFF;
    border-radius: 2px;
  }

  .list-scroll {
    flex: 1;
    padding: 10px 12px;
  }

  .loading-tip {
    padding: 40px 0;
  }

  .empty-tip {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 60px 0;
  }

  .empty-text {
    margin-top: 10px;
    font-size: 14px;
    color: #999;
  }

  .card-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .order-card {
    background-color: #fff;
    border-radius: 8px;
    padding: 14px;
  }

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
  }

  .card-equipment {
    font-size: 16px;
    font-weight: 600;
    color: #333;
  }

  .card-quantity {
    font-size: 13px;
    color: #999;
  }

  .card-body {
    display: flex;
    flex-direction: column;
    gap: 6px;
  }

  .card-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .card-label {
    font-size: 13px;
    color: #999;
  }

  .card-value {
    font-size: 13px;
    color: #333;
  }

  .card-status {
    font-size: 13px;
    font-weight: 600;
  }

  .card-footer {
    display: flex;
    justify-content: flex-end;
    gap: 16px;
    margin-top: 12px;
    padding-top: 10px;
    border-top: 1px solid #f0f0f0;
  }

  .detail-link {
    font-size: 13px;
    color: #409EFF;
  }

  .cancel-link {
    font-size: 13px;
    color: #F56C6C;
  }

  .load-more-tip {
    padding: 20px 0;
  }
</style>
