package com.yuanlrc.base.util;

import com.yuanlrc.base.dao.home.OrderDao;
import com.yuanlrc.base.entity.home.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.time.LocalDateTime;
import java.util.List;

@Configuration
@EnableScheduling
public class SaticScheduleTask {

    @Autowired
    private OrderDao orderDao;

    @Scheduled(cron = "0 0/15 * * * ?")
    //@Scheduled(fixedRate=5000)
    private void configureTasks() {
        List<Order> all = orderDao.findAll();
        for (Order order : all) {
            if (order.getType() == null){
                orderDao.deleteById(order.getId());
            }
        }
    }
}