package com.shs.ServiceImpl;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shs.Dao.SpMapper;
import com.shs.Service.SpService;
import com.shs.pool.jedispool;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@Service
public class SpServiceImpl implements SpService {
	@Autowired
	private SpMapper sp;
	static int shuliang=0;
	
	@Override
	public boolean updateSpByid(String id) {
		JedisPool jedisPool=jedispool.getJedisPool();
		Jedis jedis=null;
		if (jedisPool!=null)
			jedis = jedisPool.getResource();
		try {		
			String uuid = UUID.randomUUID().toString();

			while (jedis.setnx("lock", uuid)==0)
			{
				Thread.sleep(10);
			}
			jedis.expire("lock", 1);
			Integer count =Integer.parseInt(jedis.get("count"));
			System.out.println("输出当前数量"+count);
			if (count>0) {
				
					count=count-1;
					jedis.set("count",count.toString());
					sp.updateById(id);
					shuliang++;
					System.out.println("抢购"+shuliang+"成功");
					return true;		
			}			
		 else return false;
		
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		finally {
			jedis.del("lock");
		}
		return false;		
//		return sp.updateById(id)>0?true:false;
	}

}
