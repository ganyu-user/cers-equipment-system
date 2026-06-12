import { getToken } from '@/utils/auth'

const HEARTBEAT_INTERVAL = 30000
const RECONNECT_DELAY = 5000

let socketTask = null
let heartbeatTimer = null
let reconnectTimer = null
let isManualClose = false

// 全局消息回调列表
const messageCallbacks = []

/**
 * 注册消息回调
 */
export function onWebSocketMessage(callback) {
  messageCallbacks.push(callback)
  return () => {
    const idx = messageCallbacks.indexOf(callback)
    if (idx !== -1) messageCallbacks.splice(idx, 1)
  }
}

/**
 * 连接 WebSocket
 */
export function connectWebSocket() {
  if (socketTask) {
    return
  }

  isManualClose = false
  const token = getToken()
  if (!token) return

  const baseUrl = getBaseUrl()

  socketTask = uni.connectSocket({
    url: `${baseUrl}/ws/message/${encodeURIComponent(token)}`,
    success: () => {
      console.log('[WebSocket] 连接中...')
    },
    fail: (err) => {
      console.error('[WebSocket] 连接失败:', err)
      socketTask = null
      scheduleReconnect()
    }
  })

  socketTask.onOpen(() => {
    console.log('[WebSocket] 连接成功')
    startHeartbeat()
    clearReconnectTimer()
  })

  socketTask.onMessage((res) => {
    try {
      const data = JSON.parse(res.data)
      if (data.type === 'msg') {
        // 通知所有回调
        messageCallbacks.forEach(cb => cb(data))
        // 默认展示提示
        showNotification(data)
      }
    } catch (e) {
      console.warn('[WebSocket] 消息解析失败:', e)
    }
  })

  socketTask.onClose((e) => {
    console.log('[WebSocket] 连接关闭:', e.code, e.reason)
    stopHeartbeat()
    socketTask = null
    if (!isManualClose) {
      scheduleReconnect()
    }
  })

  socketTask.onError((e) => {
    console.error('[WebSocket] 连接错误:', e)
  })
}

/**
 * 断开 WebSocket
 */
export function disconnectWebSocket() {
  isManualClose = true
  stopHeartbeat()
  clearReconnectTimer()
  if (socketTask) {
    socketTask.close()
    socketTask = null
  }
}

/**
 * 显示通知
 */
function showNotification(data) {
  const isUrgent = data.priority === 'urgent'
  if (isUrgent) {
    // 紧急消息：模态弹窗
    uni.showModal({
      title: '【紧急】' + data.title,
      content: data.content,
      showCancel: false,
      confirmText: '查看',
      success: (res) => {
        if (res.confirm) {
          uni.navigateTo({ url: '/pages/msg/detail?id=' + data.msgId })
        }
      }
    })
  } else {
    // 普通消息：轻提示
    uni.showToast({
      title: data.title,
      icon: 'none',
      duration: 3000
    })
  }
}

function getBaseUrl() {
  // #ifdef H5
  const protocol = location.protocol === 'https:' ? 'wss:' : 'ws:'
  return `${protocol}//${location.host}`
  // #endif
  // #ifndef H5
  // APP/小程序环境
  return 'ws://localhost:8080'
  // #endif
}

function startHeartbeat() {
  stopHeartbeat()
  heartbeatTimer = setInterval(() => {
    if (socketTask) {
      socketTask.send({ data: 'ping' })
    }
  }, HEARTBEAT_INTERVAL)
}

function stopHeartbeat() {
  if (heartbeatTimer) {
    clearInterval(heartbeatTimer)
    heartbeatTimer = null
  }
}

function scheduleReconnect() {
  clearReconnectTimer()
  reconnectTimer = setTimeout(() => {
    console.log('[WebSocket] 尝试重连...')
    connectWebSocket()
  }, RECONNECT_DELAY)
}

function clearReconnectTimer() {
  if (reconnectTimer) {
    clearTimeout(reconnectTimer)
    reconnectTimer = null
  }
}
