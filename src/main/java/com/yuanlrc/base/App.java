package com.yuanlrc.base;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 项目入口启动文件
 *
 */
@SpringBootApplication
@EnableJpaAuditing
@ServletComponentScan
@Controller
public class App 
{
    public static void main( String[] args )
    {
    	 SpringApplication.run(App.class, args);
    }

    @RequestMapping("/")
    public String index(){
        return "/home/index/index";
    }

}



