package com.yuanlrc.base.constant;

import java.util.Arrays;
import java.util.List;

/**
 * 系统运行时的常量
 * @author Administrator
 *
 */
public class RuntimeConstant {

	//admin登录拦截器无需拦截的url
	public static List<String> loginExcludePathPatterns = Arrays.asList(
			"/system/login",
			"/admin/css/**",
			"/system/auth_order",
			"/admin/fonts/**",
			"/admin/js/**",
			"/admin/images/**",
			"/error",
			"/cpacha/generate_cpacha",
			"/photo/view",
			"/upload/home_upload_photo",
			"/home/**",
			"/home/css/**",
			"/home/cssimg/**",
			"/home/images/**",
			"/home/js/**",
			"/admin/bootstrap-datetimepicker/**",
			"/admin/bootstrap-select/**",
			"/admin/Distpicker/**",
			"/alipay/**",
			"/admin/jquery-tags-input/**"
	);

	//admin权限拦截器无需拦截的url
	public static List<String> authorityExcludePathPatterns = Arrays.asList(
			"/system/login",
			"/system/index",
			"/system/auth_order",
			"/system/no_right",
			"/admin/css/**",
			"/admin/bootstrap-select/**",
			"/admin/fonts/**",
			"/admin/js/**",
			"/admin/images/**",
			"/error",
			"/cpacha/generate_cpacha",
			"/system/logout",
			"/system/update_userinfo",
			"/system/update_pwd",
			"/photo/view",
			"/upload/home_upload_photo",
			"/home/**",
			"/home/css/**",
			"/home/cssimg/**",
			"/home/images/**",
			"/home/js/**",
			"/admin/bootstrap-datetimepicker/**",
			"/admin/shop/**",
			"/admin/automobileBrand/**",
			"/upload/upload_video",
			"/admin/releaseVehicleInformation/**",
			"/admin/automobileBrand/**",
			"/admin/automobileInformation/**",
			"/admin/otherServicesIems/**",
			"/admin/Distpicker/**",
			"/admin/jquery-tags-input/**",
			"/admin/adminOrder/**",
			"/alipay/**"
		);

	//home权限拦截器无需拦截的url
	public static List<String> authorityHomeExcludePathPatterns = Arrays.asList(
			"/",
			"/system/**",
			"/admin/**",
			"/error",
			"/cpacha/generate_cpacha",
			"/photo/view",
			"/upload/home_upload_photo",
			"/home/css/**",
			"/home/cssimg/**",
			"/home/images/**",
			"/home/js/**",
			"/home/layui/**",
			"/home/index/**",
			"/home/deskUser/**",
			"/alipay/**"
	);

}
