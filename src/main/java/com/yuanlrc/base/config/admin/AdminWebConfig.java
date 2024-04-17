package com.yuanlrc.base.config.admin;

import com.yuanlrc.base.constant.RuntimeConstant;
import com.yuanlrc.base.interceptor.admin.AuthorityInterceptor;
import com.yuanlrc.base.interceptor.admin.LoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 用来配置拦截器的配置类
 */

@Configuration
public class AdminWebConfig implements WebMvcConfigurer {
	
	@Autowired
	private LoginInterceptor loginInterceptor;
	
	@Autowired
	private AuthorityInterceptor authorityInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
	    registry.addInterceptor(loginInterceptor).addPathPatterns("/**").excludePathPatterns(RuntimeConstant.loginExcludePathPatterns);
	    registry.addInterceptor(authorityInterceptor).addPathPatterns("/**").excludePathPatterns(RuntimeConstant.authorityExcludePathPatterns);
	}

}
