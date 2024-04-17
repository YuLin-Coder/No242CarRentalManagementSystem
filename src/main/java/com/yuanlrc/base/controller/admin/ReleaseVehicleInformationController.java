package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.admin.*;
import com.yuanlrc.base.service.admin.*;
import com.yuanlrc.base.util.SessionUtil;
import com.yuanlrc.base.util.ValidateEntityUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/releaseVehicleInformation")
public class ReleaseVehicleInformationController {

    @Autowired
    private ReleaseVehicleInformationService releaseVehicleInformationService;

    @Autowired
    private AutomobileInformationService automobileInformationService;

    @Autowired
    private OtherServicesIemsService otherServicesIemsService;

    @Autowired
    private OperaterLogService operaterLogService;

    @RequestMapping("/list")
    public String list(Model model, ReleaseVehicleInformation releaseVehicleInformation, PageBean<ReleaseVehicleInformation> pageBean,
                       String brand,String introduceName){
        model.addAttribute("brand",brand);
        model.addAttribute("introduceName",introduceName);
        model.addAttribute("title", "租车发布信息列表");
        model.addAttribute("pageBean", releaseVehicleInformationService.findList(releaseVehicleInformation,pageBean,brand,introduceName));
        return "/admin/release_vehicle_information/list";
    }

    @RequestMapping("/adminList")
    public String adminList(Model model, ReleaseVehicleInformation releaseVehicleInformation, PageBean<ReleaseVehicleInformation> pageBean,
                       String brand,String shopName){
        model.addAttribute("brand",brand);
        model.addAttribute("shopName",shopName);
        model.addAttribute("title", "租车发布信息列表");
        model.addAttribute("pageBean", releaseVehicleInformationService.findAdminList(releaseVehicleInformation,pageBean,brand,shopName));
        return "/admin/release_vehicle_information/admin_list";
    }




    @RequestMapping(value="/add",method= RequestMethod.GET)
    public String add(Model model){
        model.addAttribute("automobileInformations",automobileInformationService.findAll());
        model.addAttribute("otherServicesIems",otherServicesIemsService.findAll());
        return "/admin/release_vehicle_information/add";
    }

    @RequestMapping(value="/add",method= RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> add(ReleaseVehicleInformation releaseVehicleInformation){
        User loginedUser = SessionUtil.getLoginedUser();
        releaseVehicleInformation.setUser(loginedUser);
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(releaseVehicleInformation);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (releaseVehicleInformation.getAutomobileInformation()== null){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_ADD1_ERROR);
        }

        if (releaseVehicleInformation.getOtherServicesIems().size()<=0){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_ADD2_ERROR);
        }
        //到这说明一切符合条件，进行数据库新增
        if(releaseVehicleInformationService.sava(releaseVehicleInformation) == null){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_ADD_ERROR);
        }
        operaterLogService.add("添加租车发布信息，租车发布信息ID：" + releaseVehicleInformation.getId());
        return Result.success(true);
    }


    @RequestMapping(value="/edit",method= RequestMethod.GET)
    public String edit(Model model, @RequestParam(name="id",required=true)Long id){
        model.addAttribute("releaseVehicleInformation", releaseVehicleInformationService.find(id));
        model.addAttribute("otherServicesIems",otherServicesIemsService.findAll());
        return "/admin/release_vehicle_information/edit";
    }

    @RequestMapping(value="/edit",method= RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> edit(ReleaseVehicleInformation releaseVehicleInformation){
        User loginedUser = SessionUtil.getLoginedUser();
        //用统一验证实体方法验证是否合法
        CodeMsg validate = ValidateEntityUtil.validate(releaseVehicleInformation);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (releaseVehicleInformation.getAutomobileInformation()==null){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_ADD1_ERROR);
        }

        if (releaseVehicleInformation.getOtherServicesIems().size()<=0){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_ADD2_ERROR);
        }
        ReleaseVehicleInformation releaseVehicleInformationById = releaseVehicleInformationService.find(releaseVehicleInformation.getId());
        BeanUtils.copyProperties(releaseVehicleInformation, releaseVehicleInformationById, "id","createTime","updateTime");
        releaseVehicleInformationById.setUser(loginedUser);
        //到这说明一切符合条件，进行数据库新增
        if(releaseVehicleInformationService.sava(releaseVehicleInformationById) == null){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_EDIT_ERROR);
        }

        operaterLogService.add("编辑租车发布信息，租车发布信息ID：" + releaseVehicleInformation.getId());
        return Result.success(true);
    }

    @RequestMapping(value="/updatePublishStatus",method= RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updatePublishStatus(Long id){
        ReleaseVehicleInformation releaseVehicleInformationById = releaseVehicleInformationService.find(id);
        Integer publishStatus = releaseVehicleInformationById.getPublishStatus();
        if (publishStatus.equals(ReleaseVehicleInformation.NOTPUBLISH)){
            releaseVehicleInformationById.setPublishStatus(ReleaseVehicleInformation.PUBLISH);
        }
        if (publishStatus.equals(ReleaseVehicleInformation.PUBLISH)){
            releaseVehicleInformationById.setPublishStatus(ReleaseVehicleInformation.NOTPUBLISH);
        }
        //到这说明一切符合条件，进行数据库新增
        if(releaseVehicleInformationService.sava(releaseVehicleInformationById) == null){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_EDIT1_ERROR);
        }

        operaterLogService.add("编辑租车发布信息发布状态，租车发布信息ID：" + id);
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
        ReleaseVehicleInformation byId = releaseVehicleInformationService.find(id);
        if (byId.getPublishStatus().equals(ReleaseVehicleInformation.PUBLISH)){
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_DELETE1_ERROR);
        }
        try {
            releaseVehicleInformationService.delete(id);
        } catch (Exception e) {
            return Result.error(CodeMsg.ADMIN_RELEASEVEHICLEINFORMATION_DELETE_ERROR);
        }
        operaterLogService.add("删除租车发布信息，租车发布信息ID：" + id);
        return Result.success(true);
    }

}
