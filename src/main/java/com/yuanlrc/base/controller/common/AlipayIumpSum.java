
package com.yuanlrc.base.controller.common;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.config.AlipayConfigInfo;
import com.yuanlrc.base.entity.admin.Alipay;
import com.yuanlrc.base.entity.admin.ReleaseVehicleInformation;
import com.yuanlrc.base.entity.home.Order;
import com.yuanlrc.base.service.admin.AlipayService;
import com.yuanlrc.base.service.admin.ReleaseVehicleInformationService;
import com.yuanlrc.base.service.home.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/alipay")

public class AlipayIumpSum {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ReleaseVehicleInformationService releaseVehicleInformationService;


    @Autowired
    private AlipayService alipayService;




    @RequestMapping(value="/orderAdd" ,method= RequestMethod.GET)
    @ResponseBody
    public Result<Alipay> orderAdd(Model model, String WIDout_trade_no, Long releaseVehicleInformationId, String collectionTime,
                                    String returnTime, String WIDsubject, String WIDtotal_amount, String WIDbody, String otherServicesAuthorities){
        String payables = WIDout_trade_no;
        // 订单名称，必填(必须是数字)
        String subject = WIDsubject;
        // 付款金额，必填
        String total_amount  = WIDtotal_amount;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        // 商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = sdf.format(new Date())+UUID.randomUUID().toString();
        Alipay alipay = orderService.orderFormSave(releaseVehicleInformationId, otherServicesAuthorities, out_trade_no, collectionTime, returnTime, payables,subject);
        if (alipay==null){
            return Result.error(CodeMsg.ADMIN_ORDER_ADD1_ERROR1);
        }
        return Result.success(alipay);
    }



    /**
     * 支付调用支付宝支付接口
     * @return Object
     */
    @RequestMapping("/alipaySum")
    public Object alipayIumpSum(Model model, String WIDout_trade_no,
                                String WIDsubject,String WIDtotal_amount,String WIDbody,
                                HttpServletResponse response  )
            throws Exception {
        String payables = WIDout_trade_no;
        // 订单名称，必填(必须是数字)
        String subject = WIDsubject;
        // 付款金额，必填
        String total_amount  = WIDtotal_amount;
        // 商品描述，可空
        String body = WIDbody;
        // 获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfigInfo.gatewayUrl, AlipayConfigInfo.app_id,
                AlipayConfigInfo.merchant_private_key, "json", AlipayConfigInfo.charset,
                AlipayConfigInfo.alipay_public_key, AlipayConfigInfo.sign_type);
        // 设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfigInfo.return_url);
        alipayRequest.setNotifyUrl(AlipayConfigInfo.notify_url);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        // 商户订单号，商户网站订单系统中唯一订单号，必填
        // 付款金额，必填
        alipayRequest.setBizContent("{\"out_trade_no\":\"" + payables + "\"," + "\"total_amount\":\"" + total_amount
                + "\"," + "\"subject\":\"" + subject + "\"," + "\"body\":\"" + body + "\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
        // 请求
        String result = alipayClient.pageExecute(alipayRequest).getBody();
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(result);


        return null;
    }

    @RequestMapping("/notify_url")
    public String notifyUrl(HttpServletRequest request ) throws UnsupportedEncodingException {
        System.out.println("1111");
        if(isValid(request)) {//验证成功
            //商户订单号
            String out_trade_no = request.getParameter("out_trade_no");

            String total_amount = request.getParameter("total_amount");

            //交易状态
            String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

            if ("TRADE_SUCCESS".equals(trade_status)){
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序
                Alipay byOut_trade_no = alipayService.findByOut_trade_no(out_trade_no);

                BigDecimal bigDecimal = new BigDecimal(total_amount);

                BigDecimal bigDecimal1 = new BigDecimal(byOut_trade_no.getTotal_amount());
                if (bigDecimal.compareTo(bigDecimal1) == 0){
                    Order byOutTradeNo = orderService.findByOutTradeNo(out_trade_no);
                    if (byOutTradeNo.getType() == null){
                        ReleaseVehicleInformation releaseVehicleInformation = byOutTradeNo.getReleaseVehicleInformation();
                        Integer mindmapTopiccarNumber = releaseVehicleInformation.getMindmapTopiccarNumber();
                        releaseVehicleInformation.setMindmapTopiccarNumber(mindmapTopiccarNumber-1);
                        releaseVehicleInformationService.sava(releaseVehicleInformation);
                        byOutTradeNo.setType(1);
                        orderService.save(byOutTradeNo);
                        return "success";
                    }
                }
                return "fail";
                //注意：
                //付款完成后，支付宝系统发送该交易状态通知
            }
            return "success";
        }else {//验证失败
            return "fail";
            //调试用，写文本函数记录程序运行情况是否正常
            //String sWord = AlipaySignature.getSignCheckContentV1(params);
            //AlipayConfig.logResult(sWord);
        }



    }



    /**
     * 验证支付宝异步通知请求的签名是否正确
     *
     * @param request
     * @return
     */

    public static boolean isValid(HttpServletRequest request) {
        Map<String, String> params = new HashMap<String, String>();
        Map<String, String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
//			try {
//				valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
//			} catch (UnsupportedEncodingException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
            params.put(name, valueStr);
        }
        try {
            return AlipaySignature.rsaCheckV1(params, AlipayConfigInfo.alipay_public_key, AlipayConfigInfo.charset, AlipayConfigInfo.sign_type);
        } catch (AlipayApiException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } //调用SDK验证签名
        return false;
    }



    @RequestMapping("/return_url")
    public String returnUrl(HttpServletRequest request){
        return "redirect:/home/index/index";
    }



}

