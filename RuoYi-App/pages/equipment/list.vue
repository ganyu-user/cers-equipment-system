<template>
  <view class="equipment-list">
    <view class="search-bar">
      <view class="filter-row">
        <picker class="level-picker" mode="selector" :range="parentNames" :value="parentIndex" @change="onParentChange">
          <view class="picker-display">
            <uni-icons type="arrowdown" size="14" color="#666"></uni-icons>
            <text class="picker-text">{{ parentNames[parentIndex] || '全部分类' }}</text>
          </view>
        </picker>
        <picker v-if="subNames.length > 0" class="level-picker sub-picker" mode="selector" :range="subNames" :value="subIndex" @change="onSubChange">
          <view class="picker-display">
            <uni-icons type="arrowdown" size="12" color="#999"></uni-icons>
            <text class="picker-text sub-text">{{ subNames[subIndex] || '子分类' }}</text>
          </view>
        </picker>
      </view>
      <view class="search-input-wrap">
        <uni-icons type="search" size="16" color="#999"></uni-icons>
        <input class="search-input" v-model="searchKeyword" placeholder="搜索设备名称..." confirm-type="search" @confirm="onSearch" />
      </view>
    </view>

    <scroll-view class="list-scroll" scroll-y>
      <view v-if="loading" class="loading-tip">
        <uni-load-more status="loading"></uni-load-more>
      </view>
      <view v-else-if="equipmentList.length === 0" class="empty-tip">
        <uni-icons type="image" size="48" color="#ccc"></uni-icons>
        <text class="empty-text">暂无可用设备</text>
      </view>
      <view v-else class="card-list">
        <view class="equipment-card" v-for="item in equipmentList" :key="item.equipmentId" @click="goDetail(item)">
          <image v-if="item.image" class="card-image" :src="getImageUrl(item.image)" mode="aspectFill"></image>
          <view v-else class="card-image-placeholder">
            <uni-icons type="image" size="36" color="#ccc"></uni-icons>
          </view>
          <view class="card-info">
            <text class="card-name">{{ item.equipmentName }}</text>
            <text class="card-category" v-if="item.categoryName">分类：{{ item.categoryName }}</text>
            <text class="card-stock">可借库存：{{ item.remainStock }}</text>
            <text class="card-location" v-if="item.location">地点：{{ item.location }}</text>
          </view>
          <uni-icons type="right" size="16" color="#ccc"></uni-icons>
        </view>
      </view>
    </scroll-view>

    <view class="pagination-bar" v-if="total > 0">
      <uni-pagination :current="page" :total="total" :pageSize="pageSize" @change="onPageChange" />
    </view>
  </view>
</template>

<script setup>
  import { ref, onMounted } from 'vue'
  import { listEquipment, getCategoryTree } from '@/api/equipment'
  import config from '@/config'

  const equipmentList = ref([])
  const categoryTree = ref([])
  const parentNames = ref(['全部'])
  const parentIds = ref([null])
  const parentIndex = ref(0)
  const subNames = ref([])
  const subIds = ref([])
  const subIndex = ref(0)
  const selectedCategoryId = ref(null)
  const searchKeyword = ref('')
  const page = ref(1)
  const pageSize = ref(10)
  const total = ref(0)
  const loading = ref(false)

  function getImageUrl(image) {
    if (!image) return ''
    if (image.startsWith('http')) return image
    return config.baseUrl + image
  }

  async function loadCategories() {
    try {
      const res = await getCategoryTree()
      const data = res.data || []
      categoryTree.value = data
      const pNames = ['全部']
      const pIds = [null]
      data.forEach(node => {
        pNames.push(node.categoryName)
        pIds.push(node.categoryId)
      })
      parentNames.value = pNames
      parentIds.value = pIds
    } catch (e) {
      // ignore
    }
  }

  function updateSubCategories() {
    const pid = parentIds.value[parentIndex.value]
    if (!pid) {
      subNames.value = []
      subIds.value = []
      subIndex.value = 0
      selectedCategoryId.value = null
      return
    }
    const parent = categoryTree.value.find(n => n.categoryId === pid)
    if (!parent || !parent.children || parent.children.length === 0) {
      subNames.value = []
      subIds.value = []
      subIndex.value = 0
      selectedCategoryId.value = pid
      return
    }
    const sNames = ['全部（' + parent.categoryName + '）']
    const sIds = [pid]
    parent.children.forEach(child => {
      sNames.push(child.categoryName)
      sIds.push(child.categoryId)
    })
    subNames.value = sNames
    subIds.value = sIds
    subIndex.value = 0
    selectedCategoryId.value = pid
  }

  function onParentChange(e) {
    parentIndex.value = e.detail.value
    updateSubCategories()
    page.value = 1
    loadEquipment()
  }

  function onSubChange(e) {
    subIndex.value = e.detail.value
    selectedCategoryId.value = subIds.value[e.detail.value]
    page.value = 1
    loadEquipment()
  }

  async function loadEquipment() {
    loading.value = true
    try {
      const params = {
        pageNum: page.value,
        pageSize: pageSize.value
      }
      if (selectedCategoryId.value) {
        params.categoryId = selectedCategoryId.value
      }
      if (searchKeyword.value) {
        params.equipmentName = searchKeyword.value
      }
      const res = await listEquipment(params)
      equipmentList.value = res.rows || []
      total.value = res.total || 0
    } catch (e) {
      // ignore
    } finally {
      loading.value = false
    }
  }

  function onPageChange(e) {
    page.value = e.current
    loadEquipment()
  }

  function onSearch() {
    page.value = 1
    loadEquipment()
  }

  function goDetail(item) {
    uni.navigateTo({
      url: '/pages/equipment/detail?id=' + item.equipmentId
    })
  }

  onMounted(() => {
    loadCategories()
    loadEquipment()
  })
</script>

<style lang="scss" scoped>
  page {
    background-color: #f5f5f5;
  }

  .equipment-list {
    display: flex;
    flex-direction: column;
    height: 100vh;
  }

  .search-bar {
    padding: 10px 12px;
    background-color: #fff;
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  .filter-row {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .level-picker {
    flex-shrink: 0;
  }

  .sub-picker {
    flex-shrink: 0;
  }

  .picker-display {
    display: flex;
    align-items: center;
    background-color: #f5f5f5;
    border-radius: 6px;
    padding: 6px 10px;
    gap: 4px;
  }

  .picker-text {
    font-size: 13px;
    color: #333;
    white-space: nowrap;
    max-width: 100px;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .sub-text {
    font-size: 12px;
    max-width: 80px;
  }

  .search-input-wrap {
    display: flex;
    align-items: center;
    background-color: #f5f5f5;
    border-radius: 6px;
    padding: 6px 10px;
    gap: 6px;
  }

  .search-input {
    flex: 1;
    font-size: 13px;
    height: 28px;
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
    padding-bottom: 10px;
  }

  .equipment-card {
    display: flex;
    align-items: center;
    background-color: #fff;
    border-radius: 8px;
    padding: 12px;
    gap: 10px;
  }

  .card-image {
    width: 80px;
    height: 80px;
    border-radius: 6px;
    flex-shrink: 0;
  }

  .card-image-placeholder {
    width: 80px;
    height: 80px;
    border-radius: 6px;
    flex-shrink: 0;
    background-color: #f5f5f5;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .card-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 4px;
    overflow: hidden;
  }

  .card-name {
    font-size: 15px;
    font-weight: 600;
    color: #333;
  }

  .card-category {
    font-size: 12px;
    color: #666;
  }

  .card-stock {
    font-size: 12px;
    color: #409EFF;
  }

  .card-location {
    font-size: 12px;
    color: #999;
  }

  .pagination-bar {
    background-color: #fff;
    padding: 4px 0;
    padding-bottom: calc(4px + env(safe-area-inset-bottom));
  }
</style>
