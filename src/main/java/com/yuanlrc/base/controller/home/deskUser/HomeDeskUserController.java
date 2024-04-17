package com.yuanlrc.base.controller.home.deskUser;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.constant.SessionConstant;
import com.yuanlrc.base.entity.common.RoleStatus;
import com.yuanlrc.base.entity.home.DeskUser;
import com.yuanlrc.base.entity.home.InquirySheet;
import com.yuanlrc.base.service.home.*;
import com.yuanlrc.base.util.SessionUtil;
import com.yuanlrc.base.util.ValidateEntityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/home/index")
public class HomeDeskUserController {
    @Autowired
    private DeskUserService deskUserService;
    @Autowired
    private DeskPersonalInfoService deskPersonalInfoService;
    @Autowired
    private DrivingModelService drivingModelService;
    @Autowired
    private InquirySheetService inquirySheetService;
    @Autowired
    private EnterpriseInfoService enterpriseInfoService;

    /**
     * 个人注册
     * @param deskUser
     * @param code
     * @return
     */
    @RequestMapping(value = "/duregister",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> register(DeskUser deskUser, @RequestParam("code") String code){
        CodeMsg codeMsg = ValidateEntityUtil.validate(deskUser);
        if(codeMsg.getCode() != CodeMsg.SUCCESS.getCode())
        {
            return Result.error(codeMsg);
        }
        //正则验证输入的手机号是否合法
        String checkPhone = "^1[3|4|5|7|8]\\d{9}$";
        Pattern r = Pattern.compile(checkPhone);
        Matcher m = r.matcher(deskUser.getPhone());
        if (!m.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        //正则验证输入的邮箱是否合法
        String checkEmail = "^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";
        Pattern pr = Pattern.compile(checkEmail);
        Matcher mt = pr.matcher(deskUser.getDemail());
        if (!mt.matches()){
            return Result.error(CodeMsg.HOME_DESK_USER_EMAIL_ERROR);
        }
        if (code==null) {
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR);
        }
        if (code.length()!=4){
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR_2);
        }
        Object attr = SessionUtil.get(SessionConstant.DESK_USER_LOGIN_CODE);
        if (attr==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (!code.equalsIgnoreCase(attr.toString())){
            return Result.error(CodeMsg.CPACHA_ERROR);
        }
        //判断手机号是否已注册
        if (deskUserService.findByPhone(deskUser.getPhone())!=null){
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR);
        }
        //判断邮箱是否已认证
        if (deskUserService.findByDemail(deskUser.getDemail())!=null){
            return Result.error(CodeMsg.HOME_DESK_USER_EMAIL_ERROR_2);
        }
        //判断注册的用户是什么身份
        if (deskUser.getType()==1){
            deskUser.setStatus(RoleStatus.STATUS_ACTIVE);//如果身份是个人,则注册账号默认可用
            if (!deskUserService.saveDu(deskUser).getData()){
                return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
            }
        }else {
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_TYPE_ERROR);
        }
        SessionUtil.set(SessionConstant.DESK_USER_LOGIN_CODE,null);
        return Result.success(true);
    }
    /**
     * 企业注册
     * @param deskUser
     * @param code
     * @return
     */
    @RequestMapping(value = "/enregister",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> enRegister(DeskUser deskUser,
                                      @RequestParam("code") String code,
                                      @RequestParam("enterpriseNo") String enterpriseNo,
                                      @RequestParam("enterpriseName") String enterpriseName,
                                      @RequestParam("enPic") String enPic){
        CodeMsg codeMsg = ValidateEntityUtil.validate(deskUser);
        if(codeMsg.getCode() != CodeMsg.SUCCESS.getCode())
        {
            return Result.error(codeMsg);
        }
        //正则验证输入的手机号是否合法
        String checkPhone = "^1[3|4|5|7|8]\\d{9}$";
        Pattern r = Pattern.compile(checkPhone);
        Matcher m = r.matcher(deskUser.getPhone());
        if (!m.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        //正则验证输入的邮箱是否合法
        String checkEmail = "^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";
        Pattern pr = Pattern.compile(checkEmail);
        Matcher mt = pr.matcher(deskUser.getDemail());
        if (!mt.matches()){
            return Result.error(CodeMsg.HOME_DESK_USER_EMAIL_ERROR);
        }
        if (enterpriseNo==null||enterpriseNo==""){
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ENNO_ERROR);
        }
        //正则验证输入的企业账号
        String checkEnterpriseNo = "\\d{15}";
        Pattern ce = Pattern.compile(checkEnterpriseNo);
        Matcher me = ce.matcher(enterpriseNo);
        if (!me.matches()){
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ENNO_ERROR_2);
        }
        if (enPic==null||enPic==""){
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ENPIC_ERROR);
        }
        if (code==null) {
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR);
        }
        if (code.length()!=4){
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR_2);
        }
        Object attr = SessionUtil.get(SessionConstant.DESK_USER_LOGIN_CODE);
        if (attr==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (!code.equalsIgnoreCase(attr.toString())){
            return Result.error(CodeMsg.CPACHA_ERROR);
        }
        //判断企业名
        if (enterpriseName==null||enterpriseName==""){
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ENNAME_ERROR);
        }
        //判断企业名是否重复
        if (enterpriseInfoService.findByEnterpriseName(enterpriseName)!=null){
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ENNAME_ERROR_2);
        }
        //判断手机号是否已注册
        if (deskUserService.findByPhone(deskUser.getPhone())!=null){
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR);
        }
        //判断邮箱是否已认证
        if (deskUserService.findByDemail(deskUser.getDemail())!=null){
            return Result.error(CodeMsg.HOME_DESK_USER_EMAIL_ERROR_2);
        }
        //判断注册的用户是什么身份
        if (deskUser.getType()==0){//身份是企业,默认不可用
            deskUser.setStatus(RoleStatus.STATUS_FORBIDDEN);
            if (!deskUserService.saveEn(deskUser,enterpriseNo,enPic,enterpriseName).getData()){
                return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
            }
        }else {
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_TYPE_ERROR);
        }
        SessionUtil.set(SessionConstant.DESK_USER_LOGIN_CODE,null);
        return Result.success(true);
    }
    /**
     * 登录
     */
    @RequestMapping(value = "/dulogin",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> login(String phone,String password,String code){
        if (phone==null){
            return Result.error(CodeMsg.HOME_DESK_USER_LOGIN_PHONE);
        }
        if (password==null){
            return Result.error(CodeMsg.HOME_DESK_USER_LOGIN_PASSWORD);
        }
        if (code==null) {
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR);
        }
        //正则验证输入的手机号是否合法
        String checkPhone = "^1[3|4|5|7|8]\\d{9}$";
        Pattern r = Pattern.compile(checkPhone);
        Matcher m = r.matcher(phone);
        if (!m.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        if (code.length()!=4){
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR_2);
        }
        Object attr = SessionUtil.get(SessionConstant.DESK_USER_LOGIN_CODE);
        if (attr==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (!code.equalsIgnoreCase(attr.toString())){
            return Result.error(CodeMsg.CPACHA_ERROR);
        }
        DeskUser deskUser = deskUserService.findByPhone(phone);
        if (deskUser==null){
            return Result.error(CodeMsg.HOME_DESK_USER_LOGIN_PHONE_2);
        }
        if (!deskUser.getPassword().equals(password)){
            return Result.error(CodeMsg.HOME_DESK_USER_LOGIN_FAIL);
        }
//        //判断此用户是否为会员
//        if (deskUser.getType()!=1){
//            return Result.error(CodeMsg.HOME_DESK_USER_LOGIN_FAIL_2);
//        }
        //判断用户状态是否可用
        if (deskUser.getStatus()!=1){
            return Result.error(CodeMsg.ADMIN_USER_UNABLE);
        }
        SessionUtil.set(SessionConstant.DESK_USER_LOGIN_KEY,deskUser);
        SessionUtil.set(SessionConstant.DESK_USER_LOGIN_CODE,null);
        return Result.success(true);
    }
    /**
     * 修改密码
     */
    @RequestMapping("/update_password")
    @ResponseBody
    public Result<Boolean> updatePwd(@RequestParam("pwd") String pwd,
                                     @RequestParam("newPwd") String newPwd,
                                     @RequestParam("reNewPwd") String reNewPwd){
        if (pwd==null||pwd.equals("")){
            return Result.error(CodeMsg.DESK_USER_UPDATE_OLDPWD_ERROR);
        }
        if (newPwd==null||newPwd.equals("")){
            return Result.error(CodeMsg.DESK_USER_UPDATE_NEWPWD_ERROR);
        }
        if (reNewPwd==null||reNewPwd.equals("")){
            return Result.error(CodeMsg.DESK_USER_UPDATE_RENEWPWD_ERROR);
        }
        if (newPwd.length()<4||newPwd.length()>16){
            return Result.error(CodeMsg.DESK_USER_UPDATE_RENEWPWD_ERROR_2);
        }
        if (reNewPwd.length()<4||reNewPwd.length()>16){
            return Result.error(CodeMsg.DESK_USER_UPDATE_RENEWPWD_ERROR_2);
        }
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        //判断输入的原密码是否正确
        if (!loginedDeskUser.getPassword().equals(pwd)){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PWD_ERROR);
        }
        //判断两次输入的新密码是否一致
        if (!newPwd.equals(reNewPwd)){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PWD_INCONFORMITY);
        }
        loginedDeskUser.setPassword(newPwd);
        if (deskUserService.save(loginedDeskUser)==null){
            return Result.error(CodeMsg.DESK_USER_UPDATE_PWD_FAIL);
        }
        SessionUtil.set(SessionConstant.DESK_USER_LOGIN_KEY,loginedDeskUser);
        return Result.success(true);
    }
    /**
     * 忘记密码
     */
    @RequestMapping(value = "/forgetPwd",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> forgetPwd(DeskUser deskUser,@RequestParam("ver_password") String rePassword){
        CodeMsg codeMsg = ValidateEntityUtil.validate(deskUser.getPhone());
        if(codeMsg.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg);
        }
        CodeMsg codeMsg1 = ValidateEntityUtil.validate(deskUser.getDemail());
        if(codeMsg1.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg1);
        }
        if (rePassword==null){
            return Result.error(CodeMsg.DESK_USER_UPDATE_RENEWPWD_ERROR);
        }
        //正则验证输入的手机号是否合法
        String checkPhone = "^1[3|4|5|7|8]\\d{9}$";
        Pattern r = Pattern.compile(checkPhone);
        Matcher m = r.matcher(deskUser.getPhone());
        if (!m.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        //正则验证输入的邮箱是否合法
        String checkEmail = "^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";
        Pattern pr = Pattern.compile(checkEmail);
        Matcher mt = pr.matcher(deskUser.getDemail());
        if (!mt.matches()){
            return Result.error(CodeMsg.HOME_DESK_USER_EMAIL_ERROR);
        }
        DeskUser byPhone = deskUserService.findByPhone(deskUser.getPhone());
        if (byPhone==null){
            return Result.error(CodeMsg.HOME_DESK_USER_LOGIN_PHONE_2);
        }
        DeskUser byDemail = deskUserService.findByDemail(deskUser.getDemail());
        if (byDemail==null){
            return Result.error(CodeMsg.HOME_DESK_USER_LOGIN_EMAIL_ERROR);
        }
        //到这里就符合要求,进行修改密码
        byPhone.setPassword(rePassword);
        if (deskUserService.save(byPhone)==null){
            return Result.error(CodeMsg.HOME_DESK_USER_FORGETPWD_FAIL);
        }
        return Result.success(true);
    }
    /**
     * 退出登录
     */
    @GetMapping(value = "/dulogout")
    public String logout(){
        if (SessionUtil.getLoginedDeskUser()!=null){
            SessionUtil.set(SessionConstant.DESK_USER_LOGIN_KEY,null);
        }
        return "redirect:index";
    }

    /**
     * 询价
     */
    @RequestMapping(value = "/inquiryAdd",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> inquiryAdd(InquirySheet inquirySheet,@RequestParam("code") String code){
        //同一方式验证
        CodeMsg codeMsg = ValidateEntityUtil.validate(inquirySheet);
        if(codeMsg.getCode() != CodeMsg.SUCCESS.getCode()) {
            return Result.error(codeMsg);
        }
        //正则验证输入的手机号是否合法
        String checkPhone = "^1[3|4|5|7|8]\\d{9}$";
        Pattern r = Pattern.compile(checkPhone);
        Matcher m = r.matcher(inquirySheet.getPhone());
        if (!m.matches()) {
            return Result.error(CodeMsg.HOME_DESK_USER_PHONE_ERROR);
        }
        //正则验证输入的邮箱是否合法
        String checkEmail = "^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";
        Pattern pr = Pattern.compile(checkEmail);
        Matcher mt = pr.matcher(inquirySheet.getEmail());
        if (!mt.matches()){
            return Result.error(CodeMsg.HOME_DESK_USER_EMAIL_ERROR);
        }
        //验证码验证
        if (code==null) {
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR);
        }
        if (code.length()!=4){
            return Result.error(CodeMsg.HOME_DESK_USER_CODE_ERROR_2);
        }
        Object attr = SessionUtil.get(SessionConstant.DESK_USER_LOGIN_CODE);
        if (attr==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        if (!code.equalsIgnoreCase(attr.toString())){
            return Result.error(CodeMsg.CPACHA_ERROR);
        }
        //符合要求 进行新增
        if (inquirySheetService.save(inquirySheet)==null){
            return Result.error(CodeMsg.INQUIRY_ADD_FAIL);
        }
        return Result.success(true);
    }
}
