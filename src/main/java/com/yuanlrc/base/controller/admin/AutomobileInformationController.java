package com.yuanlrc.base.controller.admin;


import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.admin.*;
import com.yuanlrc.base.service.admin.AutomobileBrandService;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.admin.AutomobileInformationService;
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
@RequestMapping("/admin/automobileInformation")
public class AutomobileInformationController {

    @Autowired
    private AutomobileInformationService automobileInformationService;

    @Autowired
    private AutomobileBrandService automobileBrandService;

    @Autowired
    private OperaterLogService operaterLogService;

    @RequestMapping("/list")
    public String list(Model model, AutomobileInformation automobileInformation, PageBean<AutomobileInformation> pageBean, String brand){
        model.addAttribute("brand", brand);
        model.addAttribute("introduceName", automobileInformation.getIntroduceName());
        model.addAttribute("title", "汽车信息列表");
        model.addAttribute("pageBean", automobileInformationService.findList(automobileInformation,pageBean,brand));
        return "/admin/automobile_information/list";
    }

    @RequestMapping(value="/add",method= RequestMethod.GET)
    public String add(Model model){
        model.addAttribute("automobileStalls", AutomobileStallsEnum.values());
        model.addAttribute("automobileSeat", AutomobileSeatEnum.values());
        model.addAttribute("automobileType", AutomobileTypeEnum.values());
        model.addAttribute("automobileBrands",automobileBrandService.findAll());
        return "/admin/automobile_information/add";
    }

    @RequestMapping(value="/add",method= RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> add(AutomobileInformation automobileInformation){
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(automobileInformation);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (automobileInformation.getAutomobileBrand()==null){
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_ADD5_ERROR);
        }

        if (automobileInformation.getAutomobilePicturePath() == null || automobileInformation.getAutomobilePicturePath() == ""){
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_ADD1_ERROR);
        }
        if (automobileInformation.getAutomobileVideoPath() == null || automobileInformation.getAutomobileVideoPath() == ""){
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_ADD2_ERROR);
        }
        //到这说明一切符合条件，进行数据库新增
        if(automobileInformationService.sava(automobileInformation) == null){
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_ADD_ERROR);
        }

        operaterLogService.add("添加汽车信息，汽车信息ID：" + automobileInformation.getId());
        return Result.success(true);
    }


    @RequestMapping(value="/edit",method= RequestMethod.GET)
    public String edit(Model model,@RequestParam(name="id",required=true)Long id){
        model.addAttribute("automobileStalls", AutomobileStallsEnum.values());
        model.addAttribute("automobileSeat", AutomobileSeatEnum.values());
        model.addAttribute("automobileType", AutomobileTypeEnum.values());
        model.addAttribute("automobileBrands",automobileBrandService.findAll());
        model.addAttribute("vehicleInformation", automobileInformationService.find(id));
        return "/admin/automobile_information/edit";
    }

    @RequestMapping(value="/edit",method= RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> edit(AutomobileInformation automobileInformation){
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(automobileInformation);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (automobileInformation.getAutomobilePicturePath() == null || automobileInformation.getAutomobilePicturePath() == ""){
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_ADD1_ERROR);
        }
        if (automobileInformation.getAutomobileVideoPath() == null || automobileInformation.getAutomobileVideoPath() == ""){
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_ADD2_ERROR);
        }
        AutomobileInformation automobileInformationById = automobileInformationService.find(automobileInformation.getId());
        BeanUtils.copyProperties(automobileInformation, automobileInformationById, "id","createTime","updateTime");
        //到这说明一切符合条件，进行数据库新增
        if(automobileInformationService.sava(automobileInformationById) == null){
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_EDIT_ERROR);
        }
        operaterLogService.add("编辑汽车信息，汽车信息ID：" + automobileInformation.getId());
        return Result.success(true);
    }

    /**
     * 删除车辆信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method= RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> delete(@RequestParam(name="id",required=true)Long id){
        try {
            automobileInformationService.delete(id);
        } catch (Exception e) {
            return Result.error(CodeMsg.ADMIN_VEHICLEINFORMATION_DELETE_ERROR);
        }
        operaterLogService.add("删除汽车信息，汽车信息ID：" + id);
        return Result.success(true);
    }



}
