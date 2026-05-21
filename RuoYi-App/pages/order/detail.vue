<template>
  <view class="order-detail">
    <view v-if="detail.orderId" class="detail-content">
      <view class="status-bar" :style="{ backgroundColor: getStatusBgColor(detail.orderStatus) }">
        <text class="status-text">{{ getStatusText(detail.orderStatus) }}</text>
      </view>

      <view class="info-section">
        <view class="section-title">设备信息</view>
        <view class="info-row">
          <text class="info-label">设备名称</text>
          <text class="info-value">{{ detail.equipmentName || '-' }}</text>
        </view>
        <view v-if="detail.equipmentImage" class="info-row">
          <text class="info-label">设备图片</text>
          <image class="equip-image" :src="getImageUrl(detail.equipmentImage)" mode="aspectFill"></image>
        </view>
        <view class="info-row">
          <text class="info-label">预约数量</text>
          <text class="info-value">{{ detail.quantity }}</text>
        </view>
        <view v-if="detail.assignedUnitCodes" class="info-row">
          <text class="info-label">分配编号</text>
          <text class="info-value">{{ detail.assignedUnitCodes }}</text>
        </view>
      </view>

      <view class="info-section">
        <view class="section-title">预约信息</view>
        <view class="info-row">
          <text class="info-label">预约时间</text>
          <text class="info-value">{{ detail.reserveTime || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">预计归还</text>
          <text class="info-value">{{ detail.expectReturnTime || '-' }}</text>
        </view>
        <view v-if="detail.realName" class="info-row">
          <text class="info-label">预约人</text>
          <text class="info-value">{{ detail.realName }}</text>
        </view>
        <view v-if="detail.studentNo" class="info-row">
          <text class="info-label">学号</text>
          <text class="info-value">{{ detail.studentNo }}</text>
        </view>
        <view v-if="detail.grade" class="info-row">
          <text class="info-label">年级和班级</text>
          <text class="info-value">{{ detail.grade }}</text>
        </view>
        <view v-if="detail.major" class="info-row">
          <text class="info-label">专业</text>
          <text class="info-value">{{ detail.major }}</text>
        </view>
        <view v-if="detail.phone" class="info-row">
          <text class="info-label">手机号</text>
          <text class="info-value">{{ detail.phone }}</text>
        </view>
      </view>

      <view class="info-section" v-if="detail.approverName || detail.approveTime || detail.rejectReason">
        <view class="section-title">审批信息</view>
        <view v-if="detail.approverName" class="info-row">
          <text class="info-label">审批人</text>
          <text class="info-value">{{ detail.approverName }}</text>
        </view>
        <view v-if="detail.approveTime" class="info-row">
          <text class="info-label">审批时间</text>
          <text class="info-value">{{ detail.approveTime }}</text>
        </view>
        <view v-if="detail.rejectReason" class="info-row">
          <text class="info-label">拒绝原因</text>
          <text class="info-value reject-reason">{{ detail.rejectReason }}</text>
        </view>
      </view>

      <view v-if="detail.remark" class="info-section">
        <view class="section-title">备注</view>
        <view class="remark-content">{{ detail.remark }}</view>
      </view>

      <view v-if="detail.orderStatus === '0'" class="bottom-bar">
        <view class="cancel-btn" @click="handleCancel">取消预约</view>
      </view>
      <view v-if="detail.orderStatus === '1'" class="bottom-bar">
        <view class="return-btn" @click="handleInitiateReturn">发起归还</view>
      </view>
    </view>

    <view v-else-if="!loading" class="empty-tip">
      <uni-icons type="list" size="48" color="#ccc"></uni-icons>
      <text class="empty-text">订单不存在</text>
    </view>
  </view>
</template>

<script setup>
  import { ref } from 'vue'
  import { onLoad } from '@dcloudio/uni-app'
  import { getOrderDetail, cancelOrder, initiateReturn } from '@/api/order'
  import config from '@/config'

  const orderId = ref('')
  const detail = ref({})
  const loading = ref(true)

  function getImageUrl(image) {
    if (!image) return ''
    if (image.startsWith('http')) return image
    return config.baseUrl + image
  }

  onLoad((options) => {
    orderId.value = options.id
    loadDetail()
  })

  async function loadDetail() {
    loading.value = true
    try {
      const res = await getOrderDetail(orderId.value)
      detail.value = res.data || {}
    } catch (e) {
      // ignore
    } finally {
      loading.value = false
    }
  }

  async function handleCancel() {
    const res = await uni.showModal({ title: '提示', content: '确定取消该预约吗？' })
    if (res.confirm) {
      try {
        await cancelOrder(orderId.value)
        uni.showToast({ title: '已取消', icon: 'success' })
        loadDetail()
      } catch (e) {
        // ignore
      }
    }
  }

  async function handleInitiateReturn() {
    const res = await uni.showModal({ title: '提示', content: '确认发起归还申请？发起后需等待管理员现场核验。' })
    if (res.confirm) {
      try {
        await initiateReturn(orderId.value)
        uni.showToast({ title: '归还申请已提交', icon: 'success' })
        loadDetail()
      } catch (e) {
        // ignore
      }
    }
  }

  function getStatusText(status) {
    const map = { '0': '待审批', '1': '使用中', '2': '已拒绝', '3': '已归还', '4': '已逾期', '5': '已取消', '6': '待归还核验' }
    return map[status] || '未知'
  }

  function getStatusBgColor(status) {
    const map = { '0': '#E6A23C', '1': '#67C23A', '2': '#F56C6C', '3': '#909399', '4': '#F56C6C', '5': '#909399', '6': '#E6A23C' }
    return map[status] || '#909399'
  }
</script>

<style lang="scss" scoped>
  page {
    background-color: #f5f5f5;
  }

  .order-detail {
    min-height: 100vh;
  }

  .detail-content {
    padding-bottom: 70px;
  }

  .status-bar {
    padding: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .status-text {
    font-size: 17px;
    font-weight: 600;
    color: #fff;
  }

  .info-section {
    background-color: #fff;
    margin-top: 10px;
    padding: 16px;
  }

  .section-title {
    font-size: 15px;
    font-weight: 600;
    color: #333;
    margin-bottom: 12px;
    padding-bottom: 10px;
    border-bottom: 1px solid #f0f0f0;
  }

  .info-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding: 8px 0;
  }

  .info-label {
    font-size: 13px;
    color: #999;
    flex-shrink: 0;
  }

  .info-value {
    font-size: 13px;
    color: #333;
    text-align: right;
    max-width: 60%;
  }

  .equip-image {
    width: 80px;
    height: 80px;
    border-radius: 6px;
  }

  .reject-reason {
    color: #F56C6C;
  }

  .remark-content {
    font-size: 13px;
    color: #666;
    line-height: 1.6;
  }

  .bottom-bar {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 10px 16px;
    padding-bottom: calc(10px + env(safe-area-inset-bottom));
    background-color: #fff;
    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
  }

  .cancel-btn {
    width: 100%;
    height: 44px;
    border-radius: 8px;
    border: 1px solid #F56C6C;
    color: #F56C6C;
    font-size: 16px;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .return-btn {
    width: 100%;
    height: 44px;
    border-radius: 8px;
    background-color: #409EFF;
    color: #fff;
    font-size: 16px;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .empty-tip {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 100px 0;
  }

  .empty-text {
    margin-top: 10px;
    font-size: 14px;
    color: #999;
  }
</style>
