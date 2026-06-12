package com.ruoyi.framework.config;

import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * redis配置
 * 
 * @author ruoyi
 */
@SuppressWarnings("deprecation")
@Configuration
@EnableCaching
public class RedisConfig extends CachingConfigurerSupport
{
    @Bean
    @SuppressWarnings(value = { "unchecked", "rawtypes" })
    public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory connectionFactory)
    {
        RedisTemplate<Object, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        FastJson2JsonRedisSerializer serializer = new FastJson2JsonRedisSerializer(Object.class);

        // 使用StringRedisSerializer来序列化和反序列化redis的key值
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(serializer);

        // Hash的key也采用StringRedisSerializer的序列化方式
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(serializer);

        template.afterPropertiesSet();
        return template;
    }

    @Bean
    public StringRedisTemplate stringRedisTemplate(RedisConnectionFactory connectionFactory)
    {
        return new StringRedisTemplate(connectionFactory);
    }

    @Bean
    public DefaultRedisScript<Long> limitScript()
    {
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setScriptText(limitScriptText());
        redisScript.setResultType(Long.class);
        return redisScript;
    }

    /**
     * 限流脚本
     */
    private String limitScriptText()
    {
        return "local key = KEYS[1]\n" +
                "local count = tonumber(ARGV[1])\n" +
                "local time = tonumber(ARGV[2])\n" +
                "local current = redis.call('get', key);\n" +
                "if current and tonumber(current) > count then\n" +
                "    return tonumber(current);\n" +
                "end\n" +
                "current = redis.call('incr', key)\n" +
                "if tonumber(current) == 1 then\n" +
                "    redis.call('expire', key, time)\n" +
                "end\n" +
                "return tonumber(current);";
    }

    /**
     * 预约槽位预占 Lua 脚本
     * KEYS[1]: 槽位计数key, ARGV[1]: 请求数量, ARGV[2]: 最大容量, ARGV[3]: TTL
     * 返回: 1=预占成功, 0=容量不足
     */
    @Bean("bookingOccupyScript")
    public DefaultRedisScript<Long> bookingOccupyScript()
    {
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setResultType(Long.class);
        redisScript.setScriptText(
            "local current = redis.call('GET', KEYS[1])\n" +
            "local requested = tonumber(ARGV[1])\n" +
            "local maxCap = tonumber(ARGV[2])\n" +
            "local ttl = tonumber(ARGV[3])\n" +
            "if current and tonumber(current) + requested > maxCap then\n" +
            "    return 0\n" +
            "end\n" +
            "local newVal = redis.call('INCRBY', KEYS[1], requested)\n" +
            "redis.call('EXPIRE', KEYS[1], ttl)\n" +
            "return 1"
        );
        return redisScript;
    }

    /**
     * 预约槽位释放 Lua 脚本
     * KEYS[1]: 槽位计数key, ARGV[1]: 释放数量
     * 返回: 释放后的剩余数量
     */
    @Bean("bookingReleaseScript")
    public DefaultRedisScript<Long> bookingReleaseScript()
    {
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setResultType(Long.class);
        redisScript.setScriptText(
            "local current = redis.call('GET', KEYS[1])\n" +
            "if not current then return 0 end\n" +
            "local release = tonumber(ARGV[1])\n" +
            "local newVal = math.max(0, tonumber(current) - release)\n" +
            "redis.call('SET', KEYS[1], newVal)\n" +
            "return newVal"
        );
        return redisScript;
    }
}
