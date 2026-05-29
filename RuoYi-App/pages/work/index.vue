<template>
  <view class="work-container">
    <uni-swiper-dot class="uni-swiper-dot-box" :info="data" :current="current" field="content">
      <swiper class="swiper-box" :current="swiperDotIndex" @change="changeSwiper">
        <swiper-item v-for="(item, index) in data" :key="index">
          <view class="swiper-item" @click="clickBannerItem(item)">
            <image :src="item.image" mode="aspectFill" :draggable="false" />
          </view>
        </swiper-item>
      </swiper>
    </uni-swiper-dot>

    <uni-section title="设备预约" type="line"></uni-section>
    <view class="grid-body">
      <uni-grid :column="2" :showBorder="false" @change="changeGrid">
        <uni-grid-item :index="0">
          <view class="grid-item-box">
            <uni-icons type="search" size="30" color="#409EFF"></uni-icons>
            <text class="text">查看设备</text>
          </view>
        </uni-grid-item>
        <uni-grid-item :index="1">
          <view class="grid-item-box">
            <uni-icons type="list" size="30" color="#E6A23C"></uni-icons>
            <text class="text">我的预约</text>
          </view>
        </uni-grid-item>
        <uni-grid-item :index="2">
          <view class="grid-item-box">
            <view class="icon-wrap">
              <uni-icons type="chat" size="30" color="#67C23A"></uni-icons>
              <uni-badge v-if="unreadCount > 0" :text="unreadCount > 99 ? '99+' : String(unreadCount)" type="error" :is-dot="false" absolute="rightTop" class="msg-badge" />
            </view>
            <text class="text">我的消息</text>
          </view>
        </uni-grid-item>
      </uni-grid>
    </view>
  </view>
</template>

<script setup>
  import { ref } from "vue"
  import { onShow } from '@dcloudio/uni-app'
  import { getUnreadCount } from '@/api/msg'

  const current = ref(0)
  const swiperDotIndex = ref(0)
  const unreadCount = ref(0)
  const data = ref([{ image: '/static/images/banner/banner01.jpg' }, { image: '/static/images/banner/banner02.jpg' }, { image: '/static/images/banner/banner03.jpg' }])

  onShow(() => {
    fetchUnreadCount()
  })

  async function fetchUnreadCount() {
    try {
      const res = await getUnreadCount()
      unreadCount.value = res.data || 0
    } catch (e) {
      // ignore
    }
  }

  function clickBannerItem(item) {
    console.info(item)
  }

  function changeSwiper(e) {
    current.value = e.detail.current
  }

  function changeGrid(e) {
    const index = e.detail.index
    if (index === 0) {
      uni.navigateTo({ url: '/pages/equipment/list' })
    } else if (index === 1) {
      uni.navigateTo({ url: '/pages/order/list' })
    } else if (index === 2) {
      uni.navigateTo({ url: '/pages/msg/list' })
    }
  }
</script>

<style lang="scss" scoped>
  /* #ifndef APP-NVUE */
  page {
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
    background-color: #fff;
    min-height: 100%;
    height: auto;
  }

  view {
    font-size: 14px;
    line-height: inherit;
  }
  /* #endif */

  .text {
    text-align: center;
    font-size: 26rpx;
    margin-top: 10rpx;
  }

  .grid-item-box {
    flex: 1;
    /* #ifndef APP-NVUE */
    display: flex;
    /* #endif */
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 15px 0;
  }

  .icon-wrap {
    position: relative;
  }

  .msg-badge {
    position: absolute;
    top: -8px;
    right: -16px;
  }

  .uni-margin-wrap {
    width: 690rpx;
    width: 100%;
  }

  .swiper {
    height: 300rpx;
  }

  .swiper-box {
    height: 150px;
  }

  .swiper-item {
    /* #ifndef APP-NVUE */
    display: flex;
    /* #endif */
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: #fff;
    height: 300rpx;
    line-height: 300rpx;
  }

  @media screen and (min-width: 500px) {
    .uni-swiper-dot-box {
      width: 400px;
      /* #ifndef APP-NVUE */
      margin: 0 auto;
      /* #endif */
      margin-top: 8px;
    }

    .image {
      width: 100%;
    }
  }
</style>
