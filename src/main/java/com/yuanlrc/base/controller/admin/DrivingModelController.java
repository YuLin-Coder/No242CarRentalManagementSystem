package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.home.DrivingModel;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.home.DrivingModelService;
import com.yuanlrc.base.util.ValidateEntityUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/drivingModel")
public class DrivingModelController {
    @Autowired
    private DrivingModelService drivingModelService;
    @Autowired
    private OperaterLogService operaterLogService;

    @RequestMapping("/list")
    public String list(Model model, DrivingModel drivingModel, PageBean<DrivingModel> pageBean){
        model.addAttribute("title", "准驾车型管理");
        model.addAttribute("carModel",drivingModel.getCarModel());
        model.addAttribute("pageBean",drivingModelService.findList(drivingModel,pageBean));
        return "admin/drivingModel/list";
    }
    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String add(Model model){
        return "admin/drivingModel/add";
    }
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> add(DrivingModel drivingModel){
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(drivingModel);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (drivingModel==null){
            return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_ADD_ERROR);
        }
        if (drivingModelService.findByCarModel(drivingModel.getCarModel().trim())!=null){
            return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_EDIT_ERROR_2);
        }
        if (drivingModelService.save(drivingModel)==null){
            return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_ADD_ERROR);
        }
        operaterLogService.add("添加准驾车型，准驾车型名称：" + drivingModel.getCarModel());
        return Result.success(true);
    }
    @RequestMapping(value = "/edit",method = RequestMethod.GET)
    public String edit(Model model,@RequestParam(name="id",required=true)Long id){
        model.addAttribute("drivingModel",drivingModelService.find(id));
        return "admin/drivingModel/edit";
    }

    @RequestMapping(value = "/edit",method=RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> edit(DrivingModel drivingModel){
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(drivingModel);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (drivingModel==null){
            return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_EDIT_ERROR);
        }
        if (drivingModel.getId()==null||drivingModel.getId()==0){
            return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_EDIT_ERROR);
        }
        if (drivingModelService.findByCarModel(drivingModel.getCarModel())!=null){
            if (drivingModelService.findByCarModel(drivingModel.getCarModel().trim()).getId()!=drivingModel.getId()){
                return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_EDIT_ERROR_2);
            }
        }
        DrivingModel findById = drivingModelService.find(drivingModel.getId());
        BeanUtils.copyProperties(drivingModel, findById, "id","createTime","updateTime");
        //到这说明一切符合条件，进行数据库新增
        if(drivingModelService.save(findById) == null){
            return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_EDIT_ERROR);
        }
        operaterLogService.add("编辑准驾车型，准驾车型名称：" + drivingModel.getCarModel());
        return Result.success(true);
    }

    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> delete(@RequestParam(name = "id",required = true) Long id){
        try{
            drivingModelService.delete(id);
        }catch (Exception e){
            return Result.error(CodeMsg.ADMIN_DRIVINGMODEL_DELETE_ERROR);
        }
        operaterLogService.add("删除准驾车型失败,准驾车型id:"+id);
        return Result.success(true);
    }
}
