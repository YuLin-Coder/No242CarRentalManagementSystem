$(function(){
	$(".service-list li").on("mouseover",function(){
		$(this).children(".service-list-hover").show();
		$(this).siblings().children(".service-list-hover").hide();
	});

	$(".service-list-hover").on("mouseout",function(){
		$(this).hide();
	});
	
	/*自动切换*/
	var mySwiper = new Swiper('.swiper-container', {
		autoplay: 3000,
		speed: 1000,
		loop: true,
		autoplayDisableOnInteraction : false,
		
		onSlideChangeStart: function(){
		  $(".swiper-tabs .active").removeClass('active');
		  $(".swiper-tabs a").eq(mySwiper.activeLoopIndex).addClass('active');
		}
	});
	
	/*tab切换*/
	$(".swiper-tabs a").on('touchstart mousedown',function(e){
		e.preventDefault();
		$(".swiper-tabs .active").removeClass('active');
		$(this).addClass('active');
		mySwiper.swipeTo($(this).index());
	});	
	$(".swiper-tabs a").click(function(e){
		e.preventDefault();
	});
	
	/*左右切换*/
	$('.swiper-btn-prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});
	$('.swiper-btn-next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});


	// 错误提示
	var error = $('.error-text');
	function tip(txt){
		if (txt) {
			error.text(txt);
			setTimeout(function () {
				error.text('');
			}, 2000);
		}
	};

    $("#loginForm").submit(function (e) {
        var phone = $('#loginPhone').val().trim();
        var password = $('#loginPwd').val().trim();
        var captcha = $('#loginCaptcha').val().trim();
        var reg = !(/^\d{7,15}$/.test(phone));

        if (phone.length === 0) {
            tip('手机号码为空');
            return false;
        } else if (phone.length < 7 || phone.length > 15) {
            tip('请输入7到15位手机号码');
            return false;
        } else if (phone.length > 0 && reg) {
            tip('手机号码格式错误');
            return false;
        };

        if (password.length === 0) {
            tip('请输入密码');
            return false;
        };

        if (captcha.length === 0) {
            tip('请输入验证码');
            return false;
        };
    })
})