
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>个人中心</title>
    <link href="/home/css/header.css" rel="stylesheet" />
    <link href="/home/css/simplefooter.css" rel="stylesheet"/>
    <link href="/home/css/personalLogin.css" rel="stylesheet" />
    <link rel="dns-prefetch" href="//online2.map.bdimg.com">
    <link rel="dns-prefetch" href="//cdnmaster.com">
    <link rel="dns-prefetch" href="//cms.gtags.net">
    <link href="/home/layui/css/layui.css" rel="stylesheet" />
    <link href="/home/css/global.css" rel="stylesheet" />
    <link href="/home/css/base.css" rel="stylesheet" />
    <style>
        .pane p{
            width: 100%;
            text-align: center;
            color:red;
            margin-top: 15px;
        }
        .ui-bfc-hd{
            margin-left: 20px;
        }
        .ui-bfc-jz{
            margin-left: 20px;
        }
        .desk-user-image{
            margin-left: -2px;
            width: 101px;
            height: 101px;
        }
        .desk-user-image:hover {
            transform: scale(1.10);
            transition: all 0.3s ease-in-out;
            z-index: 100;
            background-color: #fff;
        }
        #BtnOptlicense{
            margin-left: -55px;
        }
        .layui-layer-page .layui-layer-content {
            overflow: visible !important;
        }
    </style>
</head>
<body>
<div>
    <div class="header">
        <div class="header">
            <div class="head-top">
                <div class="w1180 top-linkbox clear_float">
                    <div class="top-link fl">
							<span id="spanLogin" class="">
								<a id="linkLogin" class="top-link-bold" onclick="linkLogin()"  rel="nofollow">登录</a>
								<span>|</span>
								<a id="front-desk-register" onclick="registerSwitch()" class="top-link-bold" id  rel="nofollow">免费注册</a>
							</span>
                        <span id="spanLogined" class="hide">
								<span>
                            你好,<#if deskUser??>
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
                        <a href="/home/index/info">个人中心</a>
                    </div>
                </div>
            </div>
            <div class="head-bottom">
                <div class="w1180">
                    <div class="nav">
                        <ul class="nav-wrap clear_float" id="J_NavBox">
                            <li><a href="/home/index/index" target="_top">自驾租车</a><span></span></li>
                            <li><a href="/home/index/enterpriseService" target="_top">企业服务</a><span></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="crumbs">
        <div class="crumbs-bd">
            当前位置：
            <a href="/home/index/info">个人中心</a> &gt;
            用户信息
        </div>
    </div><!-- /crumbs -->

    <div id="content">
        <div class="content-bd">
            <div class="col-main">
                <link rel="stylesheet" href="" />
                <div class="information">
                    <h2>企业信息</h2>
                    <div class="mod information-index">
                        <div class="ui-bfc information-index-panel">
                            <div class="ui-bfc-hd hd">
                                <#if deskUserEnInfo.enterprisePic??>
                                     <#if deskUserEnInfo.enterprisePic?length gt 0>
                                          <img src="/photo/view?filename=${deskUserEnInfo.enterprisePic}" class="desk-user-image" id="upload_enPic">
                                     <#else>
                                          <img src="/admin/images/default-head.jpg" class="desk-user-image" id="upload_enPic">
                                     </#if>
                                <#else>
                                    <img src="/admin/images/default-head.jpg" class="desk-user-image" id="upload_enPic">
                                </#if>
                            </div>
                            <div class="ui-bfc-bd bd">
                                <table width="100%">
                                    <tr>
                                        <td class="cell-title">电子邮件：</td>
                                        <td>
                                            <p>
                                               <#if deskUser??>
                                                 ${deskUser.demail}
                                               </#if>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cell-title">手机号：</td>
                                        <td>
                                            <p id="hide_phone"></p>
                                             <#if deskUser??>
                                                 <#if deskUser.phone??>
                                                 <a href="javascript:openPhone()">修改</a>
                                                 </#if>
                                             </#if>
                                        </td>
                                    <tr>
                                        <td colspan="2">
                                            <div class="dashed-border"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cell-title">企业名：</td>
                                        <td>
                                            <#if deskUserEnInfo??>
                                                <#if deskUserEnInfo.enterpriseName??>
                                                    ${deskUserEnInfo.enterpriseName}
                                                </#if>
                                            </#if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cell-title">企业账号：</td>
                                        <td>
                                            <#if deskUserEnInfo??>
                                                <#if deskUserEnInfo.enterpriseNo??>
                                                     <p>
                                                         ${deskUserEnInfo.enterpriseNo}
                                                     </p>
                                                </#if>
                                            </#if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="dashed-border"></div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="ui-bfc-jz">
                                <table width="100%">
                                    <tbody>
                                    <tr>
                                        <td class="cell-title">驾驶证认证：</td>
                                        <#if deskUser??>
                                            <#if deskUser.deskUserDriverInfo??>
                                                <#if deskUser.deskUserDriverInfo.driverNumber??>
                                                 <td>
                                                     <p>已上传</p>
                                                 </td>
                                                <#else>
                                                <td>
                                                    <p>未上传</p>
                                                    <a id="BtnOptlicense" href="javascript:openUpdDInfo()">编辑</a>
                                                </td>
                                                </#if>
                                            <#else>
                                            <td>
                                                <p>未上传</p>
                                                <a id="BtnOptlicense" href="javascript:openUpdDInfo()">编辑</a>
                                            </td>
                                            </#if>
                                        <#else>
                                        <td>
                                            <p>未上传</p>
                                            <a id="BtnOptlicense" href="javascript:openUpdDInfo()">编辑</a>
                                        </td>
                                        </#if>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="operate-panel">
                            <a class="ui-btn ui-btn-white-l" href="javascript:openUpdPwd()">修改密码</a>
                        </div>
                    </div>
                </div>
            </div>
            <!--站点导航-->
            <div class="col-sub">
                <dl class="sub-nav">
                    <dt>我的订单</dt>
                    <dd>
                        <a class="" href="/home/index/myOrders">订单管理</a>
                    </dd>
                    <dt>个人中心</dt>
                    <dd>
                        <a class="ck" href="/home/index/info">用户信息</a>
                    </dd>
                </dl>
            </div>
        </div>
    </div>
</div>
<#--修改手机号-->
<div class='simple_dlg_define' id="updPhone" style='display:none'>
    <div class='pane' style='padding:16px'>
        <div class="layui-form-item">
            <label class="layui-form-label">请输入原手机号:</label>
            <div class="layui-input-block">
                <input class='layui-input phone1' type='text' placeholder="请输入原手机号">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">请输入登录密码:</label>
            <div class="layui-input-block">
                <input class='layui-input password1' type='password' placeholder="请输入登录密码">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">请输入新手机号:</label>
            <div class="layui-input-block">
                <input class='layui-input newPhone1' placeholder="请输入新手机号">
            </div>
        </div>
    </div>
</div>
<#--修改企业信息-->
<div class='simple_dlg_define' id="info" style='display:none'>
    <div class='pane' style='padding:16px'>
        <div class="layui-form-item">
            <label class="layui-form-label">真实姓名:</label>
            <div class="layui-input-block">
                <input class='layui-input idCardName' type='text' name="idCardName" placeholder="请输入您的真实姓名">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">证件信息:</label>
            <div class="layui-input-block">
                <input class='layui-input idNumber' name="idNumber" placeholder="请输入您的身份证号">
            </div>
        </div>
        <p>身份证信息一旦认证不可修改</p>
    </div>
</div>
<#--修改密码-->
<div class='simple_dlg_define' id="updatePwd" style='display:none'>
    <div class='pane' style='padding:16px'>
        <div class="layui-form-item">
            <label class="layui-form-label">原密码:</label>
            <div class="layui-input-block">
                <input class='layui-input pwd' type='password' name="pwd" placeholder="请输入原密码">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码:</label>
            <div class="layui-input-block">
                <input class='layui-input newPwd' type='password' name="newPwd"  placeholder="请输入新密码">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认新密码:</label>
            <div class="layui-input-block">
                <input class='layui-input reNewPwd' type='password' name="reNewPwd"  placeholder="请确认新密码">
            </div>
        </div>
    </div>
</div>
<#--上传驾驶证信息-->
<div class='simple_dlg_define' id="updateDInfo" style='display:none'>
    <div class='pane  layui-form' style='padding:16px'>
        <div class="layui-form-item">
            <label class="layui-form-label">驾驶证号:</label>
            <div class="layui-input-block">
                <input class='layui-input driverNumber' type='text' name="reNewPwd"  placeholder="请输入驾驶证号">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">准驾车型:</label>
            <div class="layui-input-block">
                <select class="mySelect" name="drivingModel.carModel">
                    <option value="">请选择准驾车型</option>
                        <#if all??>
                            <#if all?size gt 0>
                                <#list all as dModel>
                                     <option value="${dModel.id}">${dModel.carModel}</option>
                                </#list>
                            </#if>
                        </#if>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">驾驶证领取日期:</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input test start" id="test1" placeholder="请选择驾驶证领取日期">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">驾驶证有效期:</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input test end" id="test2"  placeholder="请选择驾驶证有效期">
            </div>
        </div>
    </div>
</div>

<script src="/home/layui/layui.js"></script>
<script src="/home/js/jquery.min.js"></script>
<script src="/home/js/msg.js"></script>
<script src="/home/js/star.js"></script>
<script>
    var M = {};
    function linkLogin(){
        $(".login-register-popup").removeClass("hide");
        $(".popup-logininfo").removeClass("hide");
        $(".popup-registerinfo").addClass("hide");
    }
    function registerSwitch(){
        $(".login-register-popup").removeClass("hide");
        $(".popup-logininfo").addClass("hide");
        $(".popup-registerinfo").removeClass("hide");
    }
    function loginSwitch(){
        $(".popup-logininfo").removeClass("hide");
        $(".popup-registerinfo").addClass("hide");
    }
    function close1(){
        $(".login-register-popup").addClass("hide");
    }
    $(document).ready(function () {
    $(".popup-close").click(function () {
        $(".login-register-popup").addClass("hide");
    });
    var enNo = '';
    //给手机号显示为 只能看到前三位和后三位的形式
    var userPhone = '';
        <#if deskUser??>
            <#if deskUser.phone??>
                userPhone = '${deskUser.phone}';
            </#if>
        </#if>
    M.photo = mobile_hide(userPhone);
    $("#hide_phone").text(M.photo);

    var user = '';
		<#if deskUser??>
			user = '${deskUser}';
        </#if>
    if(user!=null&&user!=""){
        $("#spanLogined").removeClass("hide");
        $("#spanLogin").addClass("hide");
        close1();
    }
    });
    //退出登录,用于修改密码
    function logout() {
        location.href="/home/index/dulogout";
    }
    layui.use(['upload','form'],function () {
       var upload = layui.upload;
       var form = layui.form;
       //修改头像
       upload.render({
           elem: '#upload_enPic',
           url: '/upload/home_upload_photo', //改成您自己的上传接口,
           size: 1024 * 2,
           accept: 'images',
           done: function (res) {
               if (res.code == 0) {
                   $.ajax({
                       url: 'update_enPic',
                       type: 'POST',
                       data: {enPic: res.data},
                       dataType: 'json',
                       success: function (data) {
                           if (data.code == 0) {
                               $("#upload_enPic").attr("src", "/photo/view?filename=" + res.data);
                               layer.msg("上传成功", {icon: 1});
                           }
                           else {
                               layer.msg("修改失败" + data.msg, {icon: 5});
                           }
                       },
                       error: function (data) {
                           layer.msg('网络错误!');
                       }
                   });
               }
           }
       });
       form.render();
    });
    //打开修改手机号对话框
    function openPhone() {
        var dlgContent = $('#updPhone').html(); // 窗口内容
        layer.open({
            type: 1,
            title: '修改手机号',
            area: ['420px', 'auto'],
            content: dlgContent,
            btn: ['修改', '取消'],
            btn1: function (index, layero) {
                var phone = $('.phone1',layero).val().trim();
                var password = $('.password1',layero).val().trim();
                var newPhone = $('.newPhone1', layero).val().trim();
                updPhone(phone,password,newPhone);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };
    //修改手机号
    function updPhone(phone,password, newPhone) {
        if(phone.length==0) {
            layer.msg("请输入原手机号");
            return ;
        }
        if(newPhone.length==0){
            layer.msg("请输入新手机号");
            return ;
        }
        if (password.length==0){
            layer.msg("请输入登录密码");
            return ;
        }
        if (phone == newPhone){
            layer.msg("两次输入手机号不能一致");
            return ;
        }
        //手机号正则验证
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        if(!chkphone.test(phone)) {
            layer.msg("请输入正确的手机号");
            return ;
        }
        if(!chkphone.test(newPhone)) {
            layer.msg("请输入正确的手机号");
            return ;
        }
        $.ajax({
            url:'updPhone',
            type:'POST',
            data:{phone:phone,password:password,newPhone:newPhone},
            dataType:'json',
            success:function(data){
                if(data.code == 0)
                {
                    layer.msg("修改成功,请从新登陆");
                    layer.close(index);
                    logout();
                }
                else
                {
                    layer.msg(data.msg);
                }
            },
            error:function(data){
                layer.msg('网络错误!');
            }
        });
    }
    //打开修改密码对话框
    function openUpdPwd() {
        var dlgContent = $('#updatePwd').html(); // 窗口内容
        layer.open({
            type: 1,
            title: '修改密码',
            area: ['550px', 'auto'],
            content: dlgContent,
            btn: ['修改', '取消'],
            btn1: function (index, layero) {
                var pwd = $('.pwd',layero).val().trim();
                var newPwd = $('.newPwd', layero).val().trim();
                var reNewPwd = $('.reNewPwd', layero).val().trim();
                updatePwd(pwd,newPwd,reNewPwd,index);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };
    //修改密码
    function updatePwd(pwd,newPwd,reNewPwd, index) {
        if (pwd.length==0){
            layer.msg("请输入原密码");
            return ;
        }
        if (newPwd.length==0){
            layer.msg("请输入新密码");
            return ;
        }
        if (reNewPwd.length==0){
            layer.msg("请确定新密码");
            return ;
        }
        if (newPwd.length<4||newPwd.length>16){
            layer.msg("密码长度为4-16位");
            return ;
        }
        if (reNewPwd.length<4||reNewPwd.length>16){
            layer.msg("密码长度为4-16位");
            return ;
        }
        if(!newPwd==reNewPwd){
            layer.msg("两次输入的新密码不一致");
            return ;
        }
        $.ajax({
            url:'update_password',
            type:'POST',
            data:{pwd:pwd,newPwd:newPwd,reNewPwd:reNewPwd},
            dataType:'json',
            success:function(data){
                if(data.code == 0)
                {
                    layer.msg("修改成功,请重新登录");
                    setTimeout(function () {
                        layer.close(index);
                        logout();
                    },1000);
                }
                else
                {
                    layer.msg(data.msg);
                }
            },
            error:function(data){
                layer.msg('网络错误!');
            }
        });
    }
    //打开驾驶证信息对话框
    function openUpdDInfo() {
        var dlgContent = $('#updateDInfo').html(); // 窗口内容
        layer.open({
            type: 1,
            title: '编辑驾驶证信息',
            area: ['600px', 'auto'],
            content: dlgContent,
            btn: ['编辑', '取消'],
            success: function(index,layero){
                layui.use(['laydate','form'],function () {
                    var laydate = layui.laydate;
                    var form1 = layui.form;
                    form1.render();
                    lay('.test').each(function(){
                        laydate.render({
                            elem: this
                            ,format:'yyyy-MM-dd'
                            ,trigger: 'click'
                        });
                    });
                });
            },
            btn1: function (index, layero) {
                var driverNumber = $('.driverNumber',layero).val();
                var carModel = $('.mySelect', layero).val();
                var start = $('.start', layero).val();
                var end = $('.end', layero).val();
                updateDInfo(driverNumber,carModel,start,end,index);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };
    //修改驾驶证信息
    function  updateDInfo(driverNumber,carModel,start,end,index) {
        if (driverNumber.length==0){
            layer.msg("请输入驾驶证号");
            return ;
        }
        if (carModel.length==0){
            layer.msg("请选择准驾车型");
            return ;
        }
        if(start.length==0){
            layer.msg("请选择驾驶证领取日期:");
            return ;
        }
        if(end.length==0){
            layer.msg("请选择驾驶证有效期");
            return ;
        }
        var chkDriverNumber = /(\d{12})$/;
        if (!chkDriverNumber.test(driverNumber)){
            layer.msg("驾驶证号格式不正确");
            return ;
        }
        $.ajax({
            url:'/home/index/update_dInfo',
            type:'POST',
            data:{driverNumber:driverNumber,carModel:carModel,start:start,end:end},
            dataType:'json',
            success:function(data){
                if(data.code == 0)
                {
                    layer.msg("修改成功");
                    setTimeout(function () {
                        layer.close(index);
                        location.href="/home/index/info";
                    },1000);
                }
                else
                {
                    layer.msg(data.msg);
                }
            },
            error:function(data){
                layer.msg('网络错误!');
            }
        });
    }
</script>
<script type="text/javascript">
    var userVerify = "True";
    var Url = {
        EmergencyContact: '/UserCenter/MyInfo/EmergencyContact',
        SubmitEmergencyContact: '/UserCenter/MyInfo/SubmitEmergencyContact',
        DrivingLicense: '/UserCenter/MyInfo/DrivingLicense',
        ValidateImageFront: '/UserCenter/MyInfo/ValidateImageFront',
        AuthImage:'/UserCenter/MyInfo/DrivingLicenceAuth',
        MyInfo: '/UserCenter',
        UploadImage: '/UserCenter/MyInfo/UploadImage',
        UpdateIdCardInfo: '/UserCenter/MyInfo/UpdateIdCardInfo',
        DeleteDrivingLicense:'/UserCenter/MyInfo/DeleteDrivingLicense'
    };
</script>
<script>
    $(function () {
        $(".sel-year").click(function () {
            $(".card-year-sel").show();
            $(".card-month-sel").hide();
            $(".card-day-sel").hide();
        });
        $(".sel-month").click(function () {
            $(".card-month-sel").show();
            $(".card-year-sel").hide();
            $(".card-day-sel").hide();
        });
        $(".sel-day").click(function () {
            $(".card-day-sel").show();
            $(".card-year-sel").hide();
            $(".card-month-sel").hide();
        });

        //证件号
        $(".sel-card").click(function () {
            var isauth = $(this).data('isauth');
            $(".card-type-sel").show();
        });
        $(".card-type-sel span").mousedown(function () {
            var $this = $(this);
            $(".sel-card").val($this.text()).attr("id", this.id);
            $("#idCardType").val($this.data("type"));
            var type = $this.data("type");
            if (type !== 1010101) {
                $('.card-birthday').show();
                $('.card-tips').hide();
            } else if (type === 1010101) {
                $('.card-birthday').hide();
                $('.card-tips').show();
            }
            $(".card-type-sel").hide();
        });

        $(document).click(function (e) {
            if ($(e.target).is(".card-type-sel,.sel-card")) {
                return false;
            }
            $(".card-type-sel").hide();
        });
    });

    if (!String.prototype.trim) {
        String.prototype.trim = function () {
            return this.replace(/^\s+|\s+$/g, '');
        }
    }
</script>
<script type="text/javascript">
    $.ajaxSetup({
        statusCode: {
            800: function (data) {
                window.location.href = '/LoginOrRegister';
            }
        }
    });
</script>
<script>
    (function (para) {
        var p = para.sdk_url, n = para.name, w = window, d = document, s = 'script', x = null, y = null;
        if (typeof (w['sensorsDataAnalytic201505']) !== 'undefined') {
            return false;
        }
        w['sensorsDataAnalytic201505'] = n;
        w[n] = w[n] || function (a) { return function () { (w[n]._q = w[n]._q || []).push([a, arguments]); } };
        var ifs = ['track', 'quick', 'register', 'registerPage', 'registerOnce', 'trackSignup', 'trackAbtest', 'setProfile', 'setOnceProfile', 'appendProfile', 'incrementProfile', 'deleteProfile', 'unsetProfile', 'identify', 'login', 'logout', 'trackLink', 'clearAllRegister', 'getAppStatus'];
        for (var i = 0; i < ifs.length; i++) {
            w[n][ifs[i]] = w[n].call(null, ifs[i]);
        }
        if (!w[n]._t) {
            x = d.createElement(s), y = d.getElementsByTagName(s)[0];
            x.async = 0;
            x.src = p;
            x.setAttribute('charset', 'UTF-8');
            y.parentNode.insertBefore(x, y);
            w[n].para = para;
        }
    })({
        sdk_url: 'https://static.sensorsdata.cn/sdk/1.12.3/sensorsdata.min.js',
        heatmap_url: 'https://static.sensorsdata.cn/sdk/1.12.3/heatmap.min.js',
        name: 'ehiSensors',
        web_url: 'https://sensors.1hai.cn:9443/?project=production',
        server_url: 'https://sensors.1hai.cn:11621/sa?project=production',
        heatmap: {}
    });
</script>
</body>
</html>
