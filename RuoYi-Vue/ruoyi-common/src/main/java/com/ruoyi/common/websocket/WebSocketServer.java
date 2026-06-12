package com.ruoyi.common.websocket;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;

/**
 * WebSocket 消息推送服务
 * 用户连接后通过 token 鉴权，建立 userId -> session 映射，支持按用户推送消息
 */
@Component
@ServerEndpoint("/ws/message/{token}")
public class WebSocketServer
{
    private static final Logger log = LoggerFactory.getLogger(WebSocketServer.class);

    /** userId -> WebSocket session */
    private static final Map<Long, Session> USER_SESSIONS = new ConcurrentHashMap<>();

    /** sessionId -> userId 反向映射，关闭时快速查找 */
    private static final Map<String, Long> SESSION_USERS = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("token") String token)
    {
        if (StringUtils.isEmpty(token))
        {
            closeSession(session, "缺少认证token");
            return;
        }

        try
        {
            LoginUser loginUser = parseToken(token);
            if (loginUser == null)
            {
                closeSession(session, "token无效或已过期");
                return;
            }

            Long userId = loginUser.getUserId();
            Session old = USER_SESSIONS.remove(userId);
            if (old != null && old.isOpen())
            {
                SESSION_USERS.remove(old.getId());
                old.close();
            }

            USER_SESSIONS.put(userId, session);
            SESSION_USERS.put(session.getId(), userId);
            log.info("WebSocket连接建立: userId={}, sessionId={}", userId, session.getId());
        }
        catch (Exception e)
        {
            log.error("WebSocket连接验证失败: {}", e.getMessage());
            closeSession(session, "认证失败");
        }
    }

    @OnClose
    public void onClose(Session session)
    {
        Long userId = SESSION_USERS.remove(session.getId());
        if (userId != null)
        {
            USER_SESSIONS.remove(userId, session);
            log.info("WebSocket连接关闭: userId={}, sessionId={}", userId, session.getId());
        }
    }

    @OnError
    public void onError(Session session, Throwable error)
    {
        log.error("WebSocket异常: sessionId={}, error={}", session.getId(), error.getMessage());
        onClose(session);
    }

    /**
     * 推送消息给指定用户
     * @return true=推送成功, false=用户不在线
     */
    public static boolean sendToUser(Long userId, String message)
    {
        Session session = USER_SESSIONS.get(userId);
        if (session != null && session.isOpen())
        {
            try
            {
                session.getBasicRemote().sendText(message);
                return true;
            }
            catch (IOException e)
            {
                log.error("WebSocket推送失败: userId={}", userId);
                USER_SESSIONS.remove(userId);
                SESSION_USERS.remove(session.getId());
                return false;
            }
        }
        return false;
    }

    /**
     * 广播消息给所有在线用户
     */
    public static void broadcast(String message)
    {
        for (Map.Entry<Long, Session> entry : USER_SESSIONS.entrySet())
        {
            try
            {
                if (entry.getValue().isOpen())
                {
                    entry.getValue().getBasicRemote().sendText(message);
                }
            }
            catch (IOException e)
            {
                log.error("WebSocket广播失败: userId={}", entry.getKey());
            }
        }
    }

    public static int getOnlineCount()
    {
        return USER_SESSIONS.size();
    }

    /**
     * 解析 JWT token，从 Redis 获取 LoginUser
     */
    private LoginUser parseToken(String token)
    {
        try
        {
            if (token.startsWith(Constants.TOKEN_PREFIX))
            {
                token = token.replace(Constants.TOKEN_PREFIX, "");
            }
            String secret = SpringUtils.getBean(Environment.class).getProperty("token.secret");
            Claims claims = Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
            String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
            String userKey = CacheConstants.LOGIN_TOKEN_KEY + uuid;
            RedisCache redisCache = SpringUtils.getBean(RedisCache.class);
            return redisCache.getCacheObject(userKey);
        }
        catch (Exception e)
        {
            return null;
        }
    }

    private void closeSession(Session session, String reason)
    {
        try
        {
            session.close(new jakarta.websocket.CloseReason(
                    jakarta.websocket.CloseReason.CloseCodes.VIOLATED_POLICY, reason));
        }
        catch (IOException ignored)
        {
        }
    }
}
