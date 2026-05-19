<template>
  <view class="equipment-detail">
    <view v-if="detail.equipmentId" class="detail-content">
      <view class="image-area">
        <image v-if="detail.image" class="main-image" :src="getImageUrl(detail.image)" mode="aspectFill"></image>
        <view v-else class="main-image-placeholder">
          <uni-icons type="image" size="48" color="#ccc"></uni-icons>
          <text class="placeholder-text">暂无图片</text>
        </view>
      </view>

      <view class="info-section">
        <view class="info-title">{{ detail.equipmentName }}</view>
        <view class="info-row">
          <text class="info-label">设备分类</text>
          <text class="info-value">{{ detail.categoryName || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">总库存</text>
          <text class="info-value">{{ detail.totalStock }} 台</text>
        </view>
        <view class="info-row">
          <text class="info-label">可借库存</text>
          <text class="info-value highlight">{{ detail.remainStock }} 台</text>
        </view>
        <view class="info-row" v-if="detail.location">
          <text class="info-label">存放地点</text>
          <text class="info-value">{{ detail.location }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">追踪单台</text>
          <text class="info-value">{{ detail.trackUnit === '1' ? '是' : '否' }}</text>
        </view>
        <view class="info-row" v-if="detail.description">
          <text class="info-label">设备描述</text>
          <text class="info-value desc-text">{{ detail.description }}</text>
        </view>
      </view>

      <view class="bottom-bar">
        <view class="reserve-btn" @click="goReserve">立即预约</view>
      </view>
    </view>

    <view v-else-if="!loading" class="empty-tip">
      <uni-icons type="image" size="48" color="#ccc"></uni-icons>
      <text class="empty-text">设备不存在</text>
    </view>
  </view>
</template>

<script setup>
  import { ref } from 'vue'
  import { onLoad } from '@dcloudio/uni-app'
  import { getEquipment } from '@/api/equipment'
  import config from '@/config'

  const equipmentId = ref('')
  const detail = ref({})
  const loading = ref(true)

  function getImageUrl(image) {
    if (!image) return ''
    if (image.startsWith('http')) return image
    return config.baseUrl + image
  }

  onLoad((options) => {
    equipmentId.value = options.id
    loadDetail()
  })

  async function loadDetail() {
    loading.value = true
    try {
      const res = await getEquipment(equipmentId.value)
      detail.value = res.data || {}
    } catch (e) {
      // ignore
    } finally {
      loading.value = false
    }
  }

  function goReserve() {
    uni.navigateTo({
      url: '/pages/order/create?equipmentId=' + equipmentId.value
    })
  }
</script>

<style lang="scss" scoped>
  page {
    background-color: #f5f5f5;
  }

  .equipment-detail {
    min-height: 100vh;
  }

  .detail-content {
    display: flex;
    flex-direction: column;
    padding-bottom: 70px;
  }

  .image-area {
    width: 100%;
    height: 240px;
    background-color: #fff;
  }

  .main-image {
    width: 100%;
    height: 100%;
  }

  .main-image-placeholder {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-color: #f0f0f0;
  }

  .placeholder-text {
    margin-top: 8px;
    font-size: 14px;
    color: #999;
  }

  .info-section {
    background-color: #fff;
    margin-top: 10px;
    padding: 16px;
  }

  .info-title {
    font-size: 18px;
    font-weight: 600;
    color: #333;
    margin-bottom: 16px;
  }

  .info-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding: 10px 0;
    border-bottom: 1px solid #f0f0f0;
  }

  .info-row:last-child {
    border-bottom: none;
  }

  .info-label {
    font-size: 14px;
    color: #999;
    flex-shrink: 0;
  }

  .info-value {
    font-size: 14px;
    color: #333;
    text-align: right;
    max-width: 60%;
  }

  .highlight {
    color: #409EFF;
    font-weight: 600;
  }

  .desc-text {
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

  .reserve-btn {
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
