package com.yuanlrc.base.controller.admin;


import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.home.DeskUser;
import com.yuanlrc.base.entity.home.EnterpriseInfo;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.home.DeskUserService;
import com.yuanlrc.base.service.home.EnterpriseInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 前台用户企业管理
 */
@Controller
@RequestMapping("/admin/deskUserEn")
public class DeskUserEnController {
    @Autowired
    private DeskUserService deskUserService;
    @Autowired
    private EnterpriseInfoService enterpriseInfoService;
    @Autowired
    private OperaterLogService operaterLogService;
    @RequestMapping("/list")
    public String list(Model model, EnterpriseInfo enterpriseInfo, PageBean<EnterpriseInfo> pageBean){
        model.addAttribute("title", "前台用户-企业列表");
        model.addAttribute("enterpriseName",enterpriseInfo.getEnterpriseName());
        model.addAttribute("pageBean",enterpriseInfoService.findList(enterpriseInfo,pageBean));
        return "admin/deskUserEn/list";
    }
    @RequestMapping(value = "/edit",method = RequestMethod.GET)
    public String edit(Model model,@RequestParam("id") Long id){
        model.addAttribute("deskUserEn",enterpriseInfoService.find(id));
        return "admin/deskUserEn/edit";
    }
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> edit(Long id,Integer status){
        EnterpriseInfo enterpriseInfo = enterpriseInfoService.find(id);
        if(enterpriseInfo==null){
            return Result.error(CodeMsg.ADMIN_DESKUSEREN_EDIT_ERROR);
        }
        if (enterpriseInfo.getId()==null||enterpriseInfo.getId()==0){
            return Result.error(CodeMsg.ADMIN_DESKUSEREN_EDIT_ERROR);
        }
        DeskUser deskUser = deskUserService.find(enterpriseInfo.getDeskUser().getId());
        if (deskUser==null){
            return Result.error(CodeMsg.ADMIN_DESKUSEREN_EDIT_ERROR_2);

        }
        deskUser.setStatus(status);
        if (deskUserService.save(deskUser)==null){
            return Result.error(CodeMsg.ADMIN_DESKUSEREN_EDIT_ERROR);
        }
        operaterLogService.add("编辑企业信息,企业名:"+enterpriseInfo.getEnterpriseName());
        return Result.success(true);
    }
}
