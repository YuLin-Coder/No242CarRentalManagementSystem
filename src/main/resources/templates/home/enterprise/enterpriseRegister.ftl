
<html>
<head>
    <title>企业注册</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/home/css/header.css" rel="stylesheet" />
    <link href="/home/css/register.css?v=b63acc1d7c7f449ea8503a0af823b7c6" rel="stylesheet" type="text/css" />
    <link href="/home/css/mshowBox.css?v=b63acc1d7c7f449ea8503a0af823b7c6" rel="stylesheet" />
    <link href="/home/css/slide_verify.css?v=b63acc1d7c7f449ea8503a0af823b7c6" rel="stylesheet" type="text/css" />
    <link href="/home/layui/css/layui.css" rel="stylesheet" type="text/css" />
    <style>
        .head-wrap {
            width: 100%;
            height: 56px;
            padding: 25px 0 45px;
        }
        #a img{
            width: 200px;
            height:100px;
        }
        .reg-left{
            border: 1px black solid;
            margin-left: 150px;
        }
    </style>
</head>
<body>
<div class="head-wrap">
</div>
<div class="w1180">
    <div class="reg-details clear_float">
        <div class="reg-left">
            <h3>企业注册</h3>
            <div id="photo" class="reg-li">
                <span>上传营业执照 :</span>
                <div class="layui-upload-drag" id="upload">
                    <i class="layui-icon"></i>
                    <p>点击上传，或将文件拖拽到此处</p>
                    <div class="layui-hide" id="a">
                        <hr>
                        <img id="upload_enPic" name="enPic" src="" alt="" style="max-width: 196px">
                    </div>
                </div>
            </div>
            <form  id="myform">
            <div class="reg-info">
                <div class="reg-li">
                    <span>手机号码 :</span>
                    <input class="input-phone" id="phone" maxlength="11"  name="phone" type="text" placeholder="请输入手机号码"/>
                    <em>*</em>
                    <i></i>
                </div>
                <div class="reg-li">
                    <span>企业名:</span>
                    <input class="input-phone" id="enterpriseName"  name="enterpriseName" type="text" placeholder="请输入企业名"/>
                    <em>*</em>
                    <i></i>
                </div>
                <div class="reg-li">
                    <span>企业账号:</span>
                    <input class="input-phone" id="enterpriseNo"  name="enterpriseNo" type="text" placeholder="请输入企业账号"/>
                    <em>*</em>
                    <i></i>
                </div>
                <div class="reg-li">
                    <span>电子邮箱 :</span>
                    <input class="input-phone" id="demail" name="demail" placeholder="请输入企业邮箱" type="text" value="" />
                    <em>*</em>
                    <i></i>
                </div>
                <div class="reg-li clear_float">
                    <span>设置密码 :</span>
                    <div class="reg-pwd">
                        <div id="pass"><input class="input-pwd" id="password" maxlength="18"  placeholder="请设置密码" name="password" type="password" /></div>
                        <i id="pwd-state" class="pwd-show"></i>
                    </div>
                    <em>*</em>
                    <i></i>
                </div>
                <div class="reg-li clear_float">
                    <span>确认密码 :</span>
                    <div class="reg-pwd">
                        <div id="pass"><input class="input-pwd" id="repassword" maxlength="18"  placeholder="请确认密码"  type="password"/></div>
                        <i id="pwd-state" class="pwd-show"></i>
                    </div>
                    <em>*</em>
                    <i></i>
                </div>
                <div class="reg-li">
                    <span>验证码 :</span>
                    <input type="hidden" name="type" id="type" value="0">
                    <input class="input-invitecode" id="recode" maxlength="4" name="code" placeholder="请输入验证码" type="text" value="" />
                    <img src="/cpacha/generate_cpacha?vl=4&fs=25&w=128&h=40&method=user_login_img_code"
                         id="logincaptcha" style="cursor: pointer;"
                         onclick="imgRandom(this)">
                    <em></em>
                    <i></i>
                </div>
                <div class="reg-operate">
                    <div class="reg-btn">
                        <a href="javascript:register()" type="submit" id="btnSubmit" class="reg-disable">注册</a>
                        <a href="javascript:void(0)" class="reg-loading" id="rloading" style="display: none;"></a>
                    </div>
                    <div class="reg-login">
                        已有账号，<a href="/home/index/enterpriseService">直接登录 》</a>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
</div>
<style>
    .myshowbox {
        background: #ffffff !important;
        box-shadow: none;
    }
</style>
<script src="/home/layui/layui.js"></script>
<script src="/home/js/jquery.min.js"></script>
<script src="/home/js/msg.js"></script>
<script>
    var M = {};
    M.photo = "";
    layui.use('upload',function () {
        var upload = layui.upload;
        upload.render({
            elem: '#upload',
            url: '/upload/home_upload_photo', //改成您自己的上传接口,
            size: 1024 * 2,
            accept: 'images',
            done: function (res) {
                if (res.code == 0) {
                    M.photo = res.data;
                    $('#upload_enPic').attr("src","/photo/view?filename="+M.photo.toString());
                    $('#a').removeClass("layui-hide");
                    layer.msg("上传成功", {icon: 1});
                }else {
                    layer.msg('网络错误!');
                }
            }
        });
    });
    //验证码刷新
    function imgRandom(thisImg){
        thisImg.src=thisImg.src+'&d='+Math.random();
    }
    $(document).ready(function () {
        //初始化验证码
        imgRandom($("#logincaptcha"));
    });
    //注册验证
    function rcheck(){
        layui.use('layer', function(){
            var layer = layui.layer;
        });
        // 手机号的正则表达式
        var demail = $("#demail").val().trim();
        var chkemail = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/;
        var chkphone = /^1[3|4|5|7|8]\d{9}$/;
        var phone = $("#phone").val();
        var enterpriseName = $("#enterpriseName").val().trim();
        var enterpriseNo = $("#enterpriseNo").val().trim();
        var password = $("#password").val().trim();
        var repaaword = $('#repassword').val().trim();
        var code = $('#recode').val().trim();
        if(demail.length==0){
            errorMsg("请输入企业邮箱");
            return false;
        }
        if (!chkemail.test(demail)){
            errorMsg("请输入正确的企业邮箱");
            return false;
        }
        if (enterpriseName.length==0){
            errorMsg("企业名不能为空");
            return false;
        }
        if (phone.length==0){
            errorMsg("手机号不能为空");
            return false;
        }
        if(!chkphone.test(phone)) {
            errorMsg("请输入正确的手机号");
            return false;
        }
        if (enterpriseNo.length==0){
            errorMsg("企业账号不能为空");
            return false;
        }
        if (password.length==0){
            errorMsg("请输入密码");
            return false;
        }
        if(repaaword.length==0){
            errorMsg("请输入确认密码");
            return false;
        }
        if(password!=repaaword){
            errorMsg("两次输入密码不一致");
            return false;
        }
        if(code.length==0){
            errorMsg("请输入验证码");
            return false;
        }
        return true;
    }
    //提交企业注册
    function register(){
        if(rcheck()){
            var data = $("#myform").serialize()+'&'+$.param({'enPic':M.photo});
            $.ajax({
                type: "POST",
                url: '/home/index/enregister',
                data: data,
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.code == 0) {
                        successMsg("注册成功,等待管理员审核");
                        location.href = "/home/index/enterpriseService";
                    }
                    else
                    {
                        errorMsg(data.msg);
                    }
                }
            });
        }
    }
</script>
</body>
</html>