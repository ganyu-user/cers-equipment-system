<template>
  <view class="order-create">
    <view class="equipment-summary" v-if="equipmentDetail.equipmentName">
      <text class="summary-label">预约设备</text>
      <text class="summary-name">{{ equipmentDetail.equipmentName }}</text>
      <text class="summary-stock">可借库存：{{ equipmentDetail.remainStock }}</text>
    </view>

    <view class="form-section">
      <view class="form-item">
        <text class="form-label">预约数量</text>
        <view class="number-stepper">
          <view class="stepper-btn" @click="decreaseQty">-</view>
          <input class="stepper-input" type="number" v-model="form.quantity" @blur="validateQty" />
          <view class="stepper-btn" @click="increaseQty">+</view>
        </view>
      </view>

      <view class="form-item datetime-item">
        <text class="form-label required">预约时间</text>
        <picker mode="multiSelector" :range="dateTimeRange" :value="reserveTimeIndex" @change="onReserveTimeChange">
          <text class="form-value" :class="{ placeholder: !form.reserveTime }">
            {{ form.reserveTime || '请选择预约时间' }}
          </text>
        </picker>
      </view>

      <view class="form-item datetime-item">
        <text class="form-label required">预计归还</text>
        <picker mode="multiSelector" :range="dateTimeRange" :value="returnTimeIndex" @change="onReturnTimeChange">
          <text class="form-value" :class="{ placeholder: !form.expectReturnTime }">
            {{ form.expectReturnTime || '请选择预计归还时间' }}
          </text>
        </picker>
      </view>

      <view class="form-item">
        <text class="form-label">预约人</text>
        <input class="form-input" v-model="form.realName" placeholder="请输入姓名" />
      </view>

      <view class="form-item">
        <text class="form-label">学号</text>
        <input class="form-input" v-model="form.studentNo" placeholder="请输入学号" />
      </view>

      <view class="form-item">
        <text class="form-label">年级和班级</text>
        <input class="form-input" v-model="form.grade" placeholder="填写详细年级和班级" />
      </view>

      <view class="form-item">
        <text class="form-label">专业</text>
        <input class="form-input" v-model="form.major" placeholder="请输入专业" />
      </view>

      <view class="form-item">
        <text class="form-label">手机号</text>
        <input class="form-input" v-model="form.phone" placeholder="请输入手机号" />
      </view>

      <view class="form-item form-item-textarea">
        <text class="form-label">备注</text>
        <textarea class="form-textarea" v-model="form.remark" placeholder="如有特殊需求请填写备注" />
      </view>
    </view>

    <view class="bottom-bar">
      <view class="submit-btn" @click="submitOrder">提交预约</view>
    </view>
  </view>
</template>

<script setup>
  import { ref, reactive } from 'vue'
  import { onLoad } from '@dcloudio/uni-app'
  import { getEquipment } from '@/api/equipment'
  import { addOrder } from '@/api/order'
  import { useUserStore } from '@/store/modules/user'

  const userStore = useUserStore()
  const equipmentId = ref('')
  const equipmentDetail = ref({})

  const form = reactive({
    equipmentId: '',
    quantity: 1,
    reserveTime: '',
    expectReturnTime: '',
    realName: '',
    studentNo: '',
    grade: '',
    major: '',
    phone: '',
    remark: ''
  })

  const now = new Date()
  const currentYear = now.getFullYear()
  const years = []
  for (let i = 0; i < 5; i++) {
    years.push(String(currentYear + i))
  }
  const months = []
  for (let i = 1; i <= 12; i++) {
    months.push(String(i).padStart(2, '0'))
  }
  const days = []
  for (let i = 1; i <= 31; i++) {
    days.push(String(i).padStart(2, '0'))
  }
  const hours = []
  for (let i = 0; i <= 23; i++) {
    hours.push(String(i).padStart(2, '0'))
  }
  const minutes = []
  for (let i = 0; i < 60; i += 5) {
    minutes.push(String(i).padStart(2, '0'))
  }

  const dateTimeRange = [years, months, days, hours, minutes]

  const reserveTimeIndex = ref([0, monthToIndex(now.getMonth() + 1), dayToIndex(now.getDate()), 0, 0])
  const returnTimeIndex = ref([0, monthToIndex(now.getMonth() + 1), dayToIndex(now.getDate()), 0, 0])

  function monthToIndex(m) {
    const s = String(m).padStart(2, '0')
    const idx = months.indexOf(s)
    return idx >= 0 ? idx : 0
  }

  function dayToIndex(d) {
    const s = String(d).padStart(2, '0')
    const idx = days.indexOf(s)
    return idx >= 0 ? idx : 0
  }

  function indexToDateTime(idxArr) {
    const y = years[idxArr[0]]
    const m = months[idxArr[1]]
    const d = days[idxArr[2]]
    const h = hours[idxArr[3]]
    const min = minutes[idxArr[4]]
    return y + '-' + m + '-' + d + ' ' + h + ':' + min + ':00'
  }

  function onReserveTimeChange(e) {
    reserveTimeIndex.value = e.detail.value
    form.reserveTime = indexToDateTime(e.detail.value)
  }

  function onReturnTimeChange(e) {
    returnTimeIndex.value = e.detail.value
    form.expectReturnTime = indexToDateTime(e.detail.value)
  }

  onLoad((options) => {
    equipmentId.value = options.equipmentId
    form.equipmentId = options.equipmentId
    form.realName = userStore.name || ''
    loadEquipmentDetail()
  })

  async function loadEquipmentDetail() {
    try {
      const res = await getEquipment(equipmentId.value)
      equipmentDetail.value = res.data || {}
    } catch (e) {
      // ignore
    }
  }

  function decreaseQty() {
    if (form.quantity > 1) {
      form.quantity--
    }
  }

  function increaseQty() {
    const max = equipmentDetail.value.remainStock || 1
    if (form.quantity < max) {
      form.quantity++
    }
  }

  function validateQty() {
    const val = Number(form.quantity)
    if (!val || val < 1) {
      form.quantity = 1
    }
    const max = equipmentDetail.value.remainStock || 1
    if (val > max) {
      form.quantity = max
    }
    form.quantity = Math.floor(form.quantity)
  }

  async function submitOrder() {
    if (!form.reserveTime) {
      uni.showToast({ title: '请选择预约时间', icon: 'none' })
      return
    }
    if (!form.expectReturnTime) {
      uni.showToast({ title: '请选择预计归还时间', icon: 'none' })
      return
    }
    if (form.quantity < 1) {
      uni.showToast({ title: '预约数量至少为1', icon: 'none' })
      return
    }
    if (equipmentDetail.value.remainStock && form.quantity > equipmentDetail.value.remainStock) {
      uni.showToast({ title: '预约数量超过可借库存', icon: 'none' })
      return
    }

    uni.showLoading({ title: '提交中' })
    try {
      await addOrder({ ...form })
      uni.hideLoading()
      uni.showToast({ title: '预约成功，等待审批', icon: 'success' })
      setTimeout(() => {
        uni.reLaunch({ url: '/pages/work/index' })
      }, 1500)
    } catch (e) {
      uni.hideLoading()
    }
  }
</script>

<style lang="scss" scoped>
  page {
    background-color: #f5f5f5;
  }

  .order-create {
    min-height: 100vh;
    padding-bottom: 70px;
  }

  .equipment-summary {
    background-color: #fff;
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 4px;
  }

  .summary-label {
    font-size: 12px;
    color: #999;
  }

  .summary-name {
    font-size: 17px;
    font-weight: 600;
    color: #333;
  }

  .summary-stock {
    font-size: 13px;
    color: #409EFF;
  }

  .form-section {
    margin-top: 10px;
    background-color: #fff;
  }

  .form-item {
    display: flex;
    align-items: center;
    padding: 14px 16px;
    border-bottom: 1px solid #f0f0f0;
    min-height: 48px;
  }

  .datetime-item {
    cursor: pointer;
  }

  .form-item-textarea {
    flex-direction: column;
    align-items: flex-start;
  }

  .form-label {
    font-size: 14px;
    color: #333;
    width: 80px;
    flex-shrink: 0;
  }

  .form-label.required::before {
    content: '* ';
    color: #f56c6c;
  }

  .form-value {
    flex: 1;
    font-size: 14px;
    color: #333;
    text-align: right;
  }

  .form-value.placeholder {
    color: #ccc;
  }

  .form-input {
    flex: 1;
    font-size: 14px;
    text-align: right;
  }

  .form-textarea {
    margin-top: 10px;
    width: 100%;
    height: 80px;
    font-size: 14px;
  }

  .number-stepper {
    display: flex;
    align-items: center;
    margin-left: auto;
  }

  .stepper-btn {
    width: 32px;
    height: 32px;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    color: #333;
    background-color: #f5f5f5;
  }

  .stepper-input {
    width: 60px;
    height: 32px;
    text-align: center;
    font-size: 15px;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    margin: 0 4px;
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

  .submit-btn {
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
</style>
