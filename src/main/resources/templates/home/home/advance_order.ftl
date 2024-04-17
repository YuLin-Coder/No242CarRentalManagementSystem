<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${releaseInfo.automobileInformation.automobileBrand.brand}订单明细</title>
    <script src="/home/js/bigpipe.js"></script>
    <link href="/home/css/29a7315a8e0344398a9dc3070cc947bf.css" rel="stylesheet"/>
    <link href="/home/css/4432dcdc54274decb97ceed6307078a4.css" rel="stylesheet"/>
    <link href="/home/css/nologin.css" rel="stylesheet">
    <link href="/home/css/secondCommon.css">
    <link href="/home/layui/css/layui.css" rel="stylesheet"/>
    <link href="/home/css/header.css" rel="stylesheet"/>
    <link href="/home/css/simplefooter.css" rel="stylesheet"/>
    <link href="/home/css/personalLogin.css" rel="stylesheet"/>
    <script src="/home/js/bigpipe.js"></script>
    <link href="/home/css/29a7315a8e0344398a9dc3070cc947bf.css" rel="stylesheet"/>
    <link href="/home/css/4432dcdc54274decb97ceed6307078a4.css" rel="stylesheet"/>
    <link href="/home/layui/css/layui.css" rel="stylesheet"/>


</head>
<body>
<!--booking header-->
<div class="header">
    <div class="head-top">
        <div class="w1180 top-linkbox clear_float">
            <div class="top-link fl">
					<span id="spanLogin" class="">
						<a id="linkLogin" class="top-link-bold" onclick="linkLogin()" rel="nofollow">登录</a>
						<span>|</span>
						<a id="front-desk-register" onclick="registerSwitch()" class="top-link-bold" id rel="nofollow">免费注册</a>
					</span>
                <span id="spanLogined" class="hide">
						<span>
                            你好,<#if deskUser??>
                            <#if deskUserInfo??>
                                <#if deskUserInfo.idCardName??>
                                    ${deskUserInfo.idCardName}
                                <#else>
                                    ${deskUser.phone}
                                </#if>
                            <#else>
                                ${deskUser.phone}
                            </#if>
                        </#if>
                        </span>
						<a id="logout" href="/home/index/dulogout" class="top-link-bold" rel="nofollow">退出</a>
					</span>
                <span>|</span>
                <span>
                        <#if deskUser??>
                            <#if deskUser.type??>
                                <#if deskUser.type==1>
                                    身份:个人
                                <#elseif deskUser.type==0>
                                    身份:企业
                                <#else>
                                    身份:未知
                                </#if>
                            <#else>

                            </#if>
                        <#else>

                        </#if>
                </span>
                <a href="/home/index/info">我的一嗨</a>
            </div>
        </div>
    </div>
</div>
<!--存放Header-->

<!--存放内容-->


<!--step2 progress-->

<!--step2 progress-->
<div class="step2-wrap">
    <div class="step2-box">
        <!--step2 left start-->
        <div class="step2-box-left">
            <!--step2 车型门店信息 start-->
            <#if deskUser??>
                 <input type="hidden" id="sessionUser" value="${deskUser.id}" data-type="${deskUser.type}">
            <#else>
                <input type="hidden" id="sessionUser" value="-1" data-type="-1">
            </#if>

            <div class="order-info-box">
                <input type="hidden" id="dailyRentalRate"
                       data-money="${releaseInfo.automobileInformation.dailyRentalRate}"/>
                <input type="hidden" id="storeServiceCharge" data-money="${releaseInfo.user.serviceCharge}"/>
                <div class="car-image-box">
                    <img src="/photo/view?filename=${releaseInfo.automobileInformation.automobilePicturePath}"
                         alt="${releaseInfo.automobileInformation.automobileBrand.brand}">
                    <span>租 期：<em data-value="${lease}" id="lease">${lease}</em>天</span>
                </div>
                <div class="store-info-box">
                    <div class="car-name">
                        <a class="revise-back" href="/home/index/index?id=${releaseInfo.user.id}&retUserId=${retUser.id}"
                           title="返回修改">返回修改</a>
                    ${releaseInfo.automobileInformation.automobileBrand.brand}
                        <a class="car-info" href="javascript:void(0);"
                           id="cartypedetail">车辆详情&gt;</a>
                    </div>
                    <ul>
                        <li><span class="store-title">取车地点</span><span class="store-title">还车地点</span></li>
                        <li><span id="getUserId" data-id="${releaseInfo.user.id}">取车门店：${releaseInfo.user.shopName}</span>
                            <span id="retUserId" data-id="${retUser.id}">还车门店：${retUser.shopName}</span></li>
                        <li><span>取车时间：${pickUpStr}</span><span>还车时间：${reDateStr}</span></li>
                        <li><span>取车地址：${getUser.site}</span><span>还车地址：${retUser.site}</span></li>
                        <li style="padding-top: 5px;"><span class="store-title">订单说明：</span></li>
                        <li class="rule-toggle">不限公里数，超时费按车辆租赁费及门店服务费均价÷6收取实际超期小时费 (部分0元活动订单，按照40元/小时进行收取)。
                            <a href="javascript:void(0);" id="backToThat">退改规则</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="carmodel-box" style="display: none;">
                <div class="carmodel-top"></div>
                <div class="carmodel-info">
                    <h3>车辆颜色说明</h3>
                    <p>车辆颜色请以门店为准，图片仅为车型示意图。</p>
                </div>
            </div>


            <div class="payment-box">
                <div class="title">
                    支付方式
                </div>
                <div class="payment-list" id="orderPaymentList">
                    <ul class="clear_float">
                        <li>
                            <label>
                                <input name="pay" type="radio" id="Online" checked="checked" class="ba-analysis"
                                       data-ba-action="在线支付">在线支付
                            </label>
                            <span>
							</span>
                        </li>
                    </ul>

                </div>
            </div>
            <!--step2 支付方式 end-->
            <!--step2 增值服务 start-->
            <div class="service-box">
                <div class="title">
                    其它服务<#--<a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=24&amp;isLimitRules=False"
                           target="_blank">基本保障服务说明&gt;</a>-->
                </div>
                <div class="service-list">
                    <ul id="addedlist">
                        <li class="j-insurance-added" id="BasicGuarantee">
                            <input onclick="isECheckbox(this)" id="basicMoney" data-money="" name="radio"
                                   data-id="-3" type="checkbox" value="基础补充保障" class="insu ba-analysis radio"
                                   data-ba-action="基础补充保障">
                            <div class="service-name">
                                基础补充保障
                                <span class="service-name-flag">新手必买</span>
                                <div class="service-name-intro" id="basicGuarantee">

                                </div>
                                <div class="service-name-extra">不包含轮胎损坏</div>
                            </div>
                            <div class="original-price">
                                门店购买价<span id="oriPrice"></span>
                            </div>
                            <div class="service-single-price" id="servicePice">

                            </div>
                            <div class="service-price" id="sepic">

                            </div>
                        </li>
                        <li class="j-insurance-added" id="AdvancedGuarantee">
                            <input onclick="isECheckbox(this)" id="advMoney" data-money="" name="radio"
                                   data-id="-1" type="checkbox" value="高级补充保障" class="insu ba-analysis radio"
                                   data-ba-action="高级补充保障">
                            <div class="service-name">
                                高级补充保障
                                <div class="service-name-intro" id="advGuarantee">

                                </div>
                            </div>
                            <div class="original-price">
                                门店购买价<span id="seniorOrigPrice"> </span>
                            </div>
                            <div class="service-single-price" id="senServicePrice"></div>
                            <div class="service-price" id="senPrice"></div>
                        </li>
                        <li class="j-insurance-added" id="PrivilegeGuarantee">
                            <input onclick="isECheckbox(this)" id="priMoney" data-money="" name="radio"
                                   data-id="-2" type="checkbox" value="尊享补充保障" class="insu ba-analysis radio"
                                   data-ba-action="尊享补充保障">
                            <div class="service-name">
                                尊享补充保障
                                <div class="service-name-intro" id="enjoyGuarante"></div>
                            </div>
                            <div class="original-price">
                                门店购买价<span id="enjoyOriPrice"> </span>
                            </div>
                            <div class="service-single-price" id="enjoyServicePrice"></div>
                            <div class="service-price" id="enjoyPrice"></div>

                        </li>
						<#list otherServicesIems as otherServices>
							<li>
                                <input onclick="isECheckbox(this)" data-money="${otherServices.money}"
                                       data-id="${otherServices.id}"
                                       type="checkbox" value="${otherServices.name}" class="ba-analysis "
                                       data-ba-action="${otherServices.name}">
                                <div class="service-name">
                                    ${otherServices.name}
                                </div>
                                <div class="service-price">￥${otherServices.money}<span></span>
                                </div>
                            </li>
                        </#list>


                    </ul>
                </div>
            </div>

            <!--step2 增值服务 end-->
        </div>
        <!--step2left end -->
        <!--step2right start -->
        <div class="step2-box-right" id="priceall">
            <div class="price-detail">
                <div class="title">
                    费用明细
                </div>
                <ul>
                    <li class="line-clear" id="baseRatePrice">
                        <em class="price-drop">
                            ￥<font id="car-rental-fee"> <i class="price-drop-open"></i>
                        </em>车辆租赁费及门店服务费
                        <span id="carRental"></span>
                    </li>

                    <!--基本保障服务费-->
                    <li>
                        <em class="price-mid ">￥<font id="basic-guarantee">80<font></em>
                        基本保障服务费<span id="basicMoneySpan"></span>
                    </li>
                    <li id="servicePriceList">
                        <em class="price-drop">
                            ￥<font id="other-services">20</font>
                            <i class="price-drop-open"></i><i class="price-drop-close"></i>
                        </em>其它服务费

                        <div class="" style="background-color: #dddddd;" id="serviceList">
                            <span>
                                <p class="orange otherMoney" data-value="20">￥<font color="#0074C1">20</font></p>
                                <p>手续费</p>
                            </span>
                        </div>
                    </li>
                    <li id="promotionPriceList" class="hidelable">
                    </li>
                </ul>
                <div class="deposit_box">
                    <p>车辆押金<em>（可退）</em><span id="vehicleDeposit">
                        ￥${releaseInfo.automobileInformation.vehicleDeposit}</span></p>
                    <p>违章押金<em>（可退）</em>
                        <span id="illegalDeposit">
                        ￥${releaseInfo.automobileInformation.violationOfTheDeposit}</span></p>
                </div>
                <div id="offSite" style="border-top: 1px solid #ccc;display: none">
                    <span style="font-size: 17px;color: #eb5b00;">您的取车门店和还车门店不同，会有异地还车手续费，请于取车店铺协商</span>
                </div>

                <div class="price-box" id="totalAmount">
                    <span class="sub-load hidelable" id="priceloading"></span>
                    <span class="price-txt" id="priceTitle"><span>总计:</span></span>
                    <span class="price-total" id="priceTotal"><em>￥</em><span id="totalPrices"></span></span>
                </div>


                <!-- 请求支付接口 -->
                <form name=alipayment id="formDiv" onsubmit="false">
                    <input id="WIDout_trade_no" style="display: none"  value="" name="WIDout_trade_no"/>
                    <input id="WIDsubject" type="hidden" value="租车订单" name="WIDsubject"/>
                    <input id="WIDtotal_amount" type="hidden" value="租车订单" name="WIDtotal_amount"/>
                    <input id="releaseVehicleInformationId" type="hidden" value="${releaseInfo.id}"
                           name="releaseVehicleInformationId"/>
                    <input id="collectionTime" type="hidden" value="${pickUpStr}" name="collectionTime"/>
                    <input id="returnTime" type="hidden" value="${reDateStr}" name="returnTime"/>
                    <input id="otherServicesAuthorities" type="hidden" name="otherServicesAuthorities">
                </form>
                <span class="new-btn-login-sp">
                        <button class="new-btn-login" type="submit" style="text-align: center; height: 40px;
                        border-radius: 15px; width: 160px; font-size: 18px ;background-color: #93D1FF"
                                id="payBtn">付款</button>
                    </span>
                <div class="price-help">
                    <p style="display:none; border-bottom: 1px dashed ; padding-bottom: 5px; margin-bottom: 5px;"><b>此单可参加周年庆返现活动，您需支付整单金额，返还金额（基本租车费的50%）将在还车后3-5个工作日退还至您的一卡行账户</b>
                    </p>
                    首次租车请使用本人信用卡，本人二代有效身份证，本人有效地方驾驶证正副本。<br>
                    <p>本订单仅为客户租车预约登记，提交该订单后，客户需要到门店办理具体租车手续，具体权利义务以签署的合同为准。</p>
                </div>

            </div>

        </div>
        <div style="clear:both; height:70px; width: 100px;"></div>
        <!--step2right end -->
    </div>
</div>
<#--登录注册-->
<div class="login-register-popup hide">
    <div class="popup-close"><span onclick="close1()"></span></div>
    <div class="popup-left">
        <img src="https://files.1hai.cn/group72/M00/88/CC/rBUFIFwkkZKAEgXqAACvK4B3oG0649.jpg" width="100%" alt="">
        <div class="popup-left-content">
            <div class="popup-left-top">
                <span></span><em></em>注册即享双重礼<em></em><span></span>
            </div>
            <ul class="popup-left-bottom">
                <li>
                    <span class="welfare-icon1"></span>
                    <p>新用户首日立减100元</p>
                </li>
                <li>
                    <span class="welfare-icon2"></span>
                    <p>租一送一用车券</p>
                </li>
            </ul>
        </div>
    </div>
    <div class="popup-right">
        <div class="popup-logininfo">
            <h3>会员登录</h3>
            <div class="popup-loginbox">
                <div class="popup-login-common">
                    <ul class="popup-inputbox">
                        <li>
                            <input class="input-info" id="phone" type="text" placeholder="请输入手机号进行登录" maxlength="30">
                        </li>
                        <li>
                            <input class="input-info" id="password" type="password" placeholder="请输入密码" maxlength="18">
                        </li>
                        <li>
                            <div class="layui-col-md8">
                                <input type="text" name="code" id="recode1" placeholder="请输入验证码" maxlength="4"/>
                            </div>
                            <div class="layui-col-md4 login">
                                <img src="/cpacha/generate_cpacha?vl=4&fs=25&w=128&h=40&method=user_login_img_code"
                                     id="logincaptcha" style="cursor: pointer;"
                                     onclick="imgRandom(this)">
                            </div>
                        </li>
                    </ul>
                    <p class="popup-error-msg"></p>
                    <p class="popup-login-forget">
                        <a href="javascript:openDialog()" id="FindPassword">忘记密码?</a>
                    </p>
                    <p class="popup-operate-btn">
                        <a href="javascript:login()" title="登录" class="btn-popup" id="popupCommonLogin">登录</a>
                        <a href="javascript:void(0)" class="popup-loading" style="display: none"></a>
                    </p>
                </div>
            </div>
            <div class="popup-accountinfo">还没账号？<span id="registerNow" onclick="registerSwitch()">立即注册&gt;</span></div>
        </div>
        <div class="popup-registerinfo hide">
            <h3>新用户注册</h3>
            <div class="popup-register">
                <div id="register-verifybox" class="slide-verifybox"></div>
                <form action="regsiter" id="desk-user-regsiter-form" method="post">
                    <ul class="popup-inputbox">
                        <li>
                            <input class="input-info" id="registerPhone" name="phone" type="text" placeholder="请输入手机号"
                                   maxlength="11">
                        </li>
                        <li>
                            <input id="registerEmail" name="demail" type="email" placeholder="请输入电子邮箱">
                        </li>
                        <li>
                            <input id="registerPwd" type="password" name="password" placeholder="密码需4到18位"
                                   maxlength="18">
                        </li>
                        <li>
                            <input id="registerRePwd" type="password" placeholder="确认密码" maxlength="18">
                        </li>
                        <li>
                            <div class="layui-col-md8">
                                <input type="text" name="code" id="recode" placeholder="请输入验证码" maxlength="4"/>
                            </div>
                            <div class="layui-col-md4 register">
                                <img src="/cpacha/generate_cpacha?vl=4&fs=25&w=128&h=40&method=user_login_img_code"
                                     id="logincaptcha" style="cursor: pointer;"
                                     onclick="imgRandom(this)">
                            </div>
                        </li>
                        <li hidden="hidden">
                            <input type="hidden" id="type" name="type" value="1">
                        </li>
                    </ul>
                </form>
                <p class="popup-error-msg"></p>
                <p class="popup-agreement">
                    <input id="registerAgree" type="checkbox" checked="">我已阅读并同意<a
                        href="https://www.1hai.cn/NewHelp/HelpContent?menuId=2&amp;isLimitRules=False#zcyys-czrys"
                        target="_blank">租车会员注册协议》</a>和<a
                        href="https://www.1hai.cn/NewHelp/HelpContent?menuId=74&amp;isLimitRules=False" target="_blank">《一嗨租车隐私政策》</a>
                </p>
                <p class="popup-operate-btn">
                    <a href="javascript:register()" title="立即注册" class="btn-popup" id="popupRegister">立即注册</a>
                    <a href="javascript:void(0)" class="popup-loading" style="display: none"></a>
                </p>
            </div>
            <div class="popup-accountinfo">已有账号，<span id="loginNow" onclick="loginSwitch()">点击登录&gt;</span></div>
        </div>
    </div>
</div>
<#--忘记密码	-->
<div class='simple_dlg_define' style='display:none'>
    <div class='pane' style='padding:16px'>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号:</label>
            <div class="layui-input-block">
                <input class='layui-input phone' type='text' placeholder="请输入手机号">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">电子邮箱</label>
            <div class="layui-input-block">
                <input class='layui-input demail' type='text' placeholder="请输入电子邮箱">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码:</label>
            <div class="layui-input-block">
                <input class='layui-input password' type='password' placeholder="请输入密码">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码:</label>
            <div class="layui-input-block">
                <input class='layui-input password2' type='password' placeholder="请确认密码">
            </div>
        </div>
    </div>
</div>

<!-- 遮罩层 -->
<div id="cover"
     style="background: #000; position: absolute; left: 0px; top: 0px; width: 100%; filter: alpha(opacity=30); opacity: 0.6; display: none; z-index: 2 ">
</div>

<div id="mshowvideobox" class="myshowbox" style="margin: -250px 0px 0px -410px; display: none">
    <div class="myshowbox-container window-scroll" style="width: 800px;">
        <a class="btn-close" href="javascript: ;">
            <img src="/home/images/close.png" onclick="closeVideo()"/>
        </a>
        <h3 class="title" style="display: none;"></h3>
        <div class="div-myshowbox" style="width:800px; height:470px;">
            <div class="swiper-container">
                <div class="swiper-wrapper" style="width: 780px; height: 425px;">
                    <div class="swiper-slide swiper-no-swiping swiper-slide-visible swiper-slide-active"
                         style="width: 780px; height: 425px;">
                        <video id="carVideo0"
                               src="/photo/view?filename=${releaseInfo.automobileInformation.automobileVideoPath}"
                               controls="controls"></video>
                        <p id="brand"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<#--退改说明-->
<div id="backToThat-div" class="myshowbox " style="margin: -285px 0px 0px -370px; display: none">
    <div class="myshowbox-container window-scroll" style="width: 720px;">
        <a class="btn-close" id="backToThat-close" href="javascript:;"><span></span></a>
        <h3 class="title" style="display: none;"></h3>
        <div class="div-myshowbox" style="width:720px; height:540px;">
            <div class="book-rule">
                <h3>
                    预付规则
                </h3>
                <div class="ruleinfo">
                    <ul class="list-paddingleft-2">
                        <li>
                            <p class="rule-lgbt">
                                1、支付方式
                            </p>
                            <p>
                                支持支付宝在线支付
                            </p>
                        </li>
                        <li>
                            <p class="rule-lgbt">
                                2、订单取消
                            </p>
                            <p>
                                a)如取消订单，部分情况可能收取车辆租赁费及门店服务费的10%-30%作为违约金，剩余费用退还，具体违约金产生情况以用户下单时的提示为准。
                            </p>
                            <p>
                                b)因天气不可抗力（如洪水、地震等自然灾害）取消订单，不收取违约金。
                            </p>
                        </li>
                        <li>
                            <p class="rule-lgbt">
                                3、订单修改
                            </p>
                            <p>
                                a)支付完成后，允许修改订单信息。
                            </p>
                            <p>
                                b)若修改后订单金额低于原订单金额，部分情况可能收取车辆租赁费及门店服务费差额的30%作为改签费，具体情况以用户修改订单时的提示为准；若修改后订单金额高于原订单金额，支付剩余金额后即完成订单修改。
                            </p>
                        </li>
                        <li>
                            <p class="rule-lgbt">
                                4、提前还车
                            </p>
                            <p>
                                如提前还车，收取车辆租赁费及门店服务费差额的30%作为违约金。
                            </p>
                        </li>
                        <li>
                            <p class="rule-lgbt">
                                5、订单支付
                            </p>
                            <p>
                                不支持代金券支付，其它支付方式不限。
                            </p>
                            <p>
                                如客户未能及时、足额支付租赁费用，我们将以合理方式进行催收；且客户应当每日支付相当于应付而未付费用的千分之三作为滞纳金至所有费用结清之日止。
                            </p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>


<div id="windownbg" style="position: fixed; height: 100%; opacity: 0.5; z-index: 999901; display: none;"></div>

<div id="mshowbox" class="myshowbox reset-scroll" style="margin: -15px 0px 0px -330px; display: none">
    <div class="myshowbox-container window-scroll" style="width: 640px;">
        <h3 class="title" style="display: none;"></h3>
        <div class="div-myshowbox" style="width:640px; height:px;">
            <h3 class="popup-service-name">基础补充保障</h3>
            <p class="popup-service-intro"><font color="#29B7B7">•&nbsp;</font><font color="#666666">7*24小时全国道路救援</font><br><font
                    color="#29B7B7">•&nbsp;</font><font color="#666666">5000元车损免赔（轮胎除外）</font><br><font color="#29B7B7">•&nbsp;</font><font
                    color="#666666">三者保障20万</font><br><br>
                <small><font color="#E9B159">温馨提示：</font><font color="#999999">用车过程产生车损，车辆因意外事故致使他人人身伤亡或财产直接损失，三者保障限额为20万。新手推荐购买（55元/天，385元封顶/月，以一个月为一个周期），出行无忧！</font>
                </small>
            </p>
            <p class="popup-service-btn"><a href="javascript:void(0)" id="serviceKnow">我知道了</a></p>
        </div>
    </div>
</div>
<div id="mshowbox1" class="myshowbox reset-scroll" style="margin: -15px 0px 0px -330px; display: none">
    <div class="myshowbox-container window-scroll" style="width: 640px;">
        <h3 class="title" style="display: none;"></h3>
        <div class="div-myshowbox" style="width:640px; height:px;">
            <h3 class="popup-service-name">高级补充保障</h3>
            <p class="popup-service-intro"><font color="#29B7B7">•&nbsp;</font><font color="#666666">7*24小时全国道路救援</font><br><font
                    color="#29B7B7">•&nbsp;</font><font color="#666666">5000元车损免赔</font><br><font color="#29B7B7">•&nbsp;</font><font
                    color="#666666">三者保障50万</font><br><br>
                <small><font color="#E9B159">温馨提示：</font><font color="#999999">
                    用车过程产生车损，车辆因意外事故致使他人人身伤亡或财产直接损失，三者保障限额由20万增至50万。升级保障（80元/天，第8天至该月结束，25元/天，以一个月为一个周期），平安护驾！</font>
                </small>
            </p>
            <p class="popup-service-btn"><a href="javascript:void(0)" id="serviceKnow1">我知道了</a></p>
        </div>
    </div>
</div>
<div id="mshowbox2" class="myshowbox reset-scroll" style="margin: -15px 0px 0px -330px; display: none">
    <div class="myshowbox-container window-scroll" style="width: 640px;">
        <h3 class="title" style="display: none;"></h3>
        <div class="div-myshowbox" style="width:640px; height:px;">
            <h3 class="popup-service-name">尊享补充保障</h3>
            <p class="popup-service-intro"><font color="#29B7B7">•&nbsp;</font><font color="#666666">7*24小时全国道路救援</font><br><font
                    color="#29B7B7">•&nbsp;</font><font color="#666666">5000元车损免赔</font><br><font color="#29B7B7">•&nbsp;</font><font
                    color="#666666">三者保障100万</font><br><br>
                <small><font color="#E9B159">温馨提示：</font><font color="#999999">
                    用车过程产生车损，车辆因意外事故致使他人人身伤亡或财产直接损失，三者保障限额由20万增至100万。值得推荐购买（105元/天，第8天至该月结束，50元/天，以一个月为一个周期），享受最高保障！</font>
                </small>
            </p>
            <p class="popup-service-btn"><a href="javascript:void(0)" id="serviceKnow2">我知道了</a></p>
        </div>
    </div>
</div>

<div id="mshowbox3" class="myshowbox" style="margin: -185px 0px 0px -310px; display: none">
    <div class="myshowbox-container window-popup" style="width: 620px;">
        <a class="btn-close" onclick="closePaymentVer()" href="javascript:;"><span></span></a>
        <h3 class="title" style="display: none;"></h3>
        <div class="div-myshowbox" style="width:620px; height:360px;">
            <div class="card-confirm-box">
                <div class="card-confirm-title">填写证件信息</div>
                <div class="card-confirm-remark">为保证您的账户安全，请进行身份验证。</div>
                <div class="card-confirm-form">
                    <div class="card-addinfo" id="fame">
                        <em>姓　　名</em>
                        <input name="name" type="text" id="name" maxlength="20" placeholder="请输入您的真实姓名" value=""
                               onkeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"><i>*</i>
                    </div>
                    <div class="card-addinfo card-type">
                        <em>证件类型</em>
                        <input class="sel-card" name="type" type="text" readonly="readonly" value="身份证">
                        <input name="cardNo" type="text" id="idNumber" maxlength="18" placeholder="请输入您的证件号" value=""
                               onkeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"><i>*</i>
                        <span id="tips"></span>
                        <div class="sel-card-box" style="display: none;">
                            <span id="1010101">身份证</span>
                        </div>
                    </div>
                    <div class="card-confirm-btn">
                        <a href="javascript:void(0);" id="btnRegisterSubmit" style="color: #bf800c">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
<script src="/home/layui/layui.js"></script>
<script src="/home/js/jquery-1.8.0.min.js"></script>
<script src="/home/layui/layui.all.js"></script>
<script src="/home/js/msg.js"></script>
<script src="/home/js/star.js"></script>
<script>

    function closePaymentVer() {
        $("#mshowbox3").css("display", "none");
        $('#cover').css('display', 'none');
    }

    $("#btnRegisterSubmit").click(function () {
        var idNumber = $("#idNumber").val();
        var chkidNumber = /^[1-9]\d{5}(18|19|20|(3\d))\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
        if (!chkidNumber.test(idNumber)) {
            layer.msg("请正确输入身份证号");
            return;
        }
        var name = $("#name").val();
        if (name == "" || name == undefined) {
            layer.msg("姓名不能为空");
            return;
        }
        $.ajax({
            type: "POST",
            url: '/home/index/perfectInfo',
            dataType: 'json',
            data: {
                idNumber: idNumber,
                idCardName: name
            },
            cache: false,
            success: function (data) {
                if (data.code == 0) {
                    layer.msg("添加成功");
                    closePaymentVer();
                }
                else {
                    layer.msg(data.msg);
                }
            }
        });
    });



    $(document).ready(function () {
        $(".popup-close").click(function () {
            $(".login-register-popup").addClass("hide");
        });
        var user = null;
			<#if deskUser??>
				user = '${deskUser}';
            </#if>
        if (user != null & user != "") {
            $("#spanLogined").removeClass("hide");
            $("#spanLogin").addClass("hide");
            close1();
        }
        //初始化验证码
        imgRandom($("#logincaptcha"));
        offSite();
    });
</script>
<script>
    function linkLogin() {
        $(".login-register-popup").removeClass("hide");
        $(".popup-logininfo").removeClass("hide");
        $(".popup-registerinfo").addClass("hide");
    }

    function registerSwitch() {
        $(".login-register-popup").removeClass("hide");
        $(".popup-logininfo").addClass("hide");
        $(".popup-registerinfo").removeClass("hide");
    }

    function loginSwitch() {
        $(".popup-logininfo").removeClass("hide");
        $(".popup-registerinfo").addClass("hide");
    }

    function close1() {
        $(".login-register-popup").addClass("hide");
    }

    //验证码刷新
    function imgRandom(thisImg) {
        thisImg.src = thisImg.src + '&d=' + Math.random();
    }

    //注册验证
    function rcheck() {
        layui.use('layer', function () {
            var layer = layui.layer;
        });
        // 手机号的正则表达式
        var demail = $("#registerEmail").val().trim();
        var chkemail = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/;
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        var phone = $("#registerPhone").val();
        var password = $("#registerPwd").val().trim();
        var repaaword = $('#registerRePwd').val().trim();
        var code = $('#recode').val().trim();
        var registerAgree = $("#registerAgree");
        if (!registerAgree.attr("checked")) {
            errorMsg("未勾选协议");
            return false;
        }
        if (demail.length == 0) {
            errorMsg("请输入电子邮箱");
            return false;
        }
        if (!chkemail.test(demail)) {
            errorMsg("请输入正确的电子邮箱");
            return false;
        }
        if (!chkphone.test(phone)) {
            errorMsg("请输入正确的手机号");
            return false;
        }
        if (password.length == 0) {
            errorMsg("请输入密码");
            return false;
        }
        if (repaaword.length == 0) {
            errorMsg("请输入确认密码");
            return false;
        }
        if (password != repaaword) {
            errorMsg("两次输入密码不一致");
            return false;
        }
        if (code.length == 0) {
            errorMsg("请输入验证码");
            return false;
        }
        return true;
    }

    //提交注册
    function register() {
        if (rcheck()) {
            var data = $("#desk-user-regsiter-form").serialize();
            $.ajax({
                type: "POST",
                url: '/home/index/duregister',
                data: data,
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.code == 0) {
                        successMsg("注册成功,请登录");
                        setTimeout(function () {
                            loginSwitch();//跳转至登录
                            imgRandom($("#logincaptcha"));
                        }, 1000);
                    }
                    else {
                        errorMsg(data.msg);
                    }
                }
            });
        }
    }

    //提交登录
    function login() {
        var phone = $("#phone").val().trim();
        var password = $("#password").val().trim();
        var code = $("#recode1").val().trim();
        if (phone.length == 0) {
            errorMsg("请输入手机号");
            return false;
        }
        if (password.length == 0) {
            errorMsg("请输入密码");
            return false;
        }
        if (code.length == 0) {
            errorMsg("请输入验证码");
            return false;
        }
        $.ajax({
            type: "POST",
            url: '/home/index/dulogin',
            data: {phone: phone, password: password, code: code},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.code == 0) {
                    successMsg("登录成功");
                    setTimeout(function () {
                        location.href = "/home/index/independentCarRental";
                    }, 1000);
                }
                else {
                    errorMsg(data.msg);
                }
            }
        });
    }

    //打开忘记密码对话框
    function openDialog() {
        var dlgContent = $('.simple_dlg_define').html(); // 窗口内容
        layer.open({
            type: 1,
            title: '忘记密码',
            area: ['420px', 'auto'],
            content: dlgContent,
            btn: ['修改', '取消'],
            btn1: function (index, layero) {
                var phone = $('.phone', layero).val().trim();
                var demail = $('.demail', layero).val().trim();
                var password = $('.password', layero).val().trim();
                var password2 = $('.password2', layero).val().trim();
                forgetPwd(phone, demail, password, password2, index);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };

    //忘记密码
    function forgetPwd(phone, demail, password, verPassword, index) {
        if (phone.length == 0) {
            layer.msg("请输入手机号");
            return;
        }
        if (demail.length == 0) {
            layer.msg("请输入电子邮箱");
            return;
        }
        if (password.length == 0) {
            layer.msg("请输入密码");
            return;
        }

        if (verPassword.length == 0) {
            layer.msg("请输入确认密码");
            return;
        }
        if (password != verPassword) {
            layer.msg("密码不一致");
            return;
        }
        //手机号正则验证
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        if (!chkphone.test(phone)) {
            layer.msg("请输入正确的手机号");
            return;
        }
        //电子邮箱验证
        var chkemail = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/;
        if (!chkemail.test(demail)) {
            layer.msg("请输入正确的电子邮箱");
            return;
        }
        $.ajax({
            url: 'forgetPwd',
            type: 'POST',
            data: {phone: phone, demail: demail, password: password, ver_password: verPassword},
            dataType: 'json',
            success: function (data) {
                if (data.code == 0) {
                    layer.msg("修改成功");
                    layer.close(index);
                }
                else {
                    layer.msg(data.msg);
                }
            },
            error: function (data) {
                layer.msg('网络错误!');
            }
        });
    }
</script>
<script>

    function offSite() {
        var getUserId = $("#getUserId").attr("data-id");
        var retUserId = $("#retUserId").attr("data-id");
        if (getUserId != retUserId) {
            $("#offSite").css('display', '');
        }
    }

    //计算金额
    function viewPrice() {

        var lease = $("#lease").attr("data-value");

        $("#servicePice").html("53 * " + lease);
        $("#sepic").html("￥" + lease * 53);
        $("#oriPrice").html("￥" + lease * 55);
        $("#basicMoney").attr("data-money", lease * 53);

        $("#seniorOrigPrice").html("￥" + lease * 80);
        $("#senServicePrice").html("72 * " + lease);
        $("#senPrice").html("￥" + lease * 72);
        $("#advMoney").attr("data-money", lease * 72);

        $("#enjoyOriPrice").html("￥" + lease * 105);
        $("#enjoyServicePrice").html("95 * " + lease);
        $("#enjoyPrice").html("￥" + lease * 95);
        $("#priMoney").attr("data-money", lease * 95);

        var dailyRentalRate = $("#dailyRentalRate").attr("data-money");
        var storeServiceCharge = $("#storeServiceCharge").attr("data-money");
        $("#car-rental-fee").html((dailyRentalRate * lease) + (storeServiceCharge * lease));
        $("#carRental").html("车辆租赁费" + dailyRentalRate * lease + "元和门店服务费" + storeServiceCharge * lease + "元")


        $("#basic-guarantee").html(50 * lease);
        $("#basicMoneySpan").html("基本保障服务费50元 * " + lease + "天");

        var total = parseInt($("#other-services").text()) + parseInt($("#basic-guarantee").text()) + parseInt($("#car-rental-fee").text());

        var userType = $("#sessionUser").attr("data-type");
        if (userType == -1) {
            registerSwitch();
        }
        if (userType == 0) {
            if (lease > 30) {
                total = total * 0.7;
            } else {
                total = total * 0.9;
            }
        }


        $('#totalPrices').text(parseInt(total));
        $('#WIDout_trade_no').attr("value", parseInt(total));

    }

    $("#backToThat").click(function () {
        $("#backToThat-div").css("display", "");
        $('#cover').css('display', 'block'); //显示遮罩层
        $('#cover').css('height', document.body.clientHeight + 'px'); //设置遮罩层的高度为当前页面高度
    });

    $("#backToThat-close").click(function () {
        $("#backToThat-div").css("display", "none");
        $('#cover').css('display', 'none');
    });

    $("#cartypedetail").click(function () {
        $("#mshowvideobox").css("display", "");
        $('#cover').css('display', 'block'); //显示遮罩层
        $('#cover').css('height', document.body.clientHeight + 'px'); //设置遮罩层的高度为当前页面高度
    });

    function closeVideo() {
        $("#carVideo0").removeAttr("src");
        $("#brand").empty();
        $("#mshowvideobox").css("display", "none");
        $('#cover').css('display', 'none');
    }


    $("#basicGuarantee").click(function () {
        $("#mshowbox").css("display", "");
        $('#cover').css('display', 'block'); //显示遮罩层
        $('#cover').css('height', document.body.clientHeight + 'px');
    });
    $("#serviceKnow").click(function () {
        $("#mshowbox").css("display", "none");
        $('#cover').css('display', 'none');
    });

    $("#advGuarantee").click(function () {
        $("#mshowbox1").css("display", "");
        $('#cover').css('display', 'block'); //显示遮罩层
        $('#cover').css('height', document.body.clientHeight + 'px');
    });
    $("#serviceKnow1").click(function () {
        $("#mshowbox1").css("display", "none");
        $('#cover').css('display', 'none');
    });

    $("#enjoyGuarante").click(function () {
        $("#mshowbox2").css("display", "");
        $('#cover').css('display', 'block'); //显示遮罩层
        $('#cover').css('height', document.body.clientHeight + 'px');
    });
    $("#serviceKnow2").click(function () {
        $("#mshowbox2").css("display", "none");
        $('#cover').css('display', 'none');
    });


    $(document).ready(function () {
        viewPrice();
        var userType = $("#sessionUser").attr("data-type");
        if (userType == -1) {
            registerSwitch();
        }
    });

    let otherServices = new Array();

    var checkElement = document.getElementsByClassName('radio');
    for (var i in checkElement) {
        checkElement[i].onclick = checkBack;
    }

    //企业租车优惠
    function CorporateCarRentalOffer(t) {
        var lease = $("#lease").attr("data-value");
        var userType = $("#sessionUser").attr("data-type");
        if (userType == -1) {
            registerSwitch();
        }
        if (userType == 0) {
            if (lease > 30) {
                t = t * 0.7;
            } else {
                t = t * 0.9;
            }
        }
        return t ;
    }
    //计算总金额
    function sumOtherMoney() {
        var otherPrice = 0;
        var otherMoney = document.getElementsByClassName('otherMoney');
        for (var i = 0; i < otherMoney.length; i++) {
            otherPrice = parseInt(otherPrice) + parseInt($(otherMoney[i]).attr("data-value"));
        }
        $("#other-services").html(otherPrice);

        var carRentalFee = $("#car-rental-fee").text();
        var basicGuarantee = $("#basic-guarantee").text();
        var otherServices = $("#other-services").text();
        var sumMoney = 0;
        sumMoney += parseInt(parseInt(carRentalFee) + parseInt(basicGuarantee) + parseInt(otherServices));
        var rentalOffer = CorporateCarRentalOffer(sumMoney);

        $("#totalPrices").html(parseInt(rentalOffer));
        $('#WIDout_trade_no').val(parseInt(rentalOffer));
    }



    function checkBack() {
        var flag = this.checked;
        for (var i = 0; i < checkElement.length; i++) {
            checkElement[i].checked = false;
        }
        if (flag) {
            this.checked = true;
            isCheckbox();
        } else {
            this.checked = false;
            isCheckbox();
        }
    }

    function isCheckbox() {
        var checkElement = document.getElementsByClassName('radio');
        for (var i = 0; i < checkElement.length; i++) {
            if ($(checkElement[i]).prop('checked')) {
                var isECheckboxInputVal = $(checkElement[i]).attr('value');
                var isECheckboxInputDataMoney = $(checkElement[i]).attr('data-money');
                var isECheckboxInputDataId = $(checkElement[i]).attr('data-id');
                var servicePriceDiv = "<div class=\"radiotype\" style=\"background-color: #dddddd;\" data-UUId = " + isECheckboxInputDataId + " id=\"serviceList\">\n" +
                        "<span>\n" +
                        "<p data-value=" + isECheckboxInputDataMoney + " class=\"orange otherMoney\">\n" +
                        "￥<font class=\"\" color=\"#0074C1\">" + isECheckboxInputDataMoney + " </font>\n" +
                        "</p>\n" +
                        "<p>" + isECheckboxInputVal + "</p>\n" +
                        "</span>\n" +
                        "</div>";
                $('#servicePriceList').append(servicePriceDiv);
                sumOtherMoney();
            }
            else {
                var isECheckboxInputDataId = $(checkElement[i]).attr('data-id');
                $("[data-UUId = " + isECheckboxInputDataId + "]").remove();
                sumOtherMoney();
            }
        }

    }


    function isECheckbox(t) {
        if ($(t).prop('checked')) {

            var isECheckboxInputVal = $(t).attr('value');
            var isECheckboxInputDataMoney = $(t).attr('data-money');
            var isECheckboxInputDataId = $(t).attr('data-id');
            var servicePriceDiv = "<div class=\"radiotype\" style=\"background-color: #dddddd;\" data-UUId = " + isECheckboxInputDataId + " id=\"serviceList\">\n" +
                    "<span>\n" +
                    "<p data-value=" + isECheckboxInputDataMoney + " class=\"orange otherMoney\">\n" +
                    "￥<font color=\"#0074C1\">" + isECheckboxInputDataMoney + " </font>\n" +
                    "</p>\n" +
                    "<p>" + isECheckboxInputVal + "</p>\n" +
                    "</span>\n" +
                    "</div>";
            $('#servicePriceList').append(servicePriceDiv);
            sumOtherMoney();
            otherServices.push(isECheckboxInputDataId);
            var str = otherServices.join();
            $('#otherServicesAuthorities').val(str);
        }

        if (!$(t).prop('checked')) {
            var isECheckboxInputDataId = $(t).attr('data-id');
            $("[data-UUId = " + isECheckboxInputDataId + "]").remove();
            sumOtherMoney();
            removeByValue(otherServices,isECheckboxInputDataId);
            var str = otherServices.join();
            $('#otherServicesAuthorities').val(str);

        }

    }

    function removeByValue(arr, val) {
        for(var i = 0; i < arr.length; i++) {
            if(arr[i] == val) {
                arr.splice(i, 1);
                break;
            }
        }
    }

    $('#payBtn').on('click',function () {

        $.ajax({
            type: "POST",
            url: '/home/index/paymentVerification',
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.code == 0) {
                    let data = $("#formDiv").serialize();
                    $.ajax({
                        url:'/alipay/orderAdd',
                        type:'GET',
                        data:data,
                        dataType:'json',
                        success:function(data){
                            console.log(data)
                            window.location.href = '/alipay/alipaySum?WIDout_trade_no='+data.data.out_trade_no+'&WIDsubject='+data.data.subject+'&WIDtotal_amount='+data.data.total_amount;
                        },
                        error:function(data){
                            alert('网络错误!');
                        }
                    });
                }
                else if (data.code == 1) {
                    $("#mshowbox3").css("display", "");
                    $('#cover').css('display', 'block'); //显示遮罩层
                    $('#cover').css('height', document.body.clientHeight + 'px'); //设置遮罩层的高度为当前页面高度
                }
            }
        });

    })
</script>

</html>
