<script setup>
  import config from './config'
  import { getToken } from '@/utils/auth'
  import { useConfigStore } from '@/store'
  import { getCurrentInstance } from "vue"
  import { onLaunch, onHide, onShow } from '@dcloudio/uni-app'
  import { connectWebSocket, disconnectWebSocket } from '@/utils/websocket'

  const { proxy } = getCurrentInstance()

  onLaunch(() => {
    initApp()
  })

  onShow(() => {
    // 应用从后台切回前台时重连
    if (getToken()) {
      connectWebSocket()
    }
  })

  onHide(() => {
    // 应用进入后台时断开（省电）
    disconnectWebSocket()
  })

  // 初始化应用
  function initApp() {
    // 初始化应用配置
    initConfig()
    // 检查用户登录状态
    //#ifdef H5
    checkLogin()
    //#endif
  }

  function initConfig() {
    useConfigStore().setConfig(config)
  }

  function checkLogin() {
    if (!getToken()) {
      proxy.$tab.reLaunch('/pages/login') 
    } else {
      // 已登录，建立 WebSocket 连接
      connectWebSocket()
    }
  }
</script>

<style lang="scss">
  @import '@/static/scss/index.scss'
</style>
