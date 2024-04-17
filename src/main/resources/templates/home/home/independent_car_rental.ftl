<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

        <link href="/home/layui/css/layui.css" rel="stylesheet" />
        <link href="/home/css/header.css" rel="stylesheet" />
        <link href="/home/css/simplefooter.css" rel="stylesheet"/>
        <link href="/home/css/personalLogin.css" rel="stylesheet" />
		<meta http-equiv="x-dns-prefetch-control" content="on" />
		<link rel="dns-prefetch" href="//online2.map.bdimg.com">
		<link rel="dns-prefetch" href="//cdnmaster.com">
		<link rel="dns-prefetch" href="//cms.gtags.net">
		<title></title>
		<link rel="shortcut icon" href="https://www.1hai.cn/favicon.ico" type="image/x-icon" />
		<script src="/home/js/bigpipe.js"></script>
		<link href="/home/css/29a7315a8e0344398a9dc3070cc947bf.css" rel="stylesheet" />
		<link href="/home/css/4432dcdc54274decb97ceed6307078a4.css" rel="stylesheet" />
		<style>
			#desk-user-regsiter-form li input{
				height: 40px;
			}
			.popup-register p{
                margin-top: -5px;
			}
			.login img{
                position: absolute;
				top:15px;
                cursor: pointer;
			}
            .register img{
                position: absolute;
                top:0px;
                cursor: pointer;
            }
		</style>
</head>
<body>
<div id="wrap">
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
					<a href="/home/index/info">我的一嗨</a>
                </div>
            </div>
        </div>
        <div class="head-bottom">
            <div class="w1180">
                <a class="logo"></a>
                <div class="nav">
                    <ul class="nav-wrap clear_float" id="J_NavBox">
                        <li><a href="/home/index/index" target="_top">自驾租车</a><span></span></li>
                        <li><a href="/home/index/enterpriseService" target="_top">企业服务</a><span></span></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="content" class="clear_float">
        <div class="nav-city-box">
            <p>
            </p>
        </div>
        <div class="choosecartype">

            <form action="/" id="form0" method="post">
                <div class="term clearfix">
                    <ul class="first">
                        <li>
                            <label class="key">
                                取车门店：
                            </label>
                            <div class="citystore" id="pickupStore">
                                <input autocomplete="off" class="citysel input-txt" id="PickupCity" maxlength="10"
                                       name="PickUpCity" type="text"
                                       value="上海"/>
                                <input autocomplete="off" class="mendian input-txt fl" id="getStore"
                                       name="PickUpStoreName" readonly="readonly"
                                       type="text" value="八万人体育场店"/>
                                <input autocomplete="off" class="address input-txt" id="getSendService"
                                       name="PickUpServiceAddress" readonly="readonly"
                                       type="text" value="请输入送车上门地址"/>
                            </div>
                            <label class="ckb-scsm " id="city_get">
                                <input autocomplete="off" class="checkboxin" data-val="true"
                                       data-val-required="IsSendService 字段是必需的。" id="getCheck"
                                       name="IsSendService" type="checkbox" value="true"/><input name="IsSendService"
                                                                                                 type="hidden"
                                                                                                 value="false"/><span>送车上门</span>
                            </label>
                        </li>
                        <li>
                            <label class="key">
                                还车门店：
                            </label>
                            <div class="citystore" id="dropoffStore">
                                <input autocomplete="off" class="citysel input-txt" id="ReturnCity" maxlength="10"
                                       name="ReturnCity" type="text"
                                       value="上海"/>
                                <input autocomplete="off" class="mendian input-txt fl" id="retStore"
                                       name="ReturnStoreName" readonly="readonly"
                                       type="text" value="八万人体育场店"/>
                                <input autocomplete="off" class="address input-txt" id="retSendService"
                                       name="ReturnServiceAddress" readonly="readonly"
                                       type="text" value="请输入上门取车地址"/>
                            </div>

                            <label class="ckb-scsm " id="city_ret">
                                <input autocomplete="off" class="checkboxin" id="retCheck" name="IsReturnService"
                                       type="checkbox" value="true"/>
                                <input name="IsReturnService" type="hidden" value="false"/>
                                <span>上门取车</span>
                            </label>
                        </li>
                    </ul>
                    <ul class="second">
                        <li>
                            <label class="key tit" for="J_date_1">
                                取车时间：
                            </label>
                            <div class="fl" style="display: inline; margin-right: 4px;">
                                <input autocomplete="off" class="f-text input-txt" id="J_date_1" name="PickUpDate"
                                       type="text">
                            </div>
                            <div class="fl" style="display: inline; margin-right: 4px;">
                                <input autocomplete="off" class="timedetail input-txt booking-box" data-val="true"
                                       data-val-number="The field PickUpHour must be a number."
                                       data-val-required="PickUpHour 字段是必需的。" id="getHour" readonly="readonly" rel="13"
                                       type="text" value="13时">
                            </div>
                            <div class="fl">
                                <input autocomplete="off" class="timedetail input-txt booking-box" id="getMinute"
                                       type="text">
                            </div>
                        </li>
                        <li>
                            <label class="key tit" for="J_date_2">
                                还车时间：
                            </label>
                            <div class="fl" style="display: inline; margin-right: 4px;">
                                <input autocomplete="off" class="f-text input-txt" id="J_date_2" name="ReturnDate"
                                       type="text">
                            </div>
                            <div class="fl" style="display: inline; margin-right: 4px;">
                                <input autocomplete="off" class="timedetail input-txt booking-box" id="retHour">
                            </div>
                            <div class="fl">
                                <input autocomplete="off" class="timedetail input-txt booking-box" id="retMinute"
                                       type="text">
                            </div>
                        </li>
                    </ul>
                    <input class="reviseBtn" type="submit" value="" id="btnSubmit"/>
                    <img class="hidden" id="loading" src="/home/images/loading_stp2.gif" style="margin: 15px 0 0 7px"/>
                </div>
            </form>
            <div class="prompt-box clearfix">
            <#--<div class="company-prompt" id="companyPrompt">-->

            <#--</div>-->

            <#--<div class="lease-prompt">-->

            <#--</div>-->
            </div>
            <div class="car-box-body">
                <div class="choose-typebox">
                    <div class="choose-model cartypelist">
                        <a class="classify-all on" data-value="">
                            <div class="modelall">
                                <img src="/home/images/hot.png"/>

                            </div>
                        </a>
                    <#if automobileTypeEnums??>
                        <#list automobileTypeEnums as automobileType>
                            <a data-value="${automobileType.getCode()}">
                                <div class="model-classify">
                                    <p>${automobileType.getName()}</p>
                                    <span class="${automobileType.getPic()}"></span>
                                </div>
                            </a>
                        </#list>
                    </#if>
                    </div>
                    <div class="choose-branch">
                        <div class="choose-brand choose-ck">
                            <span>
                                品牌：
                            </span>
                            <div class="brandlist">
                                <a data-value="" class='on' data-ba-label="品牌_全部">全部</a>
                            <#if mobileBrands??>
                                <#list mobileBrands as mobileBrand>
                                    <a data-value="${mobileBrand.brand}" class=''
                                       data-ba-label="品牌_${mobileBrand.brand}">${mobileBrand.brand}</a>
                                </#list>
                            </#if>
                            <#---->
                            <#--<a data-value="大众" class='' data-ba-label="品牌_大众">大众</a>-->
                            <#--<a data-value="英菲尼迪" class='' data-ba-label="品牌_英菲尼迪">英菲尼迪</a>-->
                            <#--<a data-value="标致" class='' data-ba-label="品牌_标致">标致</a>-->
                            <#--<a data-value="别克" class='' data-ba-label="品牌_别克">别克</a>-->
                            <#--<a data-value="宝马" class='' data-ba-label="品牌_宝马">宝马</a>-->
                            <#--<a data-value="奥迪" class='' data-ba-label="品牌_奥迪">奥迪</a>-->
                            <#--<a data-value="大众斯柯达" class='' data-ba-label="品牌_大众斯柯达">大众斯柯达</a>-->
                            <#--<a data-value="一汽马自达" class='' data-ba-label="品牌_一汽马自达">一汽马自达</a>-->
                            <#--<a data-value="玛莎拉蒂" class='' data-ba-label="品牌_玛莎拉蒂">玛莎拉蒂</a>-->
                            <#--<a data-value="荣威" class='' data-ba-label="品牌_荣威">荣威</a>-->
                            <#--<a data-value="MG" class='' data-ba-label="品牌_MG">MG</a>-->
                            <#--<a data-value="一汽" class='' data-ba-label="品牌_一汽">一汽</a>-->
                            <#--<a data-value="东风" class='' data-ba-label="品牌_东风">东风</a>-->
                            <#--<a data-value="本田" class='' data-ba-label="品牌_本田">本田</a>-->
                            <#--<a data-value="雪佛兰" class='' data-ba-label="品牌_雪佛兰">雪佛兰</a>-->
                            <#--<a data-value="腾势" class='' data-ba-label="品牌_腾势">腾势</a>-->
                            <#--<a data-value="上汽大通" class='' data-ba-label="品牌_上汽大通">上汽大通</a>-->
                            <#--<a data-value="绅宝" class='' data-ba-label="品牌_绅宝">绅宝</a>-->
                            <#--<a data-value="沃尔沃" class='' data-ba-label="品牌_沃尔沃">沃尔沃</a>-->
                            <#--<a data-value="路虎" class='' data-ba-label="品牌_路虎">路虎</a>-->
                            <#--<a data-value="现代" class='' data-ba-label="品牌_现代">现代</a>-->
                            <#--<a data-value="丰田" class='' data-ba-label="品牌_丰田">丰田</a>-->
                            <#--<a data-value="起亚" class='' data-ba-label="品牌_起亚">起亚</a>-->
                            <#--<a data-value="福特" class='' data-ba-label="品牌_福特">福特</a>-->
                            <#--<a data-value="捷豹" class='' data-ba-label="品牌_捷豹">捷豹</a>-->
                            <#--<a data-value="日产" class='' data-ba-label="品牌_日产">日产</a>-->
                            <#--<a data-value="捷达" class='' data-ba-label="品牌_捷达">捷达</a>-->
                            <#--<a data-value="名爵" class='' data-ba-label="品牌_名爵">名爵</a>-->
                            <#--<a data-value="宝沃" class='' data-ba-label="品牌_宝沃">宝沃</a>-->
                            <#--<a data-value="奔驰" class='' data-ba-label="品牌_奔驰">奔驰</a>-->
                            <#--<a data-value="凯迪拉克" class='' data-ba-label="品牌_凯迪拉克">凯迪拉克</a>-->
                            <#--<a data-value="纳智捷" class='' data-ba-label="品牌_纳智捷">纳智捷</a>-->
                            <#--<a data-value="欧拉" class='' data-ba-label="品牌_欧拉">欧拉</a>-->
                            <#--<a data-value="DS" class='' data-ba-label="品牌_DS">DS</a>-->
                            <#--<a data-value="爱驰" class='' data-ba-label="品牌_爱驰">爱驰</a>-->
                            <#--<a data-value="Polestar" class='' data-ba-label="品牌_Polestar">Polestar</a>-->
                            <#--<a data-value="新宝骏" class='' data-ba-label="品牌_新宝骏">新宝骏</a>-->
                            <#--<a data-value="BEIJING" class='' data-ba-label="品牌_BEIJING">BEIJING</a>-->
                            <#--<a data-value="江西五十铃" class='' data-ba-label="品牌_江西五十铃">江西五十铃</a>-->
                            <#--<a data-value="野马" class='' data-ba-label="品牌_野马">野马</a>-->
                            <#--<a data-value="捷途" class='' data-ba-label="品牌_捷途">捷途</a>-->
                            <#--<a data-value="北京越野" class='' data-ba-label="品牌_北京越野">北京越野</a>-->
                            <#--<a data-value="R汽车" class='' data-ba-label="品牌_R汽车">R汽车</a>-->
                            <#--<a data-value="小鹏" class='' data-ba-label="品牌_小鹏">小鹏</a>-->
                            <#--<a data-value="观致" class='' data-ba-label="品牌_观致">观致</a>-->
                            <#--<a data-value="思铭" class='' data-ba-label="品牌_思铭">思铭</a>-->
                            <#--<a data-value="江淮" class='' data-ba-label="品牌_江淮">江淮</a>-->
                            <#--<a data-value="江铃" class='' data-ba-label="品牌_江铃">江铃</a>-->
                            <#--<a data-value="马自达" class='' data-ba-label="品牌_马自达">马自达</a>-->
                            <#--<a data-value="东南" class='' data-ba-label="品牌_东南">东南</a>-->
                            <#--<a data-value="哈弗" class='' data-ba-label="品牌_哈弗">哈弗</a>-->
                            <#--<a data-value="金杯" class='' data-ba-label="品牌_金杯">金杯</a>-->
                            <#--<a data-value="比亚迪" class='' data-ba-label="品牌_比亚迪">比亚迪</a>-->
                            <#--<a data-value="广汽传祺" class='' data-ba-label="品牌_广汽传祺">广汽传祺</a>-->
                            <#--<a data-value="克莱斯勒" class='' data-ba-label="品牌_克莱斯勒">克莱斯勒</a>-->
                            <#--<a data-value="瑞驰新能源" class='' data-ba-label="品牌_瑞驰新能源">瑞驰新能源</a>-->
                            <#--<a data-value="吉利" class='' data-ba-label="品牌_吉利">吉利</a>-->
                            <#--<a data-value="铃木" class='' data-ba-label="品牌_铃木">铃木</a>-->
                            <#--<a data-value="华晨华颂" class='' data-ba-label="品牌_华晨华颂">华晨华颂</a>-->
                            <#--<a data-value="雪铁龙" class='' data-ba-label="品牌_雪铁龙">雪铁龙</a>-->
                            <#--<a data-value="奇瑞" class='' data-ba-label="品牌_奇瑞">奇瑞</a>-->
                            <#--<a data-value="长安" class='' data-ba-label="品牌_长安">长安</a>-->
                            <#--<a data-value="福田" class='' data-ba-label="品牌_福田">福田</a>-->
                            <#--<a data-value="汇众" class='' data-ba-label="品牌_汇众">汇众</a>-->
                            <#--<a data-value="金龙" class='' data-ba-label="品牌_金龙">金龙</a>-->
                            <#--<a data-value="五菱" class='' data-ba-label="品牌_五菱">五菱</a>-->
                            <#--<a data-value="宇通" class='' data-ba-label="品牌_宇通">宇通</a>-->
                            <#--<a data-value="中华" class='' data-ba-label="品牌_中华">中华</a>-->
                            <#--<a data-value="长城" class='' data-ba-label="品牌_长城">长城</a>-->
                            <#--<a data-value="庆铃" class='' data-ba-label="品牌_庆铃">庆铃</a>-->
                            <#--<a data-value="金旅" class='' data-ba-label="品牌_金旅">金旅</a>-->
                            <#--<a data-value="依维柯" class='' data-ba-label="品牌_依维柯">依维柯</a>-->
                            <#--<a data-value="MINI" class='' data-ba-label="品牌_MINI">MINI</a>-->
                            <#--<a data-value="东风小康" class='' data-ba-label="品牌_东风小康">东风小康</a>-->
                            <#--<a data-value="传祺" class='' data-ba-label="品牌_传祺">传祺</a>-->
                            <#--<a data-value="雷克萨斯" class='' data-ba-label="品牌_雷克萨斯">雷克萨斯</a>-->
                            <#--<a data-value="斯巴鲁" class='' data-ba-label="品牌_斯巴鲁">斯巴鲁</a>-->
                            <#--<a data-value="吉普" class='' data-ba-label="品牌_吉普">吉普</a>-->
                            <#--<a data-value="Jeep" class='' data-ba-label="品牌_Jeep">Jeep</a>-->
                            <#--<a data-value="猎豹" class='' data-ba-label="品牌_猎豹">猎豹</a>-->
                            <#--<a data-value="特斯拉" class='' data-ba-label="品牌_特斯拉">特斯拉</a>-->
                            <#--<a data-value="三菱" class='' data-ba-label="品牌_三菱">三菱</a>-->
                            <#--<a data-value="道奇" class='' data-ba-label="品牌_道奇">道奇</a>-->
                            <#--<a data-value="奔腾" class='' data-ba-label="品牌_奔腾">奔腾</a>-->
                            <#--<a data-value="启辰" class='' data-ba-label="品牌_启辰">启辰</a>-->
                            <#--<a data-value="东风风神" class='' data-ba-label="品牌_东风风神">东风风神</a>-->
                            <#--<a data-value="之诺" class='' data-ba-label="品牌_之诺">之诺</a>-->
                            <#--<a data-value="众泰" class='' data-ba-label="品牌_众泰">众泰</a>-->
                            <#--<a data-value="东风日产" class='' data-ba-label="品牌_东风日产">东风日产</a>-->
                            <#--<a data-value="东风风行" class='' data-ba-label="品牌_东风风行">东风风行</a>-->
                            <#--<a data-value="九龙" class='' data-ba-label="品牌_九龙">九龙</a>-->
                            <#--<a data-value="保时捷" class='' data-ba-label="品牌_保时捷">保时捷</a>-->
                            <#--<a data-value="宝骏" class='' data-ba-label="品牌_宝骏">宝骏</a>-->
                            <#--<a data-value="菲亚特" class='' data-ba-label="品牌_菲亚特">菲亚特</a>-->
                            <#--<a data-value="smart" class='' data-ba-label="品牌_smart">smart</a>-->
                            <#--<a data-value="北汽" class='' data-ba-label="品牌_北汽">北汽</a>-->
                            <#--<a data-value="红旗" class='' data-ba-label="品牌_红旗">红旗</a>-->
                            <#--<a data-value="阿斯顿马丁" class='' data-ba-label="品牌_阿斯顿马丁">阿斯顿马丁</a>-->
                            <#--<a data-value="扬子江" class='' data-ba-label="品牌_扬子江">扬子江</a>-->
                            <#--<a data-value="力帆" class='' data-ba-label="品牌_力帆">力帆</a>-->
                            <#--<a data-value="阿尔法罗密欧" class='' data-ba-label="品牌_阿尔法罗密欧">阿尔法罗密欧</a>-->
                            <#--<a data-value="林肯" class='' data-ba-label="品牌_林肯">林肯</a>-->
                            <#--<a data-value="雷诺" class='' data-ba-label="品牌_雷诺">雷诺</a>-->
                            <#--<a data-value="海马" class='' data-ba-label="品牌_海马">海马</a>-->
                            </div>
                        </div>
                        <div class="choose-price choose-ck">
									<span>
										价格：
									</span>
                            <div class="pricelist">
                                <a class='on'>全部</a>
                                <a>100元以下</a>
                                <a>100-200元</a>
                                <a>200-300元</a>
                                <a>300元以上</a>
                            </div>
                        </div>
                        <div class="choose-gear choose-ck" style="display: none">
									<span>
										排挡：
									</span>
                            <div class="gearlist">
                                <a data-value class='on'>全部</a>
										<#if mobileStallsEnums??>
                                            <#list mobileStallsEnums as mobileStalls>
												<a data-value="${mobileStalls.getCode()}">${mobileStalls.getName()}</a>
                                            </#list>
                                        </#if>
                            </div>
                        </div>
                        <div class="choose-seat choose-ck" style="display: none">
									<span>
										座位：
									</span>
                            <div class="seatlist">
                                <a class='on'>全部</a>
										<#if mobileSeatEnums??>
                                            <#list mobileSeatEnums as mobileSeat>
												<a data-value="${mobileSeat.getCode()}">${mobileSeat.getName()}</a>
                                            </#list>
                                        </#if>
                            </div>
                        </div>
                        <div class="choosemore-box" id="J_choosemore">
									<span class="choose-more">
									</span>
                        </div>
                    </div>
                </div>
                <div class="sort clearfix">
                    <ul class="field-orderby" sortby="null">
                        <li class="sort-default">
                            <a href="javascript:;" class="order-def" value="null">
                                默认排序
                            </a>
                        </li>
                        <li class="sort-price">
                            <a href="javascript:;" class="order-def" value="RentDesc">
                                按租金
                                <span class="sort-icon">
										</span>
                            </a>
                        </li>
                        <li class="sort-emission">
                            <a href="javascript:;" class="order-def" value="OutputVolumeDesc">
                                按排量
                                <span class="sort-icon">
										</span>
                            </a>
                        </li>
                    </ul>
                    <div class="field-level-wrap">
								<span id="chkIsQueue" style="display: none;">
									false
								</span>
                    </div>
                    <div class="field-tip">
                        共有
                        <span id="carTypeCount">
									1
								</span>
                        种车型可以租用
                    </div>
                </div>
                <div class="carwrap clearfix">
                    <div id="imgLoad" class="pageinfo-box">
                        <p class="loading-box">
                            <img src="/home/images/loading.gif" alt=""/>
                            正在为您查询可租车型...
                        </p>
                    </div>
                    <div id="nocar" style="display: none;">
                        <img src="/home/images/nocar.png" alt=""/>
                        <div class="nocar-explain">
                            <p class="nocar-text1">
                                对不起，当前门店该时间段内车辆已经租满。
                            </p>
                            <p class="nocar-text2">
                                您可以重新选择其他门店。
                            </p>
                        </div>
                    </div>
                    <div>
                        <div id="reservationList" data-count="37" data-nostockcount="5">
                        <#if releaseVehicleInformationList??>
                            <#list releaseVehicleInformationList as releaseVehicleInformation>
                                <div class="det-carlist">
                                    <ul>
                                        <li class="licar-picbox">
                                            <div class="licar-picinfo">
                                                <img src="/photo/view?filename=${releaseVehicleInformation.automobileInformation.automobilePicturePath}"
                                                     alt="${releaseVehicleInformation.automobileInformation.automobileBrand.brand}"
                                                     style="display: inline;">
                                                <span id="carListVideo"
                                                      data-cartypeids="${releaseVehicleInformation.automobileInformation.id}"
                                                      class="video-playbtn video-total"></span>
                                            </div>
                                        </li>
                                        <li class="licar-namebox">
                                            <div class="licar-nameinfo">
                                                <p class="car-nameinfo">
                                                    <span>${releaseVehicleInformation.automobileInformation.automobileBrand.brand}</span>
                                                    <a href="javascript:void(0);" class="sp-aczs sp-box"><i
                                                            class="lv3"></i></a>
                                                </p>
                                                <p class="car-introinfo">
                                                    ${releaseVehicleInformation.automobileInformation.automobileStalls.getName()}|
                                                    ${releaseVehicleInformation.automobileInformation.automobileSeat.getName()}|
                                                    <a href="javascript:void(0)" id="carDetail"
                                                       data-cid="{&#39;cartypeList&#39;:[421],&#39;groupId&#39;:0}">车辆详情&gt;</a>
                                                </p>
                                                <p class="car-typeinfo">
                                                    <span></span>
                                                </p>
                                                <p class="car-activeinfo">
                                                    <span class="shalloworg">省油</span>
                                                    <span class="shalloworg">实惠</span>
                                                    <span class="shalloworg">经济</span>
                                                    <span class="shalloworg">月租特惠</span>
                                                </p>
                                            </div>
                                        </li>
                                        <li class="licar-info">
                                            <p class="condition1">
                                                <!--标准价-->
                                                <span class="cartitle"></span>
                                                <span class="carprice">
                                                <i class="symbol">¥</i>
                                                <em class="total-price">${releaseVehicleInformation.automobileInformation.dailyRentalRate}</em>/日均
                                            </span>
                                                <span class="licar-btn btnopen1 ">预订</span>
                                                <span class="typebtn btntop1 ">
                                                <a href="javascript:;" class="type-four  btn-book" data-ipcar="False"
                                                   data-price="90" data-ishicar="False"
                                                   data-price-type="1" data-cid="hG9sR6XPHfU=" data-gid="BKg1Aofv7wM=">
                                                    <span>
                                                        门店现付<br>
                                                    </span><i class="symbol">¥</i>
                                                    <em class="total-price">${releaseVehicleInformation.automobileInformation.dailyRentalRate}</em>
                                                </a>
                                            </span>
                                            </p>
                                        </li>
                                    </ul>
                                </div>
                            </#list>
                        </#if>
                            <div class="det-carlist">
                                <ul>
                                    <li class="licar-picbox">
                                        <div class="licar-picinfo">
                                            <img src="/Content/Images/Order/NewStep/lazy.gif?v=3da4e6695c0f4986adb7b3f79e99d5b0"
                                                 class="lazy"
                                                 data-original="https://externalimage.1hai.cn/cartype/92329aa09960e645c9a6f65ba0445860.png?v=3da4e6695c0f4986adb7b3f79e99d5b0"
                                                 alt="别克GL8 2018款 28T 舒适型 (沪牌)">
                                            <span id="carListVideo" data-cartypeids="1651"
                                                  class="video-playbtn video-total"></span>

                                        </div>
                                    </li>
                                    <li class="licar-namebox">
                                        <div class="licar-nameinfo">
                                            <p class="car-nameinfo">
                                                <span>别克GL8 2018款 28T 舒适型 (沪牌)</span>
                                                <a href="javascript:void(0);" class="sp-aczs sp-box"><i class="lv5"></i></a>
                                            </p>
                                            <p class="car-introinfo">
                                                <span>自动 2.0<text>T</text></span>
                                                <text>|</text>
                                                <span>MPV</span>
                                                |7座 |
                                                <a href="javascript:void(0)" id="carDetail"
                                                   data-cid="{'cartypeList':[1651],'groupId':0}">车辆详情&gt;</a>
                                            </p>
                                            <p class="car-typeinfo">
                                                <span></span>
                                            </p>
                                            <p class="car-activeinfo">
                                                <span class="shallowgray">已租满</span>
                                            </p>
                                        </div>
                                    </li>
                                    <li class="licar-operatebox">
                                        <p><span class="licar-btn btn-change-store" data-name="别克GL8 2018款 28T 舒适型 (沪牌)"
                                                 data-cid="1651" data-gid="0">换门店</span></p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="step1-body-right">
            <div id="divBookingInfo">
                <div class="step1-map">
                    <div style="width: 270px; height: 270px">
                        <div id="map" data-longitude="121.447462" data-latitude="31.191411"
                             data-baidu-longitude="121.447462"
                             data-baidu-latitude="31.191411" style="width: 100%; height: 100%">
                        </div>
                    </div>
                </div>
                <div class="step1-storeinfo">
                    <ul>
                        <li>取车门店：</li>
                        <li><span>八万人体育场店</span></li>
                        <li>上海市徐汇区斜土路2899号甲（光启文化广场内）</li>
                        <li><em>门店电话：</em><em>021-64160981</em></li>
                        <li><em>营业时间：</em><em>08:00-22:00</em></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="mshowbox" class="myshowbox undefined" style="margin: -250px 0px 0px -410px; display: none">
        <div class="myshowbox-container window-scroll" style="width: 800px;">
            <a class="btn-close" href="javascript: ;">
                <img src="/home/images/close.png" onclick="closeVideo()"></img>
            </a>
            <h3 class="title" style="display: none;"></h3>
            <div class="div-myshowbox" style="width:800px; height:470px;">
                <div class="swiper-container">
                    <div class="swiper-wrapper" style="width: 780px; height: 425px;">
                        <div class="swiper-slide swiper-no-swiping swiper-slide-visible swiper-slide-active"
                             style="width: 780px; height: 425px;">
                            <video id="carVideo0" poster="https://img.1hai.cn/groupf1/M00/9B/11/rBQFH12_5UuASgSVAAALJlNcsak749.png"
                                   controls="controls"></video>
                            <p id="brand" ></p>
                        </div>
                    </div>
                    <div class="pagination"><span
                            class="swiper-pagination-switch swiper-visible-switch swiper-active-switch"></span></div>
                    <div class="swiper-btn-prev"><span></span></div>
                    <div class="swiper-btn-next"><span></span></div>
                </div>
            </div>
        </div>
    </div>

    <!--门店列表-->
    <div id="ydkBox" class="ydk-box"></div>
    <!--门店营业时间-->
    <ul id="timeselect" class="timeselect"></ul>
    <!--门店营业时间-->
    <ul id="timeselectminute" class="timeselect"></ul>

    <div class="nav-bottom clear_float">
        <div class="navbottom-banner">
            <div class="btbanner-city">450多座城市</div>
            <div class="btbanner-store">6000多服务网点</div>
            <div class="btbanner-car">200余种车型</div>
            <div class="btbanner-service">24小时服务</div>
            <div class="btbanner-inter">国际租车</div>
        </div>
        <div class="new-sth-question center clear_float">
            <dl>
                <dt class="sth-tit">新手指南</dt>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=1&isLimitRules=False"
                       target="_blank"
                       rel="nofollow">注册新用户</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=12&isLimitRules=False"
                       target="_blank"
                       rel="nofollow">预订演示</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=19&isLimitRules=False"
                       target="_blank"
                       rel="nofollow">取消或修改订单</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/help/RentCarService.aspx" target="_blank"
                       rel="nofollow">租车协议</a>
                </dd>
            </dl>
            <dl>
                <dt class="sth-tit">租车贴士</dt>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=18&isLimitRules=False#qrdd-zffs"
                       target="_blank" rel="nofollow">支付方式</a>
                </dd>
                <dd>
                    <a href="https://news.1hai.cn/" target="_blank" rel="nofollow">精彩活动</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=17&isLimitRules=False"
                       target="_blank"
                       rel="nofollow">增值服务</a>
                </dd>
            </dl>
            <dl>
                <dt class="sth-tit">售后服务</dt>
                <dd>
                    <a href="https://my.1hai.cn/UserCenter/MyComplaint" target="_blank" rel="nofollow">投诉中心</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/help/advice.aspx" target="_blank" rel="nofollow">建议专区</a>
                </dd>
            </dl>
            <dl>
                <dt class="sth-tit">会员服务</dt>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=1&isLimitRules=False#zcdl-zhmm"
                       target="_blank" rel="nofollow">忘记密码</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=4&isLimitRules=False"
                       target="_blank"
                       rel="nofollow">会员充值</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=6&isLimitRules=False#jfsc-jfsm"
                       target="_blank" rel="nofollow">积分说明</a>
                </dd>
            </dl>
            <dl>
                <dt class="sth-tit">网站帮助</dt>
                <dd>
                    <a href="https://news.1hai.cn/" target="_blank" rel="nofollow">一嗨租车动态</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=28&isLimitRules=False"
                       target="_blank"
                       rel="nofollow">联系我们</a>
                </dd>
                <dd>
                    <a href="https://www.1hai.cn/help/nrom.aspx" target="_blank" rel="nofollow">网站帮助</a>
                </dd>
            </dl>
            <dl>
                <dt class="sth-tit">下载移动端</dt>
                <dd>
                    <img src="/home/images/4ffdf2a079c34221a51d949726acfbcd.png" width="100" height="100"/>
                </dd>
            </dl>
        </div>
    </div>
    <!-- bottom banner-->
    <div class="footer">
        <div class="footer-box clear_float">
            <div class="footer-left">
                <p>
                    <a href="https://news.1hai.cn/About/" rel="nofollow" target="_blank">关于一嗨</a>
                    |
                    <a href="https://www.1hai.cn/activity/mobile.aspx" target="_blank">移动客户端</a>
                    |
                    <a href="https://www.1hai.cn/NewHelp/Index" rel="nofollow" target="_blank">帮助中心</a>
                    |
                    <a href="https://www.1hai.cn/help/advice.aspx" rel="nofollow" target="_blank">建议专区</a>
                    |
                    <a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=28&amp;isLimitRules=False"
                       rel="nofollow"
                       target="_blank">联系我们</a>
                    |
                    <a href="https://www.1hai.cn/more/link.aspx" rel="nofollow" target="_blank">友情链接</a>
                    | &nbsp;投诉通道：400-821-1608 &nbsp;
                </p>
                <p>
                    &nbsp;Copyright &copy; 2007-2020
                    上海一嗨信息技术服务有限公司
                    <a href="http://www.miibeian.gov.cn/" target="_blank" rel="nofollow">ICP证：沪B2-20140130</a>
                </p>
            </div>
            <div class="footer-right">
                <a href="https://www.sgs.gov.cn/lz/licenseLink.do?method=licenceView&entyId=20120327164136446"
                   target="_blank">
                    <img src="/home/images/foot_shgs.png">
                </a>
                <a href="http://www.zx110.org/" target="_blank">
                    <img src="/home/images/foot_zxw.png">
                </a>
                <a href="https://shuidi.cn/companyextreme-0752d1acddc459c11bb8f943671a3347.html"
                   target="_blank">
                    <img src="/home/images/foot_sdxy.png"/>
                </a>
                <a href="https://www.beian.gov.cn/portal/registerSystemInfo?recordcode=31010702001166"
                   target="_blank">
                    <img src="/home/images/foot_hgwab.png"/>
                </a>
            </div>
        </div>

        <div class="nav-footer">
            <div id="city-all">
                <div class="city-all-wrap city-box">
                    <h3>
                        城市租车快捷导航：
                    </h3>
                    <ul class="clear_float">
                        <li><a href='https://www.1hai.cn/c_beijing/' target='_blank'>北京租车</a></li>
                        <li><a href='https://www.1hai.cn/c_shanghai/' target='_blank'>上海租车</a></li>
                        <li><a href='https://www.1hai.cn/c_tianjin/' target='_blank'>天津租车</a></li>
                        <li><a href='https://www.1hai.cn/c_chongqing/' target='_blank'>重庆租车</a></li>
                        <li><a href='https://www.1hai.cn/c_haerbin/' target='_blank'>哈尔滨租车</a></li>
                        <li><a href='https://www.1hai.cn/c_changchun/' target='_blank'>长春租车</a></li>
                        <li><a href='https://www.1hai.cn/c_shenyang/' target='_blank'>沈阳租车</a></li>
                        <li><a href='https://www.1hai.cn/c_shijiazhuang/' target='_blank'>石家庄租车</a></li>
                        <li><a href='https://www.1hai.cn/c_lanzhou/' target='_blank'>兰州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_xining/' target='_blank'>西宁租车</a></li>
                        <li><a href='https://www.1hai.cn/c_xian/' target='_blank'>西安租车</a></li>
                        <li><a href='https://www.1hai.cn/c_yinchuan/' target='_blank'>银川租车</a></li>
                        <li><a href='https://www.1hai.cn/c_zhengzhou/' target='_blank'>郑州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_jinan/' target='_blank'>济南租车</a></li>
                        <li><a href='https://www.1hai.cn/c_taiyuan/' target='_blank'>太原租车</a></li>
                        <li><a href='https://www.1hai.cn/c_hefei/' target='_blank'>合肥租车</a></li>
                        <li><a href='https://www.1hai.cn/c_wuhan/' target='_blank'>武汉租车</a></li>
                        <li><a href='https://www.1hai.cn/c_nanjing/' target='_blank'>南京租车</a></li>
                        <li><a href='https://www.1hai.cn/c_chengdu/' target='_blank'>成都租车</a></li>
                        <li><a href='https://www.1hai.cn/c_guiyang/' target='_blank'>贵阳租车</a></li>
                        <li><a href='https://www.1hai.cn/c_kunming/' target='_blank'>昆明租车</a></li>
                        <li><a href='https://www.1hai.cn/c_nanning/' target='_blank'>南宁租车</a></li>
                        <li><a href='https://www.1hai.cn/c_hangzhou/' target='_blank'>杭州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_nanchang/' target='_blank'>南昌租车</a></li>
                        <li><a href='https://www.1hai.cn/c_guangzhou/' target='_blank'>广州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_fuzhou/' target='_blank'>福州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_haikou/' target='_blank'>海口租车</a></li>
                        <li><a href='https://www.1hai.cn/c_sanya/' target='_blank'>三亚租车</a></li>
                        <li><a href='https://www.1hai.cn/c_xiamen/' target='_blank'>厦门租车</a></li>
                        <li><a href='https://www.1hai.cn/c_lijiang/' target='_blank'>丽江租车</a></li>
                        <li><a href='https://www.1hai.cn/c_dali/' target='_blank'>大理租车</a></li>
                        <li><a href='https://www.1hai.cn/c_guilin/' target='_blank'>桂林租车</a></li>
                        <li><a href='https://www.1hai.cn/c_suzhou/' target='_blank'>苏州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_qingdao/' target='_blank'>青岛租车</a></li>
                        <li><a href='https://www.1hai.cn/c_zhuhai/' target='_blank'>珠海租车</a></li>
                        <li><a href='https://www.1hai.cn/c_dongguan/' target='_blank'>东莞租车</a></li>
                    </ul>
                    <div class="city-morebox" id="J_citymore"><span class="city-more"></span></div>
                    <ul style="display: none;" class="clear_float">
                        <li><a href='https://www.1hai.cn/c_foshan/' target='_blank'>佛山租车</a></li>
                        <li><a href='https://www.1hai.cn/c_changsha/' target='_blank'>长沙租车</a></li>
                        <li><a href='https://www.1hai.cn/c_shenzhen/' target='_blank'>深圳租车</a></li>
                        <li><a href='https://www.1hai.cn/c_yantai/' target='_blank'>烟台租车</a></li>
                        <li><a href='https://www.1hai.cn/c_changzhou/' target='_blank'>常州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_ningbo/' target='_blank'>宁波租车</a></li>
                        <li><a href='https://www.1hai.cn/c_wuxi/' target='_blank'>无锡租车</a></li>
                        <li><a href='https://www.1hai.cn/c_dalian/' target='_blank'>大连租车</a></li>
                        <li><a href='https://www.1hai.cn/c_wenzhou/' target='_blank'>温州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_putian/' target='_blank'>莆田租车</a></li>
                        <li><a href='https://www.1hai.cn/c_shantou/' target='_blank'>汕头租车</a></li>
                        <li><a href='https://www.1hai.cn/c_zhenjiang/' target='_blank'>镇江租车</a></li>
                        <li><a href='https://www.1hai.cn/c_huizhou/' target='_blank'>惠州租车</a></li>
                        <li><a href='https://www.1hai.cn/c_luoyang/' target='_blank'>洛阳租车</a></li>
                        <li><a href='https://www.1hai.cn/c_nantong/' target='_blank'>南通租车</a></li>
                        <li><a href='https://www.1hai.cn/c_huaian/' target='_blank'>淮安租车</a></li>
                        <li><a href='https://www.1hai.cn/c_baotou/' target='_blank'>包头租车</a></li>
                        <li><a href='https://www.1hai.cn/c_jiaxing/' target='_blank'>嘉兴租车</a></li>
                        <li><a href='https://www.1hai.cn/c_shangrao/' target='_blank'>上饶租车</a></li>
                        <li><a href='https://www.1hai.cn/c_datong/' target='_blank'>大同租车</a></li>
                        <li><a href='https://www.1hai.cn/c_jiujiang/' target='_blank'>九江租车</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <!--s城市列表-->
    <div id="ydcityBox" class="ydcity-box">
        <div class="wrap-title">
            <ul id="mark">
                <li class="city-help">可直接输入城市或城市拼音</li>
            </ul>
            <ul class="tabHF-title list-type">
                <li class="current">热门</li>
                <li>ABCDE</li>
                <li>FGHJ</li>
                <li>KLMN</li>
                <li>PQRST</li>
                <li>WXYZ</li>
            </ul>
        </div>
        <ul class="tabHF-content list-city">
            <li class="current">
                <div class="inner-box">
                    <dl>
                        <dd>
                                    <span class="selected" sendcar="Y" rel="上海" pre="SH  " dsi="886"
                                          data-id="77">上海</span>
                        </dd>
                        <dd>
                            <span rel="北京" sendcar="Y" pre="BJ  " dsi="1145" data-id="5">北京</span>
                        </dd>
                        <dd>
                            <span rel="深圳" sendcar="Y" pre="GD  " dsi="26" data-id="21">深圳</span>
                        </dd>
                        <dd>
                            <span rel="三亚" sendcar="Y" pre="AN  " dsi="165" data-id="3">三亚</span>
                        </dd>
                        <dd>
                            <span rel="海口" sendcar="Y" pre="AN  " dsi="301" data-id="2">海口</span>
                        </dd>
                        <dd>
                            <span rel="杭州" sendcar="N" pre="ZJ  " dsi="10" data-id="88">杭州</span>
                        </dd>
                        <dd>
                            <span rel="成都" sendcar="Y" pre="SC  " dsi="30" data-id="71">成都</span>
                        </dd>
                        <dd>
                            <span rel="重庆" sendcar="Y" pre="CQ  " dsi="38" data-id="7">重庆</span>
                        </dd>
                        <dd>
                            <span rel="武汉" sendcar="Y" pre="UB  " dsi="1131" data-id="81">武汉</span>
                        </dd>
                        <dd>
                            <span rel="昆明" sendcar="Y" pre="YN  " dsi="342" data-id="86">昆明</span>
                        </dd>
                        <dd>
                            <span rel="天津" sendcar="Y" pre="TJ  " dsi="16" data-id="79">天津</span>
                        </dd>
                        <dd>
                            <span rel="南京" sendcar="Y" pre="JS  " dsi="14" data-id="50">南京</span>
                        </dd>
                        <dd>
                            <span rel="长沙" sendcar="N" pre="UN  " dsi="1342" data-id="82">长沙</span>
                        </dd>
                        <dd>
                            <span rel="珠海" sendcar="N" pre="GD  " dsi="3065" data-id="25">珠海</span>
                        </dd>
                        <dd>
                            <span rel="西安" sendcar="N" pre="AX  " dsi="2207" data-id="4">西安</span>
                        </dd>
                        <dd>
                            <span rel="郑州" sendcar="Y" pre="HN  " dsi="1018" data-id="42">郑州</span>
                        </dd>
                        <dd>
                            <span rel="大理" sendcar="N" pre="YN  " dsi="1074" data-id="108">大理</span>
                        </dd>
                        <dd>
                            <span rel="青岛" sendcar="Y" pre="SD  " dsi="11" data-id="74">青岛</span>
                        </dd>
                        <dd>
                            <span rel="贵阳" sendcar="Y" pre="GZ  " dsi="335" data-id="31">贵阳</span>
                        </dd>
                        <dd>
                            <span rel="桂林" sendcar="N" pre="GX  " dsi="28" data-id="28">桂林</span>
                        </dd>
                        <dd>
                            <span rel="宝应" sendcar="N" pre="JS  " dsi="9683" data-id="607">宝应</span>
                        </dd>
                        <dd>
                            <span rel="广州" sendcar="Y" pre="GD  " dsi="32" data-id="16">广州</span>
                        </dd>
                    </dl>
                </div>
            </li>
            <li>
                <div class="inner-box">
                    <dl>
                        <div class='city-initial'><em>A</em>
                            <dd>
                                <span rel="阿克苏" sendcar="N" pre="XJ  " dsi="8945" data-id="441">阿克苏</span>
                            </dd>
                            <dd>
                                <span rel="安达" sendcar="N" pre="HLJ " dsi="7016" data-id="499">安达</span>
                            </dd>
                            <dd>
                                <span rel="安吉" sendcar="N" pre="ZJ  " dsi="9749" data-id="608">安吉</span>
                            </dd>
                            <dd>
                                <span rel="安康" sendcar="N" pre="AX  " dsi="2739" data-id="224">安康</span>
                            </dd>
                            <dd>
                                <span rel="安庆" sendcar="N" pre="AH  " dsi="2628" data-id="204">安庆</span>
                            </dd>
                            <dd>
                                <span rel="安顺" sendcar="N" pre="GZ  " dsi="6335" data-id="157">安顺</span>
                            </dd>
                            <dd>
                                <span rel="安图" sendcar="N" pre="JL  " dsi="7897" data-id="553">安图</span>
                            </dd>
                            <dd>
                                <span rel="安阳" sendcar="N" pre="HN  " dsi="4322" data-id="277">安阳</span>
                            </dd>
                            <dd>
                                <span rel="鞍山" sendcar="Y" pre="LN  " dsi="1106" data-id="111">鞍山</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>B</em>
                            <dd>
                                <span rel="巴彦淖尔" sendcar="N" pre="NMG " dsi="5764" data-id="334">巴彦淖尔</span>
                            </dd>
                            <dd>
                                <span rel="巴中" sendcar="N" pre="SC  " dsi="5790" data-id="341">巴中</span>
                            </dd>
                            <dd>
                                <span rel="霸州" sendcar="N" pre="HB  " dsi="7012" data-id="497">霸州</span>
                            </dd>
                            <dd>
                                <span rel="白城" sendcar="N" pre="JL  " dsi="5688" data-id="332">白城</span>
                            </dd>
                            <dd>
                                <span rel="白沙" sendcar="N" pre="AN  " dsi="8360" data-id="561">白沙</span>
                            </dd>
                            <dd>
                                <span rel="白银" sendcar="N" pre="GS  " dsi="8059" data-id="406">白银</span>
                            </dd>
                            <dd>
                                <span rel="百色" sendcar="N" pre="GX  " dsi="5332" data-id="309">百色</span>
                            </dd>
                            <dd>
                                <span rel="蚌埠" sendcar="N" pre="AH  " dsi="2257" data-id="140">蚌埠</span>
                            </dd>
                            <dd>
                                <span rel="包头" sendcar="N" pre="NMG " dsi="839" data-id="64">包头</span>
                            </dd>
                            <dd>
                                <span rel="宝鸡" sendcar="N" pre="AX  " dsi="2281" data-id="141">宝鸡</span>
                            </dd>
                            <dd>
                                <span rel="宝应" sendcar="N" pre="JS  " dsi="9683" data-id="607">宝应</span>
                            </dd>
                            <dd>
                                <span rel="保定" sendcar="N" pre="HB  " dsi="785" data-id="32">保定</span>
                            </dd>
                            <dd>
                                <span rel="保山" sendcar="N" pre="YN  " dsi="5796" data-id="345">保山</span>
                            </dd>
                            <dd>
                                <span rel="北海" sendcar="N" pre="GX  " dsi="2363" data-id="159">北海</span>
                            </dd>
                            <dd>
                                <span rel="北京" sendcar="Y" pre="BJ  " dsi="1145" data-id="5">北京</span>
                            </dd>
                            <dd>
                                <span rel="本溪" sendcar="N" pre="LN  " dsi="2500" data-id="173">本溪</span>
                            </dd>
                            <dd>
                                <span rel="毕节" sendcar="N" pre="GZ  " dsi="9342" data-id="392">毕节</span>
                            </dd>
                            <dd>
                                <span rel="滨州" sendcar="N" pre="SD  " dsi="3692" data-id="259">滨州</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>C</em>
                            <dd>
                                <span rel="苍溪" sendcar="N" pre="SC  " dsi="8817" data-id="581">苍溪</span>
                            </dd>
                            <dd>
                                <span rel="沧州" sendcar="N" pre="HB  " dsi="2021" data-id="138">沧州</span>
                            </dd>
                            <dd>
                                <span rel="昌江" sendcar="N" pre="AN  " dsi="5424" data-id="312">昌江</span>
                            </dd>
                            <dd>
                                <span rel="常德" sendcar="N" pre="UN  " dsi="1495" data-id="128">常德</span>
                            </dd>
                            <dd>
                                <span rel="常山" sendcar="N" pre="ZJ  " dsi="8525" data-id="566">常山</span>
                            </dd>
                            <dd>
                                <span rel="常熟" sendcar="N" pre="JS  " dsi="1" data-id="45">常熟</span>
                            </dd>
                            <dd>
                                <span rel="常州" sendcar="Y" pre="JS  " dsi="232" data-id="46">常州</span>
                            </dd>
                            <dd>
                                <span rel="巢湖" sendcar="N" pre="AH  " dsi="3523" data-id="253">巢湖</span>
                            </dd>
                            <dd>
                                <span rel="朝阳" sendcar="N" pre="LN  " dsi="7329" data-id="364">朝阳</span>
                            </dd>
                            <dd>
                                <span rel="潮州" sendcar="N" pre="GD  " dsi="2583" data-id="194">潮州</span>
                            </dd>
                            <dd>
                                <span rel="郴州" sendcar="N" pre="UN  " dsi="2353" data-id="153">郴州</span>
                            </dd>
                            <dd>
                                <span rel="成都" sendcar="Y" pre="SC  " dsi="30" data-id="71">成都</span>
                            </dd>
                            <dd>
                                <span rel="承德" sendcar="N" pre="HB  " dsi="2713" data-id="218">承德</span>
                            </dd>
                            <dd>
                                <span rel="澄迈" sendcar="N" pre="AN  " dsi="6541" data-id="301">澄迈</span>
                            </dd>
                            <dd>
                                <span rel="池州" sendcar="N" pre="AH  " dsi="5677" data-id="323">池州</span>
                            </dd>
                            <dd>
                                <span rel="赤壁" sendcar="N" pre="UB  " dsi="7271" data-id="522">赤壁</span>
                            </dd>
                            <dd>
                                <span rel="赤峰" sendcar="N" pre="NMG " dsi="2893" data-id="236">赤峰</span>
                            </dd>
                            <dd>
                                <span rel="滁州" sendcar="N" pre="AH  " dsi="2752" data-id="229">滁州</span>
                            </dd>
                            <dd>
                                <span rel="楚雄" sendcar="N" pre="YN  " dsi="5818" data-id="349">楚雄</span>
                            </dd>
                            <dd>
                                <span rel="慈溪" sendcar="N" pre="ZJ  " dsi="7001" data-id="472">慈溪</span>
                            </dd>
                            <dd>
                                <span rel="从江" sendcar="N" pre="GZ  " dsi="7647" data-id="540">从江</span>
                            </dd>
                            <dd>
                                <span rel="长春" sendcar="Y" pre="JL  " dsi="83" data-id="43">长春</span>
                            </dd>
                            <dd>
                                <span rel="长丰" sendcar="N" pre="AH  " dsi="9512" data-id="604">长丰</span>
                            </dd>
                            <dd>
                                <span rel="长临河" sendcar="N" pre="AH  " dsi="6983" data-id="464">长临河</span>
                            </dd>
                            <dd>
                                <span rel="长沙" sendcar="N" pre="UN  " dsi="1342" data-id="82">长沙</span>
                            </dd>
                            <dd>
                                <span rel="长汀" sendcar="N" pre="FJ  " dsi="9079" data-id="587">长汀</span>
                            </dd>
                            <dd>
                                <span rel="长治" sendcar="N" pre="SX  " dsi="2450" data-id="169">长治</span>
                            </dd>
                            <dd>
                                <span rel="重庆" sendcar="Y" pre="CQ  " dsi="38" data-id="7">重庆</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>D</em>
                            <dd>
                                <span rel="达州" sendcar="N" pre="SC  " dsi="3708" data-id="264">达州</span>
                            </dd>
                            <dd>
                                <span rel="大理" sendcar="N" pre="YN  " dsi="1074" data-id="108">大理</span>
                            </dd>
                            <dd>
                                <span rel="大连" sendcar="Y" pre="LN  " dsi="856" data-id="61">大连</span>
                            </dd>
                            <dd>
                                <span rel="大庆" sendcar="N" pre="HLJ " dsi="2618" data-id="197">大庆</span>
                            </dd>
                            <dd>
                                <span rel="大同" sendcar="N" pre="SX  " dsi="1273" data-id="119">大同</span>
                            </dd>
                            <dd>
                                <span rel="大冶" sendcar="N" pre="UB  " dsi="7112" data-id="509">大冶</span>
                            </dd>
                            <dd>
                                <span rel="丹东" sendcar="N" pre="LN  " dsi="1939" data-id="137">丹东</span>
                            </dd>
                            <dd>
                                <span rel="丹阳" sendcar="N" pre="JS  " dsi="2575" data-id="186">丹阳</span>
                            </dd>
                            <dd>
                                <span rel="儋州" sendcar="N" pre="AN  " dsi="5170" data-id="304">儋州</span>
                            </dd>
                            <dd>
                                <span rel="德宏" sendcar="N" pre="YN  " dsi="4333" data-id="282">德宏</span>
                            </dd>
                            <dd>
                                <span rel="德惠" sendcar="N" pre="JL  " dsi="7211" data-id="520">德惠</span>
                            </dd>
                            <dd>
                                <span rel="德令哈" sendcar="N" pre="QH  " dsi="7382" data-id="528">德令哈</span>
                            </dd>
                            <dd>
                                <span rel="德清" sendcar="N" pre="ZJ  " dsi="2688" data-id="210">德清</span>
                            </dd>
                            <dd>
                                <span rel="德兴" sendcar="N" pre="JX  " dsi="6875" data-id="473">德兴</span>
                            </dd>
                            <dd>
                                <span rel="德阳" sendcar="N" pre="SC  " dsi="2357" data-id="156">德阳</span>
                            </dd>
                            <dd>
                                <span rel="德州" sendcar="N" pre="SD  " dsi="2624" data-id="200">德州</span>
                            </dd>
                            <dd>
                                <span rel="定安" sendcar="N" pre="AN  " dsi="5680" data-id="326">定安</span>
                            </dd>
                            <dd>
                                <span rel="定西" sendcar="N" pre="GS  " dsi="7160" data-id="411">定西</span>
                            </dd>
                            <dd>
                                <span rel="定州" sendcar="N" pre="HB  " dsi="7007" data-id="496">定州</span>
                            </dd>
                            <dd>
                                <span rel="东方" sendcar="N" pre="AN  " dsi="5195" data-id="306">东方</span>
                            </dd>
                            <dd>
                                <span rel="东莞" sendcar="Y" pre="GD  " dsi="49" data-id="14">东莞</span>
                            </dd>
                            <dd>
                                <span rel="东阳" sendcar="N" pre="ZJ  " dsi="8714" data-id="578">东阳</span>
                            </dd>
                            <dd>
                                <span rel="东营" sendcar="N" pre="SD  " dsi="3002" data-id="239">东营</span>
                            </dd>
                            <dd>
                                <span rel="都匀" sendcar="N" pre="GZ  " dsi="5681" data-id="327">都匀</span>
                            </dd>
                            <dd>
                                <span rel="敦化" sendcar="N" pre="JL  " dsi="4849" data-id="290">敦化</span>
                            </dd>
                            <dd>
                                <span rel="敦煌" sendcar="N" pre="GS  " dsi="2800" data-id="230">敦煌</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>E</em>
                            <dd>
                                <span rel="鄂尔多斯" sendcar="N" pre="NMG " dsi="2338" data-id="152">鄂尔多斯</span>
                            </dd>
                            <dd>
                                <span rel="鄂州" sendcar="N" pre="UB  " dsi="6063" data-id="351">鄂州</span>
                            </dd>
                            <dd>
                                <span rel="恩施" sendcar="N" pre="UB  " dsi="3387" data-id="249">恩施</span>
                            </dd>
                    </dl>
                </div>
            </li>
            <li>
                <div class="inner-box">
                    <dl>
                        <div class='city-initial'><em>F</em>
                            <dd>
                                <span rel="防城港" sendcar="N" pre="GX  " dsi="5839" data-id="355">防城港</span>
                            </dd>
                            <dd>
                                <span rel="丰城" sendcar="N" pre="JX  " dsi="8650" data-id="569">丰城</span>
                            </dd>
                            <dd>
                                <span rel="佛山" sendcar="N" pre="GD  " dsi="303" data-id="15">佛山</span>
                            </dd>
                            <dd>
                                <span rel="扶余" sendcar="N" pre="JL  " dsi="7861" data-id="552">扶余</span>
                            </dd>
                            <dd>
                                <span rel="福安" sendcar="N" pre="FJ  " dsi="7295" data-id="524">福安</span>
                            </dd>
                            <dd>
                                <span rel="福鼎" sendcar="N" pre="FJ  " dsi="7123" data-id="511">福鼎</span>
                            </dd>
                            <dd>
                                <span rel="福清" sendcar="N" pre="FJ  " dsi="9065" data-id="585">福清</span>
                            </dd>
                            <dd>
                                <span rel="福州" sendcar="N" pre="FJ  " dsi="325" data-id="8">福州</span>
                            </dd>
                            <dd>
                                <span rel="抚顺" sendcar="Y" pre="LN  " dsi="837" data-id="62">抚顺</span>
                            </dd>
                            <dd>
                                <span rel="抚州" sendcar="N" pre="JX  " dsi="4584" data-id="285">抚州</span>
                            </dd>
                            <dd>
                                <span rel="阜新" sendcar="N" pre="LN  " dsi="7330" data-id="365">阜新</span>
                            </dd>
                            <dd>
                                <span rel="阜阳" sendcar="N" pre="AH  " dsi="6047" data-id="275">阜阳</span>
                            </dd>
                            <dd>
                                <span rel="富阳" sendcar="N" pre="ZJ  " dsi="6698" data-id="456">富阳</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>G</em>
                            <dd>
                                <span rel="赣州" sendcar="N" pre="JX  " dsi="3510" data-id="252">赣州</span>
                            </dd>
                            <dd>
                                <span rel="高安" sendcar="N" pre="JX  " dsi="6904" data-id="476">高安</span>
                            </dd>
                            <dd>
                                <span rel="高密" sendcar="N" pre="SD  " dsi="6848" data-id="478">高密</span>
                            </dd>
                            <dd>
                                <span rel="高州" sendcar="N" pre="GD  " dsi="5250" data-id="481">高州</span>
                            </dd>
                            <dd>
                                <span rel="格尔木" sendcar="N" pre="QH  " dsi="3072" data-id="243">格尔木</span>
                            </dd>
                            <dd>
                                <span rel="公主岭" sendcar="N" pre="JL  " dsi="7109" data-id="508">公主岭</span>
                            </dd>
                            <dd>
                                <span rel="巩义" sendcar="N" pre="HN  " dsi="6992" data-id="466">巩义</span>
                            </dd>
                            <dd>
                                <span rel="共青城" sendcar="N" pre="JX  " dsi="6860" data-id="483">共青城</span>
                            </dd>
                            <dd>
                                <span rel="固原" sendcar="N" pre="NX  " dsi="8836" data-id="437">固原</span>
                            </dd>
                            <dd>
                                <span rel="广安" sendcar="N" pre="SC  " dsi="5791" data-id="342">广安</span>
                            </dd>
                            <dd>
                                <span rel="广汉" sendcar="N" pre="SC  " dsi="6934" data-id="461">广汉</span>
                            </dd>
                            <dd>
                                <span rel="广元" sendcar="N" pre="SC  " dsi="2578" data-id="189">广元</span>
                            </dd>
                            <dd>
                                <span rel="广州" sendcar="Y" pre="GD  " dsi="32" data-id="16">广州</span>
                            </dd>
                            <dd>
                                <span rel="贵定" sendcar="N" pre="GZ  " dsi="7645" data-id="538">贵定</span>
                            </dd>
                            <dd>
                                <span rel="贵港" sendcar="N" pre="GX  " dsi="2736" data-id="221">贵港</span>
                            </dd>
                            <dd>
                                <span rel="贵阳" sendcar="Y" pre="GZ  " dsi="335" data-id="31">贵阳</span>
                            </dd>
                            <dd>
                                <span rel="桂林" sendcar="N" pre="GX  " dsi="28" data-id="28">桂林</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>H</em>
                            <dd>
                                <span rel="哈尔滨" sendcar="Y" pre="HLJ " dsi="310" data-id="38">哈尔滨</span>
                            </dd>
                            <dd>
                                <span rel="海安" sendcar="N" pre="JS  " dsi="7768" data-id="546">海安</span>
                            </dd>
                            <dd>
                                <span rel="海口" sendcar="Y" pre="AN  " dsi="301" data-id="2">海口</span>
                            </dd>
                            <dd>
                                <span rel="海宁" sendcar="N" pre="ZJ  " dsi="7017" data-id="87">海宁</span>
                            </dd>
                            <dd>
                                <span rel="邯郸" sendcar="N" pre="HB  " dsi="1096" data-id="109">邯郸</span>
                            </dd>
                            <dd>
                                <span rel="汉川" sendcar="N" pre="UB  " dsi="7013" data-id="498">汉川</span>
                            </dd>
                            <dd>
                                <span rel="汉中" sendcar="N" pre="AX  " dsi="2683" data-id="206">汉中</span>
                            </dd>
                            <dd>
                                <span rel="杭州" sendcar="N" pre="ZJ  " dsi="10" data-id="88">杭州</span>
                            </dd>
                            <dd>
                                <span rel="合肥" sendcar="Y" pre="AH  " dsi="17" data-id="1">合肥</span>
                            </dd>
                            <dd>
                                <span rel="河源" sendcar="N" pre="GD  " dsi="1473" data-id="127">河源</span>
                            </dd>
                            <dd>
                                <span rel="菏泽" sendcar="N" pre="SD  " dsi="3693" data-id="260">菏泽</span>
                            </dd>
                            <dd>
                                <span rel="贺州" sendcar="N" pre="GX  " dsi="4242" data-id="272">贺州</span>
                            </dd>
                            <dd>
                                <span rel="鹤壁" sendcar="N" pre="HN  " dsi="6993" data-id="378">鹤壁</span>
                            </dd>
                            <dd>
                                <span rel="鹤岗" sendcar="N" pre="HLJ " dsi="5799" data-id="348">鹤岗</span>
                            </dd>
                            <dd>
                                <span rel="衡水" sendcar="N" pre="HB  " dsi="3275" data-id="248">衡水</span>
                            </dd>
                            <dd>
                                <span rel="衡阳" sendcar="N" pre="UN  " dsi="1375" data-id="122">衡阳</span>
                            </dd>
                            <dd>
                                <span rel="红安" sendcar="N" pre="UB  " dsi="7151" data-id="514">红安</span>
                            </dd>
                            <dd>
                                <span rel="洪洞" sendcar="N" pre="SX  " dsi="7625" data-id="532">洪洞</span>
                            </dd>
                            <dd>
                                <span rel="侯马" sendcar="N" pre="SX  " dsi="5320" data-id="308">侯马</span>
                            </dd>
                            <dd>
                                <span rel="呼和浩特" sendcar="Y" pre="NMG " dsi="334" data-id="66">呼和浩特</span>
                            </dd>
                            <dd>
                                <span rel="呼伦贝尔" sendcar="N" pre="NMG " dsi="2685" data-id="207">呼伦贝尔</span>
                            </dd>
                            <dd>
                                <span rel="葫芦岛" sendcar="N" pre="LN  " dsi="1577" data-id="129">葫芦岛</span>
                            </dd>
                            <dd>
                                <span rel="湖州" sendcar="N" pre="ZJ  " dsi="2355" data-id="163">湖州</span>
                            </dd>
                            <dd>
                                <span rel="怀化" sendcar="N" pre="UN  " dsi="4327" data-id="279">怀化</span>
                            </dd>
                            <dd>
                                <span rel="怀仁" sendcar="N" pre="SX  " dsi="7696" data-id="542">怀仁</span>
                            </dd>
                            <dd>
                                <span rel="淮安" sendcar="N" pre="JS  " dsi="882" data-id="47">淮安</span>
                            </dd>
                            <dd>
                                <span rel="淮北" sendcar="N" pre="AH  " dsi="7323" data-id="377">淮北</span>
                            </dd>
                            <dd>
                                <span rel="淮南" sendcar="N" pre="AH  " dsi="2577" data-id="188">淮南</span>
                            </dd>
                            <dd>
                                <span rel="黄冈" sendcar="N" pre="UB  " dsi="5819" data-id="350">黄冈</span>
                            </dd>
                            <dd>
                                <span rel="黄山" sendcar="N" pre="AH  " dsi="2576" data-id="187">黄山</span>
                            </dd>
                            <dd>
                                <span rel="黄石" sendcar="N" pre="UB  " dsi="5168" data-id="303">黄石</span>
                            </dd>
                            <dd>
                                <span rel="珲春" sendcar="N" pre="JL  " dsi="8164" data-id="560">珲春</span>
                            </dd>
                            <dd>
                                <span rel="会昌" sendcar="N" pre="JX  " dsi="9087" data-id="589">会昌</span>
                            </dd>
                            <dd>
                                <span rel="惠州" sendcar="N" pre="GD  " dsi="306" data-id="17">惠州</span>
                            </dd>
                            <dd>
                                <span rel="霍州" sendcar="N" pre="SX  " dsi="7706" data-id="543">霍州</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>J</em>
                            <dd>
                                <span rel="鸡西" sendcar="N" pre="HLJ " dsi="5836" data-id="353">鸡西</span>
                            </dd>
                            <dd>
                                <span rel="吉安" sendcar="N" pre="JX  " dsi="2283" data-id="143">吉安</span>
                            </dd>
                            <dd>
                                <span rel="吉林" sendcar="N" pre="JL  " dsi="2287" data-id="147">吉林</span>
                            </dd>
                            <dd>
                                <span rel="吉首" sendcar="N" pre="UN  " dsi="5651" data-id="319">吉首</span>
                            </dd>
                            <dd>
                                <span rel="吉水" sendcar="N" pre="JX  " dsi="8654" data-id="573">吉水</span>
                            </dd>
                            <dd>
                                <span rel="济南" sendcar="Y" pre="SD  " dsi="375" data-id="72">济南</span>
                            </dd>
                            <dd>
                                <span rel="济宁" sendcar="N" pre="SD  " dsi="5474" data-id="73">济宁</span>
                            </dd>
                            <dd>
                                <span rel="佳木斯" sendcar="N" pre="HLJ " dsi="2684" data-id="39">佳木斯</span>
                            </dd>
                            <dd>
                                <span rel="嘉兴" sendcar="Y" pre="ZJ  " dsi="322" data-id="89">嘉兴</span>
                            </dd>
                            <dd>
                                <span rel="嘉峪关" sendcar="N" pre="GS  " dsi="2627" data-id="203">嘉峪关</span>
                            </dd>
                            <dd>
                                <span rel="简阳" sendcar="N" pre="SC  " dsi="5678" data-id="324">简阳</span>
                            </dd>
                            <dd>
                                <span rel="建德" sendcar="N" pre="ZJ  " dsi="6701" data-id="458">建德</span>
                            </dd>
                            <dd>
                                <span rel="建瓯" sendcar="N" pre="FJ  " dsi="6945" data-id="486">建瓯</span>
                            </dd>
                            <dd>
                                <span rel="剑阁" sendcar="N" pre="SC  " dsi="8818" data-id="582">剑阁</span>
                            </dd>
                            <dd>
                                <span rel="江门" sendcar="N" pre="GD  " dsi="789" data-id="18">江门</span>
                            </dd>
                            <dd>
                                <span rel="江山" sendcar="N" pre="ZJ  " dsi="7196" data-id="519">江山</span>
                            </dd>
                            <dd>
                                <span rel="江阴" sendcar="Y" pre="JS  " dsi="731" data-id="48">江阴</span>
                            </dd>
                            <dd>
                                <span rel="江油" sendcar="N" pre="SC  " dsi="6929" data-id="490">江油</span>
                            </dd>
                            <dd>
                                <span rel="蛟河" sendcar="N" pre="JL  " dsi="9431" data-id="596">蛟河</span>
                            </dd>
                            <dd>
                                <span rel="焦作" sendcar="N" pre="HN  " dsi="5781" data-id="339">焦作</span>
                            </dd>
                            <dd>
                                <span rel="揭阳" sendcar="N" pre="GD  " dsi="2735" data-id="220">揭阳</span>
                            </dd>
                            <dd>
                                <span rel="介休" sendcar="N" pre="SX  " dsi="7626" data-id="533">介休</span>
                            </dd>
                            <dd>
                                <span rel="金昌" sendcar="N" pre="GS  " dsi="9090" data-id="405">金昌</span>
                            </dd>
                            <dd>
                                <span rel="金华" sendcar="Y" pre="ZJ  " dsi="740" data-id="90">金华</span>
                            </dd>
                            <dd>
                                <span rel="锦州" sendcar="N" pre="LN  " dsi="2501" data-id="174">锦州</span>
                            </dd>
                            <dd>
                                <span rel="进贤" sendcar="N" pre="JX  " dsi="7152" data-id="515">进贤</span>
                            </dd>
                            <dd>
                                <span rel="晋城" sendcar="N" pre="SX  " dsi="3214" data-id="245">晋城</span>
                            </dd>
                            <dd>
                                <span rel="晋中" sendcar="N" pre="SX  " dsi="6835" data-id="363">晋中</span>
                            </dd>
                            <dd>
                                <span rel="缙云" sendcar="N" pre="ZJ  " dsi="0" data-id="293">缙云</span>
                            </dd>
                            <dd>
                                <span rel="荆门" sendcar="N" pre="UB  " dsi="1698" data-id="133">荆门</span>
                            </dd>
                            <dd>
                                <span rel="荆州" sendcar="N" pre="UB  " dsi="2700" data-id="217">荆州</span>
                            </dd>
                            <dd>
                                <span rel="景德镇" sendcar="N" pre="JX  " dsi="7519" data-id="202">景德镇</span>
                            </dd>
                            <dd>
                                <span rel="靖江" sendcar="N" pre="JS  " dsi="3509" data-id="251">靖江</span>
                            </dd>
                            <dd>
                                <span rel="九江" sendcar="N" pre="JX  " dsi="983" data-id="103">九江</span>
                            </dd>
                            <dd>
                                <span rel="酒泉" sendcar="N" pre="GS  " dsi="8020" data-id="407">酒泉</span>
                            </dd>
                            <dd>
                                <span rel="句容" sendcar="N" pre="JS  " dsi="7563" data-id="530">句容</span>
                            </dd>
                    </dl>
                </div>
            </li>
            <li>
                <div class="inner-box">
                    <dl>
                        <div class='city-initial'><em>K</em>
                            <dd>
                                <span rel="喀什" sendcar="N" pre="XJ  " dsi="7291" data-id="440">喀什</span>
                            </dd>
                            <dd>
                                <span rel="开封" sendcar="Y" pre="HN  " dsi="557" data-id="154">开封</span>
                            </dd>
                            <dd>
                                <span rel="开化" sendcar="N" pre="ZJ  " dsi="8526" data-id="567">开化</span>
                            </dd>
                            <dd>
                                <span rel="凯里" sendcar="N" pre="GZ  " dsi="2498" data-id="171">凯里</span>
                            </dd>
                            <dd>
                                <span rel="库尔勒" sendcar="N" pre="XJ  " dsi="5118" data-id="299">库尔勒</span>
                            </dd>
                            <dd>
                                <span rel="昆明" sendcar="Y" pre="YN  " dsi="342" data-id="86">昆明</span>
                            </dd>
                            <dd>
                                <span rel="昆山" sendcar="Y" pre="JS  " dsi="78" data-id="49">昆山</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>L</em>
                            <dd>
                                <span rel="拉萨" sendcar="N" pre="XZ  " dsi="2037" data-id="139">拉萨</span>
                            </dd>
                            <dd>
                                <span rel="来宾" sendcar="N" pre="GX  " dsi="3733" data-id="265">来宾</span>
                            </dd>
                            <dd>
                                <span rel="兰溪" sendcar="N" pre="ZJ  " dsi="8786" data-id="580">兰溪</span>
                            </dd>
                            <dd>
                                <span rel="兰州" sendcar="N" pre="GS  " dsi="605" data-id="27">兰州</span>
                            </dd>
                            <dd>
                                <span rel="阆中" sendcar="N" pre="SC  " dsi="4223" data-id="270">阆中</span>
                            </dd>
                            <dd>
                                <span rel="廊坊" sendcar="N" pre="HB  " dsi="1124" data-id="114">廊坊</span>
                            </dd>
                            <dd>
                                <span rel="乐东" sendcar="N" pre="AN  " dsi="5766" data-id="336">乐东</span>
                            </dd>
                            <dd>
                                <span rel="乐清" sendcar="N" pre="ZJ  " dsi="8826" data-id="583">乐清</span>
                            </dd>
                            <dd>
                                <span rel="乐山" sendcar="N" pre="SC  " dsi="4324" data-id="278">乐山</span>
                            </dd>
                            <dd>
                                <span rel="耒阳" sendcar="N" pre="UN  " dsi="7000" data-id="471">耒阳</span>
                            </dd>
                            <dd>
                                <span rel="醴陵" sendcar="N" pre="UN  " dsi="6996" data-id="468">醴陵</span>
                            </dd>
                            <dd>
                                <span rel="丽江" sendcar="N" pre="YN  " dsi="1142" data-id="116">丽江</span>
                            </dd>
                            <dd>
                                <span rel="丽水" sendcar="Y" pre="ZJ  " dsi="2753" data-id="228">丽水</span>
                            </dd>
                            <dd>
                                <span rel="利川" sendcar="N" pre="UB  " dsi="7270" data-id="505">利川</span>
                            </dd>
                            <dd>
                                <span rel="溧阳" sendcar="Y" pre="JS  " dsi="2506" data-id="178">溧阳</span>
                            </dd>
                            <dd>
                                <span rel="连云港" sendcar="N" pre="JS  " dsi="4621" data-id="286">连云港</span>
                            </dd>
                            <dd>
                                <span rel="廉江" sendcar="N" pre="GD  " dsi="6034" data-id="493">廉江</span>
                            </dd>
                            <dd>
                                <span rel="辽阳" sendcar="N" pre="LN  " dsi="5840" data-id="356">辽阳</span>
                            </dd>
                            <dd>
                                <span rel="聊城" sendcar="N" pre="SD  " dsi="3695" data-id="262">聊城</span>
                            </dd>
                            <dd>
                                <span rel="林芝" sendcar="N" pre="XZ  " dsi="2815" data-id="232">林芝</span>
                            </dd>
                            <dd>
                                <span rel="临汾" sendcar="N" pre="SX  " dsi="987" data-id="104">临汾</span>
                            </dd>
                            <dd>
                                <span rel="临高" sendcar="N" pre="AN  " dsi="5686" data-id="331">临高</span>
                            </dd>
                            <dd>
                                <span rel="临海" sendcar="N" pre="ZJ  " dsi="6882" data-id="494">临海</span>
                            </dd>
                            <dd>
                                <span rel="临沂" sendcar="N" pre="SD  " dsi="3696" data-id="263">临沂</span>
                            </dd>
                            <dd>
                                <span rel="灵宝" sendcar="N" pre="HN  " dsi="6965" data-id="495">灵宝</span>
                            </dd>
                            <dd>
                                <span rel="灵石" sendcar="N" pre="SX  " dsi="7627" data-id="534">灵石</span>
                            </dd>
                            <dd>
                                <span rel="陵水" sendcar="N" pre="AN  " dsi="4287" data-id="276">陵水</span>
                            </dd>
                            <dd>
                                <span rel="浏阳" sendcar="N" pre="UN  " dsi="3731" data-id="267">浏阳</span>
                            </dd>
                            <dd>
                                <span rel="柳州" sendcar="N" pre="GX  " dsi="1775" data-id="135">柳州</span>
                            </dd>
                            <dd>
                                <span rel="六安" sendcar="N" pre="AH  " dsi="1104" data-id="110">六安</span>
                            </dd>
                            <dd>
                                <span rel="六盘水" sendcar="N" pre="GZ  " dsi="5841" data-id="357">六盘水</span>
                            </dd>
                            <dd>
                                <span rel="龙泉" sendcar="N" pre="ZJ  " dsi="9469" data-id="602">龙泉</span>
                            </dd>
                            <dd>
                                <span rel="龙岩" sendcar="N" pre="FJ  " dsi="1470" data-id="126">龙岩</span>
                            </dd>
                            <dd>
                                <span rel="龙游" sendcar="N" pre="ZJ  " dsi="9466" data-id="599">龙游</span>
                            </dd>
                            <dd>
                                <span rel="陇南" sendcar="N" pre="GS  " dsi="7894" data-id="412">陇南</span>
                            </dd>
                            <dd>
                                <span rel="娄底" sendcar="N" pre="UN  " dsi="4328" data-id="280">娄底</span>
                            </dd>
                            <dd>
                                <span rel="泸州" sendcar="N" pre="SC  " dsi="2581" data-id="192">泸州</span>
                            </dd>
                            <dd>
                                <span rel="洛阳" sendcar="N" pre="HN  " dsi="699" data-id="40">洛阳</span>
                            </dd>
                            <dd>
                                <span rel="漯河" sendcar="N" pre="HN  " dsi="581" data-id="41">漯河</span>
                            </dd>
                            <dd>
                                <span rel="吕梁" sendcar="N" pre="SX  " dsi="5763" data-id="333">吕梁</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>M</em>
                            <dd>
                                <span rel="麻城" sendcar="N" pre="UB  " dsi="7148" data-id="513">麻城</span>
                            </dd>
                            <dd>
                                <span rel="马鞍山" sendcar="N" pre="AH  " dsi="962" data-id="100">马鞍山</span>
                            </dd>
                            <dd>
                                <span rel="茂名" sendcar="N" pre="GD  " dsi="946" data-id="98">茂名</span>
                            </dd>
                            <dd>
                                <span rel="眉山" sendcar="N" pre="SC  " dsi="5641" data-id="316">眉山</span>
                            </dd>
                            <dd>
                                <span rel="梅州" sendcar="N" pre="GD  " dsi="1456" data-id="124">梅州</span>
                            </dd>
                            <dd>
                                <span rel="蒙自" sendcar="N" pre="YN  " dsi="5675" data-id="477">蒙自</span>
                            </dd>
                            <dd>
                                <span rel="汨罗" sendcar="N" pre="UN  " dsi="2740" data-id="226">汨罗</span>
                            </dd>
                            <dd>
                                <span rel="绵阳" sendcar="N" pre="SC  " dsi="977" data-id="102">绵阳</span>
                            </dd>
                            <dd>
                                <span rel="牡丹江" sendcar="N" pre="HLJ " dsi="1143" data-id="115">牡丹江</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>N</em>
                            <dd>
                                <span rel="南部" sendcar="N" pre="SC  " dsi="6935" data-id="462">南部</span>
                            </dd>
                            <dd>
                                <span rel="南昌" sendcar="Y" pre="JX  " dsi="22" data-id="59">南昌</span>
                            </dd>
                            <dd>
                                <span rel="南充" sendcar="N" pre="SC  " dsi="1747" data-id="134">南充</span>
                            </dd>
                            <dd>
                                <span rel="南京" sendcar="Y" pre="JS  " dsi="14" data-id="50">南京</span>
                            </dd>
                            <dd>
                                <span rel="南宁" sendcar="Y" pre="GX  " dsi="307" data-id="29">南宁</span>
                            </dd>
                            <dd>
                                <span rel="南平" sendcar="N" pre="FJ  " dsi="3686" data-id="258">南平</span>
                            </dd>
                            <dd>
                                <span rel="南通" sendcar="N" pre="JS  " dsi="15" data-id="51">南通</span>
                            </dd>
                            <dd>
                                <span rel="南阳" sendcar="N" pre="HN  " dsi="2586" data-id="195">南阳</span>
                            </dd>
                            <dd>
                                <span rel="内江" sendcar="N" pre="SC  " dsi="5782" data-id="340">内江</span>
                            </dd>
                            <dd>
                                <span rel="宁波" sendcar="Y" pre="ZJ  " dsi="12" data-id="91">宁波</span>
                            </dd>
                            <dd>
                                <span rel="宁德" sendcar="N" pre="FJ  " dsi="2694" data-id="214">宁德</span>
                            </dd>
                            <dd>
                                <span rel="宁海" sendcar="N" pre="ZJ  " dsi="8856" data-id="584">宁海</span>
                            </dd>
                    </dl>
                </div>
            </li>
            <li>
                <div class="inner-box">
                    <dl>
                        <div class='city-initial'><em>P</em>
                            <dd>
                                <span rel="攀枝花" sendcar="N" pre="SC  " dsi="5771" data-id="338">攀枝花</span>
                            </dd>
                            <dd>
                                <span rel="蓬安" sendcar="N" pre="SC  " dsi="7944" data-id="554">蓬安</span>
                            </dd>
                            <dd>
                                <span rel="平顶山" sendcar="N" pre="HN  " dsi="6991" data-id="380">平顶山</span>
                            </dd>
                            <dd>
                                <span rel="平凉" sendcar="N" pre="GS  " dsi="8099" data-id="410">平凉</span>
                            </dd>
                            <dd>
                                <span rel="平遥" sendcar="N" pre="SX  " dsi="6837" data-id="459">平遥</span>
                            </dd>
                            <dd>
                                <span rel="萍乡" sendcar="Y" pre="JX  " dsi="3729" data-id="257">萍乡</span>
                            </dd>
                            <dd>
                                <span rel="鄱阳" sendcar="N" pre="JX  " dsi="8397" data-id="564">鄱阳</span>
                            </dd>
                            <dd>
                                <span rel="莆田" sendcar="N" pre="FJ  " dsi="2286" data-id="146">莆田</span>
                            </dd>
                            <dd>
                                <span rel="濮阳" sendcar="N" pre="HN  " dsi="6994" data-id="379">濮阳</span>
                            </dd>
                            <dd>
                                <span rel="浦江" sendcar="N" pre="ZJ  " dsi="8672" data-id="577">浦江</span>
                            </dd>
                            <dd>
                                <span rel="普洱" sendcar="N" pre="YN  " dsi="5392" data-id="310">普洱</span>
                            </dd>
                            <dd>
                                <span rel="普宁" sendcar="N" pre="GD  " dsi="3688" data-id="480">普宁</span>
                            </dd>
                            <dd>
                                <span rel="普者黑" sendcar="N" pre="YN  " dsi="9464" data-id="598">普者黑</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>Q</em>
                            <dd>
                                <span rel="齐齐哈尔" sendcar="N" pre="HLJ " dsi="2381" data-id="165">齐齐哈尔</span>
                            </dd>
                            <dd>
                                <span rel="祁东" sendcar="N" pre="UN  " dsi="6995" data-id="467">祁东</span>
                            </dd>
                            <dd>
                                <span rel="祁县" sendcar="N" pre="SX  " dsi="7628" data-id="535">祁县</span>
                            </dd>
                            <dd>
                                <span rel="启东" sendcar="N" pre="JS  " dsi="7644" data-id="537">启东</span>
                            </dd>
                            <dd>
                                <span rel="千岛湖" sendcar="N" pre="ZJ  " dsi="6699" data-id="457">千岛湖</span>
                            </dd>
                            <dd>
                                <span rel="潜江" sendcar="N" pre="UB  " dsi="2699" data-id="216">潜江</span>
                            </dd>
                            <dd>
                                <span rel="钦州" sendcar="N" pre="GX  " dsi="5208" data-id="307">钦州</span>
                            </dd>
                            <dd>
                                <span rel="秦皇岛" sendcar="N" pre="HB  " dsi="2841" data-id="233">秦皇岛</span>
                            </dd>
                            <dd>
                                <span rel="青岛" sendcar="Y" pre="SD  " dsi="11" data-id="74">青岛</span>
                            </dd>
                            <dd>
                                <span rel="青州" sendcar="N" pre="SD  " dsi="6753" data-id="482">青州</span>
                            </dd>
                            <dd>
                                <span rel="清远" sendcar="N" pre="GD  " dsi="1157" data-id="117">清远</span>
                            </dd>
                            <dd>
                                <span rel="庆阳" sendcar="N" pre="GS  " dsi="7273" data-id="409">庆阳</span>
                            </dd>
                            <dd>
                                <span rel="庆元" sendcar="N" pre="ZJ  " dsi="9470" data-id="603">庆元</span>
                            </dd>
                            <dd>
                                <span rel="琼海" sendcar="N" pre="AN  " dsi="3594" data-id="160">琼海</span>
                            </dd>
                            <dd>
                                <span rel="琼中" sendcar="N" pre="AN  " dsi="7375" data-id="526">琼中</span>
                            </dd>
                            <dd>
                                <span rel="衢州" sendcar="N" pre="ZJ  " dsi="2354" data-id="164">衢州</span>
                            </dd>
                            <dd>
                                <span rel="曲阜" sendcar="N" pre="SD  " dsi="2504" data-id="177">曲阜</span>
                            </dd>
                            <dd>
                                <span rel="曲靖" sendcar="N" pre="YN  " dsi="2737" data-id="222">曲靖</span>
                            </dd>
                            <dd>
                                <span rel="泉州" sendcar="N" pre="FJ  " dsi="834" data-id="11">泉州</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>R</em>
                            <dd>
                                <span rel="仁怀" sendcar="N" pre="GZ  " dsi="9341" data-id="594">仁怀</span>
                            </dd>
                            <dd>
                                <span rel="日照" sendcar="N" pre="SD  " dsi="2981" data-id="238">日照</span>
                            </dd>
                            <dd>
                                <span rel="荣成" sendcar="N" pre="SD  " dsi="7146" data-id="512">荣成</span>
                            </dd>
                            <dd>
                                <span rel="如皋" sendcar="N" pre="JS  " dsi="7769" data-id="547">如皋</span>
                            </dd>
                            <dd>
                                <span rel="瑞安" sendcar="N" pre="ZJ  " dsi="2687" data-id="209">瑞安</span>
                            </dd>
                            <dd>
                                <span rel="瑞昌" sendcar="N" pre="JX  " dsi="5865" data-id="484">瑞昌</span>
                            </dd>
                            <dd>
                                <span rel="瑞金" sendcar="N" pre="JX  " dsi="9089" data-id="591">瑞金</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>S</em>
                            <dd>
                                <span rel="三江" sendcar="N" pre="GX  " dsi="5838" data-id="354">三江</span>
                            </dd>
                            <dd>
                                <span rel="三门峡" sendcar="N" pre="HN  " dsi="2582" data-id="193">三门峡</span>
                            </dd>
                            <dd>
                                <span rel="三明" sendcar="N" pre="FJ  " dsi="5107" data-id="295">三明</span>
                            </dd>
                            <dd>
                                <span rel="三穗" sendcar="N" pre="GZ  " dsi="8035" data-id="556">三穗</span>
                            </dd>
                            <dd>
                                <span rel="三亚" sendcar="Y" pre="AN  " dsi="165" data-id="3">三亚</span>
                            </dd>
                            <dd>
                                <span rel="汕头" sendcar="N" pre="GD  " dsi="878" data-id="19">汕头</span>
                            </dd>
                            <dd>
                                <span rel="汕尾" sendcar="N" pre="GD  " dsi="2625" data-id="199">汕尾</span>
                            </dd>
                            <dd>
                                <span rel="商丘" sendcar="N" pre="HN  " dsi="3697" data-id="256">商丘</span>
                            </dd>
                            <dd>
                                <span rel="上海" sendcar="Y" pre="SH  " dsi="886" data-id="77">上海</span>
                            </dd>
                            <dd>
                                <span rel="上饶" sendcar="N" pre="JX  " dsi="7252" data-id="105">上饶</span>
                            </dd>
                            <dd>
                                <span rel="尚志" sendcar="N" pre="HLJ " dsi="7825" data-id="550">尚志</span>
                            </dd>
                            <dd>
                                <span rel="韶关" sendcar="N" pre="GD  " dsi="907" data-id="20">韶关</span>
                            </dd>
                            <dd>
                                <span rel="邵武" sendcar="N" pre="FJ  " dsi="9281" data-id="593">邵武</span>
                            </dd>
                            <dd>
                                <span rel="邵阳" sendcar="N" pre="UN  " dsi="4561" data-id="284">邵阳</span>
                            </dd>
                            <dd>
                                <span rel="绍兴" sendcar="Y" pre="ZJ  " dsi="305" data-id="93">绍兴</span>
                            </dd>
                            <dd>
                                <span rel="深圳" sendcar="Y" pre="GD  " dsi="26" data-id="21">深圳</span>
                            </dd>
                            <dd>
                                <span rel="沈阳" sendcar="Y" pre="LN  " dsi="19" data-id="63">沈阳</span>
                            </dd>
                            <dd>
                                <span rel="十堰" sendcar="N" pre="UB  " dsi="2738" data-id="223">十堰</span>
                            </dd>
                            <dd>
                                <span rel="石家庄" sendcar="Y" pre="HB  " dsi="309" data-id="34">石家庄</span>
                            </dd>
                            <dd>
                                <span rel="双峰" sendcar="N" pre="UN  " dsi="6997" data-id="469">双峰</span>
                            </dd>
                            <dd>
                                <span rel="朔州" sendcar="N" pre="SX  " dsi="5127" data-id="300">朔州</span>
                            </dd>
                            <dd>
                                <span rel="四会" sendcar="N" pre="GD  " dsi="5983" data-id="485">四会</span>
                            </dd>
                            <dd>
                                <span rel="四平" sendcar="N" pre="JL  " dsi="2499" data-id="172">四平</span>
                            </dd>
                            <dd>
                                <span rel="泗阳" sendcar="N" pre="JS  " dsi="9682" data-id="606">泗阳</span>
                            </dd>
                            <dd>
                                <span rel="松阳" sendcar="N" pre="ZJ  " dsi="9468" data-id="601">松阳</span>
                            </dd>
                            <dd>
                                <span rel="松原" sendcar="N" pre="JL  " dsi="7192" data-id="367">松原</span>
                            </dd>
                            <dd>
                                <span rel="苏州" sendcar="Y" pre="JS  " dsi="7" data-id="52">苏州</span>
                            </dd>
                            <dd>
                                <span rel="绥芬河" sendcar="N" pre="HLJ " dsi="7244" data-id="521">绥芬河</span>
                            </dd>
                            <dd>
                                <span rel="随州" sendcar="N" pre="UB  " dsi="4774" data-id="289">随州</span>
                            </dd>
                            <dd>
                                <span rel="遂昌" sendcar="N" pre="ZJ  " dsi="9467" data-id="600">遂昌</span>
                            </dd>
                            <dd>
                                <span rel="遂宁" sendcar="N" pre="SC  " dsi="2513" data-id="184">遂宁</span>
                            </dd>
                            <dd>
                                <span rel="遂溪" sendcar="N" pre="GD  " dsi="5679" data-id="325">遂溪</span>
                            </dd>
                            <dd>
                                <span rel="宿迁" sendcar="N" pre="JS  " dsi="4275" data-id="273">宿迁</span>
                            </dd>
                            <dd>
                                <span rel="宿州" sendcar="N" pre="AH  " dsi="3934" data-id="269">宿州</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>T</em>
                            <dd>
                                <span rel="台山" sendcar="N" pre="GD  " dsi="5684" data-id="329">台山</span>
                            </dd>
                            <dd>
                                <span rel="台州" sendcar="Y" pre="ZJ  " dsi="1899" data-id="94">台州</span>
                            </dd>
                            <dd>
                                <span rel="太仓" sendcar="N" pre="JS  " dsi="535" data-id="53">太仓</span>
                            </dd>
                            <dd>
                                <span rel="太谷" sendcar="N" pre="SX  " dsi="7646" data-id="539">太谷</span>
                            </dd>
                            <dd>
                                <span rel="太原" sendcar="Y" pre="SX  " dsi="82" data-id="78">太原</span>
                            </dd>
                            <dd>
                                <span rel="泰安" sendcar="N" pre="SD  " dsi="2358" data-id="162">泰安</span>
                            </dd>
                            <dd>
                                <span rel="泰和" sendcar="N" pre="JX  " dsi="8655" data-id="574">泰和</span>
                            </dd>
                            <dd>
                                <span rel="泰州" sendcar="Y" pre="JS  " dsi="2291" data-id="106">泰州</span>
                            </dd>
                            <dd>
                                <span rel="唐山" sendcar="N" pre="HB  " dsi="685" data-id="35">唐山</span>
                            </dd>
                            <dd>
                                <span rel="腾冲" sendcar="N" pre="YN  " dsi="2361" data-id="158">腾冲</span>
                            </dd>
                            <dd>
                                <span rel="天津" sendcar="Y" pre="TJ  " dsi="16" data-id="79">天津</span>
                            </dd>
                            <dd>
                                <span rel="天水" sendcar="N" pre="GS  " dsi="7383" data-id="317">天水</span>
                            </dd>
                            <dd>
                                <span rel="铁岭" sendcar="N" pre="LN  " dsi="7293" data-id="366">铁岭</span>
                            </dd>
                            <dd>
                                <span rel="通化" sendcar="N" pre="JL  " dsi="9433" data-id="369">通化</span>
                            </dd>
                            <dd>
                                <span rel="通辽" sendcar="N" pre="NMG " dsi="5847" data-id="359">通辽</span>
                            </dd>
                            <dd>
                                <span rel="桐庐" sendcar="N" pre="ZJ  " dsi="6697" data-id="455">桐庐</span>
                            </dd>
                            <dd>
                                <span rel="铜陵" sendcar="N" pre="AH  " dsi="5804" data-id="274">铜陵</span>
                            </dd>
                            <dd>
                                <span rel="铜仁" sendcar="N" pre="GZ  " dsi="3844" data-id="268">铜仁</span>
                            </dd>
                            <dd>
                                <span rel="图们" sendcar="N" pre="JL  " dsi="9432" data-id="597">图们</span>
                            </dd>
                            <dd>
                                <span rel="屯昌" sendcar="N" pre="AN  " dsi="7376" data-id="527">屯昌</span>
                            </dd>
                    </dl>
                </div>
            </li>
            <li>
                <div class="inner-box">
                    <dl>
                        <div class='city-initial'><em>W</em>
                            <dd>
                                <span rel="万安" sendcar="N" pre="JX  " dsi="8656" data-id="575">万安</span>
                            </dd>
                            <dd>
                                <span rel="万宁" sendcar="N" pre="AN  " dsi="5147" data-id="302">万宁</span>
                            </dd>
                            <dd>
                                <span rel="威海" sendcar="N" pre="SD  " dsi="2360" data-id="161">威海</span>
                            </dd>
                            <dd>
                                <span rel="潍坊" sendcar="N" pre="SD  " dsi="783" data-id="75">潍坊</span>
                            </dd>
                            <dd>
                                <span rel="渭南" sendcar="N" pre="AX  " dsi="2509" data-id="180">渭南</span>
                            </dd>
                            <dd>
                                <span rel="温岭" sendcar="N" pre="ZJ  " dsi="6883" data-id="487">温岭</span>
                            </dd>
                            <dd>
                                <span rel="温州" sendcar="Y" pre="ZJ  " dsi="619" data-id="95">温州</span>
                            </dd>
                            <dd>
                                <span rel="文昌" sendcar="N" pre="AN  " dsi="4240" data-id="271">文昌</span>
                            </dd>
                            <dd>
                                <span rel="文山" sendcar="N" pre="YN  " dsi="5676" data-id="322">文山</span>
                            </dd>
                            <dd>
                                <span rel="闻喜" sendcar="N" pre="SX  " dsi="7707" data-id="544">闻喜</span>
                            </dd>
                            <dd>
                                <span rel="乌海" sendcar="N" pre="NMG " dsi="6817" data-id="422">乌海</span>
                            </dd>
                            <dd>
                                <span rel="乌兰察布" sendcar="N" pre="NMG " dsi="5845" data-id="358">乌兰察布</span>
                            </dd>
                            <dd>
                                <span rel="乌鲁木齐" sendcar="N" pre="XJ  " dsi="1099" data-id="112">乌鲁木齐</span>
                            </dd>
                            <dd>
                                <span rel="无锡" sendcar="N" pre="JS  " dsi="56" data-id="54">无锡</span>
                            </dd>
                            <dd>
                                <span rel="芜湖" sendcar="N" pre="AH  " dsi="2292" data-id="150">芜湖</span>
                            </dd>
                            <dd>
                                <span rel="吴川" sendcar="N" pre="GD  " dsi="3274" data-id="488">吴川</span>
                            </dd>
                            <dd>
                                <span rel="吴忠" sendcar="N" pre="NX  " dsi="4772" data-id="288">吴忠</span>
                            </dd>
                            <dd>
                                <span rel="梧州" sendcar="N" pre="GX  " dsi="4326" data-id="283">梧州</span>
                            </dd>
                            <dd>
                                <span rel="五指山" sendcar="N" pre="AN  " dsi="8103" data-id="559">五指山</span>
                            </dd>
                            <dd>
                                <span rel="武汉" sendcar="Y" pre="UB  " dsi="1131" data-id="81">武汉</span>
                            </dd>
                            <dd>
                                <span rel="武胜" sendcar="N" pre="SC  " dsi="6936" data-id="463">武胜</span>
                            </dd>
                            <dd>
                                <span rel="武威" sendcar="N" pre="GS  " dsi="8266" data-id="408">武威</span>
                            </dd>
                            <dd>
                                <span rel="武夷山" sendcar="N" pre="FJ  " dsi="2402" data-id="121">武夷山</span>
                            </dd>
                            <dd>
                                <span rel="武义" sendcar="N" pre="ZJ  " dsi="8395" data-id="562">武义</span>
                            </dd>
                            <dd>
                                <span rel="婺源" sendcar="N" pre="JX  " dsi="2622" data-id="201">婺源</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>X</em>
                            <dd>
                                <span rel="厦门" sendcar="N" pre="FJ  " dsi="25" data-id="12">厦门</span>
                            </dd>
                            <dd>
                                <span rel="西安" sendcar="N" pre="AX  " dsi="2207" data-id="4">西安</span>
                            </dd>
                            <dd>
                                <span rel="西昌" sendcar="N" pre="SC  " dsi="4936" data-id="292">西昌</span>
                            </dd>
                            <dd>
                                <span rel="西宁" sendcar="N" pre="QH  " dsi="2821" data-id="70">西宁</span>
                            </dd>
                            <dd>
                                <span rel="西双版纳" sendcar="N" pre="YN  " dsi="1116" data-id="113">西双版纳</span>
                            </dd>
                            <dd>
                                <span rel="锡林浩特" sendcar="N" pre="NMG " dsi="5765" data-id="335">锡林浩特</span>
                            </dd>
                            <dd>
                                <span rel="峡江" sendcar="N" pre="JX  " dsi="8653" data-id="572">峡江</span>
                            </dd>
                            <dd>
                                <span rel="仙桃" sendcar="N" pre="UB  " dsi="2512" data-id="183">仙桃</span>
                            </dd>
                            <dd>
                                <span rel="咸宁" sendcar="N" pre="UB  " dsi="1403" data-id="123">咸宁</span>
                            </dd>
                            <dd>
                                <span rel="咸阳" sendcar="N" pre="AX  " dsi="2356" data-id="155">咸阳</span>
                            </dd>
                            <dd>
                                <span rel="香格里拉" sendcar="N" pre="YN  " dsi="9261" data-id="592">香格里拉</span>
                            </dd>
                            <dd>
                                <span rel="湘潭" sendcar="N" pre="UN  " dsi="2294" data-id="151">湘潭</span>
                            </dd>
                            <dd>
                                <span rel="襄汾" sendcar="N" pre="SX  " dsi="0" data-id="545">襄汾</span>
                            </dd>
                            <dd>
                                <span rel="襄阳" sendcar="N" pre="UB  " dsi="1468" data-id="125">襄阳</span>
                            </dd>
                            <dd>
                                <span rel="孝感" sendcar="N" pre="UB  " dsi="5650" data-id="318">孝感</span>
                            </dd>
                            <dd>
                                <span rel="辛集" sendcar="N" pre="HB  " dsi="7158" data-id="516">辛集</span>
                            </dd>
                            <dd>
                                <span rel="忻州" sendcar="N" pre="SX  " dsi="5596" data-id="315">忻州</span>
                            </dd>
                            <dd>
                                <span rel="新干" sendcar="N" pre="JX  " dsi="8652" data-id="571">新干</span>
                            </dd>
                            <dd>
                                <span rel="新化" sendcar="N" pre="UN  " dsi="6998" data-id="470">新化</span>
                            </dd>
                            <dd>
                                <span rel="新乡" sendcar="N" pre="HN  " dsi="5769" data-id="337">新乡</span>
                            </dd>
                            <dd>
                                <span rel="新余" sendcar="N" pre="JX  " dsi="2511" data-id="182">新余</span>
                            </dd>
                            <dd>
                                <span rel="新郑" sendcar="N" pre="HN  " dsi="5655" data-id="320">新郑</span>
                            </dd>
                            <dd>
                                <span rel="信阳" sendcar="N" pre="HN  " dsi="2510" data-id="181">信阳</span>
                            </dd>
                            <dd>
                                <span rel="邢台" sendcar="N" pre="HB  " dsi="2503" data-id="176">邢台</span>
                            </dd>
                            <dd>
                                <span rel="兴国" sendcar="N" pre="JX  " dsi="8657" data-id="576">兴国</span>
                            </dd>
                            <dd>
                                <span rel="兴宁" sendcar="N" pre="GD  " dsi="5028" data-id="489">兴宁</span>
                            </dd>
                            <dd>
                                <span rel="兴义" sendcar="N" pre="GZ  " dsi="5393" data-id="311">兴义</span>
                            </dd>
                            <dd>
                                <span rel="雄安新区" sendcar="N" pre="HB  " dsi="6838" data-id="460">雄安新区</span>
                            </dd>
                            <dd>
                                <span rel="徐州" sendcar="Y" pre="JS  " dsi="750" data-id="56">徐州</span>
                            </dd>
                            <dd>
                                <span rel="许昌" sendcar="N" pre="HN  " dsi="2284" data-id="144">许昌</span>
                            </dd>
                            <dd>
                                <span rel="宣城" sendcar="N" pre="AH  " dsi="5803" data-id="313">宣城</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>Y</em>
                            <dd>
                                <span rel="雅安" sendcar="N" pre="SC  " dsi="4865" data-id="291">雅安</span>
                            </dd>
                            <dd>
                                <span rel="烟台" sendcar="Y" pre="SD  " dsi="1192" data-id="118">烟台</span>
                            </dd>
                            <dd>
                                <span rel="延安" sendcar="N" pre="AX  " dsi="3251" data-id="246">延安</span>
                            </dd>
                            <dd>
                                <span rel="延吉" sendcar="N" pre="JL  " dsi="2382" data-id="166">延吉</span>
                            </dd>
                            <dd>
                                <span rel="盐城" sendcar="N" pre="JS  " dsi="943" data-id="96">盐城</span>
                            </dd>
                            <dd>
                                <span rel="扬州" sendcar="Y" pre="JS  " dsi="298" data-id="57">扬州</span>
                            </dd>
                            <dd>
                                <span rel="阳春" sendcar="N" pre="GD  " dsi="3571" data-id="491">阳春</span>
                            </dd>
                            <dd>
                                <span rel="阳江" sendcar="N" pre="GD  " dsi="1872" data-id="136">阳江</span>
                            </dd>
                            <dd>
                                <span rel="阳泉" sendcar="N" pre="SX  " dsi="5849" data-id="360">阳泉</span>
                            </dd>
                            <dd>
                                <span rel="阳新" sendcar="N" pre="UB  " dsi="7113" data-id="510">阳新</span>
                            </dd>
                            <dd>
                                <span rel="伊春" sendcar="N" pre="HLJ " dsi="5174" data-id="305">伊春</span>
                            </dd>
                            <dd>
                                <span rel="依兰" sendcar="N" pre="HLJ " dsi="8588" data-id="568">依兰</span>
                            </dd>
                            <dd>
                                <span rel="宜宾" sendcar="N" pre="SC  " dsi="2579" data-id="190">宜宾</span>
                            </dd>
                            <dd>
                                <span rel="宜昌" sendcar="N" pre="UB  " dsi="976" data-id="101">宜昌</span>
                            </dd>
                            <dd>
                                <span rel="宜春" sendcar="N" pre="JX  " dsi="2741" data-id="225">宜春</span>
                            </dd>
                            <dd>
                                <span rel="宜兴" sendcar="Y" pre="JS  " dsi="2285" data-id="145">宜兴</span>
                            </dd>
                            <dd>
                                <span rel="义乌" sendcar="Y" pre="ZJ  " dsi="273" data-id="97">义乌</span>
                            </dd>
                            <dd>
                                <span rel="益阳" sendcar="N" pre="UN  " dsi="5115" data-id="298">益阳</span>
                            </dd>
                            <dd>
                                <span rel="银川" sendcar="N" pre="NX  " dsi="843" data-id="68">银川</span>
                            </dd>
                            <dd>
                                <span rel="英德" sendcar="N" pre="GD  " dsi="5683" data-id="328">英德</span>
                            </dd>
                            <dd>
                                <span rel="鹰潭" sendcar="Y" pre="JX  " dsi="2894" data-id="237">鹰潭</span>
                            </dd>
                            <dd>
                                <span rel="营口" sendcar="N" pre="LN  " dsi="1308" data-id="120">营口</span>
                            </dd>
                            <dd>
                                <span rel="应县" sendcar="N" pre="SX  " dsi="7695" data-id="541">应县</span>
                            </dd>
                            <dd>
                                <span rel="永安" sendcar="N" pre="FJ  " dsi="7331" data-id="525">永安</span>
                            </dd>
                            <dd>
                                <span rel="永城" sendcar="N" pre="HN  " dsi="6968" data-id="492">永城</span>
                            </dd>
                            <dd>
                                <span rel="永济" sendcar="N" pre="SX  " dsi="7629" data-id="536">永济</span>
                            </dd>
                            <dd>
                                <span rel="永康" sendcar="N" pre="ZJ  " dsi="8396" data-id="563">永康</span>
                            </dd>
                            <dd>
                                <span rel="永州" sendcar="N" pre="UN  " dsi="2882" data-id="235">永州</span>
                            </dd>
                            <dd>
                                <span rel="于都" sendcar="N" pre="JX  " dsi="9088" data-id="590">于都</span>
                            </dd>
                            <dd>
                                <span rel="余姚" sendcar="N" pre="ZJ  " dsi="6127" data-id="227">余姚</span>
                            </dd>
                            <dd>
                                <span rel="榆林" sendcar="N" pre="AX  " dsi="5999" data-id="361">榆林</span>
                            </dd>
                            <dd>
                                <span rel="玉林" sendcar="N" pre="GX  " dsi="9395" data-id="430">玉林</span>
                            </dd>
                            <dd>
                                <span rel="玉溪" sendcar="N" pre="YN  " dsi="3679" data-id="255">玉溪</span>
                            </dd>
                            <dd>
                                <span rel="原平" sendcar="N" pre="SX  " dsi="7605" data-id="531">原平</span>
                            </dd>
                            <dd>
                                <span rel="岳阳" sendcar="N" pre="UN  " dsi="950" data-id="99">岳阳</span>
                            </dd>
                            <dd>
                                <span rel="云浮" sendcar="N" pre="GD  " dsi="2693" data-id="213">云浮</span>
                            </dd>
                            <dd>
                                <span rel="运城" sendcar="N" pre="SX  " dsi="2288" data-id="148">运城</span>
                            </dd>
                        </div>
                        <div class='city-initial'><em>Z</em>
                            <dd>
                                <span rel="枣庄" sendcar="Y" pre="SD  " dsi="2619" data-id="198">枣庄</span>
                            </dd>
                            <dd>
                                <span rel="湛江" sendcar="N" pre="GD  " dsi="791" data-id="23">湛江</span>
                            </dd>
                            <dd>
                                <span rel="张家港" sendcar="N" pre="JS  " dsi="5022" data-id="196">张家港</span>
                            </dd>
                            <dd>
                                <span rel="张家界" sendcar="N" pre="UN  " dsi="3569" data-id="254">张家界</span>
                            </dd>
                            <dd>
                                <span rel="张家口" sendcar="N" pre="HB  " dsi="2383" data-id="167">张家口</span>
                            </dd>
                            <dd>
                                <span rel="张掖" sendcar="N" pre="GS  " dsi="5111" data-id="297">张掖</span>
                            </dd>
                            <dd>
                                <span rel="漳浦" sendcar="N" pre="FJ  " dsi="7789" data-id="549">漳浦</span>
                            </dd>
                            <dd>
                                <span rel="漳州" sendcar="N" pre="FJ  " dsi="857" data-id="13">漳州</span>
                            </dd>
                            <dd>
                                <span rel="樟树" sendcar="N" pre="JX  " dsi="8651" data-id="570">樟树</span>
                            </dd>
                            <dd>
                                <span rel="昭通" sendcar="N" pre="YN  " dsi="5833" data-id="352">昭通</span>
                            </dd>
                            <dd>
                                <span rel="诏安" sendcar="N" pre="FJ  " dsi="9347" data-id="595">诏安</span>
                            </dd>
                            <dd>
                                <span rel="肇东" sendcar="N" pre="HLJ " dsi="7188" data-id="517">肇东</span>
                            </dd>
                            <dd>
                                <span rel="肇庆" sendcar="N" pre="GD  " dsi="2290" data-id="149">肇庆</span>
                            </dd>
                            <dd>
                                <span rel="镇江" sendcar="Y" pre="JS  " dsi="580" data-id="58">镇江</span>
                            </dd>
                            <dd>
                                <span rel="郑州" sendcar="Y" pre="HN  " dsi="1018" data-id="42">郑州</span>
                            </dd>
                            <dd>
                                <span rel="枝江" sendcar="N" pre="UB  " dsi="6984" data-id="465">枝江</span>
                            </dd>
                            <dd>
                                <span rel="中山" sendcar="N" pre="GD  " dsi="720" data-id="24">中山</span>
                            </dd>
                            <dd>
                                <span rel="中卫" sendcar="N" pre="NX  " dsi="4743" data-id="287">中卫</span>
                            </dd>
                            <dd>
                                <span rel="舟山" sendcar="N" pre="ZJ  " dsi="3068" data-id="242">舟山</span>
                            </dd>
                            <dd>
                                <span rel="周口" sendcar="N" pre="HN  " dsi="5794" data-id="343">周口</span>
                            </dd>
                            <dd>
                                <span rel="珠海" sendcar="N" pre="GD  " dsi="3065" data-id="25">珠海</span>
                            </dd>
                            <dd>
                                <span rel="株洲" sendcar="N" pre="UN  " dsi="959" data-id="83">株洲</span>
                            </dd>
                            <dd>
                                <span rel="驻马店" sendcar="N" pre="HN  " dsi="5795" data-id="344">驻马店</span>
                            </dd>
                            <dd>
                                <span rel="资阳" sendcar="N" pre="SC  " dsi="5685" data-id="330">资阳</span>
                            </dd>
                            <dd>
                                <span rel="资中" sendcar="N" pre="SC  " dsi="7770" data-id="548">资中</span>
                            </dd>
                            <dd>
                                <span rel="淄博" sendcar="Y" pre="SD  " dsi="756" data-id="76">淄博</span>
                            </dd>
                            <dd>
                                <span rel="自贡" sendcar="N" pre="SC  " dsi="2580" data-id="191">自贡</span>
                            </dd>
                            <dd>
                                <span rel="遵义" sendcar="N" pre="GZ  " dsi="2692" data-id="212">遵义</span>
                            </dd>
                    </dl>
                </div>
            </li>
        </ul>
    </div>
    <!--城市检索-->
    <div class="inquire-citybox" id="cityAutoBox">
    </div>

    <script>

    </script>
    <!--e城市列表-->
    <script type="text/javascript">
        var arrCity =
                "{arrObj:[{},{cs:'阿克苏',py:'akesu',jc:'AKS',ac:'N',cid:'441'},{cs:'安达',py:'anda',jc:'AD',ac:'N',cid:'499'},{cs:'安吉',py:'anji',jc:'AJ',ac:'N',cid:'608'},{cs:'安康',py:'ankang',jc:'AK',ac:'N',cid:'224'},{cs:'安庆',py:'anqing',jc:'AQ',ac:'N',cid:'204'},{cs:'安顺',py:'anshun',jc:'AS',ac:'N',cid:'157'},{cs:'安图',py:'antu',jc:'AT',ac:'N',cid:'553'},{cs:'安阳',py:'anyang',jc:'AY',ac:'N',cid:'277'},{cs:'鞍山',py:'anshan',jc:'AS',ac:'Y',cid:'111'},{cs:'巴彦淖尔',py:'bayannaoer',jc:'BYNE',ac:'N',cid:'334'},{cs:'巴中',py:'bazhong',jc:'BZ',ac:'N',cid:'341'},{cs:'霸州',py:'bazhou',jc:'BZ',ac:'N',cid:'497'},{cs:'白城',py:'baicheng',jc:'BC',ac:'N',cid:'332'},{cs:'白沙',py:'baisha',jc:'BS',ac:'N',cid:'561'},{cs:'白银',py:'baiyin',jc:'BY',ac:'N',cid:'406'},{cs:'百色',py:'baise',jc:'BS',ac:'N',cid:'309'},{cs:'蚌埠',py:'bengbu',jc:'BB',ac:'N',cid:'140'},{cs:'包头',py:'baotou',jc:'BT',ac:'N',cid:'64'},{cs:'宝鸡',py:'baoji',jc:'BJ',ac:'N',cid:'141'},{cs:'宝应',py:'baoying',jc:'BY',ac:'N',cid:'607'},{cs:'保定',py:'baoding',jc:'BD',ac:'N',cid:'32'},{cs:'保山',py:'baoshan',jc:'BS',ac:'N',cid:'345'},{cs:'北海',py:'beihai',jc:'BH',ac:'N',cid:'159'},{cs:'北京',py:'beijing',jc:'BJ',ac:'Y',cid:'5'},{cs:'本溪',py:'benxi',jc:'BX',ac:'N',cid:'173'},{cs:'毕节',py:'bijie',jc:'BJ',ac:'N',cid:'392'},{cs:'滨州',py:'binzhou',jc:'BZ',ac:'N',cid:'259'},{cs:'苍溪',py:'cangxi',jc:'CX',ac:'N',cid:'581'},{cs:'沧州',py:'cangzhou',jc:'CZ',ac:'N',cid:'138'},{cs:'昌江',py:'changjiang',jc:'CJ',ac:'N',cid:'312'},{cs:'常德',py:'changde',jc:'CD',ac:'N',cid:'128'},{cs:'常山',py:'changshan',jc:'CS',ac:'N',cid:'566'},{cs:'常熟',py:'changshu',jc:'CS',ac:'N',cid:'45'},{cs:'常州',py:'changzhou',jc:'CZ',ac:'Y',cid:'46'},{cs:'巢湖',py:'chaohu',jc:'CH',ac:'N',cid:'253'},{cs:'朝阳',py:'chaoyang',jc:'CY',ac:'N',cid:'364'},{cs:'潮州',py:'chaozhou',jc:'CZ',ac:'N',cid:'194'},{cs:'郴州',py:'chenzhou',jc:'CZ',ac:'N',cid:'153'},{cs:'成都',py:'chengdu',jc:'CD',ac:'Y',cid:'71'},{cs:'承德',py:'chengde',jc:'CD',ac:'N',cid:'218'},{cs:'澄迈',py:'chengmai',jc:'CM',ac:'N',cid:'301'},{cs:'池州',py:'chizhou',jc:'CZ',ac:'N',cid:'323'},{cs:'赤壁',py:'chibi',jc:'CB',ac:'N',cid:'522'},{cs:'赤峰',py:'chifeng',jc:'CF',ac:'N',cid:'236'},{cs:'滁州',py:'chuzhou',jc:'CZ',ac:'N',cid:'229'},{cs:'楚雄',py:'chuxiong',jc:'CX',ac:'N',cid:'349'},{cs:'慈溪',py:'cixi',jc:'CX',ac:'N',cid:'472'},{cs:'从江',py:'congjiang',jc:'CJ',ac:'N',cid:'540'},{cs:'达州',py:'dazhou',jc:'DZ',ac:'N',cid:'264'},{cs:'大理',py:'dali',jc:'DL',ac:'N',cid:'108'},{cs:'大连',py:'dalian',jc:'DL',ac:'Y',cid:'61'},{cs:'大庆',py:'daqing',jc:'DQ',ac:'N',cid:'197'},{cs:'大同',py:'datong',jc:'DT',ac:'N',cid:'119'},{cs:'大冶',py:'daye',jc:'DY',ac:'N',cid:'509'},{cs:'丹东',py:'dandong',jc:'DD',ac:'N',cid:'137'},{cs:'丹阳',py:'danyang',jc:'DY',ac:'N',cid:'186'},{cs:'儋州',py:'danzhou',jc:'DZ',ac:'N',cid:'304'},{cs:'德宏',py:'dehong',jc:'DH',ac:'N',cid:'282'},{cs:'德惠',py:'dehui',jc:'DH',ac:'N',cid:'520'},{cs:'德令哈',py:'delingha',jc:'DLH',ac:'N',cid:'528'},{cs:'德清',py:'deqing',jc:'DQ',ac:'N',cid:'210'},{cs:'德兴',py:'dexing',jc:'DX',ac:'N',cid:'473'},{cs:'德阳',py:'deyang',jc:'DY',ac:'N',cid:'156'},{cs:'德州',py:'dezhou',jc:'DZ',ac:'N',cid:'200'},{cs:'定安',py:'dingan',jc:'DA',ac:'N',cid:'326'},{cs:'定西',py:'dingxi',jc:'DX',ac:'N',cid:'411'},{cs:'定州',py:'dingzhou',jc:'DZ',ac:'N',cid:'496'},{cs:'东方',py:'dongfang',jc:'DF',ac:'N',cid:'306'},{cs:'东莞',py:'dongguan',jc:'DG',ac:'Y',cid:'14'},{cs:'东阳',py:'dongyang',jc:'DY',ac:'N',cid:'578'},{cs:'东营',py:'dongying',jc:'DY',ac:'N',cid:'239'},{cs:'都匀',py:'duyun',jc:'DY',ac:'N',cid:'327'},{cs:'敦化',py:'dunhua',jc:'DH',ac:'N',cid:'290'},{cs:'敦煌',py:'dunhuang',jc:'DH',ac:'N',cid:'230'},{cs:'鄂尔多斯',py:'eerduosi',jc:'EEDS',ac:'N',cid:'152'},{cs:'鄂州',py:'ezhou',jc:'EZ',ac:'N',cid:'351'},{cs:'恩施',py:'enshi',jc:'ES',ac:'N',cid:'249'},{cs:'防城港',py:'fangchengg',jc:'FCG',ac:'N',cid:'355'},{cs:'丰城',py:'fengcheng',jc:'FC',ac:'N',cid:'569'},{cs:'佛山',py:'foshan',jc:'FS',ac:'N',cid:'15'},{cs:'扶余',py:'fuyu',jc:'FY',ac:'N',cid:'552'},{cs:'福安',py:'fuan',jc:'FA',ac:'N',cid:'524'},{cs:'福鼎',py:'fuding',jc:'FD',ac:'N',cid:'511'},{cs:'福清',py:'fuqing',jc:'FQ',ac:'N',cid:'585'},{cs:'福州',py:'fuzhou',jc:'FZ',ac:'N',cid:'8'},{cs:'抚顺',py:'fushun',jc:'FS',ac:'Y',cid:'62'},{cs:'抚州',py:'fuzhou',jc:'FZ',ac:'N',cid:'285'},{cs:'阜新',py:'fuxin',jc:'FX',ac:'N',cid:'365'},{cs:'阜阳',py:'fuyang',jc:'FY',ac:'N',cid:'275'},{cs:'富阳',py:'fuyang',jc:'FY',ac:'N',cid:'456'},{cs:'赣州',py:'ganzhou',jc:'GZ',ac:'N',cid:'252'},{cs:'高安',py:'gaoan',jc:'GA',ac:'N',cid:'476'},{cs:'高密',py:'gaomi',jc:'GM',ac:'N',cid:'478'},{cs:'高州',py:'gaozhou',jc:'GZ',ac:'N',cid:'481'},{cs:'格尔木',py:'geermu',jc:'GEM',ac:'N',cid:'243'},{cs:'公主岭',py:'gongzhulin',jc:'GZL',ac:'N',cid:'508'},{cs:'巩义',py:'gongyi',jc:'GY',ac:'N',cid:'466'},{cs:'共青城',py:'gongqingch',jc:'GQC',ac:'N',cid:'483'},{cs:'固原',py:'guyuan',jc:'GY',ac:'N',cid:'437'},{cs:'广安',py:'guangan',jc:'GA',ac:'N',cid:'342'},{cs:'广汉',py:'guanghan',jc:'GH',ac:'N',cid:'461'},{cs:'广元',py:'guangyuan',jc:'GY',ac:'N',cid:'189'},{cs:'广州',py:'guangzhou',jc:'GZ',ac:'Y',cid:'16'},{cs:'贵定',py:'guiding',jc:'GD',ac:'N',cid:'538'},{cs:'贵港',py:'guigang',jc:'GG',ac:'N',cid:'221'},{cs:'贵阳',py:'guiyang',jc:'GY',ac:'Y',cid:'31'},{cs:'桂林',py:'guilin',jc:'GL',ac:'N',cid:'28'},{cs:'哈尔滨',py:'haerbin',jc:'HEB',ac:'Y',cid:'38'},{cs:'海安',py:'haian',jc:'HA',ac:'N',cid:'546'},{cs:'海口',py:'haikou',jc:'HK',ac:'Y',cid:'2'},{cs:'海宁',py:'haining',jc:'HN',ac:'N',cid:'87'},{cs:'邯郸',py:'handan',jc:'HD',ac:'N',cid:'109'},{cs:'汉川',py:'hanchuan',jc:'HC',ac:'N',cid:'498'},{cs:'汉中',py:'hanzhong',jc:'HZ',ac:'N',cid:'206'},{cs:'杭州',py:'hangzhou',jc:'HZ',ac:'N',cid:'88'},{cs:'合肥',py:'hefei',jc:'HF',ac:'Y',cid:'1'},{cs:'河源',py:'heyuan',jc:'HY',ac:'N',cid:'127'},{cs:'菏泽',py:'heze',jc:'HZ',ac:'N',cid:'260'},{cs:'贺州',py:'hezhou',jc:'HZ',ac:'N',cid:'272'},{cs:'鹤壁',py:'hebi',jc:'HB',ac:'N',cid:'378'},{cs:'鹤岗',py:'hegang',jc:'HG',ac:'N',cid:'348'},{cs:'衡水',py:'hengshui',jc:'HS',ac:'N',cid:'248'},{cs:'衡阳',py:'hengyang',jc:'HY',ac:'N',cid:'122'},{cs:'红安',py:'hongan',jc:'HA',ac:'N',cid:'514'},{cs:'洪洞',py:'hongdong',jc:'HD',ac:'N',cid:'532'},{cs:'侯马',py:'houma',jc:'HM',ac:'N',cid:'308'},{cs:'呼和浩特',py:'huhehaote',jc:'HHHT',ac:'Y',cid:'66'},{cs:'呼伦贝尔',py:'hulunbeier',jc:'HLBE',ac:'N',cid:'207'},{cs:'葫芦岛',py:'huludao',jc:'HLD',ac:'N',cid:'129'},{cs:'湖州',py:'huzhou',jc:'HZ',ac:'N',cid:'163'},{cs:'怀化',py:'huaihua',jc:'HH',ac:'N',cid:'279'},{cs:'怀仁',py:'huairen',jc:'HR',ac:'N',cid:'542'},{cs:'淮安',py:'huaian',jc:'HA',ac:'N',cid:'47'},{cs:'淮北',py:'huaibei',jc:'HB',ac:'N',cid:'377'},{cs:'淮南',py:'huainan',jc:'HN',ac:'N',cid:'188'},{cs:'黄冈',py:'huanggang',jc:'HG',ac:'N',cid:'350'},{cs:'黄山',py:'huangshan',jc:'HS',ac:'N',cid:'187'},{cs:'黄石',py:'huangshi',jc:'HS',ac:'N',cid:'303'},{cs:'珲春',py:'hunchun',jc:'HC',ac:'N',cid:'560'},{cs:'会昌',py:'huichang',jc:'HC',ac:'N',cid:'589'},{cs:'惠州',py:'huizhou',jc:'HZ',ac:'N',cid:'17'},{cs:'霍州',py:'huozhou',jc:'HZ',ac:'N',cid:'543'},{cs:'鸡西',py:'jixi',jc:'JX',ac:'N',cid:'353'},{cs:'吉安',py:'jian',jc:'JA',ac:'N',cid:'143'},{cs:'吉林',py:'jilin',jc:'JL',ac:'N',cid:'147'},{cs:'吉首',py:'jishou',jc:'JS',ac:'N',cid:'319'},{cs:'吉水',py:'jishui',jc:'JS',ac:'N',cid:'573'},{cs:'济南',py:'jinan',jc:'JN',ac:'Y',cid:'72'},{cs:'济宁',py:'jining',jc:'JN',ac:'N',cid:'73'},{cs:'佳木斯',py:'jiamusi',jc:'JMS',ac:'N',cid:'39'},{cs:'嘉兴',py:'jiaxing',jc:'JX',ac:'Y',cid:'89'},{cs:'嘉峪关',py:'jiayuguan',jc:'JYG',ac:'N',cid:'203'},{cs:'简阳',py:'jianyang',jc:'JY',ac:'N',cid:'324'},{cs:'建德',py:'jiande',jc:'JD',ac:'N',cid:'458'},{cs:'建瓯',py:'jianou',jc:'JO',ac:'N',cid:'486'},{cs:'剑阁',py:'jiange',jc:'JG',ac:'N',cid:'582'},{cs:'江门',py:'jiangmen',jc:'JM',ac:'N',cid:'18'},{cs:'江山',py:'jiangshan',jc:'JS',ac:'N',cid:'519'},{cs:'江阴',py:'jiangyin',jc:'JY',ac:'Y',cid:'48'},{cs:'江油',py:'jiangyou',jc:'JY',ac:'N',cid:'490'},{cs:'蛟河',py:'jiaohe',jc:'JH',ac:'N',cid:'596'},{cs:'焦作',py:'jiaozuo',jc:'JZ',ac:'N',cid:'339'},{cs:'揭阳',py:'jieyang',jc:'JY',ac:'N',cid:'220'},{cs:'介休',py:'jiexiu',jc:'JX',ac:'N',cid:'533'},{cs:'金昌',py:'jinchang',jc:'JC',ac:'N',cid:'405'},{cs:'金华',py:'JINHUA',jc:'JH',ac:'Y',cid:'90'},{cs:'锦州',py:'jinzhou',jc:'JZ',ac:'N',cid:'174'},{cs:'进贤',py:'jinxian',jc:'JX',ac:'N',cid:'515'},{cs:'晋城',py:'jincheng',jc:'JC',ac:'N',cid:'245'},{cs:'晋中',py:'jinzhong',jc:'JZ',ac:'N',cid:'363'},{cs:'缙云',py:'jinyun',jc:'JY',ac:'N',cid:'293'},{cs:'荆门',py:'jingmen',jc:'JM',ac:'N',cid:'133'},{cs:'荆州',py:'jingzhou',jc:'JZ',ac:'N',cid:'217'},{cs:'景德镇',py:'jingdezhen',jc:'JDZ',ac:'N',cid:'202'},{cs:'靖江',py:'jingjiang',jc:'JJ',ac:'N',cid:'251'},{cs:'九江',py:'jiujiang',jc:'JJ',ac:'N',cid:'103'},{cs:'酒泉',py:'jiuquan',jc:'JQ',ac:'N',cid:'407'},{cs:'句容',py:'jurong',jc:'JR',ac:'N',cid:'530'},{cs:'喀什',py:'kashi',jc:'KS',ac:'N',cid:'440'},{cs:'开封',py:'kaifeng',jc:'KF',ac:'Y',cid:'154'},{cs:'开化',py:'kaihua',jc:'KH',ac:'N',cid:'567'},{cs:'凯里',py:'kaili',jc:'KL',ac:'N',cid:'171'},{cs:'库尔勒',py:'kuerle',jc:'KEL',ac:'N',cid:'299'},{cs:'昆明',py:'kunming',jc:'KM',ac:'Y',cid:'86'},{cs:'昆山',py:'kunshan',jc:'KS',ac:'Y',cid:'49'},{cs:'拉萨',py:'lasa',jc:'LS',ac:'N',cid:'139'},{cs:'来宾',py:'laibin',jc:'LB',ac:'N',cid:'265'},{cs:'兰溪',py:'lanxi',jc:'LX',ac:'N',cid:'580'},{cs:'兰州',py:'lanzhou',jc:'LZ',ac:'N',cid:'27'},{cs:'阆中',py:'langzhong',jc:'LZ',ac:'N',cid:'270'},{cs:'廊坊',py:'langfang',jc:'LF',ac:'N',cid:'114'},{cs:'乐东',py:'ledong',jc:'LD',ac:'N',cid:'336'},{cs:'乐清',py:'leqing',jc:'LQ',ac:'N',cid:'583'},{cs:'乐山',py:'leshan',jc:'LS',ac:'N',cid:'278'},{cs:'耒阳',py:'leiyang',jc:'LY',ac:'N',cid:'471'},{cs:'醴陵',py:'liling',jc:'LL',ac:'N',cid:'468'},{cs:'丽江',py:'lijiang',jc:'LJ',ac:'N',cid:'116'},{cs:'丽水',py:'lishui',jc:'LS',ac:'Y',cid:'228'},{cs:'利川',py:'lichuan',jc:'LC',ac:'N',cid:'505'},{cs:'溧阳',py:'liyang',jc:'LY',ac:'Y',cid:'178'},{cs:'连云港',py:'lianyungang',jc:'LYG',ac:'N',cid:'286'},{cs:'廉江',py:'lianjiang',jc:'LJ',ac:'N',cid:'493'},{cs:'辽阳',py:'liaoyang',jc:'LY',ac:'N',cid:'356'},{cs:'聊城',py:'liaocheng',jc:'LC',ac:'N',cid:'262'},{cs:'林芝',py:'linzhi',jc:'LZ',ac:'N',cid:'232'},{cs:'临汾',py:'linfen',jc:'LF',ac:'N',cid:'104'},{cs:'临高',py:'lingao',jc:'LG',ac:'N',cid:'331'},{cs:'临海',py:'linhai',jc:'LH',ac:'N',cid:'494'},{cs:'临沂',py:'linyi',jc:'LY',ac:'N',cid:'263'},{cs:'灵宝',py:'lingbao',jc:'LB',ac:'N',cid:'495'},{cs:'灵石',py:'lingshi',jc:'LS',ac:'N',cid:'534'},{cs:'陵水',py:'lingshui',jc:'LS',ac:'N',cid:'276'},{cs:'浏阳',py:'liuyang',jc:'LY',ac:'N',cid:'267'},{cs:'柳州',py:'liuzhou',jc:'LZ',ac:'N',cid:'135'},{cs:'六安',py:'luan',jc:'LA',ac:'N',cid:'110'},{cs:'六盘水',py:'liupanshui',jc:'LPS',ac:'N',cid:'357'},{cs:'龙泉',py:'longquan',jc:'LQ',ac:'N',cid:'602'},{cs:'龙岩',py:'longyan',jc:'LY',ac:'N',cid:'126'},{cs:'龙游',py:'longyou',jc:'LY',ac:'N',cid:'599'},{cs:'陇南',py:'longnan',jc:'LN',ac:'N',cid:'412'},{cs:'娄底',py:'loudi',jc:'LD',ac:'N',cid:'280'},{cs:'泸州',py:'luzhou',jc:'LZ',ac:'N',cid:'192'},{cs:'洛阳',py:'luoyang',jc:'LY',ac:'N',cid:'40'},{cs:'漯河',py:'luohe',jc:'LH',ac:'N',cid:'41'},{cs:'吕梁',py:'lvliang',jc:'LL',ac:'N',cid:'333'},{cs:'麻城',py:'macheng',jc:'MC',ac:'N',cid:'513'},{cs:'马鞍山',py:'maanshan',jc:'MAS',ac:'N',cid:'100'},{cs:'茂名',py:'maoming',jc:'MM',ac:'N',cid:'98'},{cs:'眉山',py:'meishan',jc:'MS',ac:'N',cid:'316'},{cs:'梅州',py:'meizhou',jc:'MZ',ac:'N',cid:'124'},{cs:'蒙自',py:'mengzi',jc:'MZ',ac:'N',cid:'477'},{cs:'汨罗',py:'miluo',jc:'ML',ac:'N',cid:'226'},{cs:'绵阳',py:'mianyang',jc:'MY',ac:'N',cid:'102'},{cs:'牡丹江',py:'mudanjiang',jc:'MDJ',ac:'N',cid:'115'},{cs:'南部',py:'nanbu',jc:'NB',ac:'N',cid:'462'},{cs:'南昌',py:'nanchang',jc:'NC',ac:'Y',cid:'59'},{cs:'南充',py:'nanchong',jc:'NC',ac:'N',cid:'134'},{cs:'南京',py:'nanjing',jc:'NJ',ac:'Y',cid:'50'},{cs:'南宁',py:'nanning',jc:'NN',ac:'Y',cid:'29'},{cs:'南平',py:'nanping',jc:'NP',ac:'N',cid:'258'},{cs:'南通',py:'nantong',jc:'NT',ac:'N',cid:'51'},{cs:'南阳',py:'nanyang',jc:'NY',ac:'N',cid:'195'},{cs:'内江',py:'neijiang',jc:'NJ',ac:'N',cid:'340'},{cs:'宁波',py:'ningbo',jc:'NB',ac:'Y',cid:'91'},{cs:'宁德',py:'ningde',jc:'ND',ac:'N',cid:'214'},{cs:'宁海',py:'ninghai',jc:'NH',ac:'N',cid:'584'},{cs:'攀枝花',py:'panzhihua',jc:'PZH',ac:'N',cid:'338'},{cs:'蓬安',py:'pengan',jc:'PA',ac:'N',cid:'554'},{cs:'平顶山',py:'pingdingshan',jc:'PDS',ac:'N',cid:'380'},{cs:'平凉',py:'pingliang',jc:'PL',ac:'N',cid:'410'},{cs:'平遥',py:'pingyao',jc:'PY',ac:'N',cid:'459'},{cs:'萍乡',py:'PINGXIANG',jc:'PX',ac:'Y',cid:'257'},{cs:'鄱阳',py:'poyang',jc:'PY',ac:'N',cid:'564'},{cs:'莆田',py:'putian',jc:'PT',ac:'N',cid:'146'},{cs:'濮阳',py:'puyang',jc:'PY',ac:'N',cid:'379'},{cs:'浦江',py:'pujiang',jc:'PJ',ac:'N',cid:'577'},{cs:'普洱',py:'puer',jc:'PE',ac:'N',cid:'310'},{cs:'普宁',py:'puning',jc:'PN',ac:'N',cid:'480'},{cs:'普者黑',py:'puzhehei',jc:'PZH',ac:'N',cid:'598'},{cs:'齐齐哈尔',py:'qiqihaer',jc:'QQHE',ac:'N',cid:'165'},{cs:'祁东',py:'qidong',jc:'QD',ac:'N',cid:'467'},{cs:'祁县',py:'qixian',jc:'QX',ac:'N',cid:'535'},{cs:'启东',py:'qidong',jc:'QD',ac:'N',cid:'537'},{cs:'千岛湖',py:'qiandaohu',jc:'QDH',ac:'N',cid:'457'},{cs:'潜江',py:'qianjiang',jc:'QJ',ac:'N',cid:'216'},{cs:'钦州',py:'qinzhou',jc:'QZ',ac:'N',cid:'307'},{cs:'秦皇岛',py:'qinhuangda',jc:'QHD',ac:'N',cid:'233'},{cs:'青岛',py:'qingdao',jc:'QD',ac:'Y',cid:'74'},{cs:'青州',py:'qingzhou',jc:'QZ',ac:'N',cid:'482'},{cs:'清远',py:'qingyuan',jc:'QY',ac:'N',cid:'117'},{cs:'庆阳',py:'qingyang',jc:'QY',ac:'N',cid:'409'},{cs:'庆元',py:'qingyuan',jc:'QY',ac:'N',cid:'603'},{cs:'琼海',py:'qionghai',jc:'QH',ac:'N',cid:'160'},{cs:'琼中',py:'qiongzhong',jc:'QZ',ac:'N',cid:'526'},{cs:'衢州',py:'quzhou',jc:'QZ',ac:'N',cid:'164'},{cs:'曲阜',py:'qufu',jc:'QF',ac:'N',cid:'177'},{cs:'曲靖',py:'qujing',jc:'QJ',ac:'N',cid:'222'},{cs:'泉州',py:'quanzhou',jc:'QZ',ac:'N',cid:'11'},{cs:'仁怀',py:'renhuai',jc:'RH',ac:'N',cid:'594'},{cs:'日照',py:'rizhao',jc:'RZ',ac:'N',cid:'238'},{cs:'荣成',py:'rongcheng',jc:'RC',ac:'N',cid:'512'},{cs:'如皋',py:'rugao',jc:'RG',ac:'N',cid:'547'},{cs:'瑞安',py:'ruian',jc:'RA',ac:'N',cid:'209'},{cs:'瑞昌',py:'ruichang',jc:'RC',ac:'N',cid:'484'},{cs:'瑞金',py:'ruijin',jc:'RJ',ac:'N',cid:'591'},{cs:'三江',py:'sanjiang',jc:'SJ',ac:'N',cid:'354'},{cs:'三门峡',py:'sanmenxia',jc:'SMX',ac:'N',cid:'193'},{cs:'三明',py:'sanming',jc:'SM',ac:'N',cid:'295'},{cs:'三穗',py:'sansui',jc:'SS',ac:'N',cid:'556'},{cs:'三亚',py:'sanya',jc:'SY',ac:'Y',cid:'3'},{cs:'厦门',py:'xiamen',jc:'XM',ac:'N',cid:'12'},{cs:'汕头',py:'shantou',jc:'ST',ac:'N',cid:'19'},{cs:'汕尾',py:'shanwei',jc:'SW',ac:'N',cid:'199'},{cs:'商丘',py:'shangqiu',jc:'SQ',ac:'N',cid:'256'},{cs:'上海',py:'shanghai',jc:'SH',ac:'Y',cid:'77'},{cs:'上饶',py:'shangrao',jc:'SR',ac:'N',cid:'105'},{cs:'尚志',py:'shangzhi',jc:'SZ',ac:'N',cid:'550'},{cs:'韶关',py:'shaoguan',jc:'SG',ac:'N',cid:'20'},{cs:'邵武',py:'shaowu',jc:'SW',ac:'N',cid:'593'},{cs:'邵阳',py:'shaoyang',jc:'SY',ac:'N',cid:'284'},{cs:'绍兴',py:'shaoxing',jc:'SX',ac:'Y',cid:'93'},{cs:'深圳',py:'shenzhen',jc:'SZ',ac:'Y',cid:'21'},{cs:'沈阳',py:'shenyang',jc:'SY',ac:'Y',cid:'63'},{cs:'十堰',py:'shiyan',jc:'SY',ac:'N',cid:'223'},{cs:'石家庄',py:'shijiazhuang',jc:'SJZ',ac:'Y',cid:'34'},{cs:'双峰',py:'shuangfeng',jc:'SF',ac:'N',cid:'469'},{cs:'朔州',py:'shuozhou',jc:'SZ',ac:'N',cid:'300'},{cs:'四会',py:'sihui',jc:'SH',ac:'N',cid:'485'},{cs:'四平',py:'siping',jc:'SP',ac:'N',cid:'172'},{cs:'泗阳',py:'siyang',jc:'SY',ac:'N',cid:'606'},{cs:'松阳',py:'songyang',jc:'SY',ac:'N',cid:'601'},{cs:'松原',py:'songyuan',jc:'SY',ac:'N',cid:'367'},{cs:'苏州',py:'suzhou',jc:'SZ',ac:'Y',cid:'52'},{cs:'绥芬河',py:'suifenhe',jc:'SFH',ac:'N',cid:'521'},{cs:'随州',py:'suizhou',jc:'SZ',ac:'N',cid:'289'},{cs:'遂昌',py:'suichang',jc:'SC',ac:'N',cid:'600'},{cs:'遂宁',py:'suining',jc:'SN',ac:'N',cid:'184'},{cs:'遂溪',py:'suixi',jc:'SX',ac:'N',cid:'325'},{cs:'台山',py:'taishan',jc:'TS',ac:'N',cid:'329'},{cs:'台州',py:'taizhou',jc:'TZ',ac:'Y',cid:'94'},{cs:'太仓',py:'taicang',jc:'TC',ac:'N',cid:'53'},{cs:'太谷',py:'taigu',jc:'TG',ac:'N',cid:'539'},{cs:'太原',py:'taiyuan',jc:'TY',ac:'Y',cid:'78'},{cs:'泰安',py:'taian',jc:'TA',ac:'N',cid:'162'},{cs:'泰和',py:'taihe',jc:'TH',ac:'N',cid:'574'},{cs:'泰州',py:'taizhou2',jc:'TZ',ac:'Y',cid:'106'},{cs:'唐山',py:'tangshan',jc:'TS',ac:'N',cid:'35'},{cs:'腾冲',py:'tengchong',jc:'TC',ac:'N',cid:'158'},{cs:'天津',py:'tianjin',jc:'TJ',ac:'Y',cid:'79'},{cs:'天水',py:'tianshui',jc:'TS',ac:'N',cid:'317'},{cs:'铁岭',py:'tieling',jc:'TL',ac:'N',cid:'366'},{cs:'通化',py:'tonghua',jc:'TH',ac:'N',cid:'369'},{cs:'通辽',py:'tongliao',jc:'TL',ac:'N',cid:'359'},{cs:'桐庐',py:'tonglu',jc:'TL',ac:'N',cid:'455'},{cs:'铜陵',py:'tongling',jc:'TL',ac:'N',cid:'274'},{cs:'铜仁',py:'tongren',jc:'TR',ac:'N',cid:'268'},{cs:'图们',py:'tumen',jc:'TM',ac:'N',cid:'597'},{cs:'屯昌',py:'tunchang',jc:'TC',ac:'N',cid:'527'},{cs:'万安',py:'wanan',jc:'WA',ac:'N',cid:'575'},{cs:'万宁',py:'wanning',jc:'WN',ac:'N',cid:'302'},{cs:'威海',py:'weihai',jc:'WH',ac:'N',cid:'161'},{cs:'潍坊',py:'weifang',jc:'WF',ac:'N',cid:'75'},{cs:'渭南',py:'weinan',jc:'WN',ac:'N',cid:'180'},{cs:'温岭',py:'wenling',jc:'WL',ac:'N',cid:'487'},{cs:'温州',py:'wenzhou',jc:'WZ',ac:'Y',cid:'95'},{cs:'文昌',py:'wenchang',jc:'WC',ac:'N',cid:'271'},{cs:'文山',py:'wenshan',jc:'WS',ac:'N',cid:'322'},{cs:'闻喜',py:'wenxi',jc:'WX',ac:'N',cid:'544'},{cs:'乌海',py:'wuhai',jc:'WH',ac:'N',cid:'422'},{cs:'乌兰察布',py:'wulanchabu',jc:'WLCB',ac:'N',cid:'358'},{cs:'乌鲁木齐',py:'wulumuqi',jc:'WLMQ',ac:'N',cid:'112'},{cs:'无锡',py:'wuxi',jc:'WX',ac:'N',cid:'54'},{cs:'芜湖',py:'wuhu',jc:'WH',ac:'N',cid:'150'},{cs:'吴川',py:'wuchuan',jc:'WC',ac:'N',cid:'488'},{cs:'吴忠',py:'wuzhong',jc:'WZ',ac:'N',cid:'288'},{cs:'梧州',py:'wuzhou',jc:'WZ',ac:'N',cid:'283'},{cs:'五指山',py:'wuzhishan',jc:'WZS',ac:'N',cid:'559'},{cs:'武汉',py:'wuhan',jc:'WH',ac:'Y',cid:'81'},{cs:'武胜',py:'wusheng',jc:'WS',ac:'N',cid:'463'},{cs:'武威',py:'wuwei',jc:'WW',ac:'N',cid:'408'},{cs:'武夷山',py:'wuyishan',jc:'WYS',ac:'N',cid:'121'},{cs:'武义',py:'wuyi',jc:'WY',ac:'N',cid:'562'},{cs:'婺源',py:'wuyuan',jc:'WY',ac:'N',cid:'201'},{cs:'西安',py:'xian',jc:'XA',ac:'N',cid:'4'},{cs:'西昌',py:'xichang',jc:'XC',ac:'N',cid:'292'},{cs:'西宁',py:'xining',jc:'XN',ac:'N',cid:'70'},{cs:'西双版纳',py:'xishuangbanna',jc:'XSBN',ac:'N',cid:'113'},{cs:'锡林浩特',py:'xilinhaote',jc:'XLHT',ac:'N',cid:'335'},{cs:'峡江',py:'xiajiang',jc:'XJ',ac:'N',cid:'572'},{cs:'仙桃',py:'xiantao',jc:'XT',ac:'N',cid:'183'},{cs:'咸宁',py:'xianning',jc:'XN',ac:'N',cid:'123'},{cs:'咸阳',py:'xianyang',jc:'XY',ac:'N',cid:'155'},{cs:'香格里拉',py:'xianggelila',jc:'XGLL',ac:'N',cid:'592'},{cs:'湘潭',py:'xiangtan',jc:'XT',ac:'N',cid:'151'},{cs:'襄汾',py:'xiangfen',jc:'XF',ac:'N',cid:'545'},{cs:'襄阳',py:'xiangyang',jc:'XY',ac:'N',cid:'125'},{cs:'孝感',py:'xiaogan',jc:'XG',ac:'N',cid:'318'},{cs:'辛集',py:'xinji',jc:'XJ',ac:'N',cid:'516'},{cs:'忻州',py:'xinzhou',jc:'XZ',ac:'N',cid:'315'},{cs:'新干',py:'xingan',jc:'XG',ac:'N',cid:'571'},{cs:'新化',py:'xinhua',jc:'XH',ac:'N',cid:'470'},{cs:'新乡',py:'xinxiang',jc:'XX',ac:'N',cid:'337'},{cs:'新余',py:'xinyu',jc:'XY',ac:'N',cid:'182'},{cs:'新郑',py:'xinzheng',jc:'XZ',ac:'N',cid:'320'},{cs:'信阳',py:'xinyang',jc:'XY',ac:'N',cid:'181'},{cs:'邢台',py:'xingtai',jc:'XT',ac:'N',cid:'176'},{cs:'兴国',py:'xingguo',jc:'XG',ac:'N',cid:'576'},{cs:'兴宁',py:'xingning',jc:'XN',ac:'N',cid:'489'},{cs:'兴义',py:'xingyi',jc:'XY',ac:'N',cid:'311'},{cs:'雄安新区',py:'xionganxin',jc:'XAXQ',ac:'N',cid:'460'},{cs:'宿迁',py:'suqian',jc:'SQ',ac:'N',cid:'273'},{cs:'宿州',py:'suzhou',jc:'SZ',ac:'N',cid:'269'},{cs:'徐州',py:'xuzhou',jc:'XZ',ac:'Y',cid:'56'},{cs:'许昌',py:'xuchang',jc:'XC',ac:'N',cid:'144'},{cs:'宣城',py:'xuancheng',jc:'XC',ac:'N',cid:'313'},{cs:'雅安',py:'yaan',jc:'YA',ac:'N',cid:'291'},{cs:'烟台',py:'yantai',jc:'YT',ac:'Y',cid:'118'},{cs:'延安',py:'yanan',jc:'YA',ac:'N',cid:'246'},{cs:'延吉',py:'yanji',jc:'YJ',ac:'N',cid:'166'},{cs:'盐城',py:'yancheng',jc:'YC',ac:'N',cid:'96'},{cs:'扬州',py:'yangzhou',jc:'YZ',ac:'Y',cid:'57'},{cs:'阳春',py:'yangchun',jc:'YC',ac:'N',cid:'491'},{cs:'阳江',py:'yangjiang',jc:'YJ',ac:'N',cid:'136'},{cs:'阳泉',py:'yangquan',jc:'YQ',ac:'N',cid:'360'},{cs:'阳新',py:'yangxin',jc:'YX',ac:'N',cid:'510'},{cs:'伊春',py:'yichun',jc:'YC',ac:'N',cid:'305'},{cs:'依兰',py:'yilan',jc:'YL',ac:'N',cid:'568'},{cs:'宜宾',py:'yibin',jc:'YB',ac:'N',cid:'190'},{cs:'宜昌',py:'yichang',jc:'YC',ac:'N',cid:'101'},{cs:'宜春',py:'yichun',jc:'YC',ac:'N',cid:'225'},{cs:'宜兴',py:'yixing',jc:'YX',ac:'Y',cid:'145'},{cs:'义乌',py:'yiwu',jc:'YW',ac:'Y',cid:'97'},{cs:'益阳',py:'yiyang',jc:'YY',ac:'N',cid:'298'},{cs:'银川',py:'yinchuan',jc:'YC',ac:'N',cid:'68'},{cs:'英德',py:'yingde',jc:'YD',ac:'N',cid:'328'},{cs:'鹰潭',py:'yingtan',jc:'YT',ac:'Y',cid:'237'},{cs:'营口',py:'yingkou',jc:'YK',ac:'N',cid:'120'},{cs:'应县',py:'yingxian',jc:'YX',ac:'N',cid:'541'},{cs:'永安',py:'yongan',jc:'YA',ac:'N',cid:'525'},{cs:'永城',py:'yongcheng',jc:'YC',ac:'N',cid:'492'},{cs:'永济',py:'yongji',jc:'YJ',ac:'N',cid:'536'},{cs:'永康',py:'yongkang',jc:'YK',ac:'N',cid:'563'},{cs:'永州',py:'yongzhou',jc:'YZ',ac:'N',cid:'235'},{cs:'于都',py:'yudu',jc:'YD',ac:'N',cid:'590'},{cs:'余姚',py:'yuyao',jc:'YY',ac:'N',cid:'227'},{cs:'榆林',py:'yulin',jc:'YL',ac:'N',cid:'361'},{cs:'玉林',py:'yulin',jc:'YL',ac:'N',cid:'430'},{cs:'玉溪',py:'yuxi',jc:'YX',ac:'N',cid:'255'},{cs:'原平',py:'yuanping',jc:'YP',ac:'N',cid:'531'},{cs:'岳阳',py:'yueyang',jc:'YY',ac:'N',cid:'99'},{cs:'云浮',py:'yunfu',jc:'YF',ac:'N',cid:'213'},{cs:'运城',py:'yuncheng',jc:'YC',ac:'N',cid:'148'},{cs:'枣庄',py:'zaozhuang',jc:'ZZ',ac:'Y',cid:'198'},{cs:'湛江',py:'zhanjiang',jc:'ZJ',ac:'N',cid:'23'},{cs:'张家港',py:'zhangjiagang',jc:'ZJG',ac:'N',cid:'196'},{cs:'张家界',py:'zhangjiaji',jc:'ZJJ',ac:'N',cid:'254'},{cs:'张家口',py:'zhangjiako',jc:'ZJK',ac:'N',cid:'167'},{cs:'张掖',py:'zhangye',jc:'ZY',ac:'N',cid:'297'},{cs:'漳浦',py:'zhangpu',jc:'ZP',ac:'N',cid:'549'},{cs:'漳州',py:'zhangzhou',jc:'ZZ',ac:'N',cid:'13'},{cs:'樟树',py:'zhangshu',jc:'ZS',ac:'N',cid:'570'},{cs:'长春',py:'changchun',jc:'CC',ac:'Y',cid:'43'},{cs:'长丰',py:'changfeng',jc:'CF',ac:'N',cid:'604'},{cs:'长临河',py:'changlinhe',jc:'CLH',ac:'N',cid:'464'},{cs:'长沙',py:'changsha',jc:'CS',ac:'N',cid:'82'},{cs:'长汀',py:'changting',jc:'CT',ac:'N',cid:'587'},{cs:'长治',py:'changzhi',jc:'CZ',ac:'N',cid:'169'},{cs:'昭通',py:'zhaotong',jc:'ZT',ac:'N',cid:'352'},{cs:'诏安',py:'zhaoan',jc:'ZA',ac:'N',cid:'595'},{cs:'肇东',py:'zhaodong',jc:'ZD',ac:'N',cid:'517'},{cs:'肇庆',py:'zhaoqing',jc:'ZQ',ac:'N',cid:'149'},{cs:'镇江',py:'zhenjiang',jc:'ZJ',ac:'Y',cid:'58'},{cs:'郑州',py:'zhengzhou',jc:'ZZ',ac:'Y',cid:'42'},{cs:'枝江',py:'zhijiang',jc:'ZJ',ac:'N',cid:'465'},{cs:'中山',py:'zhongshan',jc:'ZS',ac:'N',cid:'24'},{cs:'中卫',py:'zhongwei',jc:'ZW',ac:'N',cid:'287'},{cs:'重庆',py:'chongqing',jc:'CQ',ac:'Y',cid:'7'},{cs:'舟山',py:'zhoushan',jc:'ZS',ac:'N',cid:'242'},{cs:'周口',py:'zhoukou',jc:'ZK',ac:'N',cid:'343'},{cs:'珠海',py:'zhuhai',jc:'ZH',ac:'N',cid:'25'},{cs:'株洲',py:'zhuzhou',jc:'ZZ',ac:'N',cid:'83'},{cs:'驻马店',py:'zhumadian',jc:'ZMD',ac:'N',cid:'344'},{cs:'资阳',py:'ziyang',jc:'ZY',ac:'N',cid:'330'},{cs:'资中',py:'zizhong',jc:'ZZ',ac:'N',cid:'548'},{cs:'淄博',py:'zibo',jc:'ZB',ac:'Y',cid:'76'},{cs:'自贡',py:'zigong',jc:'ZG',ac:'N',cid:'191'},{cs:'遵义',py:'zunyi',jc:'ZY',ac:'N',cid:'212'}],checkObj:[{},{cs:'阿克苏'},{cs:'安达'},{cs:'安吉'},{cs:'安康'},{cs:'安庆'},{cs:'安顺'},{cs:'安图'},{cs:'安阳'},{cs:'鞍山'},{cs:'巴彦淖尔'},{cs:'巴中'},{cs:'霸州'},{cs:'白城'},{cs:'白沙'},{cs:'白银'},{cs:'百色'},{cs:'蚌埠'},{cs:'包头'},{cs:'宝鸡'},{cs:'宝应'},{cs:'保定'},{cs:'保山'},{cs:'北海'},{cs:'北京'},{cs:'本溪'},{cs:'毕节'},{cs:'滨州'},{cs:'苍溪'},{cs:'沧州'},{cs:'昌江'},{cs:'常德'},{cs:'常山'},{cs:'常熟'},{cs:'常州'},{cs:'巢湖'},{cs:'朝阳'},{cs:'潮州'},{cs:'郴州'},{cs:'成都'},{cs:'承德'},{cs:'澄迈'},{cs:'池州'},{cs:'赤壁'},{cs:'赤峰'},{cs:'滁州'},{cs:'楚雄'},{cs:'慈溪'},{cs:'从江'},{cs:'达州'},{cs:'大理'},{cs:'大连'},{cs:'大庆'},{cs:'大同'},{cs:'大冶'},{cs:'丹东'},{cs:'丹阳'},{cs:'儋州'},{cs:'德宏'},{cs:'德惠'},{cs:'德令哈'},{cs:'德清'},{cs:'德兴'},{cs:'德阳'},{cs:'德州'},{cs:'定安'},{cs:'定西'},{cs:'定州'},{cs:'东方'},{cs:'东莞'},{cs:'东阳'},{cs:'东营'},{cs:'都匀'},{cs:'敦化'},{cs:'敦煌'},{cs:'鄂尔多斯'},{cs:'鄂州'},{cs:'恩施'},{cs:'防城港'},{cs:'丰城'},{cs:'佛山'},{cs:'扶余'},{cs:'福安'},{cs:'福鼎'},{cs:'福清'},{cs:'福州'},{cs:'抚顺'},{cs:'抚州'},{cs:'阜新'},{cs:'阜阳'},{cs:'富阳'},{cs:'赣州'},{cs:'高安'},{cs:'高密'},{cs:'高州'},{cs:'格尔木'},{cs:'公主岭'},{cs:'巩义'},{cs:'共青城'},{cs:'固原'},{cs:'广安'},{cs:'广汉'},{cs:'广元'},{cs:'广州'},{cs:'贵定'},{cs:'贵港'},{cs:'贵阳'},{cs:'桂林'},{cs:'哈尔滨'},{cs:'海安'},{cs:'海口'},{cs:'海宁'},{cs:'邯郸'},{cs:'汉川'},{cs:'汉中'},{cs:'杭州'},{cs:'合肥'},{cs:'河源'},{cs:'菏泽'},{cs:'贺州'},{cs:'鹤壁'},{cs:'鹤岗'},{cs:'衡水'},{cs:'衡阳'},{cs:'红安'},{cs:'洪洞'},{cs:'侯马'},{cs:'呼和浩特'},{cs:'呼伦贝尔'},{cs:'葫芦岛'},{cs:'湖州'},{cs:'怀化'},{cs:'怀仁'},{cs:'淮安'},{cs:'淮北'},{cs:'淮南'},{cs:'黄冈'},{cs:'黄山'},{cs:'黄石'},{cs:'珲春'},{cs:'会昌'},{cs:'惠州'},{cs:'霍州'},{cs:'鸡西'},{cs:'吉安'},{cs:'吉林'},{cs:'吉首'},{cs:'吉水'},{cs:'济南'},{cs:'济宁'},{cs:'佳木斯'},{cs:'嘉兴'},{cs:'嘉峪关'},{cs:'简阳'},{cs:'建德'},{cs:'建瓯'},{cs:'剑阁'},{cs:'江门'},{cs:'江山'},{cs:'江阴'},{cs:'江油'},{cs:'蛟河'},{cs:'焦作'},{cs:'揭阳'},{cs:'介休'},{cs:'金昌'},{cs:'金华'},{cs:'锦州'},{cs:'进贤'},{cs:'晋城'},{cs:'晋中'},{cs:'缙云'},{cs:'荆门'},{cs:'荆州'},{cs:'景德镇'},{cs:'靖江'},{cs:'九江'},{cs:'酒泉'},{cs:'句容'},{cs:'喀什'},{cs:'开封'},{cs:'开化'},{cs:'凯里'},{cs:'库尔勒'},{cs:'昆明'},{cs:'昆山'},{cs:'拉萨'},{cs:'来宾'},{cs:'兰溪'},{cs:'兰州'},{cs:'阆中'},{cs:'廊坊'},{cs:'乐东'},{cs:'乐清'},{cs:'乐山'},{cs:'耒阳'},{cs:'醴陵'},{cs:'丽江'},{cs:'丽水'},{cs:'利川'},{cs:'溧阳'},{cs:'连云港'},{cs:'廉江'},{cs:'辽阳'},{cs:'聊城'},{cs:'林芝'},{cs:'临汾'},{cs:'临高'},{cs:'临海'},{cs:'临沂'},{cs:'灵宝'},{cs:'灵石'},{cs:'陵水'},{cs:'浏阳'},{cs:'柳州'},{cs:'六安'},{cs:'六盘水'},{cs:'龙泉'},{cs:'龙岩'},{cs:'龙游'},{cs:'陇南'},{cs:'娄底'},{cs:'泸州'},{cs:'洛阳'},{cs:'漯河'},{cs:'吕梁'},{cs:'麻城'},{cs:'马鞍山'},{cs:'茂名'},{cs:'眉山'},{cs:'梅州'},{cs:'蒙自'},{cs:'汨罗'},{cs:'绵阳'},{cs:'牡丹江'},{cs:'南部'},{cs:'南昌'},{cs:'南充'},{cs:'南京'},{cs:'南宁'},{cs:'南平'},{cs:'南通'},{cs:'南阳'},{cs:'内江'},{cs:'宁波'},{cs:'宁德'},{cs:'宁海'},{cs:'攀枝花'},{cs:'蓬安'},{cs:'平顶山'},{cs:'平凉'},{cs:'平遥'},{cs:'萍乡'},{cs:'鄱阳'},{cs:'莆田'},{cs:'濮阳'},{cs:'浦江'},{cs:'普洱'},{cs:'普宁'},{cs:'普者黑'},{cs:'齐齐哈尔'},{cs:'祁东'},{cs:'祁县'},{cs:'启东'},{cs:'千岛湖'},{cs:'潜江'},{cs:'钦州'},{cs:'秦皇岛'},{cs:'青岛'},{cs:'青州'},{cs:'清远'},{cs:'庆阳'},{cs:'庆元'},{cs:'琼海'},{cs:'琼中'},{cs:'衢州'},{cs:'曲阜'},{cs:'曲靖'},{cs:'泉州'},{cs:'仁怀'},{cs:'日照'},{cs:'荣成'},{cs:'如皋'},{cs:'瑞安'},{cs:'瑞昌'},{cs:'瑞金'},{cs:'三江'},{cs:'三门峡'},{cs:'三明'},{cs:'三穗'},{cs:'三亚'},{cs:'厦门'},{cs:'汕头'},{cs:'汕尾'},{cs:'商丘'},{cs:'上海'},{cs:'上饶'},{cs:'尚志'},{cs:'韶关'},{cs:'邵武'},{cs:'邵阳'},{cs:'绍兴'},{cs:'深圳'},{cs:'沈阳'},{cs:'十堰'},{cs:'石家庄'},{cs:'双峰'},{cs:'朔州'},{cs:'四会'},{cs:'四平'},{cs:'泗阳'},{cs:'松阳'},{cs:'松原'},{cs:'苏州'},{cs:'绥芬河'},{cs:'随州'},{cs:'遂昌'},{cs:'遂宁'},{cs:'遂溪'},{cs:'台山'},{cs:'台州'},{cs:'太仓'},{cs:'太谷'},{cs:'太原'},{cs:'泰安'},{cs:'泰和'},{cs:'泰州'},{cs:'唐山'},{cs:'腾冲'},{cs:'天津'},{cs:'天水'},{cs:'铁岭'},{cs:'通化'},{cs:'通辽'},{cs:'桐庐'},{cs:'铜陵'},{cs:'铜仁'},{cs:'图们'},{cs:'屯昌'},{cs:'万安'},{cs:'万宁'},{cs:'威海'},{cs:'潍坊'},{cs:'渭南'},{cs:'温岭'},{cs:'温州'},{cs:'文昌'},{cs:'文山'},{cs:'闻喜'},{cs:'乌海'},{cs:'乌兰察布'},{cs:'乌鲁木齐'},{cs:'无锡'},{cs:'芜湖'},{cs:'吴川'},{cs:'吴忠'},{cs:'梧州'},{cs:'五指山'},{cs:'武汉'},{cs:'武胜'},{cs:'武威'},{cs:'武夷山'},{cs:'武义'},{cs:'婺源'},{cs:'西安'},{cs:'西昌'},{cs:'西宁'},{cs:'西双版纳'},{cs:'锡林浩特'},{cs:'峡江'},{cs:'仙桃'},{cs:'咸宁'},{cs:'咸阳'},{cs:'香格里拉'},{cs:'湘潭'},{cs:'襄汾'},{cs:'襄阳'},{cs:'孝感'},{cs:'辛集'},{cs:'忻州'},{cs:'新干'},{cs:'新化'},{cs:'新乡'},{cs:'新余'},{cs:'新郑'},{cs:'信阳'},{cs:'邢台'},{cs:'兴国'},{cs:'兴宁'},{cs:'兴义'},{cs:'雄安新区'},{cs:'宿迁'},{cs:'宿州'},{cs:'徐州'},{cs:'许昌'},{cs:'宣城'},{cs:'雅安'},{cs:'烟台'},{cs:'延安'},{cs:'延吉'},{cs:'盐城'},{cs:'扬州'},{cs:'阳春'},{cs:'阳江'},{cs:'阳泉'},{cs:'阳新'},{cs:'伊春'},{cs:'依兰'},{cs:'宜宾'},{cs:'宜昌'},{cs:'宜春'},{cs:'宜兴'},{cs:'义乌'},{cs:'益阳'},{cs:'银川'},{cs:'英德'},{cs:'鹰潭'},{cs:'营口'},{cs:'应县'},{cs:'永安'},{cs:'永城'},{cs:'永济'},{cs:'永康'},{cs:'永州'},{cs:'于都'},{cs:'余姚'},{cs:'榆林'},{cs:'玉林'},{cs:'玉溪'},{cs:'原平'},{cs:'岳阳'},{cs:'云浮'},{cs:'运城'},{cs:'枣庄'},{cs:'湛江'},{cs:'张家港'},{cs:'张家界'},{cs:'张家口'},{cs:'张掖'},{cs:'漳浦'},{cs:'漳州'},{cs:'樟树'},{cs:'长春'},{cs:'长丰'},{cs:'长临河'},{cs:'长沙'},{cs:'长汀'},{cs:'长治'},{cs:'昭通'},{cs:'诏安'},{cs:'肇东'},{cs:'肇庆'},{cs:'镇江'},{cs:'郑州'},{cs:'枝江'},{cs:'中山'},{cs:'中卫'},{cs:'重庆'},{cs:'舟山'},{cs:'周口'},{cs:'珠海'},{cs:'株洲'},{cs:'驻马店'},{cs:'资阳'},{cs:'资中'},{cs:'淄博'},{cs:'自贡'},{cs:'遵义'}]}";
    </script>

    <script type="text/html" id="bookRuleBox">
        <div class="book-rule">
            <h3>
                强制预付规则
            </h3>
            <div class="ruleinfo">
                <ul class="list-paddingleft-2">
                    <li>
                        <p class="rule-lgbt">
                            1、支付方式
                        </p>
                        <p>
                            预订用车后，一嗨将为您保留车辆15分钟，为了不影响您的出行计划，请15分钟内完成支付，避免订单因超时未支付而提交失败。
                        </p>
                    </li>
                    <li>
                        <p class="rule-lgbt">
                            2、订单取消
                        </p>
                        <p>
                            a)如取消订单，收取车辆租赁费及门店服务费的30%作为违约金，剩余费用退还。
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
                            b)若修改后订单金额低于原订单金额，收取车辆租赁费及门店服务费差额的30%作为改签费；若修改后订单金额高于原订单金额，支付剩余金额后即完成订单修改。
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
                            如客户未能及时、足额支付租赁费用，一嗨将以合理方式进行催收；且客户应当每日支付相当于应付而未付费用的千分之三作为滞纳金至所有费用结清之日止。
                        </p>
                    </li>
                </ul>
            </div>
        </div>
    </script>

    <div class="field-level-tip">
        <p>驾照领证少于6个月会有车型预订限制，建议勾选“新手可用车型”</p>
        <div class="base-arrow">
            <em>◆</em>
            <span>◆</span>
        </div>
    </div>

    <div id="scrollTop">
        <span class="scrollIcon"></span>
        <p class="scrollText">返回<br/>顶部</p>
    </div>

    <div id="purpose-select" style="display: none;">
        <div class="show-purpose">
            <h4>请选择您此单的用途</h4>
            <span class="purpose-btline"></span>
            <div class="show-purposeinfo">
                <p>
                    <input name="purpose" type="radio" value="公司用途">
                    公司用途
                    <span>最终金额以实际结算为准。</span>
                </p>
                <p>
                    <input name="purpose" type="radio" value="个人用途" checked=&#39;checked&#39;>
                    个人用途
                    <span>更多优惠试试更长租期。</span>
                </p>
                <div class="purpose-opt">
						<span class="purpose-btn" id="purpose-btn">
							确&nbsp;&nbsp;&nbsp;定
						</span>
                </div>
            </div>
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
                                <input class="input-info" id="registerPhone" name="phone" type="text" placeholder="请输入手机号" maxlength="11">
                            </li>
							<li>
                                <input id="registerEmail" name="demail" type="email" placeholder="请输入电子邮箱">
							</li>
                            <li>
                                <input id="registerPwd" type="password" name="password" placeholder="密码需4到18位" maxlength="18">
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
                            <input id="registerAgree" type="checkbox" checked="">我已阅读并同意<a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=2&amp;isLimitRules=False#zcyys-czrys" target="_blank">《一嗨租车会员注册协议》</a>和<a href="https://www.1hai.cn/NewHelp/HelpContent?menuId=74&amp;isLimitRules=False" target="_blank">《一嗨租车隐私政策》</a>
                        </p>
                        <p class="popup-operate-btn">
                            <a href="javascript:register()" title="立即注册" class="btn-popup"id="popupRegister">立即注册</a>
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
	</body>
<script src="/home/layui/layui.all.js"></script>
<script src="/home/js/jquery.min.js"></script>
<script src="/home/js/msg.js"></script>
<script>
    $(document).ready(function () {
        $(".popup-close").click(function () {
            $(".login-register-popup").addClass("hide");
        });
        var user = null;
			<#if deskUser??>
				user = '${deskUser}';
            </#if>
        if(user!=null&user!=""){
            $("#spanLogined").removeClass("hide");
            $("#spanLogin").addClass("hide");
            close1();
        }
        //初始化验证码
        imgRandom($("#logincaptcha"));
    });
</script>
<script type="text/javascript">
        var Url = {
            SelectCarTypes: '/Order/FirstStep/LoadCarTypeData',
            Filter: '/Order/FirstStep/Filter',
            InStore: '/Order/FirstStep/InStore',
            Booking: '/Order/FirstStep/Booking',
            ChangeStore: '/Order/FirstStep/ChangeStore',
            ChangeTime: '/Order/FirstStep/ChangeTime',
            SelfChangeTime: '/Order/FirstStep/SelfChangeTime'
        };
    </script>
    <script src="/home/js/e5c9c62583c34fd49178f722ec2f471e.js"></script>
    <script src="/home/js/333609ab26734c298ca4429f855e17a2.js"></script>
    <script src="/home/js/237a3406745f4e128fbd3d5f423630fc.js"></script>
	<script type="text/javascript" src="/home/js/geoutils_min.js"></script>
	<script type="text/javascript" src="/home/js/store.baidu.map.js"></script>
    <script>
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
        //验证码刷新
        function imgRandom(thisImg){
            thisImg.src=thisImg.src+'&d='+Math.random();
        }
        //注册验证
        function rcheck(){
            layui.use('layer', function(){
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
            if(!registerAgree.attr("checked")){
                errorMsg("未勾选协议");
                return false;
            }
            if(demail.length==0){
                errorMsg("请输入电子邮箱");
                return false;
            }
            if (!chkemail.test(demail)){
                errorMsg("请输入正确的电子邮箱");
                return false;
            }
            if(!chkphone.test(phone)) {
                errorMsg("请输入正确的手机号");
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
        //提交注册
        function register(){
            if(rcheck()){
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
                            setTimeout(function() {
                                loginSwitch();//跳转至登录
                                imgRandom($("#logincaptcha"));
                            }, 1000);
                        }
                        else
                        {
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
            if(phone.length == 0)
            {
                errorMsg("请输入手机号");
                return false;
            }
            if(password.length == 0)
            {
                errorMsg("请输入密码");
                return false;
            }
            if(code.length == 0)
            {
                errorMsg("请输入验证码");
                return false;
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
                            location.href = "/home/index/independentCarRental";
                        }, 1000);
                    }
                    else
                    {
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
                    var phone = $('.phone',layero).val().trim();
                    var demail = $('.demail', layero).val().trim();
                    var password = $('.password', layero).val().trim();
                    var password2 = $('.password2', layero).val().trim();
                    forgetPwd(phone,demail, password, password2, index);
                },
                btn2: function (index, layero) {
                    layer.close(index)
                }
            });
        };
        //忘记密码
        function forgetPwd(phone,demail, password, verPassword, index) {
            if(phone.length == 0)
            {
                layer.msg("请输入手机号");
                return ;
            }
            if (demail.length==0){
                layer.msg("请输入电子邮箱");
                return ;
            }
            if(password.length == 0)
            {
                layer.msg("请输入密码");
                return ;
            }

            if(verPassword.length == 0)
            {
                layer.msg("请输入确认密码");
                return ;
            }
            if(password != verPassword)
            {
                layer.msg("密码不一致");
                return ;
            }
            //手机号正则验证
            var chkphone = /^1[3|4|5|7|8]\d{9}$/;
            if(!chkphone.test(phone))
            {
                layer.msg("请输入正确的手机号");
                return ;
            }
            //电子邮箱验证
            var chkemail = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/;
            if (!chkemail.test(demail)){
                layer.msg("请输入正确的电子邮箱");
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
                        layer.msg("修改成功");
                        layer.close(index);
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

    <script src="/home/js/e5c9c62583c34fd49178f722ec2f471e.js"></script>
    <script src="/home/js/333609ab26734c298ca4429f855e17a2.js"></script>

    <!--日历-->
    <link type="text/css" rel="stylesheet" href="/home/css/calendar.css" />

    <script language="javascript" type="text/javascript">
        var FromDateCtrlId = "J_date_1";
        var ToDateCtrlId = "J_date_2";
        var ccMinDate = "";
        var today = "2020-12-18";
    </script>
    <script src="/home/js/2bc56251433d4878af5dfefb4df46e75.js"></script>


    <script>
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + 90);
        document.cookie = "js=true;expires=" + exdate.toUTCString();
    </script>

    <script type="text/javascript">
        $.ajaxSetup({
            statusCode: {
                800: function(data) {
                    window.location.href = 'https://my.1hai.cn/'
                },
                205: function(data) {
                    alert('抱歉，操作频率过高，请刷新页面后重试!');
                    return false
                }
            }
        });

        function refreshtoken(target) {
            $(target).load('/Order/Common/RefreshToken')
        }



        /**车型视频弹窗**/
        $(document).on('click', '.video-total', function () {
            var ids = $(this).data('cartypeids');
            console.log(ids);
            $.ajax({
                type: 'post',
                url: 'viewMobilePicture',
                data: {carTypeIds: ids},
                dataType: 'json',
                async: true,
                success: function (data) {
                    var path = data.data.videoPath;
                    var brand = data.data.brand;
                    document.getElementById("mshowbox").style.display = "";
                    $("#carVideo0").attr("src","/photo/view?filename="+path);
                    $("#brand").append(brand);
                }
            });
        });

        function closeVideo() {
            $("#carVideo0").removeAttr("src");
            $("#brand").empty();
            document.getElementById("mshowbox").style.display = "none";
        }
    </script>

</body>
</html>
