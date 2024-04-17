$(function() {
    (function() {
        var curr = 0;
        $("#jsNav .trigger").each(function(i) {
            $(this).click(function() {
                curr = i;
                $("#js ul li")
                    .eq(i)
                    .fadeIn("slow")
                    .siblings("li")
                    .hide();
                $(this)
                    .siblings(".trigger")
                    .removeClass("imgSelected")
                    .end()
                    .addClass("imgSelected");
                return false;
            });
        });

        var pg = function(flag) {
            if (flag) {
                if (curr == 0) {
                    todo = 7;
                } else {
                    todo = (curr - 1) % 8;
                }
            } else {
                todo = (curr + 1) % 8;
            }
            $("#jsNav .trigger")
                .eq(todo)
                .click();
        };

        $("#prev").click(function() {
            pg(true);
            return false;
        });

        $("#next").click(function() {
            pg(false);
            return false;
        });

        var timer = setInterval(function() {
            todo = (curr + 1) % 8;
            $("#jsNav .trigger")
                .eq(todo)
                .click();
        }, 2500);

        $("#js,#prev,#next").hover(
            function() {
                clearInterval(timer);
            },
            function() {
                timer = setInterval(function() {
                    todo = (curr + 1) % 8;
                    $("#jsNav .trigger")
                        .eq(todo)
                        .click();
                }, 2500);
            }
        );
    })();

    //二级菜单显示
    $(".nav li")
        .unbind("click")
        .click(function(e) {
            $(".menu-list").css("height", "auto");
            $(this)
                .siblings()
                .children(".secondmenu");
            $(this)
                .siblings()
                .find(".arrow")
                .removeClass("arrow-rotate")
                .attr("data-arrow", true);
            if (
                $(this)
                    .find(".arrow")
                    .attr("data-arrow") == "true"
            ) {
                var secondmenu = $(this).children(".secondmenu");
                $(this)
                    .find(".arrow")
                    .addClass("arrow-rotate")
                    .attr("data-arrow", false);
                if (secondmenu.length > 0) {
                    secondmenu.slideToggle();
                }
            } else {
                var secondmenu = $(this).children(".secondmenu");
                $(this)
                    .find(".arrow")
                    .removeClass("arrow-rotate")
                    .attr("data-arrow", true);
                if (secondmenu.length > 0) {
                    secondmenu.slideToggle();
                }
            }
        });

    // 鼠標滑動位置
    $(".secondmenu a").hover(function() {
        $(this)
            .addClass("secondmenucur")
            .siblings()
            .removeClass("secondmenucur");
    });

    //修改密码显示
    $(".welcome li")
        .eq(0)
        .hover(
            function() {
                $(".passwordmenu").show();
            },
            function() {
                $(".passwordmenu").hide();
            }
        );
    $(".passwordmenu").hover(
        function() {
            $(this).show();
        },
        function() {
            $(this).hide();
        }
    );
});

//AJAX封装
function ajaxFun(opt) {
    var data =
        opt.data == null || opt.data == "" || typeof opt.data == "undefined"
            ? { data: "" }
            : opt.data;
    var async =
        opt.async == null || opt.async == "" || typeof opt.async == "undefined"
            ? "true"
            : opt.async;
    var type =
        opt.type == null || opt.type == "" || typeof opt.type == "undefined"
            ? "post"
            : opt.type;
    var dataType =
        opt.dataType == null ||
        opt.dataType == "" ||
        typeof opt.dataType == "undefined"
            ? "json"
            : opt.dataType;
    var url =
        opt.url == null || opt.url == "" || typeof opt.url == "undefined"
            ? { url: "" }
            : opt.url;
    layui.use(["layer", "form"], function() {
        var layer = layui.layer;
        $.ajax({
            url: url,
            data: data,
            type: type,
            aysnc: async,
            timeout: 1000000,
            dataType: dataType,
            beforeSend: function(data) {
                if (data.readyState == 0) {
                    layer.load(2, { shade: false });
                }
            },
            success: function(res) {
                opt.successBack(res);
            },
            complete: function(data) {
                if (data.status == 200) {
                    setTimeout(function() {
                        layer.closeAll();
                    }, 500);
                }
            },
            error: function(jqXHR) {
                layer.msg("系统错误");
                opt.errorBack();
            }
        });
    });
}

// 自驾订单详情
$(".dashline").each(function() {
    var allW = $(this)
        .parent(".price-info-item-hd")
        .width();
    var preW = $(this)
        .siblings(".price-info-item-hd h3")
        .width();
    $(this).width(allW - preW - 65);
});

$(window).load(function() {
    var contentLeftHeight = $(".content_left").innerHeight();
    var entranceHeight = $(".quickEntrance").outerHeight(true);
    $(".announcement").height(contentLeftHeight - entranceHeight - 2);

    $(".nav").height($(".content").innerHeight());
});
