<!DOCTYPE html>

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
    <style>
        .bd{
            height: 300px;
        }
        .hd{
            border: 1px solid #e7e7e7;
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
							<span id="spanLogin">
								<a id="linkLogin" class="top-link-bold" onclick="linkLogin()"  rel="nofollow">登录</a>
								<span>|</span>
								<a id="front-desk-register" onclick="registerSwitch()" class="top-link-bold" id  rel="nofollow">免费注册</a>
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
            <a href="/home/index/myOrders">订单列表</a> &gt;
            订单管理
        </div>
    </div><!-- /crumbs -->
    <div id="content">
        <div class="content-bd">
            <div class="col-main">
                <div class="orderdown">
                    <button id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        自驾订单
                        <span class="caret"></span>
                    </button>
                </div>
                <div class="J_TabSwitch order-list self-order">
                    <div class="hd clearfix">
                        <h2>自驾订单</h2>
                        <ul class="ui-tab-hd">
                            <li class="<#if type==5>ck </#if>"><a class="orderTab" data-table-class="all" id="all" href="javascript:void(0)">全部订单</a></li>
                            <li class="<#if type==1>ck</#if>"><a class="orderTab" data-table-class="reserving" id="reserving" href="javascript:void(0)">预约中</a></li>
                            <li class="<#if type==2>ck</#if>"><a class="orderTab" data-table-class="renting" id="renting" href="javascript:void(0)">租赁中</a></li>
                            <li class="<#if type==3>ck</#if>"><a class="orderTab" data-table-class="complete" id="complete" href="javascript:void(0)">已完成</a></li>
                            <li class="<#if type==0>ck</#if>"><a class="orderTab" data-table-class="canceled" id="canceled" href="javascript:void(0)">已取消</a></li>
                        </ul>
                    </div>
                    <div class="layui-tab-item layui-show">
                        <div class="layui-row layui-form">
                            <table class="layui-table">
                                <thead>
                                <tr>
                                    <th>汽车介绍名</th>
                                    <th>取车时间</th>
                                    <th>换车时间</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#if pageBean.content??>
                                    <#if pageBean.content?size gt 0>
                                        <#list pageBean.content as order>
                                            <tr>
                                                <td>${order.releaseVehicleInformation.automobileInformation.introduceName}</td>
                                                <td>${order.collectionTime?string("yyyy-MM-dd HH:mm")}</td>
                                                <td>${order.returnTime?string("yyyy-MM-dd HH:mm")}</td>
                                                <td>
                                                    <#if order.type==1>
                                                        预约中
                                                    <button data-method="offset" data-type="auto" class="layui-btn layui-btn-primary layui-btn-sm" value="取消" onclick="openDialog(${order.id})">取消</button>
                                                    <#elseif order.type==2>
                                                        租赁中
                                                    <#elseif order.type==3>
                                                        已完成
                                                    <#elseif order.type==0>
                                                        已取消
                                                    </#if>
                                                </td>
                                            </tr>
                                        </#list>
                                    <#else>
                                        <tr>
                                            <td colspan="4">您还没有订单，现在就去订车吧！</td>
                                        </tr>
                                    </#if>
                                <#else>
                                    <tr>
                                        <td colspan="4">您还没有订单，现在就去订车吧！</td>
                                    </tr>
                                </#if>
                                </tbody>
                            </table>
                        </div>
                        <div id="demo2">

                        </div>
                    </div>
                </div>
            </div>
            <!--站点导航-->
            <div class="col-sub">
                <dl class="sub-nav">
                    <dt>我的订单</dt>
                    <dd>
                        <a class=" ck" href="/home/index/myOrders">订单管理</a>
                    </dd>
                    <dt>个人中心</dt>
                    <dd>
                        <a class="" href="/home/index/info">用户信息</a>
                    </dd>
                </dl>
            </div>
            <!--站点导航-->
        </div>
    </div>
</div>
<#--紧急联系人-->
<div id="cancel" style="padding: 20px 100px;text-align: center">
</div>
<!-- Script -->
<script src="/home/layui/layui.all.js"></script>
<script src="/home/js/jquery.min.js"></script>
<script src="/home/js/msg.js"></script>

<script>
    //打开添加证件信息对话框
    function openDialog(id) {
        var dlgContent = $('#cancel').html(); // 窗口内容
        var id = id;
        layer.open({
            type: 1,
            title: '取消预约',
            area: ['200px', 'auto'],
            content: dlgContent,
            btnAlign: 'c',
            btn: ['确认', '取消'],
            btn1: function (index, layero) {
                cancel(id);
            },
            btn2: function (index, layero) {
                layer.close(index)
            }
        });
    };
    //取消预约按钮
    function cancel(id) {
        $.ajax({
            url:'cancelOrder',
            type:'POST',
            data:{id:id},
            dataType:'json',
            success:function(data){
                if(data.code == 0)
                {
                    layer.msg("取消成功");
                    location.href="/home/index/myOrders";
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
    var M = {};
    M.count = ${pageBean.total};
    M.curr = ${pageBean.currentPage};
    M.type =${type}
    layui.use('laypage', function(){
        var laypage = layui.laypage;

        laypage.render({
            elem: 'demo2' //注意，这里的 test1 是 ID，不用加 # 号
            ,count: M.count //数据总数，从服务端得到
            ,limit:${pageBean.pageSize}
            ,curr:M.curr
            ,jump: function(obj, first){
                //首次不执行
                if(!first){
                    M.curr = obj.curr;
                    location.href="/home/index/myOrders/?type="+M.type+"&currentPage="+obj.curr;
                }
            }
        });
    });
    function close1(){
        $(".login-register-popup").addClass("hide");
    }
    $(document).ready(function () {
        $(".popup-close").click(function () {
            $(".login-register-popup").addClass("hide");
        });
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
        if(user!=null){
            $("#spanLogined").removeClass("hide");
            $("#spanLogin").addClass("hide");
            close1();
        }
        //全部订单
        $('#all').click(function () {
            location.href = '/home/index/myOrders';
        });
        //预约中
        $('#reserving').click(function () {
            location.href = '/home/index/findOrder?type='+1;
        });
        //租赁中
        $('#renting').click(function () {
            location.href = '/home/index/findOrder?type='+2;
        });
        //已完成
        $('#complete').click(function () {
            location.href = '/home/index/findOrder?type='+3;
        });
        //已取消
        $('#canceled').click(function () {
            location.href = '/home/index/findOrder?type='+0;
        });
    });
    var URL = {
        getOrders: '/Order/MyOrders/Orders',
        backupOrders: '/Order/MyOrders/BackupOrders',
        getDriverOrders: '/Order/MyOrders/DriverOrders'
    };
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
</body>
</html>
