package com.yuanlrc.base.util;

import com.alibaba.fastjson.JSONObject;
import com.yuanlrc.base.bean.CodeMsg;

import java.io.*;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

/**
 * 项目通用工具类
 * @author Administrator
 *
 */
public class StringUtil {
	
	
	/**
	 * 返回指定格式的日期字符串
	 * @param date
	 * @param formatter
	 * @return
	 */
	public static String getFormatterDate(Date date,String formatter){
		SimpleDateFormat sdf = new SimpleDateFormat(formatter);
		return sdf.format(date);
	}
	
	/**
	 * 判断请求是否是ajax
	 * @param request
	 * @return
	 */
	public static boolean isAjax(HttpServletRequest request){
		String header = request.getHeader("X-Requested-With");
		if("XMLHttpRequest".equals(header))return true;
		return false;
	}
	
	/**
	 * 从流读取字符串
	 * @param inputStream
	 * @return
	 */
	public static String getStringFromInputStream(InputStream inputStream){
		String string = "";
		try {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream,"GB2312"));
			String buf = null;
			try {
				while((buf = bufferedReader.readLine()) != null){
					string += buf;
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				try {
					bufferedReader.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return string;
	}

	/**
	 * 生成唯一字符串
	 * @return
	 */
	public static String generateSn(){
		return UUID.randomUUID().toString().toUpperCase().replace("-", "");
	}

	public static String getMac(){
		String mac = "";
		try {
			InetAddress localHost = InetAddress.getLocalHost();
			byte[] hardwareAddress = NetworkInterface.getByInetAddress(localHost).getHardwareAddress();
			StringBuffer sb = new StringBuffer("");
			for(int i=0; i<hardwareAddress.length; i++) {
				//字节转换为整数
				int temp = hardwareAddress[i]&0xff;
				String str = Integer.toHexString(temp);
				//System.out.println("每8位:"+str);
				if(str.length()==1) {
					sb.append("0"+str);
				}else {
					sb.append(str);
				}
			}
			mac = sb.toString();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mac.toUpperCase();
	}

	public static boolean authOrder(String orderSn,String phone){
		Map<String, String> headerParaMap = new HashMap<String, String>();
		String mac = getMac();
		String paramToken = DESUtil.encrypt(orderSn, mac+"#"+orderSn+"#"+phone);
		headerParaMap.put("paramToken", paramToken);
		String timeToken = DESUtil.encrypt("muyi_ylrc", System.currentTimeMillis()+"");
		headerParaMap.put("timeToken", timeToken);
		String sendPost = HttpUtil.sendPost("http://120.25.120.129:8081/order_auth/verify",headerParaMap,"orderSn="+orderSn+"&phone="+phone+"&mac="+mac);
		JSONObject parseObject = JSONObject.parseObject(sendPost);
		if(parseObject.getIntValue("code") != CodeMsg.SUCCESS.getCode()){
			return false;
		}
		return true;
	}

	public static String readFileToString(File file){
		String string = "";
		if(file != null){
			try {
				BufferedReader br = new BufferedReader(new FileReader(file));
				String line = null;
				while ((line = br.readLine()) != null) {
					string += line;
				}
				br.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		return string;
	}

	public static void handleFile(File file){
		if(file.isDirectory()){
			File[] listFiles = file.listFiles();
			for(File f : listFiles){
				handleFile(f);
			}
		}else{
			System.out.println(file.getName());
			file.delete();
		}
	}
}
