package com.shs.pool;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class jedispool {
	private static volatile JedisPool jedisPool=null;
	private jedispool() {}
	
	public static JedisPool getJedisPool() {
		if (jedisPool==null)
		{
			synchronized (jedispool.class) {
				if (jedisPool==null) {
					JedisPoolConfig config =new JedisPoolConfig();
					config.setMaxTotal(1000);
					config.setMaxIdle(32);
					jedisPool =new JedisPool(config,"192.168.134.130",6380);
				
				}
			}
		}
		return jedisPool;
	}

	public static void release(JedisPool jedisPool,Jedis jedis) {
		if (jedisPool!=null) {
			jedisPool.returnResourceObject(jedis);
		}
	}
}
