
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>个人中心</title>
    <link href="/home/layui/css/layui.css" rel="stylesheet" />
    <link href="/home/css/header.css" rel="stylesheet" />
    <link href="/home/css/simplefooter.css" rel="stylesheet"/>
    <link href="/home/css/personalLogin.css" rel="stylesheet" />
    <link rel="dns-prefetch" href="//online2.map.bdimg.com">
    <link rel="dns-prefetch" href="//cdnmaster.com">
    <link rel="dns-prefetch" href="//cms.gtags.net">
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
        #BtnOptlicense,#BtnOptContact,#idCardAdd{
            margin-left: -55px;
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
                <link rel="stylesheet" href="/Content/bootstrap-datetimepicker.min.css" />
                <div class="information">
                    <h2>用户信息</h2>
                    <div class="mod information-index">
                        <div class="ui-bfc information-index-panel">
                            <div class="ui-bfc-hd hd">
                                <#if deskUserInfo.headPic??>
                                     <#if deskUserInfo.headPic?length gt 0>
                                          <img src="/photo/view?filename=${deskUserInfo.headPic}" class="desk-user-image" id="upload_headPic">
                                     <#else>
                                          <img src="/admin/images/default-head.jpg" class="desk-user-image" id="upload_headPic">
                                     </#if>
                                <#else>
                                    <img src="/admin/images/default-head.jpg" class="desk-user-image" id="upload_headPic">
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
                                        <td class="cell-title">手机号码：</td>
                                        <td>
                                            <p id="hide"></p>
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
                                        <td class="cell-title">姓名：</td>
                                        <td>
                                            <#if deskUserInfo??>
                                                <#if deskUserInfo.idCardName??>
                                                    ${deskUserInfo.idCardName}
                                                </#if>
                                            </#if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cell-title">证件号码：</td>
                                        <td>
                                            <#if deskUserInfo??>
                                                <#if deskUserInfo.idNumber??>
                                                     <p id="idHide">

                                                     </p>
                                                <#else>
                                                <p></p>
                                                <a class="card-revise" id="idCardAdd" href="javascript:openDialog();" data-toggle="modal" data-target="#myModal">添加</a>
                                                </#if>
                                            <#else>
                                                <p></p>
                                                <a class="card-revise" id="idCardAdd" href="javascript:openDialog();" data-toggle="modal" data-target="#myModal">添加</a>
                                            </#if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cell-title">生日：</td>
                                        <td id="BirthdayTd" ></td>
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
                                    <tr>
                                        <td class="cell-title">紧急联系人姓名：</td>
                                        <td>
                                            <p>
                                                <#if deskUserInfo??>
                                                    <#if deskUserInfo.ecName??>
                                                         ${deskUserInfo.ecName}
                                                    </#if>
                                                </#if>
                                            </p>
                                            <a id="BtnOptContact" href="javascript:openEcInfo()">编辑</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cell-title">紧急联系人手机：</td>
                                        <td>
                                            <p>
                                                <#if deskUserInfo??>
                                                    <#if deskUserInfo.eccPhone??>
                                                        ${deskUserInfo.eccPhone}
                                                    </#if>
                                                </#if>
                                            </p>
                                        </td>
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
<#--完善个人信息	-->
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
<#--紧急联系人-->
<div class='simple_dlg_define' id="ecInfo" style='display:none'>
    <div class='pane' style='padding:16px'>
        <div class="layui-form-item">
            <label class="layui-form-label">紧急联系人姓名:</label>
            <div class="layui-input-block">
                <input class='layui-input ecName' type='text' name="ecName" <#if deskUserInfo.ecName??>value="${deskUserInfo.ecName}"</#if> placeholder="请输入紧急联系人姓名">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">紧急联系人手机:</label>
            <div class="layui-input-block">
                <input class='layui-input ecPhone' name="ecPhone" <#if deskUserInfo.eccPhone??>value="${deskUserInfo.eccPhone}"</#if> placeholder="请输入紧急联系人手机">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">紧急联系人住址:</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea ecAddress" name="ecAddress" placeholder="请输入紧急联系人住址"><#if deskUserInfo.eccAddress??>${deskUserInfo.eccAddress}</#if></textarea>
            </div>
        </div>
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
    <div class='pane' style='padding:16px'>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名:</label>
            <div class="layui-input-block">
                <input class='layui-input layui-disabled' disabled type='text' name="name" <#if deskUserInfo.idCardName??>value="${deskUserInfo.idCardName}"</#if> >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">身份证号:</label>
            <div class="layui-input-block">
                <input class='layui-input layui-disabled' disabled type='text' name="idNumber" <#if deskUserInfo.idNumber??>value="${deskUserInfo.idNumber}"</#if> >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">驾驶证号:</label>
            <div class="layui-input-block">
                <input class='layui-input driverNumber' type='text' name="reNewPwd"  placeholder="请输入驾驶证号">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">准驾车型:</label>
            <div class="layui-input-block">
                <select class="form-control mySelect" name="drivingModel.carModel" style="height: 38px">
                    <option value="">---请选择准驾车型---</option>
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
    var userIdNumberInfo = '';
    var M = {};
    M.flag = false;
    function close1(){
        $(".login-register-popup").addClass("hide");
    }
    // 根据身份证截取生日
    function getBirth(idCard) {
        var birthday = "";
        if (idCard != null && idCard != "") {
            if (idCard.length == 15) {
                birthday = "19" + idCard.slice(6, 12);
            } else if (idCard.length == 18) {
                birthday = idCard.slice(6, 14);
            }
            birthday = birthday.replace(/(.{4})(.{2})/, "$1-$2-");
            //通过正则表达式来指定输出格式为:1990-01-01
        }
        return birthday;
    }
    function onunload() {
        var userInfo = null;
        <#if deskUserInfo??>
            <#if deskUserInfo.idNumber??>
                userInfo='${deskUserInfo.idNumber}';
            </#if>
        </#if>
        var birth = getBirth(userInfo);
        $("#BirthdayTd").text(birth);
    }
    $(document).ready(function () {
    $(".popup-close").click(function () {
        $(".login-register-popup").addClass("hide");
    });
    var userId = '';
    var userPhone = '';
    <#if deskUser??>
        <#if deskUser.phone??>
            userPhone = '${deskUser.phone}';
        </#if>
    </#if>

    $("#hide").text(mobile_hide(userPhone));
    <#if deskUserInfo??>
        <#if deskUserInfo.idNumber??>
            userId = '${deskUserInfo.idNumber}';
        </#if>
    </#if>
    $("#idHide").text(mobile_hide(userId));
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
        close1();
        onunload();
    }
    });
    //退出登录,用于修改密码
    function logout() {
        location.href="/home/index/dulogout";
    }
    layui.use('upload',function () {
       var upload = layui.upload;
       //修改头像
       upload.render({
           elem: '#upload_headPic',
           url: '/upload/home_upload_photo', //改成您自己的上传接口,
           size: 1024 * 2,
           accept: 'images',
           done: function (res) {
               if (res.code == 0) {
                   $.ajax({
                       url: 'update_headPic',
                       type: 'POST',
                       data: {headPic: res.data},
                       dataType: 'json',
                       success: function (data) {
                           if (data.code == 0) {
                               $("#upload_headPic").attr("src", "/photo/view?filename=" + res.data);
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
    //打开添加证件信息对话框
    function openDialog() {
        var dlgContent = $('#info').html(); // 窗口内容
        layer.open({
            type: 1,
            title: '添加证件及姓名信息',
            area: ['420px', 'auto'],
            content: dlgContent,
            btn: ['添加', '取消'],
            btn1: function (index, layero) {
                var idCardName = $('.idCardName',layero).val().trim();
                var idNumber = $('.idNumber', layero).val().trim();
                addInfo(idCardName,idNumber,index);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };
    //添加证件信息
    function addInfo(idCardName,idNumber, index) {
        if(idCardName.length==0) {
            layer.msg("请输入您的真实姓名");
            return ;
        }
        if (idNumber.length==0){
            layer.msg("请输入您的身份证号");
            return ;
        }
        var chkidNumber = /^[1-9]\d{5}(18|19|20|(3\d))\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
        if (!chkidNumber.test(idNumber)){
            layer.msg("请输入正确的身份证号");
            return ;
        }
        $.ajax({
            url:'updateInfo',
            type:'POST',
            data:{idCardName:idCardName,idNumber:idNumber},
            dataType:'json',
            success:function(data){
                if(data.code == 0)
                {
                    layer.msg("添加成功");
                    layer.close(index);
                    location.href="/home/index/info";
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
    //打开添加紧急联系人信息对话框
    function openEcInfo() {
        var dlgContent = $('#ecInfo').html(); // 窗口内容
        layer.open({
            type: 1,
            title: '编辑紧急联系人信息',
            area: ['550px', 'auto'],
            content: dlgContent,
            btn: ['编辑', '取消'],
            btn1: function (index, layero) {
                var ecName = $('.ecName',layero).val().trim();
                var ecPhone = $('.ecPhone', layero).val().trim();
                var ecAddress = $('.ecAddress', layero).val().trim();
                addEcInfo(ecName,ecPhone,ecAddress,index);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };
    //添加证件信息
    function addEcInfo(ecName,ecPhone,ecAddress, index) {
        if (ecName.length==0){
            layer.msg("请填写紧急联系人姓名");
            return ;
        }
        if (ecPhone.length==0){
            layer.msg("请输入紧急联系人电话");
            return ;
        }
        if (ecAddress.length==0){
            layer.msg("请输入紧急联系人住址");
            return ;
        }

        //手机号正则验证
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        if(!chkphone.test(ecPhone)) {
            layer.msg("请输入正确的手机号");
            return ;
        }
        $.ajax({
            url:'updateEcInfo',
            type:'POST',
            data:{ecName:ecName,ecPhone:ecPhone,ecAddress:ecAddress},
            dataType:'json',
            success:function(data){
                if(data.code == 0)
                {
                    layer.msg("编辑成功");
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
        if (userIdNumberInfo.length == 0){
            layer.msg("身份证信息尚未验证");
            return ;
        }else {
            var dlgContent = $('#updateDInfo').html(); // 窗口内容
            layer.open({
                type: 1,
                title: '编辑驾驶证信息',
                area: ['600px', 'auto'],
                content: dlgContent,
                btn: ['编辑', '取消'],
                success: function(index,layero){
                    layui.use('laydate',function () {
                        var laydate = layui.laydate;
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
        }
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
    ehiSensors.registerPage({
        app_name: '一嗨租车PC'
    });
    ehiSensors.quick('autoTrack');
    var ehiid = "2029267313";
    if (ehiid.length > 0) {
        ehiSensors.login(ehiid);
    }
</script>
</body>
</html>
