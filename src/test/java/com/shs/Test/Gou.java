package com.shs.Test;
import java.util.concurrent.CountDownLatch;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.shs.Service.SpService;
 
@RunWith(SpringJUnit4ClassRunner.class)

@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class Gou {

	@Autowired
	private SpService service;
	
	static final int num=10000;
	
	static final CountDownLatch biaoji =new CountDownLatch(num);
	
	static Long start =0l;
	static Long end =0l;
	@Test
	public void test() throws Exception {
		start =System.currentTimeMillis();
		for(int i=0;i<10000;i++) {
			Thread thread =new Thread(new Person());
			thread.start();
			biaoji.countDown();
		}
		Thread.sleep(20000);
		System.out.println("抢购结束");
		System.out.println(end-start);
	}

	
	public class Person implements Runnable{

		@Override
		public void run() {
			// TODO Auto-generated method stub
			try {
				biaoji.await();				
			} catch (Exception e) {
				// TODO: handle exception
			}
			service.updateSpByid("001");
			System.out.println("开始抢购");
			end =System.currentTimeMillis();
		}
	}			
}
