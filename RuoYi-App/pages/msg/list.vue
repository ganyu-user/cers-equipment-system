<template>
  <view class="msg-list">
    <view class="tab-bar">
      <view class="tab-item" :class="{ active: activeTab === '' }" @click="switchTab('')">全部</view>
      <view class="tab-item" :class="{ active: activeTab === 'unread' }" @click="switchTab('unread')">未读</view>
    </view>

    <scroll-view class="list-scroll" scroll-y @scrolltolower="loadMore">
      <view v-if="loading" class="loading-tip">
        <uni-load-more status="loading"></uni-load-more>
      </view>
      <view v-else-if="msgList.length === 0" class="empty-tip">
        <uni-icons type="chat" size="48" color="#ccc"></uni-icons>
        <text class="empty-text">暂无消息</text>
      </view>
      <view v-else class="card-list">
        <view class="msg-card" v-for="item in msgList" :key="item.msgId" @click="goDetail(item)" :class="{ unread: !item.isRead }">
          <view class="card-left">
            <view class="msg-icon" :style="{ backgroundColor: getTypeColor(item.msgType) }">
              <text class="icon-text">{{ getTypeIcon(item.msgType) }}</text>
            </view>
          </view>
          <view class="card-body">
            <view class="card-header">
              <text class="msg-title">{{ item.title }}</text>
              <text class="msg-time">{{ item.createTime }}</text>
            </view>
            <view class="msg-content">{{ item.content }}</view>
          </view>
          <view v-if="!item.isRead" class="unread-dot"></view>
        </view>
      </view>
      <view v-if="msgList.length > 0 && !loading" class="load-more-tip">
        <uni-load-more :status="hasMore ? 'more' : 'noMore'"></uni-load-more>
      </view>
    </scroll-view>

    <view v-if="msgList.length > 0" class="bottom-bar">
      <view class="read-all-btn" @click="handleReadAll">全部标记已读</view>
    </view>
  </view>
</template>

<script setup>
  import { ref } from 'vue'
  import { onShow } from '@dcloudio/uni-app'
  import { getMsgList, readMsgs, readAllMsgs } from '@/api/msg'

  const activeTab = ref('')
  const msgList = ref([])
  const page = ref(1)
  const total = ref(0)
  const loading = ref(false)
  const hasMore = ref(true)

  onShow(() => {
    page.value = 1
    loadMsgs()
  })

  async function loadMsgs() {
    loading.value = true
    try {
      const params = { pageNum: page.value, pageSize: 10 }
      if (activeTab.value === 'unread') {
        params.isRead = '0'
      }
      const res = await getMsgList(params)
      const rows = (res.rows || []).map(item => {
        item.isRead = (item.isRead === '1' || item.isRead === true)
        return item
      })
      if (page.value === 1) {
        msgList.value = rows
      } else {
        msgList.value = msgList.value.concat(rows)
      }
      total.value = res.total || 0
      hasMore.value = msgList.value.length < total.value
    } catch (e) {
      // ignore
    } finally {
      loading.value = false
    }
  }

  function loadMore() {
    if (loading.value || !hasMore.value) return
    page.value++
    loadMsgs()
  }

  function switchTab(tab) {
    activeTab.value = tab
    page.value = 1
    loadMsgs()
  }

  async function goDetail(item) {
    if (!item.isRead) {
      item.isRead = true
      try {
        await readMsgs([item.msgId])
      } catch (e) {
        item.isRead = false
      }
    }
    uni.navigateTo({ url: '/pages/msg/detail?msgId=' + item.msgId })
  }

  async function handleReadAll() {
    try {
      await readAllMsgs()
      msgList.value.forEach(item => { item.isRead = true })
      uni.showToast({ title: '已全部标为已读', icon: 'success' })
    } catch (e) {
      // ignore
    }
  }

  function getTypeColor(type) {
    const map = { 'reserve': '#409EFF', 'return': '#67C23A', 'overdue': '#F56C6C', 'system': '#909399' }
    return map[type] || '#909399'
  }

  function getTypeIcon(type) {
    const map = { 'reserve': '预', 'return': '还', 'overdue': '逾', 'system': '系' }
    return map[type] || '通'
  }
</script>

<style lang="scss" scoped>
  page {
    background-color: #f5f5f5;
  }

  .msg-list {
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

  .msg-card {
    background-color: #fff;
    border-radius: 8px;
    padding: 14px;
    display: flex;
    align-items: flex-start;
    position: relative;
  }

  .msg-card.unread {
    background-color: #f0f7ff;
  }

  .card-left {
    margin-right: 12px;
  }

  .msg-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .icon-text {
    font-size: 15px;
    color: #fff;
    font-weight: 600;
  }

  .card-body {
    flex: 1;
    overflow: hidden;
  }

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 6px;
  }

  .msg-title {
    font-size: 15px;
    font-weight: 600;
    color: #333;
  }

  .msg-time {
    font-size: 12px;
    color: #bbb;
    flex-shrink: 0;
    margin-left: 10px;
  }

  .msg-content {
    font-size: 13px;
    color: #666;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .unread-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background-color: #F56C6C;
    position: absolute;
    top: 18px;
    right: 14px;
  }

  .bottom-bar {
    padding: 10px 16px;
    padding-bottom: calc(10px + env(safe-area-inset-bottom));
    background-color: #fff;
    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
    text-align: center;
  }

  .read-all-btn {
    font-size: 14px;
    color: #409EFF;
  }

  .load-more-tip {
    padding: 20px 0;
  }
</style>