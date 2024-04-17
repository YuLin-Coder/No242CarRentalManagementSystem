package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.entity.home.InquirySheet;
import com.yuanlrc.base.service.home.InquirySheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/admin/inquirySheet")
@Controller
public class InquirySheetController {
    @Autowired
    private InquirySheetService inquirySheetService;
    @RequestMapping(value="/list")
    public String list(Model model, InquirySheet inquirySheet, PageBean<InquirySheet> pageBean){
        model.addAttribute("title", "询价单列表");
        model.addAttribute("boardingLocation",inquirySheet==null?"":inquirySheet.getBoardingLocation());
        model.addAttribute("pageBean", inquirySheetService.findList(inquirySheet,pageBean));
        return "admin/inquirySheet/list";
    }
}
