package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.admin.Role;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuanlrc.base.entity.admin.User;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.admin.RoleService;
import com.yuanlrc.base.service.admin.UserService;
import com.yuanlrc.base.util.ValidateEntityUtil;

/**
 * 后台用户管理控制器
 * @author Administrator
 *
 */
@RequestMapping("/admin/user")
@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private OperaterLogService operaterLogService;

	/**
	 * 管理员列表页面
	 * @param model
	 * @param user
	 * @param pageBean
	 * @return
	 */
	@RequestMapping(value="/list")
	public String list(Model model, User user, PageBean<User> pageBean){
		model.addAttribute("title", "用户列表");
		model.addAttribute("username", user.getUsername());
		model.addAttribute("pageBean", userService.findList(user, pageBean));
		return "admin/user/list";
	}


	/**
	 * 新增管理员页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model){
		model.addAttribute("roles", roleService.findByType());
		return "admin/user/add";
	}
	
	/**
	 * 管理员添加表单提交处理
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Result<Boolean> add(User user){
		user.setType(User.ADMIN);
		//用统一验证实体方法验证是否合法
		CodeMsg validate = ValidateEntityUtil.validate(user);
		if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
			return Result.error(validate);
		}
		if(user.getRole() == null || user.getRole().getId() == null){
			return Result.error(CodeMsg.ADMIN_USER_ROLE_EMPTY);
		}
		//判断用户名是否存在
		if(userService.isExistUsername(user.getUsername(), 0L)){
			return Result.error(CodeMsg.ADMIN_USERNAME_EXIST);
		}
		//到这说明一切符合条件，进行数据库新增
		if(userService.save(user) == null){
			return Result.error(CodeMsg.ADMIN_USE_ADD_ERROR);
		}
		operaterLogService.add("添加管理员，登陆名称：" + user.getUsername());
		return Result.success(true);
	}


	/**
	 * 管理员编辑页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public String edit(Model model,@RequestParam(name="id",required=true)Long id){
		model.addAttribute("roles", roleService.findByType());
		model.addAttribute("user", userService.find(id));
		return "admin/user/edit";
	}
	
	/**
	 * 编辑管理员信息表单提交处理
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public Result<Boolean> edit(User user){
		user.setType(User.ADMIN);
		//用统一验证实体方法验证是否合法
		CodeMsg validate = ValidateEntityUtil.validate(user);
		if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
			return Result.error(validate);
		}
		if(user.getRole() == null || user.getRole().getId() == null){
			return Result.error(CodeMsg.ADMIN_USER_ROLE_EMPTY);
		}
		if(user.getId() == null || user.getId().longValue() <= 0){
			return Result.error(CodeMsg.ADMIN_USE_NO_EXIST);
		}
		if(userService.isExistUsername(user.getUsername(), user.getId())){
			return Result.error(CodeMsg.ADMIN_USERNAME_EXIST);
		}
		//到这说明一切符合条件，进行数据库保存
		User findById = userService.find(user.getId());
		//讲提交的用户信息指定字段复制到已存在的user对象中,该方法会覆盖新字段内容
		BeanUtils.copyProperties(user, findById, "id","createTime","updateTime","type");
		if(userService.save(findById) == null){
			return Result.error(CodeMsg.ADMIN_USE_EDIT_ERROR);
		}
		operaterLogService.add("编辑管理员，登录名称：" + user.getUsername());
		return Result.success(true);
	}
	
	/**
	 * 删除管理员
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Result<Boolean> delete(@RequestParam(name="id",required=true)Long id){
		try {
			userService.delete(id);
		} catch (Exception e) {
			return Result.error(CodeMsg.ADMIN_USE_DELETE_ERROR);
		}
		operaterLogService.add("删除管理员，管理员ID：" + id);
		return Result.success(true);
	}
}
