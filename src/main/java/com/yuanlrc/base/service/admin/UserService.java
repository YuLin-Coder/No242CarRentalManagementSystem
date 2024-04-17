package com.yuanlrc.base.service.admin;

import com.yuanlrc.base.bean.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.yuanlrc.base.dao.admin.UserDao;
import com.yuanlrc.base.entity.admin.User;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import java.util.List;


/**
 * 用户管理service
 * @author Administrator
 *
 */
@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	/**
	 * 根据用户id查询
	 * @param id
	 * @return
	 */
	public User find(Long id){
		return userDao.find(id);
	}
	
	/**
	 * 按照用户名查找用户
	 * @param username
	 * @return
	 */
	public User findByUsername(String username){
		return userDao.findByUsername(username);
	}
	
	/**
	 * 用户添加/编辑操作
	 * @param user
	 * @return
	 */
	public User save(User user){
		return userDao.save(user);
	}
	
	/**
	 * 分页查询管理员用户列表
	 * @param user
	 * @param pageBean
	 * @return
	 */
	public PageBean<User> findList(User user, PageBean<User> pageBean){
		Specification<User> specification = new Specification<User>() {
			@Override
			public Predicate toPredicate(Root<User> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
				Predicate predicate = criteriaBuilder.like(root.get("username"), "%" + (user.getUsername() == null ? "" : user.getUsername()) + "%");
				Predicate predicateType = criteriaBuilder.equal(root.get("type"),User.ADMIN);
				predicate = criteriaBuilder.and(predicate,predicateType);
				return predicate;
			}
		};
		Pageable pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize());
		Page<User> findAll = userDao.findAll(specification, pageable);
		pageBean.setContent(findAll.getContent());
		pageBean.setTotal(findAll.getTotalElements());
		pageBean.setTotalPage(findAll.getTotalPages());
		return pageBean;
	}

	/**
	 * 分页查询管理员地主列表
	 * @param user
	 * @param pageBean
	 * @return
	 */
	public PageBean<User> findShopList(User user,PageBean<User> pageBean){
		Specification<User> specification = new Specification<User>() {
			@Override
			public Predicate toPredicate(Root<User> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
				Predicate predicate = criteriaBuilder.like(root.get("shopName"), "%" + (user.getShopName() == null ? "" : user.getShopName()) + "%");
				Predicate predicateType1 = criteriaBuilder.equal(root.get("type"),User.SHOPS);
				Predicate predicateType2 = criteriaBuilder.equal(root.get("type"),User.SENDTHECARPOINT);
				predicateType1 = criteriaBuilder.or(predicateType1,predicateType2);
				predicate = criteriaBuilder.and(predicate,predicateType1);
				return predicate;
			}
		};
		Pageable pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize());
		Page<User> findAll = userDao.findAll(specification, pageable);
		pageBean.setContent(findAll.getContent());
		pageBean.setTotal(findAll.getTotalElements());
		pageBean.setTotalPage(findAll.getTotalPages());
		return pageBean;
	}


	/**
	 * 判断用户名是否存在，添加和编辑均可判断
	 * @param username
	 * @param id
	 * @return
	 */
	public boolean isExistUsername(String username,Long id){
		User user = userDao.findByUsername(username);
		if(user != null){
			//表示用户名存在，接下来判断是否是编辑用户的本身
			if(user.getId().longValue() != id.longValue()){
				return true;
			}
		}
		return false;
	}


	/**
	 * 按照用户id删除
	 * @param id
	 */
	public void delete(Long id){
		userDao.deleteById(id);
	}
	
	/**
	 * 返回用户总数
	 * @return
	 */
	public long total(){
		return userDao.count();
	}

	/**
	 * 根据城市模糊查询
	 * @param city
	 * @return
	 */
	public List<User> findByCityLikeAndStatus(String city){
		return userDao.findByCityLikeAndStatus(city,1);
	}

	/**
	 * 根据区模模糊查询
	 * @param district
	 * @return
	 */
	public List<User> findByDistrict(String district){
		return userDao.findByDistrict(district);
	}

	/**
	 * 根据类型查询第一条
	 */
	public User findFirstByType(){
		return userDao.findFirstByType(User.SHOPS);
	}
}
