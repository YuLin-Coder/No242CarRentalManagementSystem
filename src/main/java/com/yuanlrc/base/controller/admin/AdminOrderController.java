package com.yuanlrc.base.controller.admin;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.entity.admin.ReleaseVehicleInformation;
import com.yuanlrc.base.entity.home.Order;
import com.yuanlrc.base.service.admin.OperaterLogService;
import com.yuanlrc.base.service.home.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@RequestMapping("/admin/adminOrder")
public class AdminOrderController {

    @Autowired
    private OperaterLogService operaterLogService;

    @Autowired
    private OrderService orderService;

    @RequestMapping("/userList")
    public String allByUserIdandDeskUserPhone(Model model, Order order, PageBean<Order> pageBean, String phone, String outTradeNo) {
        model.addAttribute("title", "订单列表");
        model.addAttribute("phone", phone);
        model.addAttribute("outTradeNo", outTradeNo);
        model.addAttribute("pageBean", orderService.findListByUserIdandDeskUserPhone(order, pageBean, phone, outTradeNo));
        return "admin/admin_order/list";
    }

    @RequestMapping("/findAllList")
    public String findAllList(Model model, Order order, PageBean<Order> pageBean, String outTradeNo, String shopName) {
        model.addAttribute("title", "订单列表");
        model.addAttribute("outTradeNo", outTradeNo);
        model.addAttribute("shopName", shopName);
        model.addAttribute("pageBean", orderService.findAllList(order, pageBean, outTradeNo, shopName));
        return "admin/admin_order/admin_list";
    }

    @RequestMapping(value = "/updateOrderType", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateOrderType(Long id) {
        Order order = orderService.find(id);
        order.setRealityReturnTime(new Date());
        order.setType(3);
        //到这说明一切符合条件，进行数据库新增
        if (orderService.save(order) == null) {
            return Result.error(CodeMsg.ADMIN_ORDER_EDIT1_ERROR);
        }

        operaterLogService.add("编辑订单还车，订单ID：" + id);
        return Result.success(true);
    }

    @RequestMapping(value = "/updateOrder", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateOrder(Long id) {
        Order order = orderService.find(id);
        order.setType(2);
        order.setRealityCollectionTime(new Date());
        //到这说明一切符合条件，进行数据库新增
        if (orderService.save(order) == null) {
            return Result.error(CodeMsg.ADMIN_ORDER_EDIT2_ERROR);
        }

        operaterLogService.add("编辑订单出车，订单ID：" + id);
        return Result.success(true);
    }


}
