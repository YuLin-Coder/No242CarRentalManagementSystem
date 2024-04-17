package com.yuanlrc.base.bean;
/**
 * 错误码统一处理类，所有的错误码统一定义在这里
 * @author Administrator
 *
 */
public class CodeMsg {

	private int code;//错误码
	
	private String msg;//错误信息
	
	/**
	 * 构造函数私有化即单例模式
	 * @param code
	 * @param msg
	 */
	private CodeMsg(int code,String msg){
		this.code = code;
		this.msg = msg;
	}
	
	public int getCode() {
		return code;
	}



	public void setCode(int code) {
		this.code = code;
	}



	public String getMsg() {
		return msg;
	}



	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	//通用错误码定义
	//处理成功消息码
	public static CodeMsg SUCCESS = new CodeMsg(0, "success");
	//非法数据错误码
	public static CodeMsg DATA_ERROR = new CodeMsg(-1, "非法数据！");
	public static CodeMsg CPACHA_EMPTY = new CodeMsg(-2, "验证码不能为空！");
	public static CodeMsg VALIDATE_ENTITY_ERROR = new CodeMsg(-3, "");
	public static CodeMsg SESSION_EXPIRED = new CodeMsg(-4, "会话已失效，请刷新页面重试！");
	public static CodeMsg CPACHA_ERROR = new CodeMsg(-5, "验证码错误！");
	public static CodeMsg USER_SESSION_EXPIRED = new CodeMsg(-6, "还未登录或会话失效，请重新登录！");
	public static CodeMsg UPLOAD_PHOTO_SUFFIX_ERROR = new CodeMsg(-7, "图片格式不正确！");
	public static CodeMsg UPLOAD_PHOTO_ERROR = new CodeMsg(-8, "图片上传错误！");
	public static CodeMsg UPLOAD_VIDEO_PHOTO_SUFFIX_ERROR = new CodeMsg(-7, "视频格式不正确！");
	public static CodeMsg UPLOAD_VIDEO_PHOTO_ERROR = new CodeMsg(-8, "视频上传错误！");
	public static CodeMsg ORDER_SN_ERROR = new CodeMsg(-12, "订单编号错误！");
	public static CodeMsg PHONE_ERROR = new CodeMsg(-13, "手机号错误！");
	public static CodeMsg ORDER_AUTH_ERROR = new CodeMsg(-14, "\u8ba2\u5355\u9a8c\u8bc1\u5931\u8d25\uff0c\u8ba2\u5355\u7f16\u53f7\u6216\u624b\u673a\u53f7\u8f93\u5165\u6709\u8bef\u6216\u8005\u53ef\u80fd\u4f60\u8d2d\u4e70\u7684\u662f\u76d7\u7248\uff0c\u8bf7\u8054\u7cfb\u3010\u733f\u6765\u5165\u6b64\u3011\u5ba2\u670d\uff01");

	//后台管理类错误码
	//用户管理类错误
	public static CodeMsg ADMIN_USERNAME_EMPTY = new CodeMsg(-2000, "用户名不能为空！");
	public static CodeMsg ADMIN_PASSWORD_EMPTY = new CodeMsg(-2001, "密码不能为空！");
	public static CodeMsg ADMIN_NO_RIGHT = new CodeMsg(-2002, "您所属的角色没有该权限！");
	public static CodeMsg ADMIN_USER_Mo = new CodeMsg(-3002, "手机输入错误");

	//登录类错误码
	public static CodeMsg ADMIN_USERNAME_NO_EXIST = new CodeMsg(-3000, "该用户名不存在！");
	public static CodeMsg ADMIN_PASSWORD_ERROR = new CodeMsg(-3001, "密码错误！");
	public static CodeMsg ADMIN_USER_UNABLE = new CodeMsg(-3002, "该用户已被冻结，请联系管理员！");
	public static CodeMsg ADMIN_USER_ROLE_UNABLE = new CodeMsg(-3003, "该用户所属角色状态不可用，请联系管理员！");
	public static CodeMsg ADMIN_USER_ROLE_AUTHORITES_EMPTY = new CodeMsg(-3004, "该用户所属角色无可用权限，请联系管理员！");

	//后台菜单管理类错误码
	public static CodeMsg ADMIN_MENU_ADD_ERROR = new CodeMsg(-4000, "菜单添加失败，请联系管理员！");
	public static CodeMsg ADMIN_MENU_EDIT_ERROR = new CodeMsg(-4001, "菜单编辑失败，请联系管理员！");
	public static CodeMsg ADMIN_MENU_ID_EMPTY = new CodeMsg(-4002, "菜单ID不能为空！");
	public static CodeMsg ADMIN_MENU_ID_ERROR = new CodeMsg(-4003, "菜单ID错误！");
	public static CodeMsg ADMIN_MENU_DELETE_ERROR = new CodeMsg(-4004, "改菜单下有子菜单，不允许删除！");
	//后台角色管理类错误码
	public static CodeMsg ADMIN_ROLE_ADD_ERROR = new CodeMsg(-5000, "角色添加失败，请联系管理员！");
	public static CodeMsg ADMIN_ROLE_NO_EXIST = new CodeMsg(-5001, "该角色不存在！");
	public static CodeMsg ADMIN_ROLE_EDIT_ERROR = new CodeMsg(-5002, "角色编辑失败，请联系管理员！");
	public static CodeMsg ADMIN_ROLE_DELETE_ERROR = new CodeMsg(-5003, "该角色下存在用户信息，不可删除！");
	//后台用户管理类错误码
	public static CodeMsg ADMIN_USER_ROLE_EMPTY = new CodeMsg(-6000, "请选择管理员所属角色！");
	public static CodeMsg ADMIN_USERNAME_EXIST = new CodeMsg(-6001, "该登录账号已存在，请换一个试试！");
	public static CodeMsg ADMIN_USE_ADD_ERROR = new CodeMsg(-6002, "管理员添加失败，请联系管理员！");
	public static CodeMsg ADMIN_USE_NO_EXIST = new CodeMsg(-6003, "管理员不存在！");
	public static CodeMsg ADMIN_USE_EDIT_ERROR = new CodeMsg(-6004, "管理员编辑失败，请联系管理员！");
	public static CodeMsg ADMIN_USE_DELETE_ERROR = new CodeMsg(-6005, "该管理员存在关联数据，不允许删除！");
	//后台店铺|送车点管理类错误码
	public static CodeMsg SHOP_USER_ROLE_EMPTY = new CodeMsg(-7000, "请选择店铺|送车点所属角色！");
	public static CodeMsg SHOP_USERNAME_EXIST = new CodeMsg(-7001, "该登陆账号已存在，请换一个试试！");
	public static CodeMsg SHOP_USE_ADD_ERROR = new CodeMsg(-7002, "店铺|送车点添加失败，请联系管理员！");
	public static CodeMsg SHOP_USE_NO_EXIST = new CodeMsg(-7003, "店铺|送车点不存在！");
	public static CodeMsg SHOP_USE_EDIT_ERROR = new CodeMsg(-7004, "店铺|送车点编辑失败，请联系管理员！");
	public static CodeMsg SHOP_USE_DELETE_ERROR = new CodeMsg(-7005, "该店铺|送车点存在关联数据，不允许删除！");
	public static CodeMsg SHOP_USE_NO_ADD_EXIST = new CodeMsg(-7006, "店铺|送车点的角色不存在或已冻结！请先创建角色!");
	public static CodeMsg SHOP_USE_NO_ADD_EDIT_EXIST = new CodeMsg(-7007, "店铺|送车点名称不能为空并且长度不能超过15");
	public static CodeMsg SHOP_USE_NO_ADD_EDIT_EXIST1 = new CodeMsg(-7008, "请填写正确地址,省,市,区,详细地址都不能为空,详细地址字数不能超过20");
	public static CodeMsg SHOP_USE_NO_ADD1_EDIT_EXIST = new CodeMsg(-7008, "经纬度不能为空并且长度不能超过100");
	public static CodeMsg SHOP_USE_NO_ADD11_EDIT_EXIST = new CodeMsg(-7009, "服务费不能为空并且不能大于一百万");
	public static CodeMsg SHOP_USE_NO_ADD11_EDIT111_EXIST = new CodeMsg(-7010, "电话不能为空");
	public static CodeMsg SHOP_USE_NO1_ADD1_EDIT_EXIST1 = new CodeMsg(-7011, "营业开始时间不能大于等于结束时间");


	//后台用户修改密码类错误码
	public static CodeMsg ADMIN_USER_UPDATE_PWD_ERROR = new CodeMsg(-8000, "旧密码错误！");
	public static CodeMsg ADMIN_USER_UPDATE_PWD_EMPTY = new CodeMsg(-8001, "新密码不能为空！");
	
	//后台用户修改密码类错误码
	public static CodeMsg ADMIN_DATABASE_BACKUP_NO_EXIST = new CodeMsg(-9000, "备份记录不存在！");

	//后台汽车品牌管理类错误码
	public static CodeMsg ADMIN_AUTOMOBILE_BRAND_ADD_ERROR = new CodeMsg(-10001, "汽车品牌添加失败，请联系管理员！");
	public static CodeMsg ADMIN_AUTOMOBILE_BRAND_EDIT_ERROR = new CodeMsg(-10002, "汽车品牌编辑失败，请联系管理员！");
	public static CodeMsg ADMIN_AUTOMOBILE_BRAND_DELETE_ERROR = new CodeMsg(-10003, "该汽车品牌存在关联数据，不允许删除！");
	public static CodeMsg ADMIN_AUTOMOBILE_BRAND_EXIST = new CodeMsg(-10004, "该汽车品牌已存在，请换一个试试！");


	//后台汽车信息管理类错误码
	public static CodeMsg ADMIN_VEHICLEINFORMATION_ADD_ERROR = new CodeMsg(-11000, "汽车信息添加失败，请联系管理员！");
	public static CodeMsg ADMIN_VEHICLEINFORMATION_EDIT_ERROR = new CodeMsg(-11001, "汽车信息编辑失败，请联系管理员！");
	public static CodeMsg ADMIN_VEHICLEINFORMATION_DELETE_ERROR = new CodeMsg(-11002, "该汽车信息存在关联数据，不允许删除！");
	public static CodeMsg ADMIN_VEHICLEINFORMATION_ADD1_ERROR = new CodeMsg(-11002, "汽车介绍图片不能为空");
	public static CodeMsg ADMIN_VEHICLEINFORMATION_ADD2_ERROR = new CodeMsg(-11002, "汽车介绍视频不能为空");
	public static CodeMsg ADMIN_VEHICLEINFORMATION_ADD5_ERROR = new CodeMsg(-11002, "请先去添加汽车品牌");




	//汽车发布信息管理类错误码
	public static CodeMsg ADMIN_RELEASEVEHICLEINFORMATION_ADD_ERROR = new CodeMsg(-12000, "租车发布信息添加失败，请联系管理员！");
	public static CodeMsg ADMIN_RELEASEVEHICLEINFORMATION_ADD1_ERROR = new CodeMsg(-12001, "请选择要发布车型信息！");
	public static CodeMsg ADMIN_RELEASEVEHICLEINFORMATION_EDIT_ERROR = new CodeMsg(-12002, "租车发布信息编辑失败，请联系管理员！");
	public static CodeMsg ADMIN_RELEASEVEHICLEINFORMATION_EDIT1_ERROR = new CodeMsg(-12003, "租车发布信息修改发布状态失败，请联系管理员！");
	public static CodeMsg ADMIN_RELEASEVEHICLEINFORMATION_ADD2_ERROR = new CodeMsg(-12004, "请选择其他服务！");
	public static CodeMsg ADMIN_RELEASEVEHICLEINFORMATION_DELETE_ERROR = new CodeMsg(-12005, "该租车发布信息存在关联数据，不允许删除！");
	public static CodeMsg ADMIN_RELEASEVEHICLEINFORMATION_DELETE1_ERROR = new CodeMsg(-12005, "该租车发布信息已发布，不允许删除！");


	//其他服务管理类错误码
	public static CodeMsg ADMIN_OTHERSERVICESIEMS_ADD_ERROR = new CodeMsg(-13000, "其他服务添加失败，请联系管理员！");
	public static CodeMsg ADMIN_OTHERSERVICESIEMS_EDIT_ERROR = new CodeMsg(-13001, "其他服务编辑失败，请联系管理员！");
	public static CodeMsg ADMIN_OTHERSERVICESIEMS_DELETE_ERROR = new CodeMsg(-13002, "该其他服务存在关联数据，不允许删除！");


	/**
	 * @author hz
	 */
	//前台用户登录注册类询价等错误码
	public static CodeMsg HOME_DESK_USER_PHONE_ERROR = new CodeMsg(-40001, "手机号格式错误");
	public static CodeMsg HOME_DESK_USER_CODE_ERROR = new CodeMsg(-40002, "验证码不能为空");
	public static CodeMsg HOME_DESK_USER_CODE_ERROR_2 = new CodeMsg(-40003, "验证码为4位数");
	public static CodeMsg HOME_DESK_USER_REGISTER_ERROR = new CodeMsg(-40004, "此电话号已注册,请前往首页登录");
	public static CodeMsg HOME_DESK_USER_REGISTER_ERROR_2 = new CodeMsg(-40005, "注册失败!");
	public static CodeMsg HOME_DESK_USER_EMAIL_ERROR = new CodeMsg(-40006, "电子邮箱格式错误");
	public static CodeMsg HOME_DESK_USER_EMAIL_ERROR_2 = new CodeMsg(-40007, "此电子邮箱已认证");
	public static CodeMsg HOME_DESK_USER_IDCARD_ERROR = new CodeMsg(-40008, "身份证格式不正确");
	public static CodeMsg HOME_ADD_DESK_USER_INFO_FAIL = new CodeMsg(-40009, "添加信息失败");
	public static CodeMsg HOME_ADD_DESK_USER_ECINFO_FAIL = new CodeMsg(-40010, "编辑紧急联系人信息失败");
	public static CodeMsg HOME_DESK_USER_PHONE_ERROR_3 = new CodeMsg(-40011, "手机号不可重复");
	public static CodeMsg HOME_DESK_USER_IDCARD_ERROR_2 = new CodeMsg(-40012, "身份证号信息不可重复");
	public static CodeMsg HOME_DESK_USER_REGISTER_TYPE_ERROR = new CodeMsg(-40013, "身份信息异常!注册失败!");
	public static CodeMsg HOME_DESK_USER_REGISTER_TYPE_ERROR_2 = new CodeMsg(-40014, "身份信息异常!上传失败");
	public static CodeMsg HOME_DESK_USER_REGISTER_ENPIC_ERROR = new CodeMsg(-40015, "企业营业执照照片不能为空");
	public static CodeMsg HOME_DESK_USER_REGISTER_ENNO_ERROR = new CodeMsg(-40016, "企业账号不能为空");
	public static CodeMsg HOME_DESK_USER_REGISTER_ENNO_ERROR_2 = new CodeMsg(-40017, "企业账号格式不正确,请输入15位数的企业账号");
	public static CodeMsg INQUIRY_ADD_FAIL = new CodeMsg(-40018, "询价单填写失败,请重新填写");
	public static CodeMsg HOME_DESK_USER_REGISTER_ENNAME_ERROR = new CodeMsg(-40019, "企业名不能为空");
	public static CodeMsg HOME_DESK_USER_REGISTER_ENNAME_ERROR_2 = new CodeMsg(-40020, "此企业名已注册");
	public static CodeMsg HOME_DESK_USER_NAME_ERROR = new CodeMsg(-40021, "姓名不能为空");

	//取消预约
	public static CodeMsg ORDER_CANCEL_FAIL = new CodeMsg(-40019, "取消订单失败");
	public static CodeMsg ORDER_CANCEL_ERROR = new CodeMsg(-40020, "此订单不可取消");

	public static CodeMsg HOME_DESK_USER_LOGIN_PHONE = new CodeMsg(-41001, "手机号不能为空");
	public static CodeMsg HOME_DESK_USER_LOGIN_PASSWORD = new CodeMsg(-40002, "密码不能为空");
	public static CodeMsg HOME_DESK_USER_LOGIN_FAIL = new CodeMsg(-41003, "手机号或密码错误,登录失败");
	public static CodeMsg HOME_DESK_USER_LOGIN_PHONE_2 = new CodeMsg(-41004, "该手机号尚未注册");
	public static CodeMsg HOME_DESK_USER_LOGIN_EMAIL_ERROR = new CodeMsg(-41005, "邮箱信息不匹配");
	public static CodeMsg HOME_DESK_USER_FORGETPWD_FAIL = new CodeMsg(-41006, "忘记密码失败");
	//修改密码
	public static CodeMsg DESK_USER_UPDATE_OLDPWD_ERROR = new CodeMsg(-31011, "旧密码不能为空");
	public static CodeMsg DESK_USER_UPDATE_NEWPWD_ERROR = new CodeMsg(-31012, "新密码不能为空");
	public static CodeMsg DESK_USER_UPDATE_RENEWPWD_ERROR = new CodeMsg(-31013, "确认新密码不能为空");
	public static CodeMsg DESK_USER_UPDATE_PWD_INCONFORMITY = new CodeMsg(-31014, "两次输入密码不一致");
	public static CodeMsg DESK_USER_UPDATE_PWD_ERROR = new CodeMsg(-31015, "输入的原密码不正确");
	public static CodeMsg DESK_USER_UPDATE_PWD_FAIL = new CodeMsg(-31016, "修改密码失败");
	public static CodeMsg DESK_USER_UPDATE_RENEWPWD_ERROR_2 = new CodeMsg(-31017, "密码长度为4-16位");

	//修改个人驾驶信息
	public static CodeMsg DESK_USER_DINFO_DNUMBER_ERROR = new CodeMsg(-42001, "驾驶证号不能为空");
	public static CodeMsg DESK_USER_DINFO_DMODEL_ERROR = new CodeMsg(-42002, "准驾类型不能为空");
	public static CodeMsg DESK_USER_DINFO_DATE_ERROR = new CodeMsg(-42003, "日期不能为空");
	public static CodeMsg DESK_USER_DINFO_DATE_ERROR_2 = new CodeMsg(-42004, "日期不正确");

	//后台准驾车型管理类错误码
	public static CodeMsg ADMIN_DRIVINGMODEL_ADD_ERROR = new CodeMsg(-43001, "准驾车型添加失败!");
	public static CodeMsg ADMIN_DRIVINGMODEL_EDIT_ERROR = new CodeMsg(-43002, "准驾车型编辑失败!");
	public static CodeMsg ADMIN_DRIVINGMODEL_DELETE_ERROR = new CodeMsg(-43003, "删除失败");
	public static CodeMsg ADMIN_DRIVINGMODEL_EDIT_ERROR_2 = new CodeMsg(-43004, "准驾车型不能重复!");

	//后台前台用户企业信息管理类错误码
	public static CodeMsg ADMIN_DESKUSEREN_EDIT_ERROR = new CodeMsg(-43005, "企业信息编辑失败!");
	public static CodeMsg ADMIN_DESKUSEREN_EDIT_ERROR_2 = new CodeMsg(-43006, "此企业账号信息异常,编辑失败!");
    //后台前台用户个人信息管理类错误码
    public static CodeMsg ADMIN_DESKUSERPN_EDIT_ERROR = new CodeMsg(-43007, "个人信息编辑失败!");
    public static CodeMsg ADMIN_DESKUSERPN_EDIT_ERROR_2 = new CodeMsg(-43008, "此个人账号信息异常,编辑失败!");


	//订单管理类错误码
	public static CodeMsg ADMIN_ORDER_EDIT1_ERROR = new CodeMsg(-18003, "还车失败,请联系管理员！");
	public static CodeMsg ADMIN_ORDER_EDIT2_ERROR = new CodeMsg(-18003, "出车失败,请联系管理员！");

	//修改手机号
	public static CodeMsg DESK_USER_UPDATE_PHONE_ERROR = new CodeMsg(-43009, "此手机号不能修改");
	public static CodeMsg DESK_USER_UPDATE_PHONE_FAIL = new CodeMsg(-430010, "修改失败");
	public static CodeMsg DESK_USER_UPDATE_PHONE_ERROR_2 = new CodeMsg(-43011, "此手机号注册不满30天不可修改");
	public static CodeMsg DESK_USER_UPDATE_PHONE_NULL = new CodeMsg(-43012, "手机号不能为空");
	public static CodeMsg DESK_USER_UPDATE_PASSWORD_NULL = new CodeMsg(-43013, "密码不能为空");
	public static CodeMsg DESK_USER_UPDATE_PASSWORD_ERROR = new CodeMsg(-43014, "密码错误");


	//生成订单失败
	public static CodeMsg ADMIN_ORDER_ADD1_ERROR1 = new CodeMsg(-10001, "生成订单失败，请联系管理员！");

}
