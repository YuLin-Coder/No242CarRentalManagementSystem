package com.yuanlrc.base.service.admin;
/**
 * 后台角色操作service
 */
import java.util.List;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.entity.admin.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.ExampleMatcher.GenericPropertyMatchers;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.yuanlrc.base.dao.admin.RoleDao;
import com.yuanlrc.base.entity.admin.Role;

@Service
public class RoleService {
	
	@Autowired
	private RoleDao roleDao;
	
	/**
	 * 角色添加/编辑
	 * @param role
	 * @return
	 */
	public Role save(Role role){
		return roleDao.save(role);
	}

	public Role findFirstByType(Integer type){
		return roleDao.findFirstByType(type);
	}
	
	/**
	 * 获取所有的角色列表
	 * @return
	 */
	public List<Role> findAll(Role role){
		return roleDao.findAll();
	}

	/**
	 * 获取所有的管理员角色列表
	 * @return
	 */
	public List<Role> findByType(){
		return roleDao.findByType(User.ADMIN);
	}

	
	/**
	 * 分页按角色名称搜索角色列表
	 * @param role
	 * @param pageBean
	 * @return
	 */
	public PageBean<Role> findByName(Role role, PageBean<Role> pageBean){
		ExampleMatcher withMatcher = ExampleMatcher.matching().withMatcher("name", GenericPropertyMatchers.contains());
		withMatcher = withMatcher.withIgnorePaths("status");
		Example<Role> example = Example.of(role, withMatcher);
		Pageable pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize());
		Page<Role> findAll = roleDao.findAll(example, pageable);
		pageBean.setContent(findAll.getContent());
		pageBean.setTotal(findAll.getTotalElements());
		pageBean.setTotalPage(findAll.getTotalPages());
		return pageBean;
	}

	
	/**
	 * 根据id查询角色
	 * @param id
	 * @return
	 */
	public Role find(Long id){
		return roleDao.find(id);
	}
	
	/**
	 * 根据id删除一条记录
	 * @param id
	 */
	public void delete(Long id){
		roleDao.deleteById(id);
	}
}
