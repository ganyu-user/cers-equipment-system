import { getToken } from '@/utils/auth'
import { ElNotification } from 'element-plus'

const HEARTBEAT_INTERVAL = 30000
const RECONNECT_DELAY = 5000

let ws = null
let heartbeatTimer = null
let reconnectTimer = null
let isManualClose = false

/**
 * 连接 WebSocket
 */
export function connectWebSocket() {
  if (ws && (ws.readyState === WebSocket.OPEN || ws.readyState === WebSocket.CONNECTING)) {
    return
  }

  isManualClose = false
  const token = getToken()
  if (!token) return

  const protocol = location.protocol === 'https:' ? 'wss:' : 'ws:'
  const host = location.host
  const url = `${protocol}//${host}/ws/message/${encodeURIComponent(token)}`

  ws = new WebSocket(url)

  ws.onopen = () => {
    console.log('[WebSocket] 连接成功')
    startHeartbeat()
    clearReconnectTimer()
  }

  ws.onmessage = (event) => {
    try {
      const data = JSON.parse(event.data)
      handleMessage(data)
    } catch (e) {
      console.warn('[WebSocket] 消息解析失败:', e)
    }
  }

  ws.onclose = (e) => {
    console.log('[WebSocket] 连接关闭:', e.code, e.reason)
    stopHeartbeat()
    if (!isManualClose) {
      scheduleReconnect()
    }
  }

  ws.onerror = (e) => {
    console.error('[WebSocket] 连接错误')
  }
}

/**
 * 断开 WebSocket
 */
export function disconnectWebSocket() {
  isManualClose = true
  stopHeartbeat()
  clearReconnectTimer()
  if (ws) {
    ws.close()
    ws = null
  }
}

/**
 * 处理收到的消息
 */
function handleMessage(data) {
  if (data.type === 'msg') {
    const isUrgent = data.priority === 'urgent'
    ElNotification({
      title: isUrgent ? '【紧急】' + data.title : data.title,
      message: data.content,
      type: isUrgent ? 'error' : 'info',
      duration: isUrgent ? 0 : 5000,
      position: 'top-right',
      dangerouslyUseHTMLString: false
    })
  }
}

function startHeartbeat() {
  stopHeartbeat()
  heartbeatTimer = setInterval(() => {
    if (ws && ws.readyState === WebSocket.OPEN) {
      ws.send('ping')
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
