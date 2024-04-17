package com.yuanlrc.base.controller.home;


import com.alibaba.fastjson.JSONObject;
import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.constant.SessionConstant;
import com.yuanlrc.base.entity.home.DeskPersonalInfo;
import com.yuanlrc.base.entity.home.DeskUser;
import com.yuanlrc.base.service.admin.*;
import com.yuanlrc.base.service.home.*;

import com.yuanlrc.base.util.SessionUtil;
import com.yuanlrc.base.entity.admin.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/home/index")
public class HomeController {

    //企业服务
    @Autowired
    private AutomobileBrandService automobileBrandService;
    @Autowired
    private AutomobileInformationService mobileInformationService;
    @Autowired
    private DeskPersonalInfoService service;
    @Autowired
    private ReleaseVehicleInformationService releaseVehicleInformationService;
    @Autowired
    private UserService userService;
    @Autowired
    private OtherServicesIemsService otherServicesIemsService;
    @Autowired
    private DeskPersonalInfoService personalInfoService;
    @Autowired
    private CarStoreService carStoreService;
    @Autowired
    private EnterpriseInfoService enterpriseInfoService;


    @RequestMapping("/enterpriseService")
    public String enterpriseService(Model model){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser!=null){
            model.addAttribute("deskUserInfo",personalInfoService.findByDeskUserId(loginedDeskUser.getId()));
            model.addAttribute("deskUser",loginedDeskUser);
            model.addAttribute("deskUserEnInfo",enterpriseInfoService.findByDeskUserId(loginedDeskUser.getId()));

        }
        model.addAttribute("mobileInformation",mobileInformationService.findByCreateTime());
        return "home/home/enterprise_service";
    }
    //企业注册
    @RequestMapping("/enterpriseRegister")
    public String enterpriseRegister(){
        return "home/enterprise/enterpriseRegister";
    }




    /**
     * 跳转到预订页面
     * @return
     */
    @GetMapping("/advanceOrder")
    public String advanceOrder(String releInfoId,String lease,String getStore,String retStore,String pickUpStr, String reDateStr,Model model){

        DeskUser deskUser = SessionUtil.getLoginedDeskUser();
        if (deskUser == null){
            return "redirect:/home/index/index";
        }
        ReleaseVehicleInformation releaseInfo = releaseVehicleInformationService.find(Long.valueOf(releInfoId));
        User getUser = userService.find(Long.valueOf(getStore));
        User retUser = userService.find(Long.valueOf(retStore));
        List<OtherServicesIems> otherServicesIems = otherServicesIemsService.findByReleaseVehicleInformationsID(Long.valueOf(releInfoId));
        model.addAttribute("deskUser",deskUser);
        model.addAttribute("otherServicesIems",otherServicesIems);
        model.addAttribute("releaseInfo",releaseInfo);//发布信息
        model.addAttribute("getUser",getUser);//取车门店
        model.addAttribute("retUser",retUser);//还车门店
        model.addAttribute("pickUpStr",pickUpStr);//取车时间
        model.addAttribute("reDateStr",reDateStr);//还车时间
        model.addAttribute("lease",lease);//租期
        return "/home/home/advance_order";
    }

//    //自驾租车
//    @RequestMapping("/independentCarRental")
//    public String independentCarRental(Model model){
//        List<ReleaseVehicleInformation> releaseVehicleInformationList = releaseVehicleInformationService.findAllBypublishStatus(1);
//        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
//        if (loginedDeskUser != null) {
//            model.addAttribute("deskUser", loginedDeskUser);
//            model.addAttribute("deskUserInfo",service.findByDeskUserId(loginedDeskUser.getId()));
//            model.addAttribute("deskUserEnInfo",enterpriseInfoService.findByDeskUserId(loginedDeskUser.getId()));
//        }
//        model.addAttribute("releaseVehicleInformationList",releaseVehicleInformationList);
//        model.addAttribute("automobileTypeEnums",AutomobileTypeEnum.values());
//        model.addAttribute("mobileStallsEnums", AutomobileStallsEnum.values());
//        model.addAttribute("mobileSeatEnums", AutomobileSeatEnum.values());
//        model.addAttribute("mobileBrands",automobileBrandService.findAll());
//        return "home/home/independent_car_rental";
//    }

    //自驾租车
    @RequestMapping("/index")
    public String index(Model model,@RequestParam(value = "id",required = false)Long id,
                        @RequestParam(value = "retUserId",required = false)Long retUserId){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser != null) {
            model.addAttribute("deskUser", loginedDeskUser);
            model.addAttribute("deskUserInfo",service.findByDeskUserId(loginedDeskUser.getId()));
            model.addAttribute("deskUserEnInfo",enterpriseInfoService.findByDeskUserId(loginedDeskUser.getId()));
        }
        User user = userService.findFirstByType();
        List<ReleaseVehicleInformation> releaseVehicleInformationList = releaseVehicleInformationService.findByUserId(user.getId());
        model.addAttribute("deskUser",loginedDeskUser);
        if (id == null){
            model.addAttribute("userFirst",user);
            model.addAttribute("retUser",user);
        }else {
            User user1 = userService.find(id);
            model.addAttribute("userFirst",user1);
            User retUser = userService.find(retUserId);
            model.addAttribute("retUser",retUser);
        }
        model.addAttribute("releaseVehicleInformationSize",releaseVehicleInformationList.size());
        model.addAttribute("releaseVehicleInformationList",releaseVehicleInformationList);
        model.addAttribute("automobileTypeEnums",AutomobileTypeEnum.values());
        model.addAttribute("mobileStallsEnums", AutomobileStallsEnum.values());
        model.addAttribute("mobileSeatEnums", AutomobileSeatEnum.values());
        model.addAttribute("mobileBrands",automobileBrandService.findAll());
        return "home/home/Index";
    }

    @RequestMapping(value = "/viewMobilePicture",method = RequestMethod.POST)
    @ResponseBody
    public Result<HashMap<String, String>> viewMobilePicture(@RequestParam("carTypeIds")Long carTypeIds){
        HashMap<String, String> hashMap = new HashMap<>();
        AutomobileInformation information = mobileInformationService.find(carTypeIds);
        hashMap.put("videoPath",information.getAutomobileVideoPath());
        hashMap.put("brand",information.getAutomobileBrand().getBrand());
        return Result.success(hashMap);
    }

    /**
     * 多条件查询
     * @param releaseVehicleInformationVo
     * @param model
     * @return
     */
    @PostMapping("/advancedQuery")
    public String advancedQuery(@RequestBody ReleaseVehicleInformationVo releaseVehicleInformationVo, Model model){
        List<ReleaseVehicleInformation> listAll = releaseVehicleInformationService.findListAll(releaseVehicleInformationVo);
        model.addAttribute("listAll",listAll);
        return "/home/home/selectAll";
    }

    @PostMapping("/geographicalMap")
    public String geographicalMap(String id ,Model model){
        User user = userService.find(Long.valueOf(id));
        model.addAttribute("user",user);
        return "/home/home/geographical_map";
    }

    @PostMapping("/storeList")
    public String storeList(@RequestBody String pickupCity,Model model){
        List<User> userList = userService.findByCityLikeAndStatus("%"+pickupCity+"%");
        ArrayList<User> districtList = userList.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(User::getDistrict))),
                ArrayList::new));
        model.addAttribute("districtList",districtList);
        return "home/home/store_list";
    }

    @PostMapping("/wrapContent")
    public String wrapContent(@RequestBody String district,Model model){
        List<User> userList = userService.findByDistrict(district);
        model.addAttribute("userList",userList);
        return "/home/home/wrap_content";
    }
    @RequestMapping("/inquiry")
    public String inquiry(Model model){
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        if (loginedDeskUser!=null){
            model.addAttribute("deskUserInfo",personalInfoService.findByDeskUserId(loginedDeskUser.getId()));
            model.addAttribute("deskUser",loginedDeskUser);
        }
        return "home/inquiry";
    }

    @PostMapping("/releFindAll")
    public String releFindAll(Model model,@RequestBody String jsonString){
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String idStr = (String) jsonObject.get("id");
        Long id = Long.valueOf(idStr);
        String city = (String) jsonObject.get("city");
        List<ReleaseVehicleInformation> listAll = releaseVehicleInformationService.releFind(id,city);
        model.addAttribute("rentFull",listAll);
        return "/home/home/rentFull";
    }


    /**
     * 查询所有有此车的门店
     * @param model
     * @param
     * @param pageBean
     * @return
     */
    @PostMapping("/carStore")
    public String carStore(Model model,PageBean<ReleaseVehicleInformation> pageBean,
                           @RequestBody String jsonString){
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String introduceName = (String) jsonObject.get("introduceName");
        String userIdStr = (String) jsonObject.get("userId");
        String city = (String) jsonObject.get("pickupCity");
        Long userId = Long.valueOf(userIdStr);
        PageBean<ReleaseVehicleInformation> carStoreList = carStoreService.findList(introduceName,userId,city,pageBean);
        model.addAttribute("pageBeanCarStoreList",carStoreList);
        model.addAttribute("introduceName",introduceName);
        return "home/home/car_store";
    }


    @PostMapping("/paymentVerification")
    @ResponseBody
    public Result<Boolean> paymentVerification(){
        DeskUser deskUser = SessionUtil.getLoginedDeskUser();
        if (deskUser.getType() == 1){
            DeskPersonalInfo deskPersonalInfo = personalInfoService.findByDeskUserId(deskUser.getId());
            Result error = Result.error(null);
            if (deskPersonalInfo.getIdNumber() == null){
                error.setCode(1);
                return error;
            }
        }
        return Result.success(true);
    }

    @PostMapping("/perfectInfo")
    @ResponseBody
    public Result<Boolean> perfectInfo(DeskPersonalInfo deskPersonalInfo){
        DeskUser deskUser = SessionUtil.getLoginedDeskUser();
        DeskPersonalInfo byDeskUserId = personalInfoService.findByDeskUserId(deskUser.getId());
        if (deskUser==null){
            return Result.error(CodeMsg.USER_SESSION_EXPIRED);
        }
        //身份证号验证
        String checkIdCard = "^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X)$";
        if (deskPersonalInfo.getIdCardName() == null || "".equals(deskPersonalInfo.getIdCardName())){
            return Result.error(CodeMsg.HOME_DESK_USER_NAME_ERROR);
        }
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
        byDeskUserId.setIdCardName(deskPersonalInfo.getIdCardName());
        byDeskUserId.setIdNumber(deskPersonalInfo.getIdNumber());
        if(personalInfoService.save(byDeskUserId)==null){
            return Result.error(CodeMsg.HOME_ADD_DESK_USER_INFO_FAIL);
        }
        return Result.success(true);
    }

}
