package com.yuanlrc.base.controller.home.deskUser;




import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.constant.SessionConstant;
import com.yuanlrc.base.entity.home.*;
import com.yuanlrc.base.service.home.*;
import com.yuanlrc.base.util.SessionUtil;
import com.yuanlrc.base.util.ValidateEntityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.yuanlrc.base.constant.SessionConstant.DESK_USER_LOGIN_KEY;

@Controller
@RequestMapping("/home/index")
public class HomeDeskUserInfoController {
    @Autowired
    private DeskPersonalInfoService personalInfoService;
    @Autowired
    private DrivingModelService drivingModelService;
    @Autowired
    private DeskUserDriverInfoService deskUserDriverInfoService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private EnterpriseInfoService enterpriseInfoService;
    @Autowired
    private DeskUserService deskUserService;

    /**
     * 完善个人证件信息
     * @param name
     * @param idNumber
     * @return
     */
    @RequestMapping(value = "/updateInfo",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateInfo(@RequestParam("idCardName") String name,
                                      @RequestParam("idNumber") String idNumber){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        DeskPersonalInfo deskPersonalInfo = personalInfoService.findByDeskUserId(loginedDeskUser.getId());
        deskPersonalInfo.setIdCardName(name);
        deskPersonalInfo.setIdNumber(idNumber);
        CodeMsg codeMsg = ValidateEntityUtil.validate(deskPersonalInfo.getIdCardName());
        if(codeMsg.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg);
        }
        CodeMsg codeMsg1 = ValidateEntityUtil.validate(deskPersonalInfo.getIdNumber());
        if(codeMsg1.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg1);
        }
        //身份证号验证
        String checkIdCard = "^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X)$";
        Pattern pattern = Pattern.compile(checkIdCard);
        Matcher m2 = pattern.matcher(deskPersonalInfo.getIdNumber());
        if(!m2.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_IDCARD_ERROR);
        }
        //判断身份证号是否重复
        if (personalInfoService.findByIdNumber(deskPersonalInfo.getIdNumber())!=null){
            if (personalInfoService.findByIdNumber(deskPersonalInfo.getIdNumber()).getId()==deskPersonalInfo.getId()){
                return Result.error(CodeMsg.HOME_DESK_USER_IDCARD_ERROR_2);
            }
        }
        if(personalInfoService.save(deskPersonalInfo)==null){
            return Result.error(CodeMsg.HOME_ADD_DESK_USER_INFO_FAIL);
        }
        return Result.success(true);
    }


    /**
     * 修改紧急联系人信息
     * @param ecName
     * @param ecPhone
     * @param ecAddress
     * @return
     */
    @RequestMapping(value = "/updateEcInfo",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateEcInfo(@RequestParam("ecName") String ecName,
                                        @RequestParam("ecPhone") String ecPhone,
                                        @RequestParam("ecAddress") String ecAddress){
        DeskUser deskUser = SessionUtil.getLoginedDeskUser();
        if (deskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        DeskPersonalInfo byDeskUserId = personalInfoService.findByDeskUserId(deskUser.getId());
        byDeskUserId.setEcName(ecName);
        byDeskUserId.setEccPhone(ecPhone);
        byDeskUserId.setEccAddress(ecAddress);
        //验证添加的 紧急联系人信息是否正确
        CodeMsg codeMsg = ValidateEntityUtil.validate(byDeskUserId.getEcName());
        if(codeMsg.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg);
        }
        CodeMsg codeMsg1 = ValidateEntityUtil.validate(byDeskUserId.getEccPhone());
        if(codeMsg1.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg1);
        }
        CodeMsg codeMsg2 = ValidateEntityUtil.validate(byDeskUserId.getEccAddress());
        if(codeMsg2.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg1);
        }
        //正则验证输入的手机号是否合法
        String checkPhone = "^1[3|4|5|7|8]\\d{9}$";
        Pattern r = Pattern.compile(checkPhone);
        Matcher m = r.matcher(byDeskUserId.getEccPhone());
        if (!m.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        //判断紧急联系人手机号是否与自身手机号重复
        if (byDeskUserId.getEccPhone().equals(deskUser.getPhone())){
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR_3);
        }
        //判断紧急联系人手机号是否重复
        if (personalInfoService.findByEccPhone(byDeskUserId.getEccPhone())!=null){
            if (personalInfoService.findByEccPhone(byDeskUserId.getEccPhone()).getId()!=byDeskUserId.getId()){
                return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR_3);
            }
        }
        //符合要求,进行修改信息
        if (personalInfoService.save(byDeskUserId)==null){
            return Result.error(CodeMsg.HOME_ADD_DESK_USER_ECINFO_FAIL);
        }
        return Result.success(true);
    }

    /**
     * 完善个人驾驶证信息
     * @param driverNumber
     * @param carModel
     * @param start
     * @param end
     * @return
     * @throws ParseException
     */
    @RequestMapping(value = "/update_dInfo",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateDInfo(@RequestParam("driverNumber") String driverNumber,
                                       @RequestParam("carModel") String carModel,
                                       @RequestParam("start") String start,
                                       @RequestParam("end") String end) throws ParseException {
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Date startTime = null;
        Date endTime = null;
        if (driverNumber==null){
            return Result.error(CodeMsg.DESK_USER_DINFO_DNUMBER_ERROR);
        }
        if (carModel==null){
            return Result.error(CodeMsg.DESK_USER_DINFO_DMODEL_ERROR);
        }
        if (start==null){
            return Result.error(CodeMsg.DESK_USER_DINFO_DATE_ERROR);
        }
        if (end==null){
            return Result.error(CodeMsg.DESK_USER_DINFO_DATE_ERROR);
        }
        startTime = sf.parse(start);
        endTime = sf.parse(end);
        if (startTime.after(endTime)){
            return Result.error(CodeMsg.DESK_USER_DINFO_DATE_ERROR_2);
        }
        DrivingModel drivingModel = drivingModelService.find(Long.parseLong(carModel));
        if (drivingModel==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        DeskUserDriverInfo deskUserDriverInfo = deskUserDriverInfoService.find(loginedDeskUser.getDeskUserDriverInfo().getId());
        deskUserDriverInfo.setDriverNumber(driverNumber);
        deskUserDriverInfo.setDrivingModel(drivingModel);
        deskUserDriverInfo.setStart(startTime);
        deskUserDriverInfo.setEnd(endTime);
        //进行修改
        if (deskUserDriverInfoService.save(deskUserDriverInfo)==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        loginedDeskUser.setDeskUserDriverInfo(deskUserDriverInfo);
        return Result.success(true);
    }

    /*
     * 修改手机号
     */
    @RequestMapping(value = "/updPhone",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updPhone(@RequestParam("phone") String phone,
                                    @RequestParam("password") String password,
                                    @RequestParam("newPhone") String newPhone){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (phone==null){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PHONE_NULL);
        }
        //正则验证输入的手机号是否合法
        String checkPhone = "^1[3|4|5|7|8]\\d{9}$";
        Pattern r = Pattern.compile(checkPhone);
        Matcher m = r.matcher(phone);
        if (!m.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        if (newPhone==null){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PHONE_NULL);
        }
        if (!r.matcher(newPhone).matches()){
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        if (password==null){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PASSWORD_NULL);
        }
        //判断新手机号是否已注册
        DeskUser byNewPhone = deskUserService.findByPhone(newPhone);
        if (byNewPhone!=null){
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR_3);
        }
        DeskUser byPhone = deskUserService.findByPhone(phone);
        if(byPhone==null){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PHONE_FAIL);
        }
        if (byPhone.getId()!=loginedDeskUser.getId()){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PHONE_FAIL);
        }
        //密码不同不可修改
        if (!byPhone.getPassword().equals(password)){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PASSWORD_ERROR);
        }
        //账号注册30天内不可修改
        long betweenDays = (long)((new Date().getTime() - byPhone.getCreateTime().getTime()) / (1000 * 60 * 60 *24) + 0.5);
        if (betweenDays<30){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PHONE_ERROR_2);
        }
        byPhone.setPhone(newPhone);
        if (deskUserService.save(byPhone)==null){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PHONE_FAIL);
        }
        return Result.success(true);
    }
    /**
     * 个人修改头像
     * @param headPic
     * @return
     */
    @RequestMapping(value = "/update_headPic",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateHeadPic(String headPic){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (headPic.trim().length()==0){
            return Result.error(CodeMsg.UPLOAD_PHOTO_ERROR);
        }
        DeskPersonalInfo byDeskUserId = personalInfoService.findByDeskUserId(loginedDeskUser.getId());
        byDeskUserId.setHeadPic(headPic);
        if (personalInfoService.save(byDeskUserId)==null){
            return Result.error(CodeMsg.UPLOAD_PHOTO_ERROR);
        }
        return Result.success(true);
    }
    /**
     * 企业修改营业执照
     * @param enPic
     * @return
     */
    @RequestMapping(value = "/update_enPic",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateEnPic(String enPic){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (enPic.trim().length()==0){
            return Result.error(CodeMsg.UPLOAD_PHOTO_ERROR);
        }
        EnterpriseInfo byDeskUserId = enterpriseInfoService.findByDeskUserId(loginedDeskUser.getId());

        byDeskUserId.setEnterprisePic(enPic);
        if (enterpriseInfoService.save(byDeskUserId)==null){
            return Result.error(CodeMsg.UPLOAD_PHOTO_ERROR);
        }
        return Result.success(true);
    }
    /**
     * 普通用户 用户信息
     */
    @RequestMapping(value = "/info")
    public String deskUserPersonal(Model model){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return "redirect:index";
        }
        if (loginedDeskUser.getType()==1){
            model.addAttribute("deskUserInfo",personalInfoService.findByDeskUserId(loginedDeskUser.getId()));
            model.addAttribute("all",drivingModelService.findAll());
            model.addAttribute("deskUser",loginedDeskUser);
            return "home/deskUser/personal";
        }else if (loginedDeskUser.getType()==0){
            model.addAttribute("deskUserEnInfo",enterpriseInfoService.findByDeskUserId(loginedDeskUser.getId()));
            model.addAttribute("all",drivingModelService.findAll());
            model.addAttribute("deskUser",loginedDeskUser);
            return "home/deskUser/enpersonal";
        }else {
            SessionUtil.set(DESK_USER_LOGIN_KEY,null);
            return "redirect:index";
        }
    }
    /**
     * 普通用户 订单管理
     */
    @RequestMapping(value = "/myOrders")
    public String deskUserOrders(Model model,Integer type, PageBean<Order> pageBean){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return "redirect:index";
        }
        Order order = new Order();
        order.setDeskUser(loginedDeskUser);
        order.setType(type);
        model.addAttribute("pageBean",orderService.findList(pageBean));
        model.addAttribute("deskUserInfo",personalInfoService.findByDeskUserId(loginedDeskUser.getId()));
        model.addAttribute("deskUserEnInfo",enterpriseInfoService.findByDeskUserId(loginedDeskUser.getId()));
        model.addAttribute("all",drivingModelService.findAll());
        if (type == null){
            type = 5;//查询全部
        }
        model.addAttribute("type",type);
        model.addAttribute("deskUser",loginedDeskUser);
        return "home/deskUser/myOrders";
    }
    /**
     * 取消订单
     */
    @RequestMapping(value = "/cancelOrder",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> deskUserOrders(@RequestParam("id") Long id){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (id==null||id==0){
            return Result.error(CodeMsg.ORDER_CANCEL_FAIL);
        }
        Order order = orderService.find(id);
        if (order.getType()!=1){
            return Result.error(CodeMsg.ORDER_CANCEL_ERROR);
        }
        order.setType(Order.CANCELED);//设置为已取消
        if (orderService.save(order)==null){
            return Result.error(CodeMsg.ORDER_CANCEL_FAIL);
        }
        return Result.success(true);
    }
    /**
     * 分类查询订单
     */
    @RequestMapping(value = "/findOrder")
    public String findOrderByType(Model model, Integer type, PageBean<Order> pageBean){
        DeskUser deskUser = SessionUtil.getLoginedDeskUser();
        if (deskUser==null){
            return "redirect:index";
        }
        Order order = new Order();
        //通过订单类型查询所有订单信息
        order.setDeskUser(deskUser);
        order.setType(type);
        model.addAttribute("pageBean",orderService.findListByDidAndType(order,pageBean));
        model.addAttribute("deskUserInfo",personalInfoService.findByDeskUserId(deskUser.getId()));
        model.addAttribute("all",drivingModelService.findAll());
        model.addAttribute("type",type);
        model.addAttribute("deskUser",deskUser);
        return "home/deskUser/myOrders";
    }
}
