package com.yuanlrc.base.service.admin;

import com.yuanlrc.base.dao.admin.OrderAuthDao;
import com.yuanlrc.base.entity.admin.OrderAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 后台操作类 数据库操作service
 * @author Administrator
 *
 */
@Service
public class OrderAuthService {
	
	@Autowired
	private OrderAuthDao orderAuthDao;
	
	/**
	 * 添加/修改操作日志，当id不为空时，修改，id为空时自动新增一条记录
	 * @param
	 * @return
	 */
	public OrderAuth save(OrderAuth orderAuth){
		return orderAuthDao.save(orderAuth);
	}
	
	/**
	 * 获取一条记录
	 * @return
	 */
	public OrderAuth findOne(){
		List<OrderAuth> findAll = orderAuthDao.findAll(Sort.by(Direction.DESC, "createTime"));
		if(findAll == null || findAll.size() < 1)return null;
		return findAll.get(0);
	}
}
