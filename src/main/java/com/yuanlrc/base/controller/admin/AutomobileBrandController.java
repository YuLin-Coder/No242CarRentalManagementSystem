package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.admin.AutomobileBrand;
import com.yuanlrc.base.service.admin.AutomobileBrandService;
import com.yuanlrc.base.service.admin.OperaterLogService;
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
@RequestMapping("/admin/automobileBrand")
public class AutomobileBrandController {

    @Autowired
    private AutomobileBrandService automobileBrandService;
    @Autowired
    private OperaterLogService operaterLogService;

    @RequestMapping("/list")
    public String list(Model model, AutomobileBrand automobileBrand, PageBean<AutomobileBrand> pageBean){
        model.addAttribute("title", "汽车品牌列表");
        model.addAttribute("brand",automobileBrand.getBrand());
        model.addAttribute("pageBean",automobileBrandService.findAllByBrand(automobileBrand,pageBean));
        return "admin/automobile_brand/list";
    }

    @RequestMapping(value = "/add",method= RequestMethod.GET)
    public String add(Model model){

        return "admin/automobile_brand/add";
    }

    @RequestMapping(value = "/add",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> add(AutomobileBrand automobileBrand){
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(automobileBrand);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        //判断汽车品牌是否存在
        if(automobileBrandService.isExistBrand(automobileBrand.getBrand(), 0L)){
            return Result.error(CodeMsg.ADMIN_AUTOMOBILE_BRAND_EXIST);
        }
        //到这说明一切符合条件，进行数据库新增
        if(automobileBrandService.save(automobileBrand) == null){
            return Result.error(CodeMsg.ADMIN_AUTOMOBILE_BRAND_ADD_ERROR);
        }
        operaterLogService.add("添加汽车品牌，汽车品牌名称：" + automobileBrand.getBrand());

        return Result.success(true);
    }

    @RequestMapping(value = "/edit",method=RequestMethod.GET)
    public String edit(Model model,@RequestParam(name="id",required=true)Long id){
        model.addAttribute("automobileBrand",automobileBrandService.find(id));
        return "admin/automobile_brand/edit";
    }

    @RequestMapping(value = "/edit",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> edit(AutomobileBrand automobileBrand){
        //用统一验证实体方法验证是否合法

        CodeMsg validate = ValidateEntityUtil.validate(automobileBrand);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        //判断汽车品牌是否存在
        if(automobileBrandService.isExistBrand(automobileBrand.getBrand(), automobileBrand.getId())){
            return Result.error(CodeMsg.ADMIN_AUTOMOBILE_BRAND_EXIST);
        }
        AutomobileBrand automobileBrandById = automobileBrandService.find(automobileBrand.getId());
        BeanUtils.copyProperties(automobileBrand, automobileBrandById, "id","createTime","updateTime");
        //到这说明一切符合条件，进行数据库新增
        if(automobileBrandService.save(automobileBrandById) == null){
            return Result.error(CodeMsg.ADMIN_AUTOMOBILE_BRAND_EDIT_ERROR);
        }
        operaterLogService.add("编辑汽车品牌，汽车品牌名称：" + automobileBrand.getBrand());

        return Result.success(true);
    }

    /**
     * 删除汽车品牌
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> delete(@RequestParam(name="id",required=true)Long id){
        try {
            automobileBrandService.delete(id);
        } catch (Exception e) {
            return Result.error(CodeMsg.ADMIN_AUTOMOBILE_BRAND_DELETE_ERROR);
        }
        operaterLogService.add("删除汽车品牌，汽车品牌ID：" + id);
        return Result.success(true);
    }
}
