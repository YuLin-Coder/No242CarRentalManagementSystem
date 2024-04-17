 
<!DOCTYPE html>
<html>
<head>
    <title>企业租车服务</title>

    <link href="/home/layui/css/layui.css" rel="stylesheet" />
    <link href="/home/css/header.css" rel="stylesheet" />
    <link href="/home/css/simplefooter.css" rel="stylesheet" />
    <link href="/home/css/login.css" rel="stylesheet" />
    <style>
        .login img{
            position: absolute;
            top:15px;
            cursor: pointer;
        }
        .service-list li:hover .service-list-hover{
            display: block;
        }
        .w1181{
            height: 200px;
        }
        .swiper-slide p{
            position: relative;
            top: 260px;
            left: -450px;
        }
    </style>
    <link href="/home/css/base.css" rel="stylesheet" />
    <link href="/home/css/index.css" rel="stylesheet" />
    <link href="/home/css/idangerous.swiper2.7.6.css" rel="stylesheet" />
</head>
<body>
<header>
            <div class="head-top">
                <div class="w1180 top-linkbox clear_float">
                    <div class="top-link fl">
							<span id="spanLogin">
								<a id="front-desk-register" href="/home/index/enterpriseRegister" class="top-link-bold" id  rel="nofollow">免费注册</a>
							</span>
                        <span id="spanLogined" class="hide">
								<span>
                                    你好,<#if deskUser??>
                                    <#if deskUser.type==1>
                                        <#if deskUserInfo??>
                                            <#if deskUserInfo.idCardName??>
                                                ${deskUserInfo.idCardName}
                                            <#else>
                                                ${deskUser.phone}
                                            </#if>
                                        <#else>
                                            ${deskUser.phone}
                                        </#if>
                                    <#elseif deskUser.type==0>
                                        <#if deskUserEnInfo??>
                                            <#if deskUserEnInfo.enterpriseName??>
                                                ${deskUserEnInfo.enterpriseName}
                                            <#else>
                                                ${deskUser.phone}
                                            </#if>
                                        <#else>
                                            ${deskUser.phone}
                                        </#if>
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
                        <span></span>
                        <a href="/home/index/info">个人中心</a>
                    </div>
                </div>
            </div>
            <div class="head-bottom">
                <div class="w1180">
                    <div class="nav">
                        <ul class="nav-wrap clear_float" id="J_NavBox">
                            <li><a href="/home/index/index" target="_top">自驾租车</a><span></span></li>
                            <li class="menu-index menu-index-on"><a href="/home/index/enterpriseService" target="_blank">企业服务</a><span></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>
    <article>
        <div class="banner-box">
            <div class="banner">
                <div class="banner-introbox">
                    <div class="banner-text">
                        <p class="banner-title">企业用车</p>
                        <p class="banner-textChinese">尊享专属服务</p>
                        <p class="banner-line"></p>
                        <p class="banner-textEnglish">Exclusive Services For <br /> Car Ownership</p>
                    </div>
                    <div class="banner-logo">
                        <p>专业&nbsp;&nbsp;高效&nbsp;&nbsp;可靠</p>
                    </div>
                </div>
                <div class="popup-right">
                    <div class="popup-logininfo">
                        <h3>企业登录</h3>
                        <ul class="poupp-logintab tab-clearfix">
                            <li class="poupp-logincur">普通登录<span></span></li>
                            <li class="poupp-logintab" onclick="enterpriseRegister()">企业注册<span></span></li>
                        </ul>
                        <div class="popup-loginbox">
                            <div class="popup-login-commo">
                                <ul class="popup-inputbox">
                                    <li>
                                        <input id="phone" name="phone" type="text" placeholder="请输入手机号" maxlength="30">
                                    </li>
                                    <li>
                                        <input id="password" name="password" type="password" placeholder="请输入密码">
                                    </li>
                                    <li>
                                        <div class="">
                                            <input type="text" name="code" id="recode2" placeholder="请输入验证码" maxlength="4"/>
                                        </div>
                                        <div class="login">
                                            <img src="/cpacha/generate_cpacha?vl=4&fs=25&w=128&h=40&method=user_login_img_code"
                                                 id="logincaptcha" style="cursor: pointer;"
                                                 onclick="imgRandom(this)">
                                        </div>
                                    </li>
                                </ul>
                                
                                <p class="login-forget">
                                    <a class="forget-link" href="javascript:openDialog1()">忘记密码?</a>
                                </p>
                                <p class="popup-error-msg"></p>
                                <p class="popup-operate-btn">
                                    <a href="javascript:login()" title="登录" class="" >登录</a>
                                    <a href="javascript:void(0)" class="popup-loading" style="display: none"></a>
                                </p>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="content-box">
            <div class="service-box w1180">
                <ul class="service-list clear_float">
                    <li>
                        <p class="iconbg"><span class="icon icon-specialCar"></span></p>
                        <p class="service-title">高端专车</p>
                        <p class="service-intro">200多座城市全天候私人管家式高品质接送服务题</p>
                        <div class="service-list-hover">
                            <p><span class="icon-lg icon-specialCar-hover"></span></p>
                            <p class="service-title-hover">高端专车</p>
                            <a class="service-btn-hover" href="/home/index/inquiry">我要咨询</a>
                        </div>
                    </li>
                    <li>
                        <p class="iconbg"><span class="icon icon-longCarRent"></span></p>
                        <p class="service-title">长租用车</p>
                        <p class="service-intro">企业贴身定制租车服务，专业高效</p>
                        <div class="service-list-hover">
                            <p><span class="icon-lg icon-longCarRent-hover"></span></p>
                            <p class="service-title-hover">长租用车</p>
                            <a class="service-btn-hover" href="/home/index/inquiry">我要咨询</a>
                        </div>
                    </li>
                    <li>
                        <p class="iconbg"><span class="icon icon-conference"></span></p>
                        <p class="service-title">会议会务</p>
                        <p class="service-intro">会议会务活动行程一站式服务</p>
                        <div class="service-list-hover">
                            <p><span class="icon-lg icon-conference-hover"></span></p>
                            <p class="service-title-hover">会议会务</p>
                            <a class="service-btn-hover" href="/home/index/inquiry">我要咨询</a>
                        </div>
                    </li>
                    <li>
                        <p class="iconbg"><span class="icon icon-fleetManage"></span></p>
                        <p class="service-title">车队管理</p>
                        <p class="service-intro">借助专业系统/解决车队管理难题</p>
                        <div class="service-list-hover">
                            <p><span class="icon-lg icon-fleetManage-hover"></span></p>
                            <p class="service-title-hover">车队管理</p>
                            <a class="service-btn-hover" href="/home/index/inquiry">我要咨询</a>
                        </div>
                    </li>
                    <li>
                        <p class="iconbg"><span class="icon icon-selfDrive"></span></p>
                        <p class="service-title">自驾租车</p>
                        <p class="service-intro">一次签约，折扣全员共享让差旅更经济、私密、高效</p>
                        <div class="service-list-hover">
                            <p><span class="icon-lg icon-selfDrive-hover"></span></p>
                            <p class="service-title-hover">自驾租车</p>
                            <a class="service-btn-hover" href="/home/index/inquiry">我要咨询</a>
                        </div>
                    </li>
                    <li>
                        <p class="iconbg"><span class="icon icon-internationalDrive"></span></p>
                        <p class="service-title">国际租车</p>
                        <p class="service-intro">美国、加拿大、澳大利亚等多个海外城市提供租车服务</p>
                        <div class="service-list-hover">
                            <p><span class="icon-lg icon-internationalDrive-hover"></span></p>
                            <p class="service-title-hover">国际租车</p>
                            <a class="service-btn-hover" href="/home/index/inquiry">我要咨询</a>
                        </div>
                    </li>
                    <li>
                        <p class="iconbg"><span class="icon icon-differCooperate"></span></p>
                        <p class="service-title">异业合作</p>
                        <p class="service-intro">分享市场营销资源，强强联合</p>
                        <div class="service-list-hover">
                            <p><span class="icon-lg icon-differCooperate-hover"></span></p>
                            <p class="service-title-hover">异业合作</p>
                            <a class="service-btn-hover" href="/home/index/inquiry">我要咨询</a>
                        </div>
                    </li>
                    <li class="service-more">
                        <p>更多服务项目<br />敬请期待</p>
                        <p><span></span></p>
                    </li>
                </ul>
            </div>
        </div>

        <div class="recommend-box w1180">
            <div class="common-title">
                <div class="english-title">Model Query</div>
                <div class="chinese-title">车型推荐</div>
            </div>

            <div class="recommend-carbox">
                <div class="swiper-tabs">
                <#if mobileInformation??>
                    <#if mobileInformation?size gt 0>
                        <#list mobileInformation as info>
                        <a target="_blank">${info.introduceName}<spn class="swiper-curbd"></spn></a>
                        </#list>
                    </#if>
                </#if>
                </div>
                <div class="layui-carousel" id="test1" lay-filter="test1">
                    <div carousel-item="">
                        <#if mobileInformation??>
                            <#if mobileInformation?size gt 0>
                                <#list mobileInformation as info>
                                      <div style="background-color: white" class="swiper-slide">
                                          <img style="width: 900px; height: 450px;"  src="/photo/view?filename=${info.automobilePicturePath}">
                                          <p style="display: inline-block">${info.introduceName}</p>
                                      </div>
                                </#list>
                            </#if>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="recommend-btnbox">
                <a class="recommend-consult" href="/home/index/inquiry">我要询价&nbsp;&nbsp;&gt;</a>
            </div>
        </div>
        <div class="recommend-box w1181">
            <p></p>
            <p></p>
            <p></p>
            <p></p>
        </div>
    </article>
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
</body>
<script src="/home/js/jquery.min.js"></script>
<script src="/home/js/idangerous.swiper2.7.6.js"></script>
<script src="/home/js/jquery.kinmaxshow-1.1.min.js"></script>
<script src="/home/js/slide_verify.js"></script>
<script src="/home/js/corporate.js"></script>
<script src="/home/js/jsencrypt.js"></script>
<script src="/home/layui/layui.all.js"></script>
<script src="/home/js/msg.js"></script>
<script>

    $(document).ready(function () {
        $(".swiper-tabs").find('a').eq(0).addClass('active');
        $(".swiper-tabs").find('a').eq(0).prev().removeClass('active');
    });
    layui.use(['carousel', 'form'], function(){
        var carousel = layui.carousel
                ,form = layui.form;
        //图片轮播
        carousel.render({
            elem: '#test1'
            ,width: '1180px'
            ,height: '550px'
            ,interval: 5000
            ,indicator:'none'
        });
        //监听轮播切换事件
        carousel.on('change(test1)', function(obj){ //test1来源于对应HTML容器的 lay-filter="test1" 属性值
            console.log(obj.index); //当前条目的索引
            console.log(obj.prevIndex); //上一个条目的索引
            console.log(obj.item); //当前条目的元素对象
            $(".swiper-tabs").find('a').eq(obj.index).siblings().removeClass('active');
            $(".swiper-tabs").find('a').eq(obj.index).addClass('active');
        });
    });
</script>
<script>
    //跳转至企业注册
    function enterpriseRegister() {
        location.href = "/home/index/enterpriseRegister";
    }
    //验证码刷新
    function imgRandom(thisImg){
        thisImg.src=thisImg.src+'&d='+Math.random();
    }
    var userIdNumberInfo = '';
    function close1(){
        $(".login-register-popup").addClass("hide");
    }
    function onunload() {
        var userInfo = null;
        <#if deskUserInfo??>
            <#if deskUserInfo.idNumber??>
                userInfo='${deskUserInfo.idNumber}';
            </#if>
        </#if>
    }
    $(document).ready(function () {
        $(".popup-close").click(function () {
            $(".login-register-popup").addClass("hide");
        });
        //初始化验证码
        imgRandom($("#logincaptcha"));
        var userAddressInfo = '';
    <#if deskUserInfo??>
        <#if deskUserInfo.eccAddress??>
            userAddressInfo='${deskUserInfo.eccAddress}';
        </#if>
        <#if deskUserInfo.idNumber??>
            userIdNumberInfo='${deskUserInfo.idNumber}';

        </#if>
    </#if>
        $(".layui-textarea").text(userAddressInfo);
        var user = '';
		<#if deskUser??>
			user = '${deskUser}';
        </#if>
        if(user!=null&user!=""){
            $("#spanLogined").removeClass("hide");
            $("#spanLogin").addClass("hide");
            $(".popup-right").addClass("hide");
            close1();
            onunload();
        }
    });
    //提交登录
    function login() {
        var phone = $("#phone").val().trim();
        var password = $("#password").val().trim();
        var code = $("#recode2").val().trim();
        if(phone.length == 0)
        {
            errorMsg("手机号不能为空", {icon: 5});
            return false;
        }
        if(password.length == 0)
        {
            errorMsg("密码不能为空", {icon: 5});
            return false;
        }
        if(code.length == 0)
        {
            errorMsg("验证码不能为空", {icon: 5});
            return false;
        }
        //手机号正则验证
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        if(!chkphone.test(phone))
        {
            errorMsg("请输入正确的手机号");
            return ;
        }
        $.ajax({
            type: "POST",
            url: '/home/index/dulogin',
            data: {phone:phone, password:password, code:code},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.code == 0) {
                    successMsg("登录成功");
                    setTimeout(function()
                    {
                        location.href = "/home/index/enterpriseService";
                    }, 1000);
                }
                else
                {
                    //alert(data.msg);
                    errorMsg(data.msg);
                }
            }
        });
    }
    //打开忘记密码对话框
    function openDialog1() {
        var dlgContent = $('.simple_dlg_define').html(); // 窗口内容
        layer.open({
            type: 1,
            title: '忘记密码',
            area: ['420px', 'auto'],
            content: dlgContent,
            btn: ['修改', '取消'],
            btn1: function (index, layero) {
                var phone = $('.phone',layero).val().trim();
                var demail = $('.demail', layero).val().trim();
                var password = $('.password', layero).val().trim();
                var password2 = $('.password2', layero).val().trim();
                forgetPwd1(phone,demail, password, password2, index);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };
    //忘记密码
    function forgetPwd1(phone,demail, password, verPassword, index) {
        if(phone.length == 0)
        {
            errorMsg("请输入手机号");
            return ;
        }
        if (demail.length==0){
            errorMsg("请输入电子邮箱");
            return ;
        }
        if(password.length == 0)
        {
            errorMsg("请输入密码");
            return ;
        }

        if(verPassword.length == 0)
        {
            errorMsg("请输入确认密码");
            return ;
        }
        if(password != verPassword)
        {
            errorMsg("密码不一致");
            return ;
        }
        //手机号正则验证
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        if(!chkphone.test(phone))
        {
            errorMsg("请输入正确的手机号");
            return ;
        }
        //电子邮箱验证
        var chkemail = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/;
        if (!chkemail.test(demail)){
            errorMsg("请输入正确的电子邮箱");
            return ;
        }
        $.ajax({
            url:'forgetPwd',
            type:'POST',
            data:{phone:phone,demail:demail, password:password,ver_password:verPassword},
            dataType:'json',
            success:function(data){
                if(data.code == 0)
                {
                    successMsg("修改成功");
                    layer.close(index);
                }
                else
                {
                    errorMsg(data.msg);
                }
            },
            error:function(data){
                errorMsg('网络错误!');
            }
        });
    }
</script>
</html>
