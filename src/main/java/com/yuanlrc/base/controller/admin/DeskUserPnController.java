package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.home.DeskPersonalInfo;
import com.yuanlrc.base.entity.home.DeskUser;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.home.DeskPersonalInfoService;
import com.yuanlrc.base.service.home.DeskUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 前台用户个人管理
 */
@Controller
@RequestMapping("/admin/deskUserPn")
public class DeskUserPnController {
    @Autowired
    private DeskUserService deskUserService;
    @Autowired
    private DeskPersonalInfoService deskPersonalInfoService;
    @Autowired
    private OperaterLogService operaterLogService;

    @RequestMapping("/list")
    public String list(Model model, DeskPersonalInfo deskPersonalInfo, PageBean<DeskPersonalInfo> pageBean){
        model.addAttribute("title","前台用户-个人列表");
        model.addAttribute("idCardName",deskPersonalInfo.getIdCardName()==null?"":deskPersonalInfo.getIdCardName());
        model.addAttribute("pageBean",deskPersonalInfoService.findList(deskPersonalInfo,pageBean));
        return "admin/deskUserPn/list";
    }
    @RequestMapping(value = "edit",method = RequestMethod.GET)
    public String edit(Model model,@RequestParam("id") Long id){
        model.addAttribute("deskUserPn",deskPersonalInfoService.find(id));
        return "admin/deskUserPn/edit";
    }
    @RequestMapping(value = "edit",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> edit(Long id,Integer status){
        DeskPersonalInfo deskPersonalInfo = deskPersonalInfoService.find(id);
        if (deskPersonalInfo==null){
            return Result.error(CodeMsg.ADMIN_DESKUSERPN_EDIT_ERROR);
        }
        if (deskPersonalInfo.getId()==null||deskPersonalInfo.getId()==0){
            return Result.error(CodeMsg.ADMIN_DESKUSERPN_EDIT_ERROR);
        }
        if (deskPersonalInfo.getDeskUser().getId()==null||deskPersonalInfo.getDeskUser().getId()==0){
            return Result.error(CodeMsg.ADMIN_DESKUSERPN_EDIT_ERROR);
        }
        DeskUser deskUser = deskUserService.find(deskPersonalInfo.getDeskUser().getId());
        if (deskUser==null){
            return Result.error(CodeMsg.ADMIN_DESKUSERPN_EDIT_ERROR_2);
        }
        deskUser.setStatus(status);
        if (deskUserService.save(deskUser)==null){
            return Result.error(CodeMsg.ADMIN_DESKUSERPN_EDIT_ERROR);
        }
        operaterLogService.add("编辑个人信息,个人用户名:"+deskPersonalInfo.getIdCardName());
        return Result.success(true);
    }
}
