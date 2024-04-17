
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>询价|企业服务</title>
    <link href="/home/css/corporate_default.css" rel="stylesheet" />
    <link href="/home/css/corporate_book.css" rel="stylesheet" />
    <link href="/home/css/simplefooter.css" rel="stylesheet" />
    <link href="/home/layui/css/layui.css" rel="stylesheet" />
    <link rel="shortcut icon" href="/Content/img/favicon.ico" type="image/x-icon">
</head>
<style>
    .book-box-left ul .btn-box botton {
        margin-left: 4px;
        width: 120px;
        height: 35px;
        background: url(../images/book_btn.png) no-repeat;
        display: inline-block;
        margin-right: 20px;
        vertical-align: middle;
    }
</style>
<body>
<div class="ehai_page">
    <div class="header_helper">
        <a href='/home/index/index' target="">&lt; 返回首页</a>
    </div>
</div>
<form id="fmBook" action="">
    <div>
        <div class="main_content">
            <div class="book-box">
                <div class="book-box-left">
                    <div class="book-title">
                        询价单<span><em>*</em>为必填项</span>
                    </div>
                    <ul>
                        <li>
                            <span><em>*</em>您的上车时间</span>
                            <input type="text" name="boardingTime" id="test1">
                        </li>
                        <li>
                            <span><em>*</em>您的上车地点</span>
                            <input type="text" id="txtAboardCity" name="boardingLocation">
                            <input type="text" id="txtAboardAddress" name="boardingLocationNearby" class="address" placeholder="请输入附近的小区/街道" value="">
                        </li>
                        <li class="v-top">
                            <span><em></em>其他需求</span>
                            <textarea rows="2" cols="20" id="txtContents" name="demand" class="txt-area" scroll="no"></textarea>
                        </li>
                        <li>
                            <span><em>*</em>您的姓名</span><input type="text" id="txtCustomerName" name="name">
                        </li>
                        <li>
                            <span><em>*</em>您的电话</span><input type="text" id="txtCustomerPhone" name="phone">
                        </li>
                        <li>
                            <span><em>*</em>电子邮件</span>
                            <input type="text" id="txtCustomerEmail" name="email">
                        </li>
                        <li>
                            <span><em>*</em>验证码</span>
                            <input ID="captcha" name="code" class="ui-input" type="text" style="width:80px" placeholder="请输入验证码" />
                            <img src="/cpacha/generate_cpacha?vl=4&fs=25&w=128&h=40&method=user_login_img_code"
                                 id="logincaptcha" style="cursor: pointer;"
                                 onclick="imgRandom(this)">
                        </li>
                        <li id="boxDiv" onclick="inquiry()" class="btn-box">
                            <botton></botton>
                        </li>
                    </ul>
                </div>
                <div class="book-box-right">
                    <img src="/home/images/book_right_banner.jpg">
                </div>
            </div>
        </div>
    </div>
</form>
</div>
<script type="text/javascript" src="/home/js/jquery.min.js"></script>
<script type="text/javascript" src="/home/layui/layui.all.js"></script>
<script type="text/javascript" src="/home/js/msg.js"></script>
<script>
    function inquiry() {
        var phone = $("#txtCustomerPhone").val().trim();
        var name = $("#txtCustomerName").val().trim();
        var email = $("#txtCustomerEmail").val().trim();
        var boardingTime = $('#test1').val();
        var boardingLocation = $('#txtAboardCity').val().trim();
        if (boardingTime.length==0){
            errorMsg("请选择您的上车时间");
            return false;
        }
        if (boardingLocation.length==0){
            errorMsg("请填写您的上车地点");
            return false;
        }
        if (name.length == 0){
            errorMsg("请填写您的称呼");
            return false;
        }
        if(phone.length == 0) {
            errorMsg("请输入您的手机号");
            return false;
        }
        if (email.length==0){
            errorMsg("请输入您的电子邮箱");
            return false;
        }
        //手机号正则验证
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        if(!chkphone.test(phone))
        {
            errorMsg("请输入正确的手机号");
            return false;
        }
        //电子邮箱验证
        var chkemail = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/;
        if (!chkemail.test(email)){
            errorMsg("请输入正确的电子邮箱");
            return false;
        }
        var data = $("#fmBook").serialize();
        $.ajax({
            url:'inquiryAdd',
            type:'POST',
            data:data,
            dataType:'json',
            success:function(data){
                if(data.code == 0) {
                    successMsg("已收到信息，我们的工作人员会尽快与您联系!");
                    setTimeout(function () {
                        location.href = '/home/index/index';
                    },1000)
                }
                else {
                    errorMsg(data.msg);
                }
            },
            error:function(data){
                errorMsg('网络错误!');
            }
        });
    }

    //验证码刷新
    function imgRandom(thisImg){
        thisImg.src=thisImg.src+'&d='+Math.random();
    }
    $(document).ready(function () {
       //初始化验证码
        imgRandom($("#logincaptcha"));
    });
    layui.use('laydate',function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#test1'
            ,format:'yyyy-MM-dd'
            ,trigger: 'click',
            min:0
        });
    });
</script>
</body>
</html>