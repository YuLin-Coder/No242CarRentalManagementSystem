var publickKey =
    'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHwHOMa1hnnxI2Kd/S+X6hS537R7bMYjLn8j++jUTPL+2+3qne7+Ca7tts7+rGuYAdOGL6adRRp/k89N1D55w5V704zkm93jhkIV3qTrqhQUfQ+McpKHVzbwO3HhiuiTnoJiPqUBsx5VSth7gv3fvML2MRTHiP+2AA8+dDdOIoRwIDAQAB'


//十六进制转字节
function hexToBytes(hex) {
    var bytes = [];
    for (var c = 0; c < hex.length; c += 2) {
        bytes.push(parseInt(hex.substr(c, 2), 16));
    }
    return bytes;
}

// 字节转十六进制
function bytesToHex(bytes) {
    var hex = [];
    for (var i = 0; i < bytes.length; i++) {
        hex.push((bytes[i] >>> 4).toString(16));
        hex.push((bytes[i] & 0xf).toString(16));
    }
    return hex.join('');
}

JSEncrypt.prototype.encryptLong = function (string) {
    var k = this.getKey();
    try {
        var lt = '';
        var ct = '';
        //RSA每次加密117bytes，需要辅助方法判断字符串截取位置
        //1.获取字符串截取点
        var bytes = new Array();
        bytes.push(0);
        var byteNo = 0;
        var len, c;
        len = string.length;
        var temp = 0;
        for (var i = 0; i < len; i++) {
            c = string.charCodeAt(i);
            if (c >= 0x010000 && c <= 0x10ffff) {
                byteNo += 4;
            } else if (c >= 0x000800 && c <= 0x00ffff) {
                byteNo += 3;
            } else if (c >= 0x000080 && c <= 0x0007ff) {
                byteNo += 2;
            } else {
                byteNo += 1;
            }
            if (byteNo % 117 >= 114 || byteNo % 117 == 0) {
                if (byteNo - temp >= 114) {
                    bytes.push(i);
                    temp = byteNo;
                }
            }
        }
        //2.截取字符串并分段加密
        if (bytes.length > 1) {
            for (var j = 0; j < bytes.length - 1; j++) {
                var str;
                if (j == 0) {
                    str = string.substring(0, bytes[j + 1] + 1);
                } else {
                    str = string.substring(bytes[j] + 1, bytes[j + 1] + 1);
                }
                var t1 = k.encrypt(str);
                ct += t1;
            }
            if (bytes[bytes.length - 1] != string.length - 1) {
                var lastStr = string.substring(bytes[bytes.length - 1] + 1);
                ct += k.encrypt(lastStr);
            }
            return hexToBytes(ct);
        }
        var t = k.encrypt(string);
        var y = hexToBytes(t);
        return y;
    } catch (ex) {
        console.log('--------ex--------');
        console.log(ex);
        return false;
    }
}

var encrypt = new JSEncrypt();
encrypt.setPublicKey(publickKey);



/*******快速登录 ************/
var logOrRegDom = {
    imgCaptcha: "#imgCaptcha"
};
function refreshCaptcha() {
    var b = $(logOrRegDom.imgCaptcha);
    var a = LogOrRegUrl.loginCaptcha + "?" + new Date().getTime();
    b.attr("src", a);
}
function quickrefreshCapthca() {
    //刷新验证码
    $("#quick_imgCaptcha").attr("src", window.GlobalUrl.fastLoginCaptcha + "?" + new Date().getTime());
}

//**验证提示**/
function vercError(message) {
    $(".btn-popup").show();
    $(".popup-operate-btn a.popup-loading").hide();
    $(".popup-error-msg").text(message);
}

//**验证输入手机号**/
function checkPhone(txtPhone) {
    var $inputPhone = $(txtPhone);
    var value = $.trim($inputPhone.val());
    var reg = (/^\d{7,15}$/.test(value));
    var emaliReg = (/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/.test(value));

    if (value.length === 0) {
        vercError("手机号码或邮箱不能为空");
        return false;
    }
    if (reg) {
        return true;
    }
    else if (emaliReg) {
        return true;
    }
    else {
        vercError("请输入正确的手机号码或邮箱");
        return false;
    }
}

//验证短信验证码
function checkPhoneCode(txtSmsCode) {
    var $inputSmsCode = $(txtSmsCode);
    var value = $.trim($inputSmsCode.val());
    if (value.length === 0) {
        vercError("请输入短信验证码");
        return false;
    }
    return true;
};

//**验证输入用户名**/
function checkName(txtName) {
    var $inputName = $(txtName);
    var value = $.trim($inputName.val());
    if (value.length === 0) {
        vercError("请输入用户名");
        return false;
    }
    return true;
};

//**验证输入密码**/
function checkCurPwd(txtCurPwd) {
    var $inputCurPwd = $(txtCurPwd);
    var value = $.trim($inputCurPwd.val());
    if (value.length === 0) {
        vercError("请输入密码");
        return false;
    }
    return true;
};

//**验证输入图片验证码**/
function checkCaptha(txtCapthca) {
    var $inputCapthca = $(txtCapthca);
    var value = $.trim($inputCapthca.val());
    if (value.length === 0) {
        vercError("请输入图形验证码");
        return false;
    }
    return true;
}

//**验证设置密码**/
function checkPassword(txtPassword) {
    var $inputPassword = $(txtPassword);
    var value = $.trim($inputPassword.val());
    var reg = !(/^[A-Za-z0-9]+$/.test(value));
    if (value.length === 0) {
        vercError("请设置您的密码");
        return false;
    } else if (value.length < 6 || value.length > 18) {
        vercError("请输入6-18个字符");
        return false;
    } else if (value.length > 0 && reg) {
        vercError("限数字、英文字母6-18个字符");
        return false;
    }
    return true;
}

function HideLoding() {
    $(".btn-popup").show();
    $(".popup-operate-btn a.popup-loading").hide();
}

///**检查是否同意用户协议**/
//function checkAgreement(checkAgree) {
//    var $inputAgree = $(checkAgree);
//    if ($inputAgree.length > 0 && !$(checkAgree).is(":checked")) {
//        vercError("请勾选会员注册协议");
//        return false;
//    }
//    return true;
//}

$(function () {
    $(document).on("click", logOrRegDom.imgCaptcha, function () {
        refreshCaptcha();
    });
    // 快速登录和普通登录切换
    $(document).on("click", ".poupp-logintab li", function () {
        var i = $(this).index();
        $(this).addClass("poupp-logincur").siblings().removeClass("poupp-logincur");
        $('.input-info').val("");
        $(".popup-error-msg").text("");
        $('.popup-loginbox > div').eq(i).removeClass("hide").siblings().addClass("hide");
        HideLoding();
    });

    // 登录和注册切换
    $(document).on("click", "#registerNow", function () {
        $(".popup-registerinfo").removeClass("hide");
        $(".popup-logininfo").addClass("hide");
        $(".slide-verifybox").html('');
        $('.input-info').val("");
        $(".popup-error-msg").text("");
        HideLoding();
    });
    $(document).on("click", "#loginNow", function () {
        $(".popup-logininfo").removeClass("hide");
        $(".popup-registerinfo").addClass("hide");
        $(".slide-verifybox").html('');
        $('.input-info').val("");
        $(".popup-error-msg").text("");
        HideLoding();
    });

    //关闭图形验证码
    $(document).on("click",
        '#J_Close',
        function () {
            $(".slide-verifybox").html('');
        });

    // 快速登录获取验证码
    $(document).on("click",
        "#loginCodeBtn",
        function () {
            var cur = document.getElementById("loginCodeBtn");
            if (!checkPhone("#loginPhone")) {
                $("#loginPhone").focus();
                return false;
            }
            $(".popup-error-msg").text("");
            $(".btn-close").remove();
                
            //先获取图形验证码的页面
            $.ajax({
                type: "GET",
                url: LogOrRegUrl.SecurityVerify,
                dateType: "html",
                success: function (data) {
                    $("#login-verifybox").html(data);
                }
            });
            //var phone = $("#loginPhone").val().trim();
            //$.ajax({
            //    type: "GET",
            //    url: LogOrRegUrl.SendMessage + "?phone=" + phone,
            //    success: function (data) {
            //        $("#login-verifybox").html(data);
            //        timeDown(cur);
            //    }
            //});
        });

    /*
*点击按钮倒计时效果
**/
    var wait = 59;
    function timeDown(obj) {
        if (wait === 0) {
            obj.removeAttribute("disabled");
            obj.value = "重获验证码";
            wait = 59;
            obj.style.color = "#23b7b7";
            obj.style.cursor = "";
        } else {
            obj.setAttribute("disabled", true);
            obj.style.color = "#999";
            obj.style.cursor = "default";
            obj.value = wait + "s后重发";
            wait--;
            setTimeout(function () {
                timeDown(obj);
            },
                1000);
        }
    }
    //**验证输入邮箱**/
    function checkEmail(mail) {
        // var $inputPhone = $(mail);
        //  var value = $.trim($inputPhone.val());
        var reg = !(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/.test(mail));

        if (mail.length === 0) {
            vercError("邮箱为空");
            return false;
        } else if (mail.length > 0 && reg) {
            vercError("邮箱格式错误");
            return false;
        }
        return true;
    }
    //提交记录
    $(document).on("click", "#addAccountInfo", function () {
        var logon = $('#logon').val();
        var mail = $('#mail').val();
        var userId = $('#userId').val();
        if (!checkEmail(mail)) {
            $("#mail").focus();
            return false;
        }
        var param = JSON.stringify({ "userId": userId, "enterpriseId": logon, "email": mail });
        //param = "loginName=" + loginName + "&password=" + loginPwd + "&captcha=" + loginCaptcha + "&state=false";
        var encryptedQuery = encrypt.encryptLong(param);
        // 转成16进制字符串
        encryptedQuery = bytesToHex(encryptedQuery);
        $.ajax({
            url: LogOrRegUrl.SubmitAccountInfo,
            data: { p: encryptedQuery },
            method: "Post",
            async: false,
            error: function (request) {
                vercError("系统异常");
            },
            success: function (data) {
                vercError(data);
            }
        });
        return false;
    });
    // 快速登录
    $(document).on("click", "#popupQuickLogin", function () {
        $(".btn-popup").hide();
        $(".popup-operate-btn a.popup-loading").show();
        var param;
        encrypt.setPublicKey(publickKey);
        if (!checkPhone("#loginPhone")) {
            $("#loginPhone").focus();
        } else if (!checkPhoneCode("#loginCode")) {
            $("#loginCode").focus();
        } else {
            param = JSON.stringify({ "Phone": $("#loginPhone").val().trim(), "Code": $("#loginCode").val().trim() });
            //param = "phoneNumber=" + $("#loginPhone").val().trim() + "&code=" + $("#loginCode").val().trim();
            console.log(param);
            var encryptedQuery = encrypt.encryptLong(param);
            // 转成16进制字符串
            encryptedQuery = bytesToHex(encryptedQuery);

            console.log(encryptedQuery);
            $.ajax({
                type: "POST",
                url: LogOrRegUrl.FastLogin,
                data: { p: encryptedQuery },
                dateType: "json",
                success: function (data) {
                    if (!data.Success) {

                        if (data.Message == "BindAccount") {
                            window.location = LogOrRegUrl.BindAccount + "?p=" + data.Data;
                        } else {
                            vercError(data.Message);
                        }


                        return false;
                    }
                    window.location = LogOrRegUrl.ReturnUrl;

                    return true;
                }
            });
            return true;
        };
    });

    // 普通登录
    $(document).on("click", "#popupCommonLogin", function () {
        $(".btn-popup").hide();
        $(".popup-operate-btn a.popup-loading").show();
        var param;
        if (!checkPhone("#loginName")) {
            $("#loginName").focus();
            return false;
        }
        else if (!checkCurPwd("#password")) {
            $("#password").focus();
            return false;
        }
        else if (!checkCaptha("#captcha")) {
            $("#captcha").focus();
            return false;
        }
        else {
            var loginName = $('#loginName').val();
            var loginPwd = $('#password').val();
            var loginCaptcha = $('#captcha').val();
            param = JSON.stringify({ "loginName": loginName, "password": loginPwd, "captcha": loginCaptcha });
            //param = "loginName=" + loginName + "&password=" + loginPwd + "&captcha=" + loginCaptcha + "&state=false";
            var encryptedQuery = encrypt.encryptLong(param);
            // 转成16进制字符串
            encryptedQuery = bytesToHex(encryptedQuery);
            $.ajax({
                type: "POST",
                url: LogOrRegUrl.Login,
                data: { captcha: loginCaptcha, p: encryptedQuery },
                dateType: "json",
                success: function (data) {
                    refreshCaptcha();
                    if (!data.Success) {
                        if (data.Message == "BindAccount") {
                            //param = JSON.stringify({ "userId": data.data });
                            //var encryptedQuery = encrypt.encryptLong(param);
                            //// 转成16进制字符串
                            //encryptedQuery = bytesToHex(encryptedQuery);
                            window.location = LogOrRegUrl.BindAccount + "?p=" + data.Data;
                        } else {
                            vercError(data.Message);
                        }
                        return false;
                    }
                    window.location = LogOrRegUrl.ReturnUrl;
                    return true;
                }
            });
        }
    });

    $(document).on("click",
        ".popup-close",
        function () {
            $("#LogOrRegView").html("");
        });

    // 新用户注册获取验证码
    $(document).on("click", "#registerCodeBtn", function () {
        if (!checkPhone("#registerPhone")) {
            $("#registerPhone").focus();
            return false;
        }
        $(".popup-error-msg").text("");
        $(".btn-close").remove();
        $.ajax({
            type: "GET",
            url: LogOrRegUrl.SecurityVerify,
            dateType: "html",
            success: function (data) {
                $("#register-verifybox").html(data);
            }
        });
    });

    // 新用户注册
    $(document).on("click", "#popupRegister", function () {
        $(".btn-popup").hide();
        $(".popup-operate-btn a.popup-loading").show();
        var param;
        if (!checkPhone("#registerPhone")) {
            $("#registerPhone").focus();
            return false;
        }
        else if (!checkPhoneCode("#registerCode")) {
            $("#registerCode").focus();
            return false;
        }
        else if (!checkPassword("#registerPwd")) {
            $("#registerPwd").focus();
            return false;
        }
        else if (!checkAgreement("#registerAgree")) {
            return false;
        }
        else {
            param = "registerPhone=" + $('#registerPhone').val() + "&registerCode=" + $('#registerCode').val() + "&registerPwd=" + $('#registerPwd').val();
            var encryptedQuery = encrypt.encryptLong(param);
            // 转成16进制字符串
            encryptedQuery = bytesToHex(encryptedQuery);
            $.ajax({
                type: "POST",
                url: LogOrRegUrl.Register,
                data: { p: encryptedQuery },
                dateType: "json",
                success: function (data) {
                    if (!data.Success) {
                        vercError(data.Message);
                        return false;
                    }
                    window.location = LogOrRegUrl.FastReturnUrl;
                    return true;
                }
            });
        }
    });
});