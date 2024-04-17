package com.yuanlrc.base.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import java.util.Map.Entry;

/**
 * https请求
 * @author llq
 *
 */
public class HttpUtil {

	public static String sendPost(String curl, Map<String, String> headerPara,String param) {
        String result = "";// 返回的结果
        BufferedReader in = null;// 读取响应输入流
        try {
            //创建连接
            URL url = new URL(curl);
            HttpURLConnection connection = (HttpURLConnection) url
                    .openConnection();
            connection.setDoOutput(true); //是否打开outputStream 相对于程序，即我们向远程服务器写入数据，默认为false，不打开
            connection.setDoInput(true);  //输入流，获取到返回的响应内容， 默认为true，所以get请求时可以不设置这个连接信息 
            connection.setRequestMethod("POST"); //发送请求的方式
            connection.setUseCaches(false); //不使用缓存
            connection.setInstanceFollowRedirects(true); //重定向，一般浏览器才需要
            connection.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded;charset=utf-8"); //设置服务器解析数据的方式
            if(headerPara != null){
            	for(Entry<String, String> entry : headerPara.entrySet()){
            		connection.setRequestProperty(entry.getKey(), entry.getValue());
            	}
            }
            connection.connect();

            //POST请求
            BufferedWriter out = new BufferedWriter(new OutputStreamWriter(connection.getOutputStream(),"UTF-8"));
            out.write(param);
            out.flush();
            out.close();

            //读取响应
            // 定义BufferedReader输入流来读取URL的响应,并设置编码方式
            in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
            String line;
            // 读取返回的内容
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Http请求方法内部问题");
        } finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }
	
}
