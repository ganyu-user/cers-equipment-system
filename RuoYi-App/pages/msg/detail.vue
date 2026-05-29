<template>
  <view class="msg-detail">
    <view v-if="msg.title" class="detail-content">
      <view class="detail-header">
        <text class="detail-title">{{ msg.title }}</text>
        <view class="detail-meta">
          <text class="detail-time">{{ msg.createTime }}</text>
          <text class="detail-sender">发送者：{{ msg.senderName || '系统' }}</text>
        </view>
      </view>

      <view class="detail-body">
        <text class="detail-content-text">{{ msg.content }}</text>
      </view>

      <view v-if="msg.remark" class="detail-remark">
        <view class="remark-title">备注</view>
        <text class="remark-text">{{ msg.remark }}</text>
      </view>

      <view v-if="!isRead" class="bottom-bar">
        <view class="read-btn" @click="handleRead">标记为已读</view>
      </view>
    </view>

    <view v-else-if="!loading" class="empty-tip">
      <uni-icons type="chat" size="48" color="#ccc"></uni-icons>
      <text class="empty-text">消息不存在</text>
    </view>
  </view>
</template>

<script setup>
  import { ref } from 'vue'
  import { onLoad } from '@dcloudio/uni-app'
  import { getMsgList, readMsgs } from '@/api/msg'

  const msgId = ref('')
  const msg = ref({})
  const isRead = ref(false)
  const loading = ref(true)

  onLoad((options) => {
    msgId.value = options.msgId
    loadDetail()
  })

  async function loadDetail() {
    loading.value = true
    try {
      const res = await getMsgList({ pageNum: 1, pageSize: 100 })
      const rows = res.rows || []
      msg.value = rows.find(item => String(item.msgId) === String(msgId.value)) || {}
    } catch (e) {
      // ignore
    } finally {
      loading.value = false
    }
  }

  async function handleRead() {
    try {
      await readMsgs([Number(msgId.value)])
      isRead.value = true
      uni.showToast({ title: '已标记为已读', icon: 'success' })
    } catch (e) {
      // ignore
    }
  }
</script>

<style lang="scss" scoped>
  page {
    background-color: #f5f5f5;
  }

  .msg-detail {
    min-height: 100vh;
  }

  .detail-content {
    padding-bottom: 70px;
  }

  .detail-header {
    background-color: #fff;
    padding: 20px 16px;
  }

  .detail-title {
    font-size: 18px;
    font-weight: 700;
    color: #333;
    line-height: 1.5;
  }

  .detail-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
  }

  .detail-time {
    font-size: 13px;
    color: #999;
  }

  .detail-sender {
    font-size: 13px;
    color: #999;
  }

  .detail-body {
    background-color: #fff;
    margin-top: 10px;
    padding: 16px;
  }

  .detail-content-text {
    font-size: 15px;
    color: #333;
    line-height: 1.8;
  }

  .detail-remark {
    background-color: #fff;
    margin-top: 10px;
    padding: 16px;
  }

  .remark-title {
    font-size: 14px;
    font-weight: 600;
    color: #999;
    margin-bottom: 8px;
  }

  .remark-text {
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

  .read-btn {
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