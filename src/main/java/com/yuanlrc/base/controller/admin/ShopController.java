package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.admin.Role;
import com.yuanlrc.base.entity.admin.User;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.admin.RoleService;
import com.yuanlrc.base.service.admin.UserService;
import com.yuanlrc.base.util.ValidateEntityUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/admin/shop")
@Controller
public class ShopController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private OperaterLogService operaterLogService;

    /**
     * 店铺列表页面
     * @param model
     * @param user
     * @param pageBean
     * @return
     */
    @RequestMapping(value="/shopList")
    public String shopList(Model model, User user, PageBean<User> pageBean){
        model.addAttribute("title", "店铺|送车点列表");
        model.addAttribute("shopName", user.getShopName());
        model.addAttribute("pageBean", userService.findShopList(user, pageBean));
        return "admin/shop/list";
    }

    /**
     * 新增管理员页面
     * @param model
     * @return
     */
    @RequestMapping(value="/shopAdd",method= RequestMethod.GET)
    public String shopAdd(Model model){
        return "admin/shop/add";
    }

    /**
     * 管理员添加表单提交处理
     * @param user
     * @return
     */
    @RequestMapping(value="/shopAdd",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> shopAdd(User user){
        Role role = roleService.findFirstByType(User.SHOPS);
        if (role != null && role.getStatus() == Role.ADMIN_ROLE_STATUS_ENABLE){
            user.setRole(role);
        }else {
            return Result.error(CodeMsg.SHOP_USE_NO_ADD_EXIST);
        }
        if (user.getShopName()=="" || user.getShopName()==null || user.getShopName().length()>15){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD_EDIT_EXIST);
        }
        if (user.getOpeningHours().getTime()>=user.getCloseOfBusiness().getTime()){
            return Result.error(CodeMsg.SHOP_USE_NO1_ADD1_EDIT_EXIST1);
        }
        if (user.getMobile() == null || user.getMobile() == ""){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD11_EDIT111_EXIST);
        }
        if (user.getLongitudeAndLatitude()=="" || user.getLongitudeAndLatitude()==null || user.getLongitudeAndLatitude().length()>100){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD1_EDIT_EXIST);
        }
        if (user.getServiceCharge() == null  || Double.valueOf(user.getServiceCharge())> 1000000L){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD11_EDIT_EXIST);
        }

        if (user.getSite().length()>20||user.getCity() == null || user.getDistrict() == null || user.getProvince() == null || user.getSite() == null ||user.getCity() == "" || user.getDistrict() == "" || user.getProvince() == "" || user.getSite() == ""){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD_EDIT_EXIST1);
        }
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(user);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if(user.getRole() == null || user.getRole().getId() == null){
            return Result.error(CodeMsg.SHOP_USER_ROLE_EMPTY);
        }
        //判断用户名是否存在
        if(userService.isExistUsername(user.getUsername(), 0L)){
            return Result.error(CodeMsg.SHOP_USERNAME_EXIST);
        }
        //到这说明一切符合条件，进行数据库新增
        if(userService.save(user) == null){
            return Result.error(CodeMsg.SHOP_USE_ADD_ERROR);
        }
        operaterLogService.add("添加店铺|送车点，登录名称：" + user.getUsername());
        return Result.success(true);
    }

    /**
     * 店铺编辑页面
     * @param model
     * @return
     */
    @RequestMapping(value="/shopEdit",method=RequestMethod.GET)
    public String shopEdit(Model model,@RequestParam(name="id",required=true)Long id){
        model.addAttribute("user", userService.find(id));
        return "admin/shop/edit";
    }

    /**
     * 编辑管理员信息表单提交处理
     * @param user
     * @return
     */
    @RequestMapping(value="/shopEdit",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> shopEdit(User user){
        Role role = roleService.findFirstByType(User.SHOPS);
        if (role != null && role.getStatus() == Role.ADMIN_ROLE_STATUS_ENABLE){
            user.setRole(role);
        }else {
            return Result.error(CodeMsg.SHOP_USE_NO_ADD_EXIST);
        }
        if (user.getShopName()=="" || user.getShopName()==null || user.getShopName().length()>15){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD_EDIT_EXIST);
        }
        if (user.getOpeningHours().getTime()>=user.getCloseOfBusiness().getTime()){
            return Result.error(CodeMsg.SHOP_USE_NO1_ADD1_EDIT_EXIST1);
        }
        if (user.getLongitudeAndLatitude()=="" || user.getLongitudeAndLatitude()==null || user.getLongitudeAndLatitude().length()>100){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD1_EDIT_EXIST);
        }
        if (user.getSite().length()>20||user.getCity() == null || user.getDistrict() == null || user.getProvince() == null || user.getSite() == null ||user.getCity() == "" || user.getDistrict() == "" || user.getProvince() == "" || user.getSite() == ""){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD_EDIT_EXIST1);
        }
        if (user.getMobile() == null || user.getMobile() == ""){
            return Result.error(CodeMsg.SHOP_USE_NO_ADD11_EDIT111_EXIST);
        }

        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(user);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if(user.getRole() == null || user.getRole().getId() == null){
            return Result.error(CodeMsg.SHOP_USER_ROLE_EMPTY);
        }
        if(user.getId() == null || user.getId().longValue() <= 0){
            return Result.error(CodeMsg.SHOP_USE_NO_EXIST);
        }
        if(userService.isExistUsername(user.getUsername(), user.getId())){
            return Result.error(CodeMsg.SHOP_USERNAME_EXIST);
        }
        //到这说明一切符合条件，进行数据库保存
        User findById = userService.find(user.getId());
        //讲提交的用户信息指定字段复制到已存在的user对象中,该方法会覆盖新字段内容
        BeanUtils.copyProperties(user, findById, "id","createTime","updateTime");
        if(userService.save(findById) == null){
            return Result.error(CodeMsg.SHOP_USE_EDIT_ERROR);
        }
        operaterLogService.add("编辑店铺|送车点，登陆名称：" + user.getUsername());
        return Result.success(true);
    }

    /**
     * 删除店铺|送车点
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> delete(@RequestParam(name="id",required=true)Long id){
        try {
            userService.delete(id);
        } catch (Exception e) {
            return Result.error(CodeMsg.SHOP_USE_DELETE_ERROR);
        }
        operaterLogService.add("删除店铺|送车点，店铺|送车点ID：" + id);
        return Result.success(true);
    }


}
