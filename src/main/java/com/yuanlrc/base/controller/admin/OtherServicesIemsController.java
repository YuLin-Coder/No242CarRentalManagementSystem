package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.admin.OtherServicesIems;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.admin.OtherServicesIemsService;
import com.yuanlrc.base.util.ValidateEntityUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/otherServicesIems")
public class OtherServicesIemsController {

    @Autowired
    private OtherServicesIemsService otherServicesIemsService;

    @Autowired
    private OperaterLogService operaterLogService;

    /**
     * 分页按其他服务名称搜索列表
     * @param model
     * @param otherServicesIems
     * @param pageBean
     * @return
     */
    @RequestMapping(value="/list")
    public String list(Model model, OtherServicesIems otherServicesIems, PageBean<OtherServicesIems> pageBean){
        model.addAttribute("title", "其他服务列表");
        model.addAttribute("name", otherServicesIems.getName());
        model.addAttribute("pageBean", otherServicesIemsService.findAllByName(otherServicesIems, pageBean));
        return "admin/other_servicesIems/list";
    }

    /**
     * 其他服务添加页面
     * @return
     */
    @RequestMapping(value="/add",method= RequestMethod.GET)
    public String add(){
        return "admin/other_servicesIems/add";
    }

    /**
     * 其他服务添加表单提交处理
     * @param otherServicesIems
     * @return
     */
    @RequestMapping(value="/add",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> add(OtherServicesIems otherServicesIems){
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(otherServicesIems);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if(otherServicesIemsService.sava(otherServicesIems)== null){
            return Result.error(CodeMsg.ADMIN_OTHERSERVICESIEMS_ADD_ERROR);
        }
        operaterLogService.add("添加其他服务，其他服务名称：" + otherServicesIems.getName());
        return Result.success(true);
    }

    /**
     * 其他服务编辑页面
     * @param model
     * @return
     */
    @RequestMapping(value="/edit",method= RequestMethod.GET)
    public String edit(Model model,@RequestParam(name="id",required=true)Long id){
        model.addAttribute("otherServicesIems",otherServicesIemsService.find(id));
        return "admin/other_servicesIems/edit";
    }

    /**
     * 编辑其他服务表单提交处理
     * @param otherServicesIems
     * @return
     */
    @RequestMapping(value="/edit",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> edit(OtherServicesIems otherServicesIems){
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(otherServicesIems);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        //到这说明一切符合条件，进行数据库保存
        OtherServicesIems findById = otherServicesIemsService.find(otherServicesIems.getId());
        //讲提交的用户信息指定字段复制到已存在的OtherServicesIems对象中,该方法会覆盖新字段内容
        BeanUtils.copyProperties(otherServicesIems, findById, "id","createTime","updateTime");
        if(otherServicesIemsService.sava(findById) == null){
            return Result.error(CodeMsg.ADMIN_OTHERSERVICESIEMS_EDIT_ERROR);
        }
        operaterLogService.add("编辑其他服务，其他服务名称：" + otherServicesIems.getName());
        return Result.success(true);
    }

    /**
     * 删除其他服务
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method= RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> delete(@RequestParam(name="id",required=true)Long id){
        try {
            otherServicesIemsService.delete(id);
        } catch (Exception e) {
            return Result.error(CodeMsg.ADMIN_OTHERSERVICESIEMS_DELETE_ERROR);
        }
        operaterLogService.add("删除其他服务，其他服务ID：" + id);
        return Result.success(true);
    }

}
