/* Minification failed. Returning unminified contents.
(1756,8-9): run-time error JS1195: Expected expression: >
(1760,5-6): run-time error JS1002: Syntax error: }
(1761,28-29): run-time error JS1004: Expected ';': {
 */
/*
** Unobtrusive Ajax support library for jQuery
** Copyright (C) Microsoft Corporation. All rights reserved.
*/
(function(a){var b="unobtrusiveAjaxClick",g="unobtrusiveValidation";function c(d,b){var a=window,c=(d||"").split(".");while(a&&c.length)a=a[c.shift()];if(typeof a==="function")return a;b.push(d);return Function.constructor.apply(null,b)}function d(a){return a==="GET"||a==="POST"}function f(b,a){!d(a)&&b.setRequestHeader("X-HTTP-Method-Override",a)}function h(c,b,e){var d;if(e.indexOf("application/x-javascript")!==-1)return;d=(c.getAttribute("data-ajax-mode")||"").toUpperCase();a(c.getAttribute("data-ajax-update")).each(function(f,c){var e;switch(d){case"BEFORE":e=c.firstChild;a("<div />").html(b).contents().each(function(){c.insertBefore(this,e)});break;case"AFTER":a("<div />").html(b).contents().each(function(){c.appendChild(this)});break;default:a(c).html(b)}})}function e(b,e){var j,k,g,i;j=b.getAttribute("data-ajax-confirm");if(j&&!window.confirm(j))return;k=a(b.getAttribute("data-ajax-loading"));i=b.getAttribute("data-ajax-loading-duration")||0;a.extend(e,{type:b.getAttribute("data-ajax-method")||undefined,url:b.getAttribute("data-ajax-url")||undefined,beforeSend:function(d){var a;f(d,g);a=c(b.getAttribute("data-ajax-begin"),["xhr"]).apply(this,arguments);a!==false&&k.show(i);return a},complete:function(){k.hide(i);c(b.getAttribute("data-ajax-complete"),["xhr","status"]).apply(this,arguments)},success:function(a,e,d){h(b,a,d.getResponseHeader("Content-Type")||"text/html");c(b.getAttribute("data-ajax-success"),["data","status","xhr"]).apply(this,arguments)},error:c(b.getAttribute("data-ajax-failure"),["xhr","status","error"])});e.data.push({name:"X-Requested-With",value:"XMLHttpRequest"});g=e.type.toUpperCase();if(!d(g)){e.type="POST";e.data.push({name:"X-HTTP-Method-Override",value:g})}a.ajax(e)}function i(c){var b=a(c).data(g);return!b||!b.validate||b.validate()}a("a[data-ajax=true]").live("click",function(a){a.preventDefault();e(this,{url:this.href,type:"GET",data:[]})});a("form[data-ajax=true] input[type=image]").live("click",function(c){var g=c.target.name,d=a(c.target),f=d.parents("form")[0],e=d.offset();a(f).data(b,[{name:g+".x",value:Math.round(c.pageX-e.left)},{name:g+".y",value:Math.round(c.pageY-e.top)}]);setTimeout(function(){a(f).removeData(b)},0)});a("form[data-ajax=true] :submit").live("click",function(c){var e=c.target.name,d=a(c.target).parents("form")[0];a(d).data(b,e?[{name:e,value:c.target.value}]:[]);setTimeout(function(){a(d).removeData(b)},0)});a("form[data-ajax=true]").live("submit",function(d){var c=a(this).data(b)||[];d.preventDefault();if(!i(this))return;e(this,{url:this.action,type:this.method||"GET",data:c.concat(a(this).serializeArray())})})})(jQuery);;
/******************************
*Author<ChengFeng.zhu>
*Create Date <2017.08.9>
*Description <jQuery使用扩展>
******************************/
(function($) {
    var serialize = {
        json: function() {
            var serializeObj = {};
            $(this.serializeArray()).each(function() {
                serializeObj[this.name] = this.value;
            });
            return serializeObj;
        }
    };
    //序列化json格式字符串
    $.fn.serializeJson = function(arg) {
        if (serialize[arg]) {
            return serialize[arg].apply(this, Array.prototype.slice.call(arg));;
        }
        return $.error('Method ' + arg + ' does not exist on jQuery.serializeJson');
    };

})(jQuery);

var eHi = {
    //对象序列化json
    toJSONString: function(jsonObj) {
        var json = "{ ";
        for(var item in jsonObj) {
            if (jsonObj.hasOwnProperty(item)) {
                json += "'" + item + "':'" + jsonObj[item] + "',";
            }
        }
        json = json.substring(0, json.lastIndexOf(','));
        json += "}";
        return json;
    }
};


;
/******************************
*Author<ChengFeng.zhu>
*Create Date <2013.07.21>
*Description <城市框自动提示属性>
******************************/

(function ($) {

    $.suggest = function (input, options) {
        var $input = $(input).attr("autocomplete", "off");

        if (!options.attachObject)
            options.attachObject = $(document.createElement("div")).appendTo("body");

        var $results = $(options.attachObject);
        var tempStr="";
        $input.blur(function () {
            if($.trim($(this).val())==="") {
                $(this).val(tempStr);
                return;
            }
            var isCheck=false;
            var value=$.trim($(this).val());
            for (var i = 0; i < options.checkObj.length; i++) {//城市匹配
                var reg = new RegExp('^' + value + '.*$', 'im');
                if (reg.test(options.source[i][0]) && value===options.source[i][0]) {
                     isCheck=true;
                     return;
                  }
            }
            if(!isCheck) {
               $(this).val(tempStr);
            }
            
        }).focus(function () {
            tempStr=$(this).attr("value");
           // $(this).val("");
        });

        //TODO IE 中Iframe 遮盖select

        //键盘事件
        $input.keyup(function(e){
            if($.trim($(this).val())==="")
                return;
            switch(e.keyCode) {
                case 38: // up
                    prev();
                    break;
                case 40: // down
                    next();
                    break;
                case 13: // Enter    
                    selectCurrentResult($(this));
                    displayItems($.trim($(this).val()));
                    $results.children('ul').children('li:first-child').addClass(options.selectedClass);
                    break;
                default:
                    displayItems($.trim($(this).val()));
                    $results.children('ul').children('li:first-child').addClass(options.selectedClass);
                    break;
            }
  
        });
        
        function getCurrentSelectCity() {
        
            if (!$results.is(':visible'))
                return false;

            var $currentResult = $results.children('ul').children('li.' + options.selectedClass);

            if (!$currentResult.length)
                $currentResult = false;
            return $currentResult;
        }
        
        function next() {
            $currentResult = getCurrentSelectCity();
            if ($currentResult)
                $currentResult
                .removeClass(options.selectedClass)
                .next().addClass(options.selectedClass);
            else
                $results.children('ul').children('li:first-child').addClass(options.selectedClass);

        }
        
        function prev() {
            $currentResult = getCurrentSelectCity();
            if ($currentResult)
                $currentResult
                .removeClass(options.selectedClass)
                .prev()
	                .addClass(options.selectedClass);
            else
                $results.children('ul').children('li:last-child').addClass(options.selectedClass);

        }
        
        function selectCurrentResult(obj) {
            $currentResult = getCurrentSelectCity();
            if ($currentResult) {
                obj.val($currentResult.attr("rel"));
            }
        }

        /*
        *拼接cities返回HTML
        **/
        function displayItems(items) {
            var html = "";
            var suggestTip = "";
            var i;
            for (i = 0; i < options.source.length; i++) {//城市匹配
                var reg = new RegExp('^' + items + '.*$', 'im');
                if (reg.test(options.source[i][0]) || reg.test(options.source[i][2])) {
                    html += '<li rel="' + options.source[i][0] + '" sendcar="' + options.source[i][3] + '" cid="' + options.source[i][4] + '"><a href="#' + i + '"><span class="city-zh">' + options.source[i][0] + '</span><span class="city-pinyin"></span></a></li>';
                }
            }
            if (html === '') {
                for (i = 0; i < options.source.length; i++) {//城市匹配
                    var reg1 = new RegExp('^' + items + '.*$', 'im');
                    if (reg1.test(options.source[i][1])) {
                        html += '<li rel="' + options.source[i][0] + '" sendcar="' + options.source[i][3] + '" cid="' + options.source[i][4] + '"><a href="#' + i + '"><span class="city-zh">' + options.source[i][0] + '</span><span class="city-pinyin"></span></a></li>';
                    }
                }
                suggestTip = '<div class="citybox-confirm"><span>对不起,找不到:</span><span>' + items + '</span></div>';
            } else {
                suggestTip = '<div class="citybox-confirm"><span>' + items + '</span><span>,按拼音搜索排序</span></div>';
            }
            html = suggestTip + '<ul class="inquire-city-list">' + html + '</ul>';
            $results.html(html).show();
        }
    }
    /*
    *自定义自动触发jQuery函数
    *@param source数据源
    *@param options 自定义属性类
    **/
    $.fn.autoComplete = function (source, options) {
        if (!source)
            return;
        options.source = source; //数据源
        options.attachObject = options.attachObject || null; //添加数据的Dom标签
        options.checkObj = options.checkObj || null;
        options.selectedClass= options.selectedClass;//选中样式
        $.suggest(this,options);
        return this;
    };
})(jQuery);
/*************************************************************
Auhtor   <ChengFeng>
Create Date <2013-05-15>
Description <封装属性>
*************************************************************/

/**
*封装预订框域值
*/
var BookingInfo = {
    /**
    * 初始化预订框基本信息
    * @param  cityName 城市名称
    * @param  storeName 门店名称
    * @param  address 地址信息
    * @param  date  [yyyy-MM-dd]取车日期 
    * @param  hour [HH]取车时间
    * @function
    */
    Initialize: function (cityName, storeName, address, date, hour) {
        this.CityName = cityName;
        this.StoreName = storeName;
        this.Address = address;
        this.Date = date;
        this.Hour = hour;
    },

    /**
    *当前操作类型
    *@param type [get/ret][取车/还车]
    *@function
    */
    Type: function (type) { // 成员函数    
        this.Type = type;
    },

    /**
    *是否送车上门
    *@function
    *@return boolean
    */
    IsSendAndReturnService: function (value) {
        this.IsSendAndReturnService = value;
    },
    InitSendCarHtml: function (lat, lng, name, address) {
        return '<li class="send-cur" lat="' + lat + '" lng="' + lng + '"><div class="send-storepic"></div><div class="send-storename">' + name + '</div><div class="send-storearea">' + address + '</div><div class="send-btn"><input type="button" value="确认地址"></div></li>';
    },
    InitTakeCarHtml: function (lat, lng, name, address) {
        return '<li class="send-cur" lat="' + lat + '" lng="' + lng + '"><div class="send-storepic"></div><div class="send-storename">' + name + '</div><div class="send-storearea">' + address + '</div><div class="send-btn"><input type="button" value="确认地址"></div></li>';
    }
};


/**
*浮框控制
*/
var Floating = {
    /**
    * @param  source 浮层DOM元素
    * @param  targetSource 鼠标点击DOM元素
    * @function
    */
    Initialize: function (source, targetSource) {
        this.Source = source;
        this.TargetSource = targetSource;
    },

    /**
    * @param  isMouseOut 鼠标是否移开
    * @function
    */
    IsMouseOut: function (isMouseOut) {
        this.IsMouseOut = isMouseOut;
    },
    /**
    * @param  IsServiceMouseOut 鼠标是否移开
    * @function
    */
    IsServiceMouseOut: function (isMouseOut) {
        this.IsServiceMouseOut = isMouseOut;
    },

    /**
    * 浮框隐藏控制
    * @function
    * @return boolean
    */
    IsHide: function () {
        return this.Source == null && this.Target == null;
    },

    /**
    * css类
    * @class
    */
    XyOpts: {},

    /**
    * 设置浮框坐标定位
    * @function
    */
    VerticalPosition: function (source) {
        var xy = $(source).position();
        var id = $(source).attr("id");
        if (!this.XyOpts[source]) {
            this.XyOpts[id] = {
                left: xy.left + "px",
                top: xy.top + 26 + "px",
                position: "absolute"
            };
        }
    },
    /**
    * 设置浮框坐标定位
    * @function
    */
    HorizontalPosition: function (source) {
        var xy = $(source).position();
        var id = $(source).attr("id");
        var width = $(BookTarget.PickupStoreNameId).width();
        width = width > 150 ? width + 15 : width + 25; // Modify by liu 2012-10-24
        if (!this.XyOpts[source]) {
            this.XyOpts[id] = {
                left: xy.left + width + "px",
                top: xy.top + "px",
                position: "absolute"
            };
        }
    },
    /**
    * 浮框定位
    *@param type:定位点
    *@param currentId:当前点击Html唯一标记
    *@param floatBox:浮框唯一标记
    * @function
    */
    IsShow: function (type, currentId, floatBox) {
        if (floatBox == FloatTarget.FlightNumber) {
            this.HorizontalPosition(currentId);
            $(floatBox).css(this.XyOpts[$(currentId).attr("id")]).show();
        } else {
            this.VerticalPosition(currentId);
            $(floatBox).css(this.XyOpts[$(currentId).attr("id")]).show();
        }
    }
};
/**
*浮层
*/
FloatTarget = {
    /**
    * @param  cityBoxId 城市浮框ID
    * @param  storeBoxId 门店浮框ID
    * @function
    */
    Initialize: function (cityBoxId, storeBoxId, sendBoxId, getFree, timeselect, hbhbox, cityautoBoxId, timeselectminute) {
        this.CityBoxId = "#" + cityBoxId;
        this.StoreBoxId = "#" + storeBoxId;
        this.SendBoxId = "#" + sendBoxId;
        this.FreeId = "#" + getFree;
        this.SelectTime = "#" + timeselect;
        this.SelectTimeMinute = "#" + timeselectminute;
        this.FlightNumber = "#" + hbhbox;
        this.CityAutoBoxId = "#" + cityautoBoxId;
    },

    FloatBoxIdList: function () {
        return this.CityBoxId + "," + this.StoreBoxId + "," + this.SendBoxId + "," + this.FreeId + "," + FloatTarget.FlightNumber + "," + this.SelectTime + "," + this.CityAutoBoxId + "," + this.SelectTimeMinute + ",#ctimeselect";
    },

    /**
    *城市框
    */
    CityBoxTarget: {
        CitySpan: ".ydcity-box .list-city li dl dd span",
        CityLi: ".ydcity-box .list-city li",
        CityTab: " .ydcity-box .list-type li"
    },
    /**
    *门店框
    */
    StoreBoxTarget: {
        StoreContentSpan: ".ydk-box .list-mendian li .dl-mendian dd span",
        StoreTabLi: ".ydk-box .list-area li",
        StoreContentLi: ".ydk-box .list-mendian  li",
        StoreDetail: ".ydk-box .inf-box",
        StoreAdd: ".ydk-box .inf-box .inf-address .address",
        StoreSend: ".ydk-box .inf-box .inf-address .sp-scd",
        StoreTime: ".ydk-box .inf-box .inf-time .txt-time",
        StoreMap: ".ydk-box .inf-box .inf-address li .link-map",
        StorePhoneNumber: ".ydk-box .inf-box .inf-time .storephone span"
    },

    /**
    * 送还车服务ID
    */
    ServiceTarger: {
        City: "#shcBox .list-city li",
        LeftInput: "#txtSelectType",
        LeftSelectType: ".shc-form .select-type .select-showbox",
        RightInput: "#txtSelectArea",
        RightSelectArea: ".shc-form .select-area .select-showbox",
        Address: "#txtShcAddress",
        ListCityLi: ".shc-box .list-city li",
        SelectBox: ".shc-form .select-showbox",
        ServicePrice: ".shc-form .op-box .txt-price .price",
        ServiceSelectShowBoxLi: ".shc-form .select-showbox .type-list li"
    },
    /**
    *免费送车服务
    */
    FreeRoad: {
        Roadspan: ".road ul li span",
        Community: ".community ul.cun li",
        Back: ".free .back",
        CommunityId: "#community"
    },
    /**
    *是否免费服务
    *@param vArg 元素选中值
    *@param str 匹配目标
    *@function
    *@return Boolean  true 是 false 不是
    */
    IsFreeSendService: function (vArg, str) {
        return vArg.indexOf(str) > -1;
    },
    /**
    *面板切换
    */
    TabHF: {
        tabTitleLi: ".tabHF-title li",
        tabContent: ".tabHF-content",
        tabContentLi: ".tabHF-content li"
    }
};

/**
* 预订框标签ID
*/
var BookTarget = {
    /**
    *初始化预订框标签ID
    * @param  pickupCityId 取车城市ID
    * @param  returnCityId 还车城市ID
    * @param  pickupStoreId 取车门店ID
    * @param  returnStoreId 还车门店ID
    * @param  pickupAddressId 取车地址ID
    * @param  returnAddressId 还车地址ID
    * @param  fromDateId 开始时间
    * @param  toDateId 结束时间
    * @function
    */
    Initialize: function (pickupCityId, returnCityId, pickupStoreId, returnStoreId, getCheck, retCheck, pickupAddressId, returnAddressId, fromDateId, toDateId, getTime, retTime, sameReturnAddress, getMinute, retMinute) {
        this.PickupCityId = "#" + pickupCityId;
        this.ReturnCityId = "#" + returnCityId;
        this.PickupStoreNameId = "#" + pickupStoreId;
        this.ReturnStoreNameId = "#" + returnStoreId;
        this.SendServiceCheckId = "#" + getCheck;
        this.ReturnServiceCheckId = "#" + retCheck;
        this.SendServiceId = "#" + pickupAddressId;
        this.ReturnServiceId = "#" + returnAddressId;
        this.FromDateId = "#" + fromDateId;
        this.ToDateId = "#" + toDateId;
        this.FromTimeId = "#" + getTime;
        this.ToTimeId = "#" + retTime;
        this.SameReturnAddress = "#" + sameReturnAddress;
        this.FromMinuteId = "#" + getMinute;
        this.ToMinuteId = "#" + retMinute;
    },
    PickupStoreID: "#getStoreId",
    ReturnStoreID: "#retStoreId",
    FlightNumberID: "#FlightNumber",
    PickUpFreeServicePointId: "#PickUpFreeServicePointId",
    ReturnFreeServicePointId: "#ReturnFreeServicePointId",
    AhrNearStore: "#ahrNearStore",
    Address: "#txtAddress"
};

/*
*预订框Ajax 
*ajax 请求路径
*/
/*var BookingAjax = {
    //请求路径
   /!* Url: {
        /!*StorePath: "/Order/Address/SearchStore",*!/
        ChannelRegister: "/Customer/Login/ChannelRegister",
        NearStorePath: "/Order/Address/SearchNearStore",
        CoordinateSearchNearStore: "/Order/Address/CoordinateSearchNearStore",
        ServicePath: "/Order/Address/ServiceDistrictList",
        FreeServiceRoadPath: "/Order/Address/FreeServiceRoadsList",
        StoreTimePath: "/Order/Address/StoreOpeningTime",
        ValidatePath: "/Order/Validate/Index",
        ServiceMap: "/Order/Address/ServiceMap",
        MapPositionPath: "/Order/Address/PositionAddress",
        IsAllowMapService: "/Order/Address/IsAllowService",
        MapPositionAddress: "/Order/Address/SearchAddressPosition",
        cartypeConfigPath: "/Order/FirstStep/CartypeConfig",
        SearchNearAddress: "/Order/Address/SearchNearAddress",
        ShowEnterpriseTip: "/Order/FirstStepExtent/BindEnterpriseTip",
        GetCarTypeVideoInfo: "/Order/FirstStep/GetCarTypeVideoInfo",
        CarTypeVideoInfo: "/Order/FirstStep/CarTypeVideoInfo"
    },*!/
    /!**
    *预订框请求
    *@param url 请求路径
    *@param param 请求参数
    *@param type 返回数据类型
    *param callBack 回调函数
    *!/
    ReqStore: function (url, param, type, storeCallBack) {
        var self = this;
        if (param in self.ResData[type]) {
            storeCallBack(self.ResData[type][param]);
            return false;
        }
        var path = encodeURI(url + "?" + param + "&t=" + Math.random());
        $.ajax({
            type: "get",
            url: path,
            contentType: "application/json;charset=UTF-8",
            async: false,
            success: function (data) {
                self.ResData[type][param] = data;
                storeCallBack(data);
            }
        });
        return false;
    },
    Post: function (url, param, type, storeCallBack) {
        var self = this;
        if (param in self.ResData[type]) {
            storeCallBack(self.ResData[type][param]);
            return false;
        }
        var path = encodeURI(url + "?t=" + Math.random());
        $.ajax({
            type: "post",
            data: param,
            url: path,
            contentType: "application/json;charset=UTF-8",
            async: false,
            success: function (data) {
                self.ResData[type][param] = data;
                storeCallBack(data);
            }
        });
        return false;
    },
    /!**
    *预订框请求
    *@param target 接收返回Dom元素的ID
    *@param url 请求参数
    *@param param 请求参数
    *@param type 返回数据类型
    *!/
    ReqService: function (url, param, target, type) {
        var self = this;
        if (param in self.ResData[type]) {
            $(target).html("");
            $(target).html(self.ResData[type][param]);
            return false;
        }
        $(target).load(url, param, function (data) {
            self.ResData[type][param] = data;
        });
        return false;
    },
    /!*
    *按钮提交
    **!/
    ReqSubmit: function (url, type, storeCallBack) {
        $.ajax({
            type: type,
            url: url,
            contentType: "application/json;charset=UTF-8",
            async: false,
            success: function (data) {
                storeCallBack(data);
            }
        });
    },
    /!*
*按钮提交
**!/
    Submit: function (url, param, type, storeCallBack) {
        $.ajax({
            type: type,
            data: param,
            url: url,
            headers: { "__RequestVerificationToken": $("input[name='__RequestVerificationToken']").val() },
            contentType: "application/json;charset=UTF-8",
            async: false,
            success: function (data) {
                storeCallBack(data);
            },
            complete: function (xhr) {
                if (xhr.status == 204) {
                    alert('访问频率过高，请稍后重试。');
                }
                return false;
            }
        });
    },
    ReqAjax: function (url, param, httpVerbs, type, dataType, callback) {
        var self = this;
        if (param in self.ResData[type]) {
            callback(self.ResData[type][param]);
            return false;
        }
        $.ajax({
            type: httpVerbs,
            data: param,
            url: url,
            dataType: dataType,
            contentType: "application/json;charset=UTF-8",
            async: false,
            cache: false,
            success: function (data) {
                self.ResData[type][param] = data;
                callback(data);
            }
        });
        return false;
    },
    /!*
    *保存返回数据
    **!/
    ResData: {
        Store: {},
        ReturnStore: {},
        NearStore: {},
        SendAndReturnCity: {},
        FreeService: {},
        FreeServiceRoad: {},
        SelectedTime: {},
        ServiceMap: {},
        MapPositionAddress: {},
        MapPositionPath: {},
        IsAllowMapService: {},
        cartyoeConfig: {},
        searchNearAddress: {},
        SportStore: {},
        ReturnSportStore: {},
        ReturnNearStore: {},
        EnterpriseTips: {}
    }
};*/
/**********************************************************************************************
*Author <ChengFeng>
*Create Date <2013-05-16>
*Description <预订框>
**********************************************************************************************/
$(function () {
    /**
    *初始化标签及浮层 yudingkuang_prototype.js
    */
    BookTarget.Initialize("PickupCity", "ReturnCity", "getStore", "retStore", "getCheck", "retCheck", "getSendService", "retSendService", "J_date_1", "J_date_2", "getHour", "retHour", "sameReturnAddress", "getMinute", "retMinute");
    FloatTarget.Initialize("ydcityBox", "ydkBox", "shcBox", "getfree", "timeselect", "hbh-box", "cityAutoBox", "timeselectminute");
    Floating.Initialize();
    BookingInfo.Initialize("上海");
    /**
    *@param type 点击类型
    *@param source 浮框DOM
    */
    var initializeObj = function (id, source, value) {
        BookingInfo.Type = id.indexOf(value) > -1 ? "get" : "ret";
        Floating.Source = source;
    };
    /*
    *初始化表单
    **/
    var initFromInput = function () {
        var isSendService = $(BookTarget.SendServiceCheckId).attr("checked");
        var isReturnService = $(BookTarget.ReturnServiceCheckId).attr("checked");
        if (isSendService) {
            $(BookTarget.PickupStoreNameId).hide();
            $('#getSendService').show();
            $("#usedStore").hide();
        } else {
            $(BookTarget.PickupStoreNameId).show();
            $('#getSendService').hide();
        }
        if (isReturnService) {
            $(BookTarget.ReturnStoreNameId).hide();
            $('#retSendService').show();
        } else {
            $(BookTarget.ReturnStoreNameId).show();
            $('#retSendService').hide();
        }
        if (!isSendService && $("#mendian-popup").attr("id")) {
            $("#usedStore").show();
        }
    }();
    /**
    *清空数据
    */
    var cleanBookingData = function (isSendService, isReturnService) {
        if (isSendService) {
            $(BookTarget.PickupStoreNameId).attr("placeholder", "请选择取车营业门店");
        } else {
            $(BookTarget.SendServiceId).attr("placeholder", "请输入送车上门地址");
        }
        if (isReturnService) {
            $(BookTarget.ReturnStoreNameId).attr("placeholder", "请选择还车营业门店");
        } else {
            $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
        }
    };


    /**
    *取还车城市点击事件
    */
    $(BookTarget.PickupCityId + "," + BookTarget.ReturnCityId).click(function () {
        $(this).select();
        BookingInfo.CityName = $(this).attr("value");
        initializeObj($(this).attr("id"), $(FloatTarget.CityBoxId), "PickupCity");
        Floating.IsShow(BookingInfo.Type, this, FloatTarget.CityBoxId);
        // 城市选中样式控制
        $(FloatTarget.CityBoxTarget.CitySpan).removeClass("selected hover");
        var index = 0;
        if ($.trim($(FloatTarget.CityBoxTarget.CityLi).eq(0).find("span[rel='" + BookingInfo.CityName + "']").text()) === "") {
            index = $(FloatTarget.CityBoxTarget.CitySpan + "[rel='" + BookingInfo.CityName + "']").parents(FloatTarget.CityBoxTarget.CityLi).index();
        }
        $(FloatTarget.CityBoxTarget.CitySpan + "[rel='" + BookingInfo.CityName + "']").addClass("hover");
        $(FloatTarget.CityBoxTarget.CityLi).eq(index).show().siblings().hide();
        $(FloatTarget.CityBoxTarget.CityTab).eq(index).addClass("current").siblings().removeClass("current");
    });

    /**
    *城市Input赋值
    */
    $(FloatTarget.CityBoxTarget.CitySpan).click(function () {
        var obj = $(this);
        var cityGet = $("#city_get");
        var cityRet = $("#city_ret");
        BookingInfo.CityName = obj.text();
        var isAllowSendCar = obj.attr("sendcar") === "Y";
        var id = $(this).data("id");
        if (BookingInfo.Type === "get") {
            $("#PickUpCityId,#ReturnCityId").val(id);
            $("#getStoreId,#retStoreId").val(0);
            isAllowSendCar ? cityGet.show() : cityGet.hide();
            isAllowSendCar ? cityRet.show() : cityRet.hide();

            if (!isAllowSendCar) {
                $(BookTarget.SendServiceCheckId + "," + BookTarget.ReturnServiceCheckId).attr("checked", false);
                $(BookTarget.PickupStoreNameId + ',' + BookTarget.ReturnStoreNameId).show();
                $('#getSendService,#retSendService').hide();
            }

            $("#getlng,#getlat,#retlng,#retlat,#getAddress,#retAddress").val('');
            $(BookTarget.PickupCityId + "," + BookTarget.ReturnCityId).attr("value", BookingInfo.CityName);
            $(BookTarget.PickupStoreNameId + ',' + BookTarget.ReturnStoreNameId).val("");
            $(BookTarget.SendServiceId + ',' + BookTarget.ReturnServiceId).val("");
            $(BookTarget.PickupStoreNameId).attr("placeholder", "请选择取车营业门店");
            $(BookTarget.ReturnStoreNameId).attr("placeholder", "请选择还车营业门店");
            $(BookTarget.SendServiceId).attr("placeholder", "请输入送车上门地址");
            $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
            //车型预订流程Setp2赋值
            if ($('#BrandCityName').length > 0)
                $('#BrandCityName').attr('value', BookingInfo.CityName);
        } else {
            $("#ReturnCityId").val(id);
            isAllowSendCar ? cityRet.show() : cityRet.hide();

            if (!isAllowSendCar) {
                $(BookTarget.ReturnServiceCheckId).attr("checked", false);
                $(BookTarget.ReturnStoreNameId).show();
                $('#retSendService').hide();
            }

            $("#retlng，#retlat,#retAddress").val('');
            $(BookTarget.ReturnCityId).attr("value", BookingInfo.CityName);
            $(BookTarget.ReturnStoreNameId).val("");
            $(BookTarget.ReturnServiceId).val("");
            $(BookTarget.ReturnStoreNameId).attr("placeholder", "请选择还车营业门店");
            $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
        }
        Floating.Source && Floating.Source.hide();
    });

    /**
    *城市选中状态
    */
    $(document).delegate(FloatTarget.CityBoxTarget.CitySpan + "," + FloatTarget.ServiceTarger.ListCityLi, "hover",
        function (event) {
            var className = $("#" + BookingInfo.Type + "Check").attr("checked") ? "current" : "hover";
            if (event.type === "mouseenter") {
                $(this).addClass(className);
            } else {
                $(this).removeClass(className);
            }
        });
    /**
    *门店选中状态
    */
    $(document).delegate(FloatTarget.StoreBoxTarget.StoreContentSpan, "mouseover",
        function () {
            $(FloatTarget.StoreBoxTarget.StoreContentSpan).removeClass("hover");
            $(this).addClass("hover");
            storeValue($(this));
        });

    /**
    *取还车门店点击事件
    */
    $(BookTarget.PickupStoreNameId + "," + BookTarget.ReturnStoreNameId).click(function () {
        BookingInfo.StoreName = $(this).attr("value");
        initializeObj($(this).attr("id"), $(FloatTarget.StoreBoxId), "getStore");
        Floating.IsShow(BookingInfo.Type, this, FloatTarget.StoreBoxId);
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").attr("value") : $("#ReturnCityId").attr("value");
       /* var path = BookingAjax.Url.StorePath;*/
        var param = "isPickupService=" + (BookingInfo.Type === "get") + "&cityId=" + cityId;
        $(FloatTarget.StoreBoxId).html("");
        var cacheName = BookingInfo.Type === "get" ? "Store" : "ReturnStore";
       /* BookingAjax.ReqStore( param, cacheName, storeCallBack);*/
    });

    /**
    *取还车门店赋值
    */
    $(document).delegate(FloatTarget.StoreBoxTarget.StoreContentSpan, "click", function () {
        BookingInfo.StoreName = $.trim($(this).text());
        var storeId = $(this).attr("sid");
        var cid = $(this).data("cid");
        var cname = $(this).data("cname");
        if (BookingInfo.StoreName.indexOf("免费") > -1) {
            BookingInfo.Type === "get" ? $(BookTarget.SendServiceCheckId).attr("checked", true) : $(BookTarget.ReturnServiceCheckId).attr("checked", true);
            var target = BookingInfo.Type === "get" ? BookTarget.SendServiceCheckId : BookTarget.ReturnServiceCheckId;
            isSendCarService(target);
        } else {
            if (BookingInfo.Type === "get") {
                if ($(BookTarget.PickupCityId).attr("value") === $(BookTarget.ReturnCityId).attr("value")) {
                    $(BookTarget.PickupStoreNameId + "," + BookTarget.ReturnStoreNameId).attr("value", BookingInfo.StoreName);
                    $(BookTarget.PickupStoreID + "," + BookTarget.ReturnStoreID).attr("value", storeId);
                    $(BookTarget.PickupCityId + "," + BookTarget.ReturnCityId).attr("value", cname);
                    $("#PickUpCityId,#ReturnCityId").attr("value", cid);
                } else {
                    $(BookTarget.PickupStoreNameId).attr("value", BookingInfo.StoreName);
                    $(BookTarget.PickupStoreID).attr("value", storeId);
                    $("#PickUpCityId").attr("value", cid);
                    $(BookTarget.PickupCityId).attr("value", cname);
                }

            } else {
                $("#ReturnCityId").attr("value", cid);
                $(BookTarget.ReturnCityId).attr("value", cname);
                $(BookTarget.ReturnStoreNameId).attr("value", BookingInfo.StoreName);
                $(BookTarget.ReturnStoreID).attr("value", storeId);
            }

            Floating.Source.hide();
        }
    });
    /*
    *常用门店
    */
    $("#ahrUsedStore").live('click', function () {
        if (!$(".mendian-used-list input").hasClass("sel")) {
            alert("请选择您的常用门店");
            return false;
        }
        var obj = $(".mendian-used-list input.sel");
        $(BookTarget.PickupStoreID).attr("value", obj.attr("pid"));
        $(BookTarget.ReturnStoreID).attr("value", obj.attr("rid"));
        $(BookTarget.PickupStoreNameId).attr("value", obj.attr("pna"));
        $(BookTarget.ReturnStoreNameId).attr("value", obj.attr("rna"));
        $(BookTarget.PickupCityId).attr("value", obj.attr("pcn"));
        $(BookTarget.ReturnCityId).attr("value", obj.attr("rcn"));
        $("#PickUpCityId").val(obj.attr("cid"));
        $("#ReturnCityId").val(obj.attr("rcid"));
        $(".btn-close").trigger("click");
    });
    /*
    *弹出常用门店
    */
    $("#usedStore").live('click', function () {
        myshowBox('', '', '600', '260', 'false', '');
        $(".div-myshowbox").wrapInner($('#mendian-popup').html());
    });
    /*
    *常用门店Radio
    */
    $(".mendian-used-list input").live('click', function () {
        $(this).addClass("sel").parent().siblings().find("input").removeClass("sel");
    });
    /**
    *ajax 回调函数
    *@param  data ajax成功返回Dom元素
    *@function
    */
    var storeCallBack = function (data) {
        $(FloatTarget.StoreBoxId).html(data);
        if (BookingInfo.StoreName.indexOf("营业门店") > -1) {
            BookingInfo.StoreName = $(FloatTarget.StoreBoxTarget.StoreContentSpan).eq(0).text().replace(/\n/g, '');
        }
        defaultStoreSelected(BookingInfo.StoreName);
    };

    /**
    * 门店默认选中状态
    *@param store 门店名称
    *@function
    */
    var defaultStoreSelected = function (store) {
        var storeName = $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(0).find("span[rel='" + store + "']").text(); //第一个面板有无相应匹配项
        var index = $(FloatTarget.StoreBoxTarget.StoreContentLi).find(" span[rel='" + store + "']").parents(FloatTarget.StoreBoxTarget.StoreContentLi).index(); //获取匹配索引
        $(FloatTarget.StoreBoxTarget.StoreContentLi).find(" span[rel='" + store + "']").addClass("hover").siblings().removeClass("hover");
        if (storeName !== "") {
            index = -1;
        }

        var storeObj = null;
        if (index === -1) {
            $(FloatTarget.StoreBoxTarget.StoreTabLi).eq(0).addClass("current");
            $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(0).addClass("current");
            if (storeName != "") {
                storeObj = $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(0).find("span[rel='" + store + "']");
            } else {
                storeObj = $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(0).find(".dl-mendian dd span").eq(0).addClass("hover");
            }
        } else {
            $(FloatTarget.StoreBoxTarget.StoreTabLi).eq(index).addClass("current").siblings().removeClass("current");
            $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(index).addClass("current").show().siblings().hide();
            storeObj = $(FloatTarget.StoreBoxTarget.StoreContentLi).find(" span[rel='" + store + "']");
        }
        storeValue(storeObj);
    };

    /**
    *  门店详细
    *@param storeObj  单个门店Dom对象
    *@function
    */
    var storeValue = function (storeObj) {
        var address = storeObj.attr("add");
        var fromTime = storeObj.attr("from_time");
        var time = storeObj.attr("time");
        var sid = storeObj.attr("sid");
        var getCity = $(BookTarget.PickupCityId).attr("value");
        var retCity = $(BookTarget.ReturnCityId).attr("value");
        var city = BookingInfo.Type === "get" ? getCity : retCity;
        var phoneNumber = storeObj.attr("p");
        var storeUrl = $(FloatTarget.StoreBoxTarget.StoreMap).attr("href");
        var airportAddress = storeObj.attr("air");
        var mapUrl = storeUrl;
        if (storeUrl != undefined && storeUrl.indexOf("?") > 0) {
            mapUrl = storeUrl.substring(0, storeUrl.indexOf("?"));
        }
        var map = mapUrl + "?" + 'sid=' + sid + '&c=' + escape(city);
        $(FloatTarget.StoreBoxTarget.StoreAdd).text(address);

        $(FloatTarget.StoreBoxTarget.StoreTime).find(".allDay").remove();
        if (storeObj.has(".allhour").length > 0) {
            $(FloatTarget.StoreBoxTarget.StoreTime).append("<span class='allDay'>24小时营业</span>");
            $(FloatTarget.StoreBoxTarget.StoreTime).find('.time').hide();
        } else {
            $(FloatTarget.StoreBoxTarget.StoreTime + " .get-hour").text(fromTime);
            $(FloatTarget.StoreBoxTarget.StoreTime + " .ret-hour").text(time);
            $(FloatTarget.StoreBoxTarget.StoreTime).find('.time').show();
        }
        $(FloatTarget.StoreBoxTarget.StoreMap).attr("href", map);
        $(FloatTarget.StoreBoxTarget.StorePhoneNumber).text(phoneNumber);

        $(FloatTarget.StoreBoxTarget.StoreDetail).show();
        airportAddress != undefined && airportAddress.length > 0 ? $("#jsj").show().text(airportAddress) : $("#jsj").hide();

    };
   /* /!**
    *门店营业时间
    *!/
    var selectStoreTimeInit = function (startHour, endHour, type) {
        var toHour = parseInt(endHour);
        var fromHour = parseInt(startHour);
        var currHour = new Date().getHours();
        var preFromHour = parseInt($(BookTarget.FromTimeId).attr("value").replace("时", ""));
        var preToHour = parseInt($(BookTarget.ToTimeId).attr("value").replace("时", ""));

        var getTime = preFromHour;
        var retTime = preToHour;
        if (fromHour >= preFromHour || currHour <= fromHour) {
            getTime = fromHour;
        }

        if (fromHour >= preToHour || currHour <= fromHour) {
            retTime = fromHour;
        }

        if (toHour <= preFromHour) {
            getTime = toHour;
        }

        if (toHour <= preToHour) {
            retTime = toHour;
        }
        if (type === "get") {
            $("#hdnReturnHour").val(getTime);
            $("#hdnPickupHour").val(getTime);
            $(BookTarget.FromTimeId).attr("value", (getTime < 10 ? "0" : "") + getTime + "时");
            $(BookTarget.ToTimeId).attr("value", (getTime < 10 ? "0" : "") + getTime + "时");
        } else {
            $(BookTarget.ToTimeId).attr("value", (retTime < 10 ? "0" : "") + retTime + "时");
            $("#hdnReturnHour").val(retTime);
        }
    };
*/
    /**
    *勾选送/还车服务
    */
    $(BookTarget.SendServiceCheckId + "," + BookTarget.ReturnServiceCheckId).click(function () {
        initializeObj($(this).attr("id"), null, "getCheck");
        $("#SearchStore").val("");
        if ($(this).attr("checked")) {
            showMap();
        }
        $("#usedStore").hide();
        isSendCarService(this);
        var isSel = $(this).prop("checked");
        if (BookingInfo.Type === "get") {
            if (!isSel) {
                $("#getAddress").val("");
            }
            $(BookTarget.SendServiceId).attr("placeholder", "请输入送车上门地址");
        } else {
            if (!isSel) {
                $("#retAddress").val("");
            }
            $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
        }
    });

    $(".send-close").click(function () {
        $("#shcMapBox").addClass("hidden");
    });

    var isSendCarService = function (targetId) {
        var isSendServiceChecked = $(BookTarget.SendServiceCheckId).attr("checked");
        var isReturnServiceChecked = $(BookTarget.ReturnServiceCheckId).attr("checked");
        cleanBookingData(isSendServiceChecked, isReturnServiceChecked);
        //2014.08.28 ChengFeng
        $(BookTarget.SameReturnAddress).find("input").attr("checked", false);

        initializeObj($(targetId).attr("id"), null, "getCheck");
        var isGet = BookingInfo.Type === "get";
        if ($(targetId).attr('checked')) {
            isGet ? $(BookTarget.PickupStoreNameId).hide() : $(BookTarget.ReturnStoreNameId).hide();
            $('#' + BookingInfo.Type + 'SendService').show();
        } else {
            $("#usedStore").show();
            isGet ? $(BookTarget.PickupStoreNameId).show() : $(BookTarget.ReturnStoreNameId).show();
            $("#" + BookingInfo.Type + "SendService").hide();
        }
        $('#' + BookingInfo.Type + 'SendService').val("");
    };
    function showMap() {
        $("#shcMapBox").removeClass("hidden");
        var str = BookingInfo.Type === "get" ? "送车上门" : "上门取车";
        $("#send-replace,#send-replace2").text(str);
        $("#SearchStore").attr("placeholder", "输入" + str + "地址");
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").val() : $("#ReturnCityId").val();
        var param = "cityId=" + cityId;
        BookingAjax.ReqStore(BookingAjax.Url.ServiceMap, param, "ServiceMap", function (data) {
            if (data == "") {
                $("#inside").hide();
                $("#outside").show();
                return false;
            }
            var obj = eval('(' + data + ')');
            // var json = JSON.stringify(obj.Range);
            var json = obj.Range;
            if (obj.Range[0] == null) {
                // json = JSON.stringify(data);
                json = data;
            }
            initServiceMap(obj.CityCenter.Lat, obj.CityCenter.Lng, json, 12);
            var param = "lat=" + obj.CityCenter.Lat + "&lng=" + obj.CityCenter.Lng + "&cityId=" + cityId;
            BookingAjax.ReqStore(BookingAjax.Url.MapPositionPath, param, "MapPositionPath", function (data1) {
                $("#addresslist").html(data1);
            });
        });
    }
    /**
    *点击送/还车Input
    */
    $(BookTarget.SendServiceId + "," + BookTarget.ReturnServiceId).click(function () {
        $("#SearchStore").val("");
        $("#shcMapBox").removeClass("hidden");
        initializeObj($(this).attr("id"), $(FloatTarget.SendBoxId), "getSendService");
        var str = BookingInfo.Type === "get" ? "送车上门" : "上门取车";
        $(FloatTarget.ServiceTarger.Address).val("请输入您的" + str + "地址");
        if (isUpdate) {
            showMap();
        } else {
            SetMapIcon();
        }
        var address = BookingInfo.Type === "get" ? $("#getAddress").val() : $("#retAddress").val();
        if (address === "") {
            showMap();
            return false;
        }
        var getLat, getLng, retLat, retLng;
        if (BookingInfo.Type === "get") {
            getLat = $("#getlat").val();
            getLng = $("#getlng").val();
            MapCommon.func.GetAddress(getLng, getLat);
        } else {
            retLat = $("#retlat").val();
            retLng = $("#retlng").val();
            MapCommon.func.GetAddress(retLng, retLat);
        }

        var html = BookingInfo.Type === "get" ? BookingInfo.InitSendCarHtml(getLat, getLng, $(this).val(), $("#getAddress").val()) : BookingInfo.InitTakeCarHtml(retLat, retLng, $(this).val(), $("#retAddress").val());
        if (html === "" || html === undefined) {
            $("#inside").hide();
            $("#outside").show();
        } else {
            $("#inside").show();
            $("#outside").hide();
            $("#addresslist").html(html);
        }
    });

    /**
    *点击左边区域   
    */
    $(FloatTarget.ServiceTarger.LeftInput + ",.shc-form .select-type #selectType").live("click", function () {
        $(this).parents(".shc-form .select-type").addClass("current");
        Floating.IsShow(BookingInfo.Type, FloatTarget.ServiceTarger.LeftInput, FloatTarget.ServiceTarger.LeftSelectType);
    });

    /**
    *右边区域 Input 赋值
    */
    $(FloatTarget.ServiceTarger.RightSelectArea + " .type-list li").live("click", function () {
        $(FloatTarget.ServiceTarger.RightInput).attr("value", $(this).text());
        $(FloatTarget.ServiceTarger.RightSelectArea).hide();
    });
    /**
    *下拉选中效果
    */
    $(FloatTarget.ServiceTarger.ServiceSelectShowBoxLi).live("mouseover",
        function () {
            $(this).addClass("current");
        }).live("mouseout",
            function () {
                $(this).removeClass("current");
            });

    /**
    *点击输入地址Input
    */
    $(FloatTarget.ServiceTarger.Address).click(function () {
        if ($(this).attr("value").indexOf('输入您的') > -1) {
            $(this).attr("value", "");
        }
    }).blur(function () {
        var str = BookingInfo.Type === "get" ? "送车上门" : "上门取车";
        if ($(this).attr("value") === "") {
            $(this).attr("value", "请输入您的" + str + "地址");
        }
    });
    /**
    *点击保存按钮
    */
    $(".shc-form .op-box .btn-save").live("click", function () {
        var city = $(".shc-box .list-city li.selected").text();
        var str = BookingInfo.Type === "get" ? "送车上门" : "上门取车";
        var leftValue = $(FloatTarget.ServiceTarger.LeftInput).attr("value").replace(/^\s+|\s+$/g, "");
        var address = $(FloatTarget.ServiceTarger.Address).attr("value").replace(/^\s+|\s+$/g, "");
        var strValue = city + address;
        if (leftValue.indexOf('请选择') > -1) {
            return alert('请选择区域');
        }

        if (address.indexOf('请输入') > -1 || $.trim(address).length === 0) {
            return alert('请输入您的' + str + "地址");
        }
        if (address.indexOf('#') > -1 || address.indexOf('-') > -1) {
            return alert('您输入的地址中包含特殊字符');
        }
        if (BookingInfo.Type === "get") {
            $(BookTarget.SendServiceId).attr("value", strValue);
            //ChengFeng 2014.08.28
            var isSameReturnAddress = $(BookTarget.SameReturnAddress).find("input").attr("checked");
            if (isSameReturnAddress) {
                $(BookTarget.ReturnServiceCheckId).attr("checked", true);
                $(BookTarget.ReturnServiceId).attr("value", strValue);
                $(".citystore").eq(1).hide();
                $('#retSendService').show();
                $(BookTarget.ReturnCityId).attr("value", city);
            }
        } else {
            $(BookTarget.ReturnServiceId).attr("value", strValue);
        }
        BookingInfo.Type === "get" ? $(BookTarget.PickupCityId).attr("value", city) : $(BookTarget.ReturnCityId).attr("value", city);
        Floating.Source.hide();
    });

    /**
    *免费送车上门选中效果
    */
    $(document).delegate(FloatTarget.FreeRoad.Roadspan + "," + FloatTarget.FreeRoad.Community + "," + FloatTarget.SelectTime + " li" + "," + FloatTarget.SelectTimeMinute + " li", "mouseover mouseout", function (e) {
        if (e.type === "mouseover" && !$(this).hasClass("disable")) {
            $(this).addClass("on");
        } else {
            $(this).removeClass("on");
        }
    });

    /*点击小区*/
    $(document).delegate(FloatTarget.FreeRoad.Community, "click", function () {
        var target = BookingInfo.Type === "get" ? BookTarget.SendServiceId : BookTarget.ReturnServiceId;
        var id = $(this).attr("id");
        if (BookingInfo.Type === "get")
            $(BookTarget.PickUpFreeServicePointId).attr("value", id);
        else
            $(BookTarget.ReturnFreeServicePointId).attr("value", id);
        var cityName = $(this).attr("city").replace(/^\s+|\s+$/g, "");
        var area = $(this).attr("area").replace(/^\s+|\s+$/g, "");
        var address = $(this).find("address").text().replace(/^\s+|\s+$/g, "");
        $(target).attr("value", cityName + "-" + area + "-" + address);
        $(FloatTarget.FreeRoad.CommunityId).hide();
        $(FloatTarget.FreeId).hide();
    });
    /*点击返回*/
    $(FloatTarget.FreeRoad.Back).live("click", function () {
        $(FloatTarget.FreeId).hide();
        var target = BookingInfo.Type === "get" ? BookTarget.SendServiceId : BookTarget.ReturnServiceId;
        Floating.IsShow(BookingInfo.Type, target, FloatTarget.SendBoxId);
        Floating.Source = $(FloatTarget.SendBoxId);
        var str = BookingInfo.Type === "get" ? "送车上门" : "上门取车";
        $(FloatTarget.ServiceTarger.Address).val("请输入您的" + str + "地址");
    });
    /**
    *时间选择框
    */
    $(BookTarget.FromTimeId + "," + BookTarget.ToTimeId).delegate('', 'click', function () {
        initializeObj($(this).attr("id"), $(FloatTarget.SelectTime), "getHour");
        Floating.IsShow(BookingInfo.Type, this, FloatTarget.SelectTime);
        var sid = BookingInfo.Type === "get" ? $("#getStoreId").attr("value") : $("#retStoreId").attr("value");
        if (sid == undefined) {
            sid = BookingInfo.Type === "get" ? $("#PickUpStoreId").attr("value") : $("#ReturnStoreId").attr("value");
        }
        if ($("#getCheck").prop("checked") && BookingInfo.Type === "get") {
            sid = "0";
        }
        if ($("#retCheck").prop("checked") && BookingInfo.Type === "ret") {
            sid = "0";
        }
        var pct = BookingInfo.Type === "get" ? $(BookTarget.FromDateId).val() : $(BookTarget.ToDateId).val();
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").val() : $("#ReturnCityId").val();
        var param = "storeId=" + sid + "&pickupDatetime=" + pct + "&ism=false&cityId=" + cityId;
        $(FloatTarget.SelectTime).html("");
        BookingAjax.ReqService(BookingAjax.Url.StoreTimePath, param, FloatTarget.SelectTime, "SelectedTime");
    });

    /**
    *时间选择框
    */
    $(BookTarget.FromMinuteId + "," + BookTarget.ToMinuteId).delegate('', 'click', function () {
        initializeObj($(this).attr("id"), $(FloatTarget.SelectTimeMinute), "getMinute");
        Floating.IsShow(BookingInfo.Type, this, FloatTarget.SelectTimeMinute);
        var sid = BookingInfo.Type === "get" ? $("#getStoreId").attr("value") : $("#retStoreId").attr("value");
        if (sid == undefined) {
            sid = BookingInfo.Type === "get" ? $("#PickUpStoreId").attr("value") : $("#ReturnStoreId").attr("value");
        }
        if ($("#getCheck").prop("checked") && BookingInfo.Type === "get") {
            sid = "0";
        }
        if ($("#retCheck").prop("checked") && BookingInfo.Type === "ret") {
            sid = "0";
        }
        var pickupTime = $(BookTarget.FromDateId).val() + ' ' + $("#hdnPickupHour").val() + ":00";
        var returnTime = $(BookTarget.ToDateId).val() + ' ' + $("#hdnReturnHour").val() + ":00";
        var pct = BookingInfo.Type === "get" ? pickupTime : returnTime;
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").val() : $("#ReturnCityId").val();
        var param = "storeId=" + sid + "&pickupDatetime=" + pct + "&ism=true&cityId=" + cityId;
        $(FloatTarget.SelectTimeMinute).html("");
        BookingAjax.ReqService(BookingAjax.Url.StoreTimePath, param, FloatTarget.SelectTimeMinute, "SelectedTime");
    });


    /**
    *时间下拉点击事件
    */
    $(document).delegate(FloatTarget.SelectTime + " .t", "click", function () {
        var obj = $(this);
        var hour = obj.text();
        var getStore = $.trim($(BookTarget.PickupStoreNameId).attr("value"));
        var retStore = $.trim($(BookTarget.ReturnStoreNameId).attr("value"));
        if (BookingInfo.Type === "get") {
            if (getStore === retStore) {
                $(BookTarget.FromTimeId + "," + BookTarget.ToTimeId).attr("value", hour);
                $("#hdnPickupHour,#hdnReturnHour").attr("value", obj.attr("rel"));
            } else {
                $(BookTarget.FromTimeId).attr("value", hour);
                $("#hdnPickupHour").attr("value", obj.attr("rel"));
            }
        } else {
            $(BookTarget.ToTimeId).attr("value", hour);
            $("#hdnReturnHour").attr("value", obj.attr("rel"));
        }
        Floating.Source.hide();
    });

    /**
    *时间下拉点击事件
    */
    $(document).delegate(FloatTarget.SelectTimeMinute + " .t", "click", function () {
        var obj = $(this);
        var hour = obj.text();
        var getStore = $.trim($(BookTarget.PickupStoreNameId).attr("value"));
        var retStore = $.trim($(BookTarget.ReturnStoreNameId).attr("value"));
        if (BookingInfo.Type === "get") {
            if (getStore === retStore) {
                $(BookTarget.FromMinuteId + "," + BookTarget.ToMinuteId).attr("value", hour);
                $("#hdnReturnMinute,#hdnPickUpMinute").attr("value", obj.attr("rel"));
            } else {
                $(BookTarget.FromMinuteId).attr("value", hour);
                $("#hdnPickUpMinute").attr("value", obj.attr("rel"));
            }
        } else {
            $(BookTarget.ToMinuteId).attr("value", hour);
            $("#hdnReturnMinute").attr("value", obj.attr("rel"));
        }
        Floating.Source.hide();
    });

    /**
    *搜索门店弹出框Tab切换
    *Create Date 2013.08.13 
    */
    $(FloatTarget.StoreBoxId).delegate(".store-inquire .iqst-all", "click", function (e) {
        var id = $(this).attr("id").toLowerCase();
        var city = BookingInfo.Type === "get"
            ? $(BookTarget.PickupCityId).attr("value")
            : $(BookTarget.ReturnCityId).attr("value");
        var cacheName = BookingInfo.Type === "get" ? "Store" : "ReturnStore";
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").attr("value") : $("#ReturnCityId").attr("value");
        $("#city").text(city);
        var path, param, isPickupService;
        isPickupService = BookingInfo.Type === "get";
        param = "isPickupService=" + isPickupService + "&cityId=" + cityId;
        if (id.indexOf("allstore") > -1) {
            path = BookingAjax.Url.StorePath;
            $(FloatTarget.StoreBoxId).html("");
            BookingAjax.ReqStore(path, param, cacheName, storeCallBack);

            $("#setAllStore").show().siblings().hide();
            $(".businessDistrict").removeClass("current").hide();
            $("#allStore").addClass("iqst-current").siblings().removeClass("iqst-current");

            $("#ydkBox .inf-box").show();
        } else if (id.indexOf("hotspots") > -1) {
            $("#setHotSpots").show().siblings().hide();
            $("#setHotSpots li").eq(0).addClass("current");
            $("#hotSpots").addClass("iqst-current").siblings().removeClass("iqst-current");
            param = $("#setHotSpots").find("li").eq(0).data("param");
            $(FloatTarget.StoreBoxId).find(".tabHF-content.list-mendian").html("");
            cacheName = isPickupService ? "SportStore" : "ReturnSportStore";
            BookingAjax.ReqAjax(BookingAjax.Url.CoordinateSearchNearStore + "?isPickupService=" + isPickupService,
                param,
                "post",
                cacheName,
                "html",
                function (data) {
                    if ($.trim(data) === "") {
                        $(FloatTarget.StoreBoxId).find(".inf-box").hide();
                        $(FloatTarget.StoreBoxId).find(".tabHF-content.list-mendian").html("<div class='list-none'>附近未查到相关门店信息</div>");
                    } else {
                        $("#ydkBox .list-mendian,#ydkBox .inf-box").show();
                        $("#ydkBox .list-mendian").html("").html(data);
                        $("#ydkBox .check-address span").hide();
                        var storeObj = $(FloatTarget.StoreBoxTarget.StoreContentSpan).eq(0).addClass("hover");
                        storeValue(storeObj);
                    }
                });
        } else if (id.indexOf("nearstore") > -1) {
            $("#setNearStore").show().siblings().hide();
            $("#nearStore").addClass("iqst-current").siblings().removeClass("iqst-current");

            $("#setNearStoreLi").show();
            $("#txtAddress").focus();
            $("#ydkBox .list-mendian,#ydkBox .inf-box,#ydkBox .check-address span").hide();
        } else {
            path = BookingAjax.Url.StorePath;
            param = "isPickupService=" + (BookingInfo.Type === "get") + "&cityId=" + cityId;
            $(FloatTarget.StoreBoxId).html("");
            BookingAjax.ReqStore(path, param, cacheName, function (data) {
                $(FloatTarget.StoreBoxId).html(data);

                $("#setBusinessDistrict").show().siblings().hide();
                $("#setBusinessDistrict li").eq(0).addClass("current");
                $("#ydkBox .list-mendian").show();

                $(".businessDistrict").eq(0).show().siblings().removeClass("current").hide();
                var storeObj = $(".businessDistrict dl dd").eq(0).find("span").addClass("hover");
                storeValue(storeObj);
                $("#businessDistrict").addClass("iqst-current").siblings().removeClass("iqst-current");
            });
        }
    });

    $("#btnSubmit").click(function () {

    });

    //禁用Enter键表单自动提交    
    document.onkeydown = function (event) {
        var target, code, tag;
        if (!event) {
            event = window.event; //针对ie浏览器    
            target = event.srcElement;
            code = event.keyCode;
            if (code == 13) {
                tag = target.tagName;
                if (tag == "TEXTAREA") {
                    return true;
                } else {
                    return false;
                }
            }
        } else {
            target = event.target; //针对遵循w3c标准的浏览器，如Firefox    
            code = event.keyCode;
            if (code == 13) {
                tag = target.tagName;
                if (tag == "INPUT") {
                    return false;
                } else {
                    return true;
                }
            }
        }
    };
    /**
    *面板切换状态
    */
    $(document).delegate(FloatTarget.TabHF.tabTitleLi, "mouseover mouseout", function (e) {
        if (e.type === "mouseover") {
            var obj = $(this);
            var index = obj.index();
            function action() {
                if ($("#businessDistrict").hasClass("iqst-current")) //不是否商圈+商圈数量
                {
                    var size = index + $("#setAllStore li").size();
                    obj.parent().parent().parent().addClass("curbox");
                    obj.addClass("current").siblings(".curbox " + FloatTarget.TabHF.tabTitleLi).removeClass("current");
                    $(".curbox " + FloatTarget.TabHF.tabContentLi).eq(size).addClass("current").siblings().removeClass("current");
                    $(".curbox " + FloatTarget.TabHF.tabContentLi).eq(size).find("dd").eq(0).find("span").addClass("hover");
                    $(".curbox " + FloatTarget.TabHF.tabContentLi).eq(size).show()
                        .siblings(".curbox " + FloatTarget.TabHF.tabContentLi).hide();
                    obj.parent().parent().parent().removeClass("curbox");

                    storeItemObj = $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(size).find("span").eq(0)
                        .addClass("hover");
                    storeValue(storeItemObj);
                }
                else if ($("#hotSpots").hasClass("iqst-current")) {
                    return;
                } else {
                    obj.parent().parent().parent().addClass("curbox");
                    obj.addClass("current").siblings(".curbox " + FloatTarget.TabHF.tabTitleLi).removeClass("current");
                    $(".curbox " + FloatTarget.TabHF.tabContentLi).eq(index).addClass("current")
                        .siblings(".curbox " + FloatTarget.TabHF.tabContentLi).removeClass("current");
                    $(".curbox " + FloatTarget.TabHF.tabContentLi).eq(index).show()
                        .siblings(".curbox " + FloatTarget.TabHF.tabContentLi).hide();
                    obj.parent().parent().parent().removeClass("curbox");
                    //区域切换门店效果处理
                    if ($(e.target).parent().hasClass("list-area")) {
                        var storeItemObj = null;
                        $(FloatTarget.StoreBoxTarget.StoreContentSpan).removeClass("hover");
                        var storeName = $.trim($(FloatTarget.StoreBoxTarget.StoreContentLi).eq(index)
                            .find("span[rel='" + BookingInfo.StoreName + "']").text());
                        if (storeName !== "") {
                            storeItemObj = $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(index)
                                .find("span[rel='" + storeName + "']");
                            $(FloatTarget.StoreBoxTarget.StoreContentSpan + "[rel='" + storeName + "']")
                                .addClass("hover");
                        } else {
                            storeItemObj = $(FloatTarget.StoreBoxTarget.StoreContentLi).eq(index).find("span").eq(0)
                                .addClass("hover");

                        }
                        storeValue(storeItemObj);
                    }
                }
            }

            window.handle = setTimeout(action, 200);
        } else {
            clearTimeout(handle);
        }
    });
    /**
    *浮层控制
    */
    $(FloatTarget.FloatBoxIdList()).live("mouseover",
        function () {
            Floating.IsMouseOut = false;
        }).live("mouseout",
            function () {
                Floating.IsMouseOut = true;
            });

    $(FloatTarget.ServiceTarger.SelectBox).live("mouseover",
        function () {
            Floating.IsServiceMouseOut = false;
        }).live("mouseout",
            function () {
                Floating.IsServiceMouseOut = true;
            });

    //隐藏浮动层
    $(document).mousedown(function (e) {
        e = window.e || e;

        var target = e.target || e.srcElement;
        Floating.Target = target;
        if (Floating.IsServiceMouseOut) {
            $(FloatTarget.ServiceTarger.SelectBox).hide();
            $(FloatTarget.ServiceTarger.SelectBox).parent().removeClass("current");
        }

        if (Floating.IsMouseOut && Floating.IsHide && Floating.Source != undefined) {
            $(".store-inquire span").removeClass("iqst-current");
            Floating.Source.hide();
            Floating.Source = null;
        }
    });

    $(".timeselect li").live("click", function () {
        var date1 = $.trim($(BookTarget.FromDateId).val()) + " " + $.trim($("#hdnPickupHour").val()) + ":" + $.trim($("#hdnPickUpMinute").val());
        var date2 = $.trim($(BookTarget.ToDateId).val()) + " " + $.trim($("#hdnReturnHour").val()) + ":" + $.trim($("#hdnReturnMinute").val());
        calcTenancy(date1, date2);
    });

    /*=================================
    *Author <ChengFeng>
    *Create Date <2013-07-23>
    *Description <Add城市智能匹配>
    =================================*/

   /* /!*
    *城市自动提示调用
    **!/
    function autoComplete() {
        var source = eval('(' + arrCity + ')');
        var cities = new Array();
        var checkObj = new Array();
        for (var i = 0; i < source.arrObj.length; i++) {
            cities[i] = new Array(source.arrObj[i]["cs"], source.arrObj[i]["py"], source.arrObj[i]["jc"], source.arrObj[i]["ac"], source.arrObj[i]["cid"]);
        }
        for (var i = 0; i < source.checkObj.length; i++) {
            checkObj[i] = new Array(source.checkObj[i]["cs"]);
        }
        $(BookTarget.PickupCityId + "," + BookTarget.ReturnCityId).autoComplete(cities, { attachObject: '.inquire-citybox', selectedClass: 'citybox-select', checkObj: checkObj });
    }
*/
    /*autoComplete();*/
    /*
    *Input键盘触发事件
    **/
    $(BookTarget.PickupCityId + "," + BookTarget.ReturnCityId).keyup(function (e) {
        if (Floating.Source)
            Floating.Source.hide();
        if (e.keyCode == 9)
            return;

        var id = "#" + $(this).attr("id");
        initializeObj(id, $(FloatTarget.CityAutoBoxId), "PickupCity");
        Floating.IsShow("get", id, FloatTarget.CityAutoBoxId);
        if (e.keyCode == 13) {
            var value = $(".inquire-citybox li.citybox-select").attr("rel");
            var cid = $(".inquire-citybox li.citybox-select").attr("cid");
            var cityGet = $("#city_get");
            var cityRet = $("#city_ret");
            var isAllowSendCar = $(".inquire-citybox li.citybox-select").attr("sendCar") === "Y";

            if (!$.trim($(FloatTarget.CityBoxTarget.CityLi).find("span[rel='" + $(this).val() + "']").text())) {
                return;
            }
            if (BookingInfo.Type === "get") {
                isAllowSendCar ? cityGet.show() : cityGet.hide();
                isAllowSendCar ? cityRet.show() : cityRet.hide();

                if (!isAllowSendCar) {
                    $(BookTarget.SendServiceCheckId + "," + BookTarget.ReturnServiceCheckId).attr("checked", false);
                    $(BookTarget.PickupStoreNameId + ',' + BookTarget.ReturnStoreNameId).show();
                    $('#getSendService,#retSendService').hide();
                }

                $("#PickUpCityId,#ReturnCityId").attr("value", cid);
                $("#getlng,#getlat,#retlng,#retlat,#getAddress,#retAddress").val('');
                $(BookTarget.PickupCityId + "," + BookTarget.ReturnCityId).attr("value", value);
                $(BookTarget.PickupStoreNameId + ',' + BookTarget.ReturnStoreNameId).val("");
                $(BookTarget.SendServiceId + ',' + BookTarget.ReturnServiceId).val("")
                $(BookTarget.SendServiceId).attr("placeholder", "请输入送车上门地址");
                $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
                $(BookTarget.PickupStoreNameId).attr("placeholder", "请选择取车营业门店");
                $(BookTarget.ReturnStoreNameId).attr("placeholder", "请选择还车营业门店");
            } else {
                isAllowSendCar ? cityRet.show() : cityRet.hide();

                if (!isAllowSendCar) {
                    $(BookTarget.ReturnServiceCheckId).attr("checked", false);
                    $(BookTarget.ReturnStoreNameId).show();
                    $('#retSendService').hide();
                }

                $("#retlng，#retlat,#retAddress").val('');
                $(BookTarget.ReturnCityId).attr("value", value);
                $("#ReturnCityId").attr("value", cid);
                $(BookTarget.ReturnStoreNameId).val("");
                $(BookTarget.ReturnServiceId).val("");
                $(BookTarget.ReturnStoreNameId).attr("placeholder", "请选择还车营业门店");
                $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
            }
            Floating.Source.hide();
        }
        //切换城市选择框
        if ($.trim($(this).attr("value")) === "") {
            Floating.Source.hide();
            initializeObj(id, $(FloatTarget.CityBoxId), "PickupCity");
            Floating.IsShow("get", id, FloatTarget.CityBoxId);
        }
    });

    /*
    *城市下拉选中值 （autocomplete.js）
    **/
    $(".inquire-citybox li").live("click", function () {
        var obj = $(this);
        var value = obj.attr("rel");
        var sendCar = obj.attr("sendCar");
        var cityGet = $("#city_get");
        var cityRet = $("#city_ret");
        var cid = obj.attr("cid");
        var isAllowSendCar = sendCar === "Y";
        BookingInfo.CityName = value;
        if (BookingInfo.Type === "get") {
            isAllowSendCar ? cityGet.show() : cityGet.hide();
            isAllowSendCar ? cityRet.show() : cityRet.hide();
            if (!isAllowSendCar) {
                $(BookTarget.SendServiceCheckId + "," + BookTarget.ReturnServiceCheckId).attr("checked", false);
                $(BookTarget.PickupStoreNameId + ',' + BookTarget.ReturnStoreNameId).show();
                $('#getSendService,#retSendService').hide();
            }
            $("#PickUpCityId,#ReturnCityId").attr("value", cid);
            $("#getlng,#getlat,#retlng,#retlat,#getAddress,#retAddress").val('');
            $(BookTarget.SendServiceId).attr("placeholder", "请输入送车上门地址");
            $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
            $(BookTarget.PickupCityId + "," + BookTarget.ReturnCityId).attr("value", value);
            $(BookTarget.PickupStoreNameId).val("").attr("placeholder", "请选择取车营业门店");
            $(BookTarget.ReturnStoreNameId).val("").attr("placeholder", "请选择还车营业门店");
        } else {
            isAllowSendCar ? cityRet.show() : cityRet.hide();
            if (!isAllowSendCar) {
                $(BookTarget.ReturnServiceCheckId).attr("checked", false);
                $(BookTarget.ReturnStoreNameId).show();
                $('#retSendService').hide();
            }
            $("#ReturnCityId").attr("value", cid);
            $("#retlng,#retlat,#retAddress").val('');
            $(BookTarget.ReturnServiceId).attr("placeholder", "请输入上门取车地址");
            $(BookTarget.ReturnCityId).attr("value", value);
            $(BookTarget.ReturnStoreNameId).val("").attr("placeholder", "请选择还车营业门店");
        }
        $(FloatTarget.CityAutoBoxId).hide();
    });

    $(document).on("keyup", '#txtAddress', function (e) {
        if (e.keyCode > 36 && e.keyCode < 41 || e.keyCode === 13) {
            return false;
        }
        var nearSearch = $("#NearSearch");
        nearSearch.html("");
        var obj = $("#txtAddress");
        var top = obj.position().top;
        var left = obj.position().left;
        nearSearch.css({
            top: (top + 29) + "px",
            left: left + "px"
        }).show();
        var address = obj.val();
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").val() : $("#ReturnCityId").val();
        if (address.length < 3) return false;
        setTimeout(function () {
            BookingAjax.ReqAjax(BookingAjax.Url.SearchNearAddress, "{ \"cityId\": \"" + cityId + "\", \"address\":\"" + address + "\"}", "post", "searchNearAddress", "html", function (data) {
                nearSearch.html(data);
            });
        }, 200);

    });

    $(document).on("click", "#setHotSpots li",
        function () {
            var param = $(this).data("param");
            $(this).addClass("current").siblings().removeClass("current");
            var isPickupService = BookingInfo.Type === "get";
            var cacheName = isPickupService ? "SportStore" : "ReturnSportStore";
            BookingAjax.ReqAjax(BookingAjax.Url.CoordinateSearchNearStore + "?isPickupService=" + isPickupService, param, "post", cacheName, "html", function (data) {
                if ($.trim(data) === "") {
                    $(FloatTarget.StoreBoxId).find(".inf-box").hide();
                    $("#ydkBox .list-mendian").html("<div class='list-none'>附近未查到相关门店信息<div>").show();
                } else {
                    $("#ydkBox .list-mendian,#ydkBox .inf-box").show();
                    $("#ydkBox .list-mendian").html("").html(data);
                    $("#ydkBox .check-address span").hide();
                    var storeObj = $(FloatTarget.StoreBoxTarget.StoreContentSpan).eq(0).addClass("hover");
                    storeValue(storeObj);
                }
            });
        });

    $(document).on("click",
        ".nearsearch-list li",
        function () {
            var lat = $(this).data("lat");
            var lng = $(this).data("lng");
            var add = $(this).data("address");
            $("#txtAddress").val(add);
            var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").val() : $("#ReturnCityId").val();
            var isPickupService = BookingInfo.Type === "get";
            var cacheName = isPickupService ? "NearStore" : "ReturnNearStore";
            BookingAjax.ReqAjax(BookingAjax.Url.CoordinateSearchNearStore + "?isPickupService=" + isPickupService, "{ \"cityId\": \"" + cityId + "\", \"lng\":\"" + lng + "\",\"lat\":\"" + lat + "\"}", "post", cacheName, "html", function (data) {
                $("#NearSearch").hide();
                if ($.trim(data) === "") {
                    $("#ydkBox .check-address span").text("未查到相关信息，请检查地址文字是否输入正确，重新再试。").show();
                } else {
                    $("#ydkBox .list-mendian,#ydkBox .inf-box").show();
                    $("#ydkBox .list-mendian").html("").html(data);
                    $("#ydkBox .check-address span").hide();
                    storeObj = $(FloatTarget.StoreBoxTarget.StoreContentSpan).eq(0).addClass("hover");
                    storeValue(storeObj);
                }
            });
        });
    $(document).on("click",
        "#linkLogin",
        function () {
            var url = LogUrl.LoginOrRegisterView + "?url=" + window.location.href.toString();
            CrossRequest(url);//发送请求
        });
    $(document).on("click",
        "#linkReg",
        function () {
            var url = LogUrl.LoginOrRegisterView + "?url=" + window.location.href.toString() + "&type=register";
            CrossRequest(url);//发送请求
        });
});
function CrossRequest(url) {
    $("#logOrReg").show();
    var server = document.getElementById("serverIf");
    server.src = url;
}
function beforeCheck() {
    var jsonData = $("form").serializeJson("json");
    jsonData.IsSendService = $(BookTarget.SendServiceCheckId).prop("checked");
    jsonData.IsReturnService = $(BookTarget.ReturnServiceCheckId).prop("checked");
    if (jsonData.IsSendService === false && jsonData.PickUpStoreName === "") {
        alert("请选择您的取车门店");
        return false;
    }
    if (jsonData.IsReturnService === false && jsonData.ReturnStoreName === "") {
        alert("请选择您的还车门店");
        return false;
    }
    delete jsonData.PickUpCity;
    delete jsonData.PickUpStoreName;
    delete jsonData.ReturnCity;
    delete jsonData.ReturnStoreName;
    var result = true;
    BookingAjax.Submit(BookingAjax.Url.ValidatePath,
        eHi.toJSONString(jsonData),
        "post",
        function (data) {
            if (data === "") {
                result = false;
            } else if (data !== null && data !== undefined && !data.IsSuccess) {
                alert(data.Message);
                result = false;
            }
        });
    if (!result) {
        return false;
    }
};
if (!window.MapCommon) var MapCommon = window.MapCommon = {};
(function (map, icon, mkr, ply) {
    //��ʼ������
    MapCommon.Parameter = {
        initialLat: 0, //��ʼ��ά��
        initialLng: 0, //��ʼ������
        MapDivId: "", //��ͼ��ʼ������ID
        MapZoomLevel: 16,  //��ͼ��ʼ�����ż���(Ĭ��16)
        MapPolygonData: "", //���ƶ���εľ�γ������(���磺[[{"Lng":"1","Lat":"2"},{"Lng":"3","Lat":"4"}],[{"Lng":"2","Lat":"3"}]])  Lng:����  Lat:ά��
        MarkerIcon: "", //ͼ���ز�(����Ĭ��ͼ��)
        ImgWidth: 47, // Icon��
        ImgHight: 47, //Icon��
        OutFun: function () { },//���ͼ��������ִ�е��¼�
        InFun: function () { }//���ͼ��������ִ�е��¼�

    };
    MapCommon.func = {
        //��ͼ��ʼ������
        MapLoad: function() {
            map = new BMap.Map(MapCommon.Parameter.MapDivId);
            map.setDefaultCursor("hand");
            var pt = new BMap.Point(MapCommon.Parameter.initialLng, MapCommon.Parameter.initialLat);
            if (MapCommon.Parameter.MarkerIcon !== "")
                icon = new BMap.Icon(MapCommon.Parameter.MarkerIcon,
                    new BMap.Size(MapCommon.Parameter.ImgWidth, MapCommon.Parameter.ImgHight));
            mkr = new BMap.Marker(pt, { icon: icon });
            mkr.enableDragging(); //������ק
            map.centerAndZoom(pt, MapCommon.Parameter.MapZoomLevel);
            map.enableScrollWheelZoom(); //�����������
            map.enablePinchToZoom(); //����˫ָ��������
            map.enableContinuousZoom(); //��������ƽ��
            MapCommon.func.MapPolygon(); //���ƶ����
            map.addOverlay(mkr);
            //�󶨰ٶȵ�ͼ��������¼�
            mkr.addEventListener('dragend',
                function (e) {
                    MapCommon.func.InOrOutPolygon(e.point.lng, e.point.lat, true);
                });
            map.addEventListener("click",
                function (e) {
                    MapCommon.func.InOrOutPolygon(e.point.lng, e.point.lat, true);
                });
        },
        //���ƶ����
        MapPolygon: function() {
            ply = [];
            // ��ʼ��������и�����
            map.clearOverlays();
            // var json = eval('(' + MapCommon.Parameter.MapPolygonData + ')');
            var json = MapCommon.Parameter.MapPolygonData;
            for (var j = 0; j < json.length; j++) {
                var obj = json[j],
                    pts = [];
                for (var i = 0; i < obj.length; i++) {
                    pts.push(new BMap.Point(obj[i].Lng, obj[i].Lat));
                }
                var newPly = new BMap.Polygon(pts);

                //�����ߵ�����
                newPly.setStrokeColor("#0c95ff");
                newPly.setStrokeWeight(2);

                //���ø����������
                newPly.setFillOpacity(0.1);
                newPly.setFillColor("#0c95ff");
                map.addOverlay(newPly);
                ply.push(newPly);

            }
        },
        IsInPolygon: function(lng, lat) {
            var pt = new BMap.Point(lng, lat);
            var result = false;
            for (var i = 0; i < ply.length; i++) {
                if (result) {
                    break;
                }
                result = BMapLib.GeoUtils.isPointInPolygon(pt, ply[i]);
            }
            return result;
        },
        //�жϵ�����Ƿ��ڷ�Χ֮��
        InOrOutPolygon: function(lng, lat, isType) {
            var pt = new BMap.Point(lng, lat);
            if (isType) {
                MapCommon.Parameter.InFun(lng, lat);
            }
            map.centerAndZoom(pt, 17);
            mkr.setPosition(pt);
            map.addOverlay(mkr);
        },
        //���ݵ�ַ��ѯλ����Ϣ
        GetPosition: function(address) {
            var pt;
            var localSearch = new BMap.LocalSearch(map);
            localSearch.setSearchCompleteCallback(function(searchResult) {
                if (searchResult == undefined) return;
                var poi = searchResult.getPoi(0);
                if (poi == undefined) return;
                map.centerAndZoom(poi.point, MapCommon.Parameter.MapZoomLevel);
                pt = new BMap.Point(poi.point.lng, poi.point.lat);
                map.centerAndZoom(pt, 17);
                mkr.setPosition(pt);
                map.addOverlay(mkr);
            });
            localSearch.search(address);
        },
        //���ݾ�γ�ȶ�λ����
        GetAddress: function(lng, lat) {
            var pt = new BMap.Point(lng, lat);
            map.centerAndZoom(pt, 17);
            mkr.setPosition(pt);
            map.addOverlay(mkr);
        }
    };
    
})();;
//! moment.js
//! version : 2.10.3
//! authors : Tim Wood, Iskren Chernev, Moment.js contributors
//! license : MIT
//! momentjs.com
!function(a,b){"object"==typeof exports&&"undefined"!=typeof module?module.exports=b():"function"==typeof define&&define.amd?define(b):a.moment=b()}(this,function(){"use strict";function a(){return Dc.apply(null,arguments)}function b(a){Dc=a}function c(a){return"[object Array]"===Object.prototype.toString.call(a)}function d(a){return a instanceof Date||"[object Date]"===Object.prototype.toString.call(a)}function e(a,b){var c,d=[];for(c=0;c<a.length;++c)d.push(b(a[c],c));return d}function f(a,b){return Object.prototype.hasOwnProperty.call(a,b)}function g(a,b){for(var c in b)f(b,c)&&(a[c]=b[c]);return f(b,"toString")&&(a.toString=b.toString),f(b,"valueOf")&&(a.valueOf=b.valueOf),a}function h(a,b,c,d){return za(a,b,c,d,!0).utc()}function i(){return{empty:!1,unusedTokens:[],unusedInput:[],overflow:-2,charsLeftOver:0,nullInput:!1,invalidMonth:null,invalidFormat:!1,userInvalidated:!1,iso:!1}}function j(a){return null==a._pf&&(a._pf=i()),a._pf}function k(a){if(null==a._isValid){var b=j(a);a._isValid=!isNaN(a._d.getTime())&&b.overflow<0&&!b.empty&&!b.invalidMonth&&!b.nullInput&&!b.invalidFormat&&!b.userInvalidated,a._strict&&(a._isValid=a._isValid&&0===b.charsLeftOver&&0===b.unusedTokens.length&&void 0===b.bigHour)}return a._isValid}function l(a){var b=h(0/0);return null!=a?g(j(b),a):j(b).userInvalidated=!0,b}function m(a,b){var c,d,e;if("undefined"!=typeof b._isAMomentObject&&(a._isAMomentObject=b._isAMomentObject),"undefined"!=typeof b._i&&(a._i=b._i),"undefined"!=typeof b._f&&(a._f=b._f),"undefined"!=typeof b._l&&(a._l=b._l),"undefined"!=typeof b._strict&&(a._strict=b._strict),"undefined"!=typeof b._tzm&&(a._tzm=b._tzm),"undefined"!=typeof b._isUTC&&(a._isUTC=b._isUTC),"undefined"!=typeof b._offset&&(a._offset=b._offset),"undefined"!=typeof b._pf&&(a._pf=j(b)),"undefined"!=typeof b._locale&&(a._locale=b._locale),Fc.length>0)for(c in Fc)d=Fc[c],e=b[d],"undefined"!=typeof e&&(a[d]=e);return a}function n(b){m(this,b),this._d=new Date(+b._d),Gc===!1&&(Gc=!0,a.updateOffset(this),Gc=!1)}function o(a){return a instanceof n||null!=a&&null!=a._isAMomentObject}function p(a){var b=+a,c=0;return 0!==b&&isFinite(b)&&(c=b>=0?Math.floor(b):Math.ceil(b)),c}function q(a,b,c){var d,e=Math.min(a.length,b.length),f=Math.abs(a.length-b.length),g=0;for(d=0;e>d;d++)(c&&a[d]!==b[d]||!c&&p(a[d])!==p(b[d]))&&g++;return g+f}function r(){}function s(a){return a?a.toLowerCase().replace("_","-"):a}function t(a){for(var b,c,d,e,f=0;f<a.length;){for(e=s(a[f]).split("-"),b=e.length,c=s(a[f+1]),c=c?c.split("-"):null;b>0;){if(d=u(e.slice(0,b).join("-")))return d;if(c&&c.length>=b&&q(e,c,!0)>=b-1)break;b--}f++}return null}function u(a){var b=null;if(!Hc[a]&&"undefined"!=typeof module&&module&&module.exports)try{b=Ec._abbr,require("./locale/"+a),v(b)}catch(c){}return Hc[a]}function v(a,b){var c;return a&&(c="undefined"==typeof b?x(a):w(a,b),c&&(Ec=c)),Ec._abbr}function w(a,b){return null!==b?(b.abbr=a,Hc[a]||(Hc[a]=new r),Hc[a].set(b),v(a),Hc[a]):(delete Hc[a],null)}function x(a){var b;if(a&&a._locale&&a._locale._abbr&&(a=a._locale._abbr),!a)return Ec;if(!c(a)){if(b=u(a))return b;a=[a]}return t(a)}function y(a,b){var c=a.toLowerCase();Ic[c]=Ic[c+"s"]=Ic[b]=a}function z(a){return"string"==typeof a?Ic[a]||Ic[a.toLowerCase()]:void 0}function A(a){var b,c,d={};for(c in a)f(a,c)&&(b=z(c),b&&(d[b]=a[c]));return d}function B(b,c){return function(d){return null!=d?(D(this,b,d),a.updateOffset(this,c),this):C(this,b)}}function C(a,b){return a._d["get"+(a._isUTC?"UTC":"")+b]()}function D(a,b,c){return a._d["set"+(a._isUTC?"UTC":"")+b](c)}function E(a,b){var c;if("object"==typeof a)for(c in a)this.set(c,a[c]);else if(a=z(a),"function"==typeof this[a])return this[a](b);return this}function F(a,b,c){for(var d=""+Math.abs(a),e=a>=0;d.length<b;)d="0"+d;return(e?c?"+":"":"-")+d}function G(a,b,c,d){var e=d;"string"==typeof d&&(e=function(){return this[d]()}),a&&(Mc[a]=e),b&&(Mc[b[0]]=function(){return F(e.apply(this,arguments),b[1],b[2])}),c&&(Mc[c]=function(){return this.localeData().ordinal(e.apply(this,arguments),a)})}function H(a){return a.match(/\[[\s\S]/)?a.replace(/^\[|\]$/g,""):a.replace(/\\/g,"")}function I(a){var b,c,d=a.match(Jc);for(b=0,c=d.length;c>b;b++)Mc[d[b]]?d[b]=Mc[d[b]]:d[b]=H(d[b]);return function(e){var f="";for(b=0;c>b;b++)f+=d[b]instanceof Function?d[b].call(e,a):d[b];return f}}function J(a,b){return a.isValid()?(b=K(b,a.localeData()),Lc[b]||(Lc[b]=I(b)),Lc[b](a)):a.localeData().invalidDate()}function K(a,b){function c(a){return b.longDateFormat(a)||a}var d=5;for(Kc.lastIndex=0;d>=0&&Kc.test(a);)a=a.replace(Kc,c),Kc.lastIndex=0,d-=1;return a}function L(a,b,c){_c[a]="function"==typeof b?b:function(a){return a&&c?c:b}}function M(a,b){return f(_c,a)?_c[a](b._strict,b._locale):new RegExp(N(a))}function N(a){return a.replace("\\","").replace(/\\(\[)|\\(\])|\[([^\]\[]*)\]|\\(.)/g,function(a,b,c,d,e){return b||c||d||e}).replace(/[-\/\\^$*+?.()|[\]{}]/g,"\\$&")}function O(a,b){var c,d=b;for("string"==typeof a&&(a=[a]),"number"==typeof b&&(d=function(a,c){c[b]=p(a)}),c=0;c<a.length;c++)ad[a[c]]=d}function P(a,b){O(a,function(a,c,d,e){d._w=d._w||{},b(a,d._w,d,e)})}function Q(a,b,c){null!=b&&f(ad,a)&&ad[a](b,c._a,c,a)}function R(a,b){return new Date(Date.UTC(a,b+1,0)).getUTCDate()}function S(a){return this._months[a.month()]}function T(a){return this._monthsShort[a.month()]}function U(a,b,c){var d,e,f;for(this._monthsParse||(this._monthsParse=[],this._longMonthsParse=[],this._shortMonthsParse=[]),d=0;12>d;d++){if(e=h([2e3,d]),c&&!this._longMonthsParse[d]&&(this._longMonthsParse[d]=new RegExp("^"+this.months(e,"").replace(".","")+"$","i"),this._shortMonthsParse[d]=new RegExp("^"+this.monthsShort(e,"").replace(".","")+"$","i")),c||this._monthsParse[d]||(f="^"+this.months(e,"")+"|^"+this.monthsShort(e,""),this._monthsParse[d]=new RegExp(f.replace(".",""),"i")),c&&"MMMM"===b&&this._longMonthsParse[d].test(a))return d;if(c&&"MMM"===b&&this._shortMonthsParse[d].test(a))return d;if(!c&&this._monthsParse[d].test(a))return d}}function V(a,b){var c;return"string"==typeof b&&(b=a.localeData().monthsParse(b),"number"!=typeof b)?a:(c=Math.min(a.date(),R(a.year(),b)),a._d["set"+(a._isUTC?"UTC":"")+"Month"](b,c),a)}function W(b){return null!=b?(V(this,b),a.updateOffset(this,!0),this):C(this,"Month")}function X(){return R(this.year(),this.month())}function Y(a){var b,c=a._a;return c&&-2===j(a).overflow&&(b=c[cd]<0||c[cd]>11?cd:c[dd]<1||c[dd]>R(c[bd],c[cd])?dd:c[ed]<0||c[ed]>24||24===c[ed]&&(0!==c[fd]||0!==c[gd]||0!==c[hd])?ed:c[fd]<0||c[fd]>59?fd:c[gd]<0||c[gd]>59?gd:c[hd]<0||c[hd]>999?hd:-1,j(a)._overflowDayOfYear&&(bd>b||b>dd)&&(b=dd),j(a).overflow=b),a}function Z(b){a.suppressDeprecationWarnings===!1&&"undefined"!=typeof console&&console.warn&&console.warn("Deprecation warning: "+b)}function $(a,b){var c=!0,d=a+"\n"+(new Error).stack;return g(function(){return c&&(Z(d),c=!1),b.apply(this,arguments)},b)}function _(a,b){kd[a]||(Z(b),kd[a]=!0)}function aa(a){var b,c,d=a._i,e=ld.exec(d);if(e){for(j(a).iso=!0,b=0,c=md.length;c>b;b++)if(md[b][1].exec(d)){a._f=md[b][0]+(e[6]||" ");break}for(b=0,c=nd.length;c>b;b++)if(nd[b][1].exec(d)){a._f+=nd[b][0];break}d.match(Yc)&&(a._f+="Z"),ta(a)}else a._isValid=!1}function ba(b){var c=od.exec(b._i);return null!==c?void(b._d=new Date(+c[1])):(aa(b),void(b._isValid===!1&&(delete b._isValid,a.createFromInputFallback(b))))}function ca(a,b,c,d,e,f,g){var h=new Date(a,b,c,d,e,f,g);return 1970>a&&h.setFullYear(a),h}function da(a){var b=new Date(Date.UTC.apply(null,arguments));return 1970>a&&b.setUTCFullYear(a),b}function ea(a){return fa(a)?366:365}function fa(a){return a%4===0&&a%100!==0||a%400===0}function ga(){return fa(this.year())}function ha(a,b,c){var d,e=c-b,f=c-a.day();return f>e&&(f-=7),e-7>f&&(f+=7),d=Aa(a).add(f,"d"),{week:Math.ceil(d.dayOfYear()/7),year:d.year()}}function ia(a){return ha(a,this._week.dow,this._week.doy).week}function ja(){return this._week.dow}function ka(){return this._week.doy}function la(a){var b=this.localeData().week(this);return null==a?b:this.add(7*(a-b),"d")}function ma(a){var b=ha(this,1,4).week;return null==a?b:this.add(7*(a-b),"d")}function na(a,b,c,d,e){var f,g,h=da(a,0,1).getUTCDay();return h=0===h?7:h,c=null!=c?c:e,f=e-h+(h>d?7:0)-(e>h?7:0),g=7*(b-1)+(c-e)+f+1,{year:g>0?a:a-1,dayOfYear:g>0?g:ea(a-1)+g}}function oa(a){var b=Math.round((this.clone().startOf("day")-this.clone().startOf("year"))/864e5)+1;return null==a?b:this.add(a-b,"d")}function pa(a,b,c){return null!=a?a:null!=b?b:c}function qa(a){var b=new Date;return a._useUTC?[b.getUTCFullYear(),b.getUTCMonth(),b.getUTCDate()]:[b.getFullYear(),b.getMonth(),b.getDate()]}function ra(a){var b,c,d,e,f=[];if(!a._d){for(d=qa(a),a._w&&null==a._a[dd]&&null==a._a[cd]&&sa(a),a._dayOfYear&&(e=pa(a._a[bd],d[bd]),a._dayOfYear>ea(e)&&(j(a)._overflowDayOfYear=!0),c=da(e,0,a._dayOfYear),a._a[cd]=c.getUTCMonth(),a._a[dd]=c.getUTCDate()),b=0;3>b&&null==a._a[b];++b)a._a[b]=f[b]=d[b];for(;7>b;b++)a._a[b]=f[b]=null==a._a[b]?2===b?1:0:a._a[b];24===a._a[ed]&&0===a._a[fd]&&0===a._a[gd]&&0===a._a[hd]&&(a._nextDay=!0,a._a[ed]=0),a._d=(a._useUTC?da:ca).apply(null,f),null!=a._tzm&&a._d.setUTCMinutes(a._d.getUTCMinutes()-a._tzm),a._nextDay&&(a._a[ed]=24)}}function sa(a){var b,c,d,e,f,g,h;b=a._w,null!=b.GG||null!=b.W||null!=b.E?(f=1,g=4,c=pa(b.GG,a._a[bd],ha(Aa(),1,4).year),d=pa(b.W,1),e=pa(b.E,1)):(f=a._locale._week.dow,g=a._locale._week.doy,c=pa(b.gg,a._a[bd],ha(Aa(),f,g).year),d=pa(b.w,1),null!=b.d?(e=b.d,f>e&&++d):e=null!=b.e?b.e+f:f),h=na(c,d,e,g,f),a._a[bd]=h.year,a._dayOfYear=h.dayOfYear}function ta(b){if(b._f===a.ISO_8601)return void aa(b);b._a=[],j(b).empty=!0;var c,d,e,f,g,h=""+b._i,i=h.length,k=0;for(e=K(b._f,b._locale).match(Jc)||[],c=0;c<e.length;c++)f=e[c],d=(h.match(M(f,b))||[])[0],d&&(g=h.substr(0,h.indexOf(d)),g.length>0&&j(b).unusedInput.push(g),h=h.slice(h.indexOf(d)+d.length),k+=d.length),Mc[f]?(d?j(b).empty=!1:j(b).unusedTokens.push(f),Q(f,d,b)):b._strict&&!d&&j(b).unusedTokens.push(f);j(b).charsLeftOver=i-k,h.length>0&&j(b).unusedInput.push(h),j(b).bigHour===!0&&b._a[ed]<=12&&b._a[ed]>0&&(j(b).bigHour=void 0),b._a[ed]=ua(b._locale,b._a[ed],b._meridiem),ra(b),Y(b)}function ua(a,b,c){var d;return null==c?b:null!=a.meridiemHour?a.meridiemHour(b,c):null!=a.isPM?(d=a.isPM(c),d&&12>b&&(b+=12),d||12!==b||(b=0),b):b}function va(a){var b,c,d,e,f;if(0===a._f.length)return j(a).invalidFormat=!0,void(a._d=new Date(0/0));for(e=0;e<a._f.length;e++)f=0,b=m({},a),null!=a._useUTC&&(b._useUTC=a._useUTC),b._f=a._f[e],ta(b),k(b)&&(f+=j(b).charsLeftOver,f+=10*j(b).unusedTokens.length,j(b).score=f,(null==d||d>f)&&(d=f,c=b));g(a,c||b)}function wa(a){if(!a._d){var b=A(a._i);a._a=[b.year,b.month,b.day||b.date,b.hour,b.minute,b.second,b.millisecond],ra(a)}}function xa(a){var b,e=a._i,f=a._f;return a._locale=a._locale||x(a._l),null===e||void 0===f&&""===e?l({nullInput:!0}):("string"==typeof e&&(a._i=e=a._locale.preparse(e)),o(e)?new n(Y(e)):(c(f)?va(a):f?ta(a):d(e)?a._d=e:ya(a),b=new n(Y(a)),b._nextDay&&(b.add(1,"d"),b._nextDay=void 0),b))}function ya(b){var f=b._i;void 0===f?b._d=new Date:d(f)?b._d=new Date(+f):"string"==typeof f?ba(b):c(f)?(b._a=e(f.slice(0),function(a){return parseInt(a,10)}),ra(b)):"object"==typeof f?wa(b):"number"==typeof f?b._d=new Date(f):a.createFromInputFallback(b)}function za(a,b,c,d,e){var f={};return"boolean"==typeof c&&(d=c,c=void 0),f._isAMomentObject=!0,f._useUTC=f._isUTC=e,f._l=c,f._i=a,f._f=b,f._strict=d,xa(f)}function Aa(a,b,c,d){return za(a,b,c,d,!1)}function Ba(a,b){var d,e;if(1===b.length&&c(b[0])&&(b=b[0]),!b.length)return Aa();for(d=b[0],e=1;e<b.length;++e)b[e][a](d)&&(d=b[e]);return d}function Ca(){var a=[].slice.call(arguments,0);return Ba("isBefore",a)}function Da(){var a=[].slice.call(arguments,0);return Ba("isAfter",a)}function Ea(a){var b=A(a),c=b.year||0,d=b.quarter||0,e=b.month||0,f=b.week||0,g=b.day||0,h=b.hour||0,i=b.minute||0,j=b.second||0,k=b.millisecond||0;this._milliseconds=+k+1e3*j+6e4*i+36e5*h,this._days=+g+7*f,this._months=+e+3*d+12*c,this._data={},this._locale=x(),this._bubble()}function Fa(a){return a instanceof Ea}function Ga(a,b){G(a,0,0,function(){var a=this.utcOffset(),c="+";return 0>a&&(a=-a,c="-"),c+F(~~(a/60),2)+b+F(~~a%60,2)})}function Ha(a){var b=(a||"").match(Yc)||[],c=b[b.length-1]||[],d=(c+"").match(td)||["-",0,0],e=+(60*d[1])+p(d[2]);return"+"===d[0]?e:-e}function Ia(b,c){var e,f;return c._isUTC?(e=c.clone(),f=(o(b)||d(b)?+b:+Aa(b))-+e,e._d.setTime(+e._d+f),a.updateOffset(e,!1),e):Aa(b).local();return c._isUTC?Aa(b).zone(c._offset||0):Aa(b).local()}function Ja(a){return 15*-Math.round(a._d.getTimezoneOffset()/15)}function Ka(b,c){var d,e=this._offset||0;return null!=b?("string"==typeof b&&(b=Ha(b)),Math.abs(b)<16&&(b=60*b),!this._isUTC&&c&&(d=Ja(this)),this._offset=b,this._isUTC=!0,null!=d&&this.add(d,"m"),e!==b&&(!c||this._changeInProgress?$a(this,Va(b-e,"m"),1,!1):this._changeInProgress||(this._changeInProgress=!0,a.updateOffset(this,!0),this._changeInProgress=null)),this):this._isUTC?e:Ja(this)}function La(a,b){return null!=a?("string"!=typeof a&&(a=-a),this.utcOffset(a,b),this):-this.utcOffset()}function Ma(a){return this.utcOffset(0,a)}function Na(a){return this._isUTC&&(this.utcOffset(0,a),this._isUTC=!1,a&&this.subtract(Ja(this),"m")),this}function Oa(){return this._tzm?this.utcOffset(this._tzm):"string"==typeof this._i&&this.utcOffset(Ha(this._i)),this}function Pa(a){return a=a?Aa(a).utcOffset():0,(this.utcOffset()-a)%60===0}function Qa(){return this.utcOffset()>this.clone().month(0).utcOffset()||this.utcOffset()>this.clone().month(5).utcOffset()}function Ra(){if(this._a){var a=this._isUTC?h(this._a):Aa(this._a);return this.isValid()&&q(this._a,a.toArray())>0}return!1}function Sa(){return!this._isUTC}function Ta(){return this._isUTC}function Ua(){return this._isUTC&&0===this._offset}function Va(a,b){var c,d,e,g=a,h=null;return Fa(a)?g={ms:a._milliseconds,d:a._days,M:a._months}:"number"==typeof a?(g={},b?g[b]=a:g.milliseconds=a):(h=ud.exec(a))?(c="-"===h[1]?-1:1,g={y:0,d:p(h[dd])*c,h:p(h[ed])*c,m:p(h[fd])*c,s:p(h[gd])*c,ms:p(h[hd])*c}):(h=vd.exec(a))?(c="-"===h[1]?-1:1,g={y:Wa(h[2],c),M:Wa(h[3],c),d:Wa(h[4],c),h:Wa(h[5],c),m:Wa(h[6],c),s:Wa(h[7],c),w:Wa(h[8],c)}):null==g?g={}:"object"==typeof g&&("from"in g||"to"in g)&&(e=Ya(Aa(g.from),Aa(g.to)),g={},g.ms=e.milliseconds,g.M=e.months),d=new Ea(g),Fa(a)&&f(a,"_locale")&&(d._locale=a._locale),d}function Wa(a,b){var c=a&&parseFloat(a.replace(",","."));return(isNaN(c)?0:c)*b}function Xa(a,b){var c={milliseconds:0,months:0};return c.months=b.month()-a.month()+12*(b.year()-a.year()),a.clone().add(c.months,"M").isAfter(b)&&--c.months,c.milliseconds=+b-+a.clone().add(c.months,"M"),c}function Ya(a,b){var c;return b=Ia(b,a),a.isBefore(b)?c=Xa(a,b):(c=Xa(b,a),c.milliseconds=-c.milliseconds,c.months=-c.months),c}function Za(a,b){return function(c,d){var e,f;return null===d||isNaN(+d)||(_(b,"moment()."+b+"(period, number) is deprecated. Please use moment()."+b+"(number, period)."),f=c,c=d,d=f),c="string"==typeof c?+c:c,e=Va(c,d),$a(this,e,a),this}}function $a(b,c,d,e){var f=c._milliseconds,g=c._days,h=c._months;e=null==e?!0:e,f&&b._d.setTime(+b._d+f*d),g&&D(b,"Date",C(b,"Date")+g*d),h&&V(b,C(b,"Month")+h*d),e&&a.updateOffset(b,g||h)}function _a(a){var b=a||Aa(),c=Ia(b,this).startOf("day"),d=this.diff(c,"days",!0),e=-6>d?"sameElse":-1>d?"lastWeek":0>d?"lastDay":1>d?"sameDay":2>d?"nextDay":7>d?"nextWeek":"sameElse";return this.format(this.localeData().calendar(e,this,Aa(b)))}function ab(){return new n(this)}function bb(a,b){var c;return b=z("undefined"!=typeof b?b:"millisecond"),"millisecond"===b?(a=o(a)?a:Aa(a),+this>+a):(c=o(a)?+a:+Aa(a),c<+this.clone().startOf(b))}function cb(a,b){var c;return b=z("undefined"!=typeof b?b:"millisecond"),"millisecond"===b?(a=o(a)?a:Aa(a),+a>+this):(c=o(a)?+a:+Aa(a),+this.clone().endOf(b)<c)}function db(a,b,c){return this.isAfter(a,c)&&this.isBefore(b,c)}function eb(a,b){var c;return b=z(b||"millisecond"),"millisecond"===b?(a=o(a)?a:Aa(a),+this===+a):(c=+Aa(a),+this.clone().startOf(b)<=c&&c<=+this.clone().endOf(b))}function fb(a){return 0>a?Math.ceil(a):Math.floor(a)}function gb(a,b,c){var d,e,f=Ia(a,this),g=6e4*(f.utcOffset()-this.utcOffset());return b=z(b),"year"===b||"month"===b||"quarter"===b?(e=hb(this,f),"quarter"===b?e/=3:"year"===b&&(e/=12)):(d=this-f,e="second"===b?d/1e3:"minute"===b?d/6e4:"hour"===b?d/36e5:"day"===b?(d-g)/864e5:"week"===b?(d-g)/6048e5:d),c?e:fb(e)}function hb(a,b){var c,d,e=12*(b.year()-a.year())+(b.month()-a.month()),f=a.clone().add(e,"months");return 0>b-f?(c=a.clone().add(e-1,"months"),d=(b-f)/(f-c)):(c=a.clone().add(e+1,"months"),d=(b-f)/(c-f)),-(e+d)}function ib(){return this.clone().locale("en").format("ddd MMM DD YYYY HH:mm:ss [GMT]ZZ")}function jb(){var a=this.clone().utc();return 0<a.year()&&a.year()<=9999?"function"==typeof Date.prototype.toISOString?this.toDate().toISOString():J(a,"YYYY-MM-DD[T]HH:mm:ss.SSS[Z]"):J(a,"YYYYYY-MM-DD[T]HH:mm:ss.SSS[Z]")}function kb(b){var c=J(this,b||a.defaultFormat);return this.localeData().postformat(c)}function lb(a,b){return this.isValid()?Va({to:this,from:a}).locale(this.locale()).humanize(!b):this.localeData().invalidDate()}function mb(a){return this.from(Aa(),a)}function nb(a,b){return this.isValid()?Va({from:this,to:a}).locale(this.locale()).humanize(!b):this.localeData().invalidDate()}function ob(a){return this.to(Aa(),a)}function pb(a){var b;return void 0===a?this._locale._abbr:(b=x(a),null!=b&&(this._locale=b),this)}function qb(){return this._locale}function rb(a){switch(a=z(a)){case"year":this.month(0);case"quarter":case"month":this.date(1);case"week":case"isoWeek":case"day":this.hours(0);case"hour":this.minutes(0);case"minute":this.seconds(0);case"second":this.milliseconds(0)}return"week"===a&&this.weekday(0),"isoWeek"===a&&this.isoWeekday(1),"quarter"===a&&this.month(3*Math.floor(this.month()/3)),this}function sb(a){return a=z(a),void 0===a||"millisecond"===a?this:this.startOf(a).add(1,"isoWeek"===a?"week":a).subtract(1,"ms")}function tb(){return+this._d-6e4*(this._offset||0)}function ub(){return Math.floor(+this/1e3)}function vb(){return this._offset?new Date(+this):this._d}function wb(){var a=this;return[a.year(),a.month(),a.date(),a.hour(),a.minute(),a.second(),a.millisecond()]}function xb(){return k(this)}function yb(){return g({},j(this))}function zb(){return j(this).overflow}function Ab(a,b){G(0,[a,a.length],0,b)}function Bb(a,b,c){return ha(Aa([a,11,31+b-c]),b,c).week}function Cb(a){var b=ha(this,this.localeData()._week.dow,this.localeData()._week.doy).year;return null==a?b:this.add(a-b,"y")}function Db(a){var b=ha(this,1,4).year;return null==a?b:this.add(a-b,"y")}function Eb(){return Bb(this.year(),1,4)}function Fb(){var a=this.localeData()._week;return Bb(this.year(),a.dow,a.doy)}function Gb(a){return null==a?Math.ceil((this.month()+1)/3):this.month(3*(a-1)+this.month()%3)}function Hb(a,b){if("string"==typeof a)if(isNaN(a)){if(a=b.weekdaysParse(a),"number"!=typeof a)return null}else a=parseInt(a,10);return a}function Ib(a){return this._weekdays[a.day()]}function Jb(a){return this._weekdaysShort[a.day()]}function Kb(a){return this._weekdaysMin[a.day()]}function Lb(a){var b,c,d;for(this._weekdaysParse||(this._weekdaysParse=[]),b=0;7>b;b++)if(this._weekdaysParse[b]||(c=Aa([2e3,1]).day(b),d="^"+this.weekdays(c,"")+"|^"+this.weekdaysShort(c,"")+"|^"+this.weekdaysMin(c,""),this._weekdaysParse[b]=new RegExp(d.replace(".",""),"i")),this._weekdaysParse[b].test(a))return b}function Mb(a){var b=this._isUTC?this._d.getUTCDay():this._d.getDay();return null!=a?(a=Hb(a,this.localeData()),this.add(a-b,"d")):b}function Nb(a){var b=(this.day()+7-this.localeData()._week.dow)%7;return null==a?b:this.add(a-b,"d")}function Ob(a){return null==a?this.day()||7:this.day(this.day()%7?a:a-7)}function Pb(a,b){G(a,0,0,function(){return this.localeData().meridiem(this.hours(),this.minutes(),b)})}function Qb(a,b){return b._meridiemParse}function Rb(a){return"p"===(a+"").toLowerCase().charAt(0)}function Sb(a,b,c){return a>11?c?"pm":"PM":c?"am":"AM"}function Tb(a){G(0,[a,3],0,"millisecond")}function Ub(){return this._isUTC?"UTC":""}function Vb(){return this._isUTC?"Coordinated Universal Time":""}function Wb(a){return Aa(1e3*a)}function Xb(){return Aa.apply(null,arguments).parseZone()}function Yb(a,b,c){var d=this._calendar[a];return"function"==typeof d?d.call(b,c):d}function Zb(a){var b=this._longDateFormat[a];return!b&&this._longDateFormat[a.toUpperCase()]&&(b=this._longDateFormat[a.toUpperCase()].replace(/MMMM|MM|DD|dddd/g,function(a){return a.slice(1)}),this._longDateFormat[a]=b),b}function $b(){return this._invalidDate}function _b(a){return this._ordinal.replace("%d",a)}function ac(a){return a}function bc(a,b,c,d){var e=this._relativeTime[c];return"function"==typeof e?e(a,b,c,d):e.replace(/%d/i,a)}function cc(a,b){var c=this._relativeTime[a>0?"future":"past"];return"function"==typeof c?c(b):c.replace(/%s/i,b)}function dc(a){var b,c;for(c in a)b=a[c],"function"==typeof b?this[c]=b:this["_"+c]=b;this._ordinalParseLenient=new RegExp(this._ordinalParse.source+"|"+/\d{1,2}/.source)}function ec(a,b,c,d){var e=x(),f=h().set(d,b);return e[c](f,a)}function fc(a,b,c,d,e){if("number"==typeof a&&(b=a,a=void 0),a=a||"",null!=b)return ec(a,b,c,e);var f,g=[];for(f=0;d>f;f++)g[f]=ec(a,f,c,e);return g}function gc(a,b){return fc(a,b,"months",12,"month")}function hc(a,b){return fc(a,b,"monthsShort",12,"month")}function ic(a,b){return fc(a,b,"weekdays",7,"day")}function jc(a,b){return fc(a,b,"weekdaysShort",7,"day")}function kc(a,b){return fc(a,b,"weekdaysMin",7,"day")}function lc(){var a=this._data;return this._milliseconds=Rd(this._milliseconds),this._days=Rd(this._days),this._months=Rd(this._months),a.milliseconds=Rd(a.milliseconds),a.seconds=Rd(a.seconds),a.minutes=Rd(a.minutes),a.hours=Rd(a.hours),a.months=Rd(a.months),a.years=Rd(a.years),this}function mc(a,b,c,d){var e=Va(b,c);return a._milliseconds+=d*e._milliseconds,a._days+=d*e._days,a._months+=d*e._months,a._bubble()}function nc(a,b){return mc(this,a,b,1)}function oc(a,b){return mc(this,a,b,-1)}function pc(){var a,b,c,d=this._milliseconds,e=this._days,f=this._months,g=this._data,h=0;return g.milliseconds=d%1e3,a=fb(d/1e3),g.seconds=a%60,b=fb(a/60),g.minutes=b%60,c=fb(b/60),g.hours=c%24,e+=fb(c/24),h=fb(qc(e)),e-=fb(rc(h)),f+=fb(e/30),e%=30,h+=fb(f/12),f%=12,g.days=e,g.months=f,g.years=h,this}function qc(a){return 400*a/146097}function rc(a){return 146097*a/400}function sc(a){var b,c,d=this._milliseconds;if(a=z(a),"month"===a||"year"===a)return b=this._days+d/864e5,c=this._months+12*qc(b),"month"===a?c:c/12;switch(b=this._days+Math.round(rc(this._months/12)),a){case"week":return b/7+d/6048e5;case"day":return b+d/864e5;case"hour":return 24*b+d/36e5;case"minute":return 1440*b+d/6e4;case"second":return 86400*b+d/1e3;case"millisecond":return Math.floor(864e5*b)+d;default:throw new Error("Unknown unit "+a)}}function tc(){return this._milliseconds+864e5*this._days+this._months%12*2592e6+31536e6*p(this._months/12)}function uc(a){return function(){return this.as(a)}}function vc(a){return a=z(a),this[a+"s"]()}function wc(a){return function(){return this._data[a]}}function xc(){return fb(this.days()/7)}function yc(a,b,c,d,e){return e.relativeTime(b||1,!!c,a,d)}function zc(a,b,c){var d=Va(a).abs(),e=fe(d.as("s")),f=fe(d.as("m")),g=fe(d.as("h")),h=fe(d.as("d")),i=fe(d.as("M")),j=fe(d.as("y")),k=e<ge.s&&["s",e]||1===f&&["m"]||f<ge.m&&["mm",f]||1===g&&["h"]||g<ge.h&&["hh",g]||1===h&&["d"]||h<ge.d&&["dd",h]||1===i&&["M"]||i<ge.M&&["MM",i]||1===j&&["y"]||["yy",j];return k[2]=b,k[3]=+a>0,k[4]=c,yc.apply(null,k)}function Ac(a,b){return void 0===ge[a]?!1:void 0===b?ge[a]:(ge[a]=b,!0)}function Bc(a){var b=this.localeData(),c=zc(this,!a,b);return a&&(c=b.pastFuture(+this,c)),b.postformat(c)}function Cc(){var a=he(this.years()),b=he(this.months()),c=he(this.days()),d=he(this.hours()),e=he(this.minutes()),f=he(this.seconds()+this.milliseconds()/1e3),g=this.asSeconds();return g?(0>g?"-":"")+"P"+(a?a+"Y":"")+(b?b+"M":"")+(c?c+"D":"")+(d||e||f?"T":"")+(d?d+"H":"")+(e?e+"M":"")+(f?f+"S":""):"P0D"}var Dc,Ec,Fc=a.momentProperties=[],Gc=!1,Hc={},Ic={},Jc=/(\[[^\[]*\])|(\\)?(Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|Q|YYYYYY|YYYYY|YYYY|YY|gg(ggg?)?|GG(GGG?)?|e|E|a|A|hh?|HH?|mm?|ss?|S{1,4}|x|X|zz?|ZZ?|.)/g,Kc=/(\[[^\[]*\])|(\\)?(LTS|LT|LL?L?L?|l{1,4})/g,Lc={},Mc={},Nc=/\d/,Oc=/\d\d/,Pc=/\d{3}/,Qc=/\d{4}/,Rc=/[+-]?\d{6}/,Sc=/\d\d?/,Tc=/\d{1,3}/,Uc=/\d{1,4}/,Vc=/[+-]?\d{1,6}/,Wc=/\d+/,Xc=/[+-]?\d+/,Yc=/Z|[+-]\d\d:?\d\d/gi,Zc=/[+-]?\d+(\.\d{1,3})?/,$c=/[0-9]*['a-z\u00A0-\u05FF\u0700-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+|[\u0600-\u06FF\/]+(\s*?[\u0600-\u06FF]+){1,2}/i,_c={},ad={},bd=0,cd=1,dd=2,ed=3,fd=4,gd=5,hd=6;G("M",["MM",2],"Mo",function(){return this.month()+1}),G("MMM",0,0,function(a){return this.localeData().monthsShort(this,a)}),G("MMMM",0,0,function(a){return this.localeData().months(this,a)}),y("month","M"),L("M",Sc),L("MM",Sc,Oc),L("MMM",$c),L("MMMM",$c),O(["M","MM"],function(a,b){b[cd]=p(a)-1}),O(["MMM","MMMM"],function(a,b,c,d){var e=c._locale.monthsParse(a,d,c._strict);null!=e?b[cd]=e:j(c).invalidMonth=a});var id="January_February_March_April_May_June_July_August_September_October_November_December".split("_"),jd="Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_"),kd={};a.suppressDeprecationWarnings=!1;var ld=/^\s*(?:[+-]\d{6}|\d{4})-(?:(\d\d-\d\d)|(W\d\d$)|(W\d\d-\d)|(\d\d\d))((T| )(\d\d(:\d\d(:\d\d(\.\d+)?)?)?)?([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?$/,md=[["YYYYYY-MM-DD",/[+-]\d{6}-\d{2}-\d{2}/],["YYYY-MM-DD",/\d{4}-\d{2}-\d{2}/],["GGGG-[W]WW-E",/\d{4}-W\d{2}-\d/],["GGGG-[W]WW",/\d{4}-W\d{2}/],["YYYY-DDD",/\d{4}-\d{3}/]],nd=[["HH:mm:ss.SSSS",/(T| )\d\d:\d\d:\d\d\.\d+/],["HH:mm:ss",/(T| )\d\d:\d\d:\d\d/],["HH:mm",/(T| )\d\d:\d\d/],["HH",/(T| )\d\d/]],od=/^\/?Date\((\-?\d+)/i;a.createFromInputFallback=$("moment construction falls back to js Date. This is discouraged and will be removed in upcoming major release. Please refer to https://github.com/moment/moment/issues/1407 for more info.",function(a){a._d=new Date(a._i+(a._useUTC?" UTC":""))}),G(0,["YY",2],0,function(){return this.year()%100}),G(0,["YYYY",4],0,"year"),G(0,["YYYYY",5],0,"year"),G(0,["YYYYYY",6,!0],0,"year"),y("year","y"),L("Y",Xc),L("YY",Sc,Oc),L("YYYY",Uc,Qc),L("YYYYY",Vc,Rc),L("YYYYYY",Vc,Rc),O(["YYYY","YYYYY","YYYYYY"],bd),O("YY",function(b,c){c[bd]=a.parseTwoDigitYear(b)}),a.parseTwoDigitYear=function(a){return p(a)+(p(a)>68?1900:2e3)};var pd=B("FullYear",!1);G("w",["ww",2],"wo","week"),G("W",["WW",2],"Wo","isoWeek"),y("week","w"),y("isoWeek","W"),L("w",Sc),L("ww",Sc,Oc),L("W",Sc),L("WW",Sc,Oc),P(["w","ww","W","WW"],function(a,b,c,d){b[d.substr(0,1)]=p(a)});var qd={dow:0,doy:6};G("DDD",["DDDD",3],"DDDo","dayOfYear"),y("dayOfYear","DDD"),L("DDD",Tc),L("DDDD",Pc),O(["DDD","DDDD"],function(a,b,c){c._dayOfYear=p(a)}),a.ISO_8601=function(){};var rd=$("moment().min is deprecated, use moment.min instead. https://github.com/moment/moment/issues/1548",function(){var a=Aa.apply(null,arguments);return this>a?this:a}),sd=$("moment().max is deprecated, use moment.max instead. https://github.com/moment/moment/issues/1548",function(){var a=Aa.apply(null,arguments);return a>this?this:a});Ga("Z",":"),Ga("ZZ",""),L("Z",Yc),L("ZZ",Yc),O(["Z","ZZ"],function(a,b,c){c._useUTC=!0,c._tzm=Ha(a)});var td=/([\+\-]|\d\d)/gi;a.updateOffset=function(){};var ud=/(\-)?(?:(\d*)\.)?(\d+)\:(\d+)(?:\:(\d+)\.?(\d{3})?)?/,vd=/^(-)?P(?:(?:([0-9,.]*)Y)?(?:([0-9,.]*)M)?(?:([0-9,.]*)D)?(?:T(?:([0-9,.]*)H)?(?:([0-9,.]*)M)?(?:([0-9,.]*)S)?)?|([0-9,.]*)W)$/;Va.fn=Ea.prototype;var wd=Za(1,"add"),xd=Za(-1,"subtract");a.defaultFormat="YYYY-MM-DDTHH:mm:ssZ";var yd=$("moment().lang() is deprecated. Instead, use moment().localeData() to get the language configuration. Use moment().locale() to change languages.",function(a){return void 0===a?this.localeData():this.locale(a)});G(0,["gg",2],0,function(){return this.weekYear()%100}),G(0,["GG",2],0,function(){return this.isoWeekYear()%100}),Ab("gggg","weekYear"),Ab("ggggg","weekYear"),Ab("GGGG","isoWeekYear"),Ab("GGGGG","isoWeekYear"),y("weekYear","gg"),y("isoWeekYear","GG"),L("G",Xc),L("g",Xc),L("GG",Sc,Oc),L("gg",Sc,Oc),L("GGGG",Uc,Qc),L("gggg",Uc,Qc),L("GGGGG",Vc,Rc),L("ggggg",Vc,Rc),P(["gggg","ggggg","GGGG","GGGGG"],function(a,b,c,d){b[d.substr(0,2)]=p(a)}),P(["gg","GG"],function(b,c,d,e){c[e]=a.parseTwoDigitYear(b)}),G("Q",0,0,"quarter"),y("quarter","Q"),L("Q",Nc),O("Q",function(a,b){b[cd]=3*(p(a)-1)}),G("D",["DD",2],"Do","date"),y("date","D"),L("D",Sc),L("DD",Sc,Oc),L("Do",function(a,b){return a?b._ordinalParse:b._ordinalParseLenient}),O(["D","DD"],dd),O("Do",function(a,b){b[dd]=p(a.match(Sc)[0],10)});var zd=B("Date",!0);G("d",0,"do","day"),G("dd",0,0,function(a){return this.localeData().weekdaysMin(this,a)}),G("ddd",0,0,function(a){return this.localeData().weekdaysShort(this,a)}),G("dddd",0,0,function(a){return this.localeData().weekdays(this,a)}),G("e",0,0,"weekday"),G("E",0,0,"isoWeekday"),y("day","d"),y("weekday","e"),y("isoWeekday","E"),L("d",Sc),L("e",Sc),L("E",Sc),L("dd",$c),L("ddd",$c),L("dddd",$c),P(["dd","ddd","dddd"],function(a,b,c){var d=c._locale.weekdaysParse(a);null!=d?b.d=d:j(c).invalidWeekday=a}),P(["d","e","E"],function(a,b,c,d){b[d]=p(a)});var Ad="Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),Bd="Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_"),Cd="Su_Mo_Tu_We_Th_Fr_Sa".split("_");G("H",["HH",2],0,"hour"),G("h",["hh",2],0,function(){return this.hours()%12||12}),Pb("a",!0),Pb("A",!1),y("hour","h"),L("a",Qb),L("A",Qb),L("H",Sc),L("h",Sc),L("HH",Sc,Oc),L("hh",Sc,Oc),O(["H","HH"],ed),O(["a","A"],function(a,b,c){c._isPm=c._locale.isPM(a),c._meridiem=a}),O(["h","hh"],function(a,b,c){b[ed]=p(a),j(c).bigHour=!0});var Dd=/[ap]\.?m?\.?/i,Ed=B("Hours",!0);G("m",["mm",2],0,"minute"),y("minute","m"),L("m",Sc),L("mm",Sc,Oc),O(["m","mm"],fd);var Fd=B("Minutes",!1);G("s",["ss",2],0,"second"),y("second","s"),L("s",Sc),L("ss",Sc,Oc),O(["s","ss"],gd);var Gd=B("Seconds",!1);G("S",0,0,function(){return~~(this.millisecond()/100)}),G(0,["SS",2],0,function(){return~~(this.millisecond()/10)}),Tb("SSS"),Tb("SSSS"),y("millisecond","ms"),L("S",Tc,Nc),L("SS",Tc,Oc),L("SSS",Tc,Pc),L("SSSS",Wc),O(["S","SS","SSS","SSSS"],function(a,b){b[hd]=p(1e3*("0."+a))});var Hd=B("Milliseconds",!1);G("z",0,0,"zoneAbbr"),G("zz",0,0,"zoneName");var Id=n.prototype;Id.add=wd,Id.calendar=_a,Id.clone=ab,Id.diff=gb,Id.endOf=sb,Id.format=kb,Id.from=lb,Id.fromNow=mb,Id.to=nb,Id.toNow=ob,Id.get=E,Id.invalidAt=zb,Id.isAfter=bb,Id.isBefore=cb,Id.isBetween=db,Id.isSame=eb,Id.isValid=xb,Id.lang=yd,Id.locale=pb,Id.localeData=qb,Id.max=sd,Id.min=rd,Id.parsingFlags=yb,Id.set=E,Id.startOf=rb,Id.subtract=xd,Id.toArray=wb,Id.toDate=vb,Id.toISOString=jb,Id.toJSON=jb,Id.toString=ib,Id.unix=ub,Id.valueOf=tb,Id.year=pd,Id.isLeapYear=ga,Id.weekYear=Cb,Id.isoWeekYear=Db,Id.quarter=Id.quarters=Gb,Id.month=W,Id.daysInMonth=X,Id.week=Id.weeks=la,Id.isoWeek=Id.isoWeeks=ma,Id.weeksInYear=Fb,Id.isoWeeksInYear=Eb,Id.date=zd,Id.day=Id.days=Mb,Id.weekday=Nb,Id.isoWeekday=Ob,Id.dayOfYear=oa,Id.hour=Id.hours=Ed,Id.minute=Id.minutes=Fd,Id.second=Id.seconds=Gd,Id.millisecond=Id.milliseconds=Hd,Id.utcOffset=Ka,Id.utc=Ma,Id.local=Na,Id.parseZone=Oa,Id.hasAlignedHourOffset=Pa,Id.isDST=Qa,Id.isDSTShifted=Ra,Id.isLocal=Sa,Id.isUtcOffset=Ta,Id.isUtc=Ua,Id.isUTC=Ua,Id.zoneAbbr=Ub,Id.zoneName=Vb,Id.dates=$("dates accessor is deprecated. Use date instead.",zd),Id.months=$("months accessor is deprecated. Use month instead",W),Id.years=$("years accessor is deprecated. Use year instead",pd),Id.zone=$("moment().zone is deprecated, use moment().utcOffset instead. https://github.com/moment/moment/issues/1779",La);var Jd=Id,Kd={sameDay:"[Today at] LT",nextDay:"[Tomorrow at] LT",nextWeek:"dddd [at] LT",lastDay:"[Yesterday at] LT",lastWeek:"[Last] dddd [at] LT",sameElse:"L"},Ld={LTS:"h:mm:ss A",LT:"h:mm A",L:"MM/DD/YYYY",LL:"MMMM D, YYYY",LLL:"MMMM D, YYYY LT",LLLL:"dddd, MMMM D, YYYY LT"},Md="Invalid date",Nd="%d",Od=/\d{1,2}/,Pd={future:"in %s",past:"%s ago",s:"a few seconds",m:"a minute",mm:"%d minutes",h:"an hour",
hh:"%d hours",d:"a day",dd:"%d days",M:"a month",MM:"%d months",y:"a year",yy:"%d years"},Qd=r.prototype;Qd._calendar=Kd,Qd.calendar=Yb,Qd._longDateFormat=Ld,Qd.longDateFormat=Zb,Qd._invalidDate=Md,Qd.invalidDate=$b,Qd._ordinal=Nd,Qd.ordinal=_b,Qd._ordinalParse=Od,Qd.preparse=ac,Qd.postformat=ac,Qd._relativeTime=Pd,Qd.relativeTime=bc,Qd.pastFuture=cc,Qd.set=dc,Qd.months=S,Qd._months=id,Qd.monthsShort=T,Qd._monthsShort=jd,Qd.monthsParse=U,Qd.week=ia,Qd._week=qd,Qd.firstDayOfYear=ka,Qd.firstDayOfWeek=ja,Qd.weekdays=Ib,Qd._weekdays=Ad,Qd.weekdaysMin=Kb,Qd._weekdaysMin=Cd,Qd.weekdaysShort=Jb,Qd._weekdaysShort=Bd,Qd.weekdaysParse=Lb,Qd.isPM=Rb,Qd._meridiemParse=Dd,Qd.meridiem=Sb,v("en",{ordinalParse:/\d{1,2}(th|st|nd|rd)/,ordinal:function(a){var b=a%10,c=1===p(a%100/10)?"th":1===b?"st":2===b?"nd":3===b?"rd":"th";return a+c}}),a.lang=$("moment.lang is deprecated. Use moment.locale instead.",v),a.langData=$("moment.langData is deprecated. Use moment.localeData instead.",x);var Rd=Math.abs,Sd=uc("ms"),Td=uc("s"),Ud=uc("m"),Vd=uc("h"),Wd=uc("d"),Xd=uc("w"),Yd=uc("M"),Zd=uc("y"),$d=wc("milliseconds"),_d=wc("seconds"),ae=wc("minutes"),be=wc("hours"),ce=wc("days"),de=wc("months"),ee=wc("years"),fe=Math.round,ge={s:45,m:45,h:22,d:26,M:11},he=Math.abs,ie=Ea.prototype;ie.abs=lc,ie.add=nc,ie.subtract=oc,ie.as=sc,ie.asMilliseconds=Sd,ie.asSeconds=Td,ie.asMinutes=Ud,ie.asHours=Vd,ie.asDays=Wd,ie.asWeeks=Xd,ie.asMonths=Yd,ie.asYears=Zd,ie.valueOf=tc,ie._bubble=pc,ie.get=vc,ie.milliseconds=$d,ie.seconds=_d,ie.minutes=ae,ie.hours=be,ie.days=ce,ie.weeks=xc,ie.months=de,ie.years=ee,ie.humanize=Bc,ie.toISOString=Cc,ie.toString=Cc,ie.toJSON=Cc,ie.locale=pb,ie.localeData=qb,ie.toIsoString=$("toIsoString() is deprecated. Please use toISOString() instead (notice the capitals)",Cc),ie.lang=yd,G("X",0,0,"unix"),G("x",0,0,"valueOf"),L("x",Xc),L("X",Zc),O("X",function(a,b,c){c._d=new Date(1e3*parseFloat(a,10))}),O("x",function(a,b,c){c._d=new Date(p(a))}),a.version="2.10.3",b(Aa),a.fn=Jd,a.min=Ca,a.max=Da,a.utc=h,a.unix=Wb,a.months=gc,a.isDate=d,a.locale=v,a.invalid=l,a.duration=Va,a.isMoment=o,a.weekdays=ic,a.parseZone=Xb,a.localeData=x,a.isDuration=Fa,a.monthsShort=hc,a.weekdaysMin=kc,a.defineLocale=w,a.weekdaysShort=jc,a.normalizeUnits=z,a.relativeTimeThreshold=Ac;var je=a;return je});;
/// <reference path="../../jquery-1.8.3-vsdoc.js" />
/// <reference path="../../moment.js" />


// 2012-9-20
var Dom = {
    PickupStore: $("#getStore"),
    PickupStoreId: $("#getStoreId"),
    PickupDate: $("#J_date_1"),
    PickupTime: $("#hdnPickupHour"),
    PickupMinute: $("#hdnPickUpMinute"),
    ReturnDate: $("#J_date_2"),
    ReturnTime: $("#hdnReturnHour"),
    ReturnMinute: $("#hdnReturnMinute"),
    CarTypeLoading: $("#imgLoad"),
    CarTypeList: $("#carTypeList"),
    btnSubmit: $('#btnSubmit'),
    IsQueue: $("#chkIsQueue"),
    SortBy: $('.field-orderby')
};
var Filter = {
    selectBrands: [],
    selectPriceLevel: "",
    selectGear: "",
    selectType: "",
    selectSeat: "",
    sortBy: "",
    setPriceLevel: function (p) {
        /// <summary>
        /// 设置当前选中价格区间
        /// </summary>
        /// <param name="p" type="type"></param>
        var self = this;
        self.selectPriceLevel = p;
    },
    setGear: function (gear) {
        /// <summary>
        /// 设置当前选中排挡类型
        /// </summary>
        /// <param name="gear" type="type"></param>
        var self = this;
        self.selectGear = gear;
    },
    setType: function (type) {
        /// <summary>
        /// 设置当前选中车辆类型
        /// </summary>
        /// <param name="type" type="type"></param>
        var self = this;
        self.selectType = type;
    },
    setSeat: function (seat) {
        /// <summary>
        /// 设置当前选中座位数
        /// </summary>
        /// <param name="seat" type="type"></param>
        var self = this;
        self.selectSeat = seat;
    },
    setSortBy: function (sort) {
        /// <summary>
        /// 设置排序
        /// </summary>
        /// <param name="sort" type="type"></param>
        var self = this;
        self.sortBy = sort;
    },
    addBrands: function (brand) {
        /// <summary>
        /// 新增一个筛选的品牌
        /// </summary>
        /// <param name="brand" type="type"></param>
        var self = this;
        if (!brand) {
            return;
        }
        if ($.inArray(brand, self.selectBrands < 0)) {
            self.selectBrands.push(brand);
        }
    },
    removeBrand: function (brand) {
        /// <summary>
        /// 移除一个筛选的品牌
        /// </summary>
        /// <param name="brand" type="type"></param>
        var self = this;
        if (!brand || !self.selectBrands || self.selectBrands.length < 1) {
            return;
        }
        for (var i = self.selectBrands.length; i >= 0; i--) {
            if (self.selectBrands[i] === brand) {
                self.selectBrands.splice(i, 1);
            }
        }
    },
    clearBrands: function () {
        /// <summary>
        /// 清空已选择的品牌
        /// </summary>
        var self = this;
        self.selectBrands = [];
    },
    getBrands: function () {
        /// <summary>
        /// 获取已选中品牌字符串
        /// </summary>
        /// <returns type=""></returns>
        var self = this;
        var text = self.selectBrands.join('|');
        return text;
    },
    //是否企业协议价
    IsEnterprise: $("#purPromptTxt").text().indexOf("公司用途") !== -1
};


//ChengFeng 2014.06.20
var carType = {
    isCache: true,
    isLoading: true,
    ResData: {
        CarTypeAll: {},
        Categrate: {}
    },
    IsSubmit: false,
    ReqCarTypeData: function (url, para, target, type, heades, callback) {
        var param = para;
        if (typeof (para) === 'object') {
            param = $.param(para);
        }
        var jsonData = eHi.toJSONString($("form").serializeJson("json")) + eHi.toJSONString(para);
        var self = this;
        if (type !="Categrate" && self.isCache && jsonData in self.ResData[type]) {
            callback(self.ResData[type][jsonData]);
            return false;
        }
        $.ajax({
            type: "post",
            url: url,
            data: param,
            headers: heades,
            contentType: "application/json",
            timeout: 15000, //超时时间设置，单位毫秒
            async: true,
            beforeSend: function () {
                if (carType.isLoading) {
                    $("#loading").removeClass("hidden");
                    $("#btnSubmit").addClass("hidden");
                }
            },
            success: function (data, status, xhr) {
                self.ResData[type][jsonData] = data;
                callback(data, status, xhr);
                $("#loading").addClass("hidden");
                $("#btnSubmit").removeClass("hidden");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                Dom.CarTypeLoading.hide();
                $("#nocar").show();
                $("#loading").addClass("hidden");
                $("#btnSubmit").removeClass("hidden");
            },
            complete: function (XMLHttpRequest, status) { //请求完成后最终执行参数
                if (status == 'timeout') {//超时,status还有success,error等值的情况
                    Dom.CarTypeLoading.hide();
                    $("#nocar").show();
                }
                $("#loading").addClass("hidden");
                $("#btnSubmit").removeClass("hidden");
            }
        });
        return false;
    }
};

var cookie = {
    setCookie: function (name, value, option) {
        var str = name + '=' + value;
        if (option) {
            if (option.expireHours) {
                var d = new Date();
                d.setTime(d.getTime() + option.expireHours * 3600 * 1000);
                str += '; expires=' + d.toGMTString();
            }
        }
        document.cookie = str + ';path=/';
    },
    getCookie: function (name) {
        var arr = document.cookie.split('; ');
        if (arr.length == 0) return '';
        for (var i = 0; i < arr.length; i++) {
            tmp = arr[i].split('=');
            if (tmp[0] == name) return unescape(tmp[1]);
        }
        return '';
    },
    delCookie: function (name) {
        this.setCookie(name, '', { expireHours: -1 });
    }
};


function parseDate(dateString) {
    /// <summary>
    /// 转换字符串"yyyy-MM-dd"为Date类型
    /// </summary>
    /// <param name="dateString" type="type"></param>
    /// <returns type=""></returns>
    var parts = dateString.split('-');
    var date = new Date();
    date.setFullYear(parts[0], parts[1] - 1, parts[2]);
    date.setHours(0, 0, 0, 0);
    return date;

}

function beforeSubmit() {
    return true;
}
function afterSubmit() {
    carType.isLoading = true;
    refreshBookingBoxTips();
    carType.ResData.Categrate.length = 0;
    queryCars(Url.SelectCarTypes,"CarTypeAll");
    initMap(); /// 依赖store.baidu.map.js文件

}

function isHoliday() {
    var pickDate = getDate($("#J_date_1").val());
    var dropDate = getDate($("#J_date_2").val());
    var startDate = getDate("2016-10-01");
    var endDate = getDate("2016-10-07");
    if (!(dropDate < startDate || pickDate > endDate)) {
        return true;
    }
    return false;
}
var getDate = function (dateStr) {
    return new Date(Date.parse(dateStr.replace(/-/g, "/")));//.getTime();
}


function getPickupTimeStr() {
    /// <summary>
    /// 获取取车时间字符串
    /// </summary>
    /// <returns type=""></returns>
    var pickupDate = Dom.PickupDate.val();
    var pickupTime = Dom.PickupTime.val();
    var pickupMinute = Dom.PickupMinute.val();
    var pickupDateTime = new Date(pickupDate);
    pickupDateTime.setHours(pickupTime);
    pickupDateTime.setMinutes(pickupMinute);
    return pickupDateTime;
}

function getReturnTimeStr() {
    /// <summary>
    /// 获取还车时间字符串
    /// </summary>
    /// <returns type=""></returns>
    var returnDate = Dom.ReturnDate.val();
    var returnTime = Dom.ReturnTime.val();
    var returnMinute = Dom.ReturnMinute.val();
    var returnDateTime = new Date(returnDate);
    returnDateTime.setHours(returnTime);
    returnDateTime.setMinutes(returnMinute);
    return returnDateTime;
}

function getRentDays(renthours) {
    /// <summary>
    /// 根据租车小时数计算天数
    /// </summary>
    /// <param name="renthours" type="type"></param>
    /// <returns type=""></returns>
    var days = Math.floor(renthours / 24);
    var remainHours = renthours % 24;
    if (remainHours > 0) {
        var addDays = remainHours > 6 ? 1 : 0.5;
        days += addDays;
    }
    return days;
}
/*function refreshBookingBoxTips() {
    if (!$prompt.hasClass("purpose-prompt")) {
        var pickupTime = getPickupTimeStr();
        var returnTime = getReturnTimeStr();
        var pickupMoment = moment(pickupTime);
        var returnMoment = moment(returnTime);
        var rentHours = returnMoment.diff(pickupMoment, "hours");
        var rentDays = getRentDays(rentHours);
        $prompt.html("* 当前选定租期：<span>" + rentDays + "</span>天");
        //if (rentDays < 3) {
        //    //租期小于2天不能打包
        //    $prompt.html(
        //        "* 当前选定租期：" + rentDays + "天，还差<span id='lease-lack'>" + (3 - rentDays) + "</span>天就可享受3天打包套餐价！");
        //} else {
        //    $prompt.html("* 当前选定租期:" + rentDays + "天");
        //}
    }
}*/

function queryCars(url,cacheName) {
    /// <summary>
    /// 刷新车型列表
    /// </summary>
    // 长租频道切换短租频道查询车型控制
    if ($(".batch-time").is(":hidden")) {
        return;
    }
    // 清空车型
    $('.wraplist').remove();
    // 隐藏noCar
    $("#nocar").hide();
    // 显示Loading
    Dom.CarTypeLoading.show();
    var data = {
        PriceLevel: Filter.selectPriceLevel,
        Brands: Filter.getBrands(),
        Gear: Filter.selectGear,
        Type: Filter.selectType,
        Seat: Filter.selectSeat,
        SortBy: Filter.sortBy,
        IsEnterprise: Filter.IsEnterprise
    };
    carType.ReqCarTypeData(url,
        eHi.toJSONString(data),
        Dom.CarTypeList,
        cacheName,
        { "__RequestVerificationToken": $("input[name='__RequestVerificationToken']").val() },
        function (result) {
            Dom.CarTypeList.html("").html(result);
            Dom.CarTypeLoading.hide();
            UpadateCarTypeCount();
            $(".det-carlist img").each(function (index, element) { //遍历所有的li
                if (index < 5) {
                    var obj = $(element);
                    obj.attr("src", obj.data("original"));
                }
            });
            $("img.lazy").lazyload({
                effect: "fadeIn",
                threshold: 154
            });
            refreshtoken("#token");
        });
}

/*// 加载车型
function LoadCarType(forceRefresh) {
    // 长租频道切换短租频道查询车型控制
    if ($(".batch-time").is(":hidden")) {
        return;
    }
    if (!isHoliday() && $(".batch-time").html() && $("#PickupCity").val() !== $("#ReturnCity").val()) {
        alert("打包订单不支持异地还车");
        return;
    }

    var type = $("#type .on").data("value");

    var priceLevel = $(".pricelist a.on").data("value");
    //var brands = $(".brandlist a.on").data("value");
    var gear = $(".gearlist a.on").data("value");
    var seat = $(".seatlist a.on").data("value");
    var brands = GetBarnds();
    var isQueue = Dom.IsQueue.text();
    var sortBy = Dom.SortBy.attr("sortby");
    // 清空车型
    $('.wraplist').remove();
    // 隐藏noCar
    $("#nocar").hide();
    // 显示Loading
    Dom.CarTypeLoading.show();
    var data = "PriceLevel=" + priceLevel + "&Brands=" + brands + "&Gear=" + gear + "&Type=" + type + "&seat=" + seat
        + "&IsQueue=" + isQueue
        + "&SortBy=" + sortBy + "&v=" + new Date().getMilliseconds();

    carType.ReqCarTypeData(Url.SelectCarTypes,
        data,
        Dom.CarTypeList,
        "CarTypeAll",
        { "__RequestVerificationToken": $("input[name='__RequestVerificationToken']").val() },
        function (resData) {
            Dom.CarTypeList.html("").html(resData);
            var totalSize = $(".wraplist").attr("totalSize");
            if (totalSize > 0) {
                UpadateCarTypeCount();
                Dom.CarTypeLoading.hide();
            } else {
                Dom.CarTypeList.html("");
                Dom.CarTypeLoading.hide();
                $('#nocar').show();

            }
        },
        forceRefresh);
}*/

/*var initCartype = {
    BindEnterpriseTip: function () {
        BookingAjax.ReqAjax(BookingAjax.Url.ShowEnterpriseTip,
            "",
            "Get",
            "EnterpriseTips",
            "Html",
            function (data) {
                $("#companyPrompt").html(data);
            });
    }
};*/
/*initCartype.BindEnterpriseTip();*/

function UpadateCarTypeCount() {
    /// <summary>
    /// 更新可用车型列表数量及“无车”样式
    /// </summary>
    /// <returns type=""></returns>
    var totalSize = $(".wraplist").data("count");
    var nostockcount = $(".wraplist").data("nostockcount");
    if (!totalSize) {
        $("#carTypeCount").html(0);
        Dom.CarTypeList.html("");
    } else {
        $("#carTypeCount").html(totalSize);
    }
    if (totalSize > 0 || nostockcount > 0) {
        $("#nocar").hide();
    } else {
        $('#nocar').show();
    }
    return totalSize;
}

$(function () {
    var greenLimitMsg = "电动车仅限同门店取还车!";
    var vipLimitMsg = "尊享车租期最少为";
    var vipTimeLimitMsg = "尊享车取车时间在8:00到20:00之间";
    var vipCityLimitMsg = "尊享车不支持异地还车";
    var vipUserLimitMsg = "尊享车只允许尊享会员预订";

    $.ajaxSetup({
        cache: false
    });
    if (window.isChannelBooking==="True") {
        window.myshowBox('', '', '560', '380', 'false', 'window-scroll');
        $(".div-myshowbox").html($('#rentCarPopup').html());
    }
    //初始化加载车型




   /* // 价格过滤
    $(".pricelist").on("click", "a", function () {
        var $this = $(this);
        Filter.setPriceLevel($this.data("value"));
        $this.addClass("on").siblings().removeClass('on');
        carType.isLoading = false;
        queryCars(Url.Filter,"CarTypeAll");
    });

    // 类型过滤
    $(".cartypelist").on("click", "a", function () {
        var $this = $(this);
        Filter.setType($this.data("value"));
        $this.addClass("on").siblings().removeClass('on');
        queryCars(Url.Filter,"Categrate");
    });

    // 排档过滤
    $(".gearlist").on("click", "a", function () {
        var $this = $(this);
        Filter.setGear($this.data("value"));
        $this.addClass("on").siblings().removeClass('on');
        carType.isLoading = false;
        queryCars(Url.Filter,"CarTypeAll");
    });

    //座位过滤
    $(".seatlist").on("click", "a", function () {
        var $this = $(this);
        Filter.setSeat($this.data("value"));
        $this.addClass("on").siblings().removeClass('on');
        carType.isLoading = false;
        queryCars(Url.Filter,"CarTypeAll");
    });


    // 排序
    $('.field-orderby  a').click(function () {
        var currClass = $(this).attr('class');
        var pClass = $(this).parent().attr("class");

        $('.field-orderby a').removeClass();
        $('.field-orderby a').addClass("order-def");

        if (pClass != "sort-default") {
            $('.field-orderby .sort-default a').removeClass();
            $(this).removeClass();

            if (currClass == "order-desc") {
                $(this).addClass("order-asc");
                if (pClass == "sort-price") {
                    $(this).attr("value", "Rent");
                }
                if (pClass == "sort-emission") {
                    $(this).attr("value", "OutputVolume");
                }
            } else {
                $(this).addClass("order-desc");
                if (pClass == "sort-price") {
                    $(this).attr("value", "RentDesc");
                }
                if (pClass == "sort-emission") {
                    $(this).attr("value", "OutputVolumeDesc");
                }
            }
        }
        carType.isLoading = false;
        Filter.setSortBy($(this).attr("value"));
        queryCars(Url.Filter,"CarTypeAll");
    });*/

    //短租预订按钮
    Dom.CarTypeList.on('click', '.btn-book', function () {
        var carid = $(this).data("cid");
        var dsid = $(this).data("smid");
        var priceType = $(this).data("priceType");
        var gid = $(this).data("gid");
        var ipcar = $(this).data("ipcar");
        var ishicar = $(this).data("ishicar");
        var price = $(this).data("price");
        var url = Url.Booking + "?carTypeId=" + carid + "&dependentStroeId=" + dsid + "&priceType=" + priceType + "&groupId=" + gid + "&isipcar=" + ipcar + "&isHiCarEnjoy=" + ishicar+"&price=" + price;
        window.location.href = url;
    });

    // 更换门店预订按钮
 /*   $(document).on('click', '.show-carlist .btn-book', function () {
        var carid = $(this).data("cid");
        var sid = $(this).data("sid");
        var gid = $(this).data("gid");
        var priceType = $(this).data("priceType");
        var ipcar = $(this).data("ipcar");
        var price = $(this).data("price");

    });*/

    // 长租频道预订套餐按钮
    $(document).on('click', ".batch-booking", function () {
        var msg = CheckSpecialCar($(this));

        if (msg !== "") {
            alert(msg);
            return;
        }

        var carid = $(this).data("cid");
        var sid = $(this).data("sid");
        var priceType = $(this).data("priceType");
        var gid = $(this).data("gid");
        var ipcar = $(this).data("ipcar");
        var url = Url.Booking + "?carTypeId=" + carid + "&dependentStroeId=" + sid + "&groupId=" + gid + "&isipcar=" + ipcar;
        if (priceType) {
            url = url + "&priceType=" + priceType;
        }
        window.location.href = url;
    });

    // 长租频道换门店预订按钮
    $(document).on('click', '.batch-change-store-book', function () {
        var msg = CheckSpecialCar($(this));

        if (msg !== "") {
            alert(msg);
            return;
        }

        var carid = $(this).data("cid");
        var sid = $(this).data("sid");
        var priceType = $(this).data("priceType");
        var ipcar = $(this).data("ipcar");
        var url = Url.Booking + "?carTypeId=" + carid + "&StoreId=" + sid + "&isipcar=" + ipcar;
        if (priceType) {
            url = url + "&priceType=" + priceType;
        }
        window.location.href = url;
    });

    //打包调整时间
    $(".modify-time").live("click", function () {
        carType.isCache = false;
        var returnDateTime = $(this).attr("returnDateTime");
        $.post(Url.BatchChangeTime, {
            "returnDateTime": returnDateTime
        }, function () {
            $("#J_date_2").val(returnDateTime);
            $("#biReturnDateTime").text(returnDateTime);
            //设置日历控件选中日期
            window.oDepCal.endDate = window.oBackCal.endDate = returnDateTime;
            window.oDepCal.setDateInfo(window.oDepCal.startDate);
            window.oBackCal.setDateInfo(returnDateTime);
                queryCars(Url.Filter,"CarTypeAll");
            carType.isCache = true;
        });
    });

    $(".carprice-new .drop a").live('click', function () {
        $(this).parent().hide().siblings("div").show();
        $(this).parent().parent().parent().parent().siblings("div").find("#batchPrepay").hide().prev().show();
    });

    // 排队
    Dom.CarTypeList.on("click", '.btn-queue', function () {
        var msg = CheckSpecialCar($(this));
        if (msg == vipUserLimitMsg) {
            ShowVipSubmitBox();
            return;
        }
        var carid = $(this).data("cid");
        var dsid = $(this).data("smid");
        if ($(this).hasClass("greenLimit")) {
            alert(greenLimitMsg);
            return;
        }

        window.location.href = Url.Queue + "?carTypeId=" + carid + "&dependentStroeId=" + dsid;
    });

    /*// 更换门店
    Dom.CarTypeList.on('click', '.btn-change-store,.batch-change', function () {
        window.myshowBox('', '', '800', '392', 'false', 'show-div-ghmd');
        $(".div-myshowbox").html('<p style="text-align:center; padding-top:180px">' +
            '<img style="vertical-align:middle;" src="../../../../Content/Images/Shared/loading.gif" alt="" />&nbsp&nbsp&nbsp&nbsp正在加载门店...</p>'
        );
        var carid = $(this).data("cid");
        var gid = $(this).data("gid");
        var name = $(this).data("name");
        $(".div-myshowbox").load(Url.ChangeStore, "carTypeId=" + carid + "&groupId=" + gid, function () {
            // 加载JS伪分页控件
            pagesizeLoad();
            $("#gname").text(name);
            $("#ctip").text(name + ",所有门店均已售罄。");
            // 门店列表双行显示
            $(".myshowbox .pagesize-list li:odd").addClass("bg-sp");
        });
    });*/

    // 调整时间
    Dom.CarTypeList.on('click', '.btn-change-time', function () {
        window.popTips();
        $("#windown-content").html("<div class=\"pupup-loading\"></div>");

        var carId = $(this).data("cid");
        $("#windown-content").load(Url.ChangeTime, "carTypeId=" + carId, function () {
            InitChangeTimeCalendar();
        });
    });

    // 调整时间预订按钮
    $("#simTestContent .btn-box").live('click', function () {
        if ($(".sel-active").attr("checked")) {
            $("#windownbg").remove();
            $("#windown-box").fadeOut("slow", function () { $(this).remove(); });

            var pickupDate = $("#ctpickDate").val();
            var pickupTime = $("#ctgetTime").val().replace("时", ":00");
            var returnDate = $("#ctreturnDate").val();
            var returnTime = $("#ctretTime").val().replace("时", ":00");
            carType.isCache = false;
            $.get(Url.SelfChangeTime, {
                "pickupDateTime": pickupDate + " " + pickupTime, "returnDateTime": returnDate + " " + returnTime
            }, function (result) {
                if (result === "success") {
                    $("#J_date_1").val(pickupDate);
                    $("#J_date_2").val(returnDate);
                    $("#biPickUpDateTime").text(pickupDate);
                    $("#biReturnDateTime").text(returnDate);
                    $("#getTime").val(pickupTime);
                    $("#retTime").val(returnTime);
                    $("#biPickUpTime").text(pickupTime);
                    $("#biReturnTime").text(returnTime);

                    //设置日历控件选中日期
                    window.oDepCal.startDate = window.oBackCal.startDate = pickupDate;
                    window.oDepCal.endDate = window.oBackCal.endDate = returnDate;
                    window.oDepCal.setDateInfo(window.oDepCal.startDate);
                    window.oBackCal.setDateInfo(window.oBackCal.endDate);

                    queryCars(Url.Filter,"CarTypeAll");
                    carType.isCache = true;
                } else {
                    alert("时间调整失败,请重试!");
                }

            });
        }
        else if ($(".sel-date-radio:checked").length > 0) {
            $("#windown-box,#windownbg").fadeOut();
            var pickDateTime = $(".sel-date-radio:checked").attr("pickupdatetime");
            var returnDateTime = $(".sel-date-radio:checked").attr("returndatetime");

            var pickupDate = pickDateTime.substring(0, 10);
            var returnDate = returnDateTime.substring(0, 10);
            var pickupTime = pickDateTime.substring(11, 16);
            var returnTime = returnDateTime.substring(11, 16);


            $.get(Url.SelfChangeTime, {
                "pickupDateTime": pickDateTime, "returnDateTime": returnDateTime
            }, function (result) {
                if (result === "success") {
                    $("#J_date_1").val(pickupDate);
                    $("#J_date_2").val(returnDate);
                    $("#biPickUpDateTime").text(pickupDate);
                    $("#biReturnDateTime").text(returnDate);
                    $("#getTime").val(pickupTime);
                    $("#retTime").val(returnTime);
                    $("#biPickUpTime").text(pickupTime);
                    $("#biReturnTime").text(returnTime);

                    //设置日历控件选中日期
                    window.oDepCal.startDate = window.oBackCal.startDate = pickupDate;
                    window.oDepCal.endDate = window.oBackCal.endDate = returnDate;
                    window.oDepCal.setDateInfo(window.oDepCal.startDate);
                    window.oBackCal.setDateInfo(window.oBackCal.endDate);

                    queryCars(Url.Filter,"CarTypeAll");
                    //LoadCarType(true);
                } else {
                    alert("时间调整失败,请重试!");
                }
            });
        } else {
            $("#windown-box,#windownbg").fadeOut();
            return false;
        }
    });

    // 切换选择时间
    $('.sel-date-radio').live('click', function () {
        $(this).parent("span").parent("div").addClass("on").siblings(".sel-date").removeClass("on");
        $(this).parent("span").parent("div").parent(".popup-body").find(".popup-sel-time").find("input").removeClass("date-active").attr("disabled", "disabled");
        $("#pickupdatetime").val($(this).attr("pickupdatetime"));
        $("#returndatetime").val($(this).attr("returndatetime"));
        $("#ctpickDate").attr("disabled", true);
        $("#ctreturnDate").attr("disabled", true);
    });
    $('.sel-active').live('click', function () {
        $(this).parent("span").parent("div").next(".popup-sel-time").find("input").addClass("date-active").removeAttr("disabled");
    });

    // 时间选择
    var ctimeSelectId = "";

    $("#ctgetTime, #ctretTime").live('click', function () {
        if (!$(this).hasClass("date-active")) return;
        ctimeSelectId = $(this).attr("id");
        window.Floating.IsShow("", this, "#ctimeselect");
        window.Floating.Source = $("#ctimeselect");
        var sid = $(this).attr("sid");
        sid = sid == "0" || $.trim(sid) == "" ? 3 : sid;
        var param = "storeId=" + sid + "&cityName=" + $("#PickupCity").val() + "&pickupDatetime=" + $("#ctpickDate").val() + "&ism=false";
        $("#ctimeselect").html("");
        $("#ctimeselect").load("/Order/Address/StoreOpeningTime", param);
    });

    $(document).delegate("#ctimeselect li", "mouseover mouseout", function (e) {
        if (e.type === "mouseover") {
            $(this).addClass("on");
        } else {
            $(this).removeClass("on");
        }
    });

    $("#ctimeselect  li").live("click", function () {
        var hour = $(this).text();
        var getStore = $.trim($("#ctgetTime").attr("sid"));
        var retStore = $.trim($("#ctretTime").attr("sid"));
        if (ctimeSelectId === "ctgetTime") {
            if (getStore === retStore)
                $("#ctgetTime, #ctretTime").attr("value", hour);
            else
                $("#ctgetTime").attr("value", hour);
        } else {
            $("#ctretTime").attr("value", hour);
        }
        window.Floating.Source.hide();
    });

    // 调整时间 hover 下拉
    $(".show-time .cld-showbox ul li").hover(
        function () {
            $(this).addClass("hover");
        }, function () {
            $(this).removeClass("hover");
        });

    // 激活
    $(".show-time .select-hour").live('click', function () {
        $(this).children(".cld-showbox").show();
    });

    // 弹出释放
    var showflag = false;
    $(".cld-showbox").hover(function () {
        showflag = true;
    }, function () {
        showflag = false;
    });

    $(document).mouseup(function (e) {
        e = window.e || e;
        var target = e.target || e.srcElement;
        if (!showflag && target != $(".cld-showbox")) {
            $(".cld-showbox").hide();
        }
    });

    $('.Btnsubmit span').live('mouseover', function () {
        $(this).addClass('shadow');
    });
    $('.Btnsubmit span').live('mouseout', function () {
        $(this).removeClass('shadow');
    });



    // 总租金&长租套餐
    Dom.CarTypeList.on('mouseenter', '.carprice>a', function () {
        $('.dayrent').hide();
        var pickDate = parseDate(Dom.PickupDate.val());
        var returnDate = parseDate(Dom.ReturnDate.val());

        var rentDays = (returnDate - pickDate) / 1000 / 3600 / 24 + 1;
        if (rentDays <= 28) {
            $(this).addClass('hover');
            $(this).siblings(".dayrent").show(SelectTwoWeek($(this)));
        }
    });
    Dom.CarTypeList.on('mouseleave', '.carprice>a', function () {
        $(this).removeClass('hover').siblings(".dayrent").hide();
    });

    $('.batchrentprice').live('mouseover', function () {
        $('.batchrent').hide();
        $(this).siblings(".batchrent").show(SelectBatchRents($(this)));
    });
    $('.batchrentprice').live('mouseout', function () {
        $(this).siblings(".batchrent").hide();
    });
    $('.festival-price').live('mouseover', function () {
        $('.festival-rent').hide();
        $(this).siblings(".festival-rent").show(SelectBatchRents($(this)));
    });
    $('.festival-price').live('mouseout', function () {
        $(this).siblings(".festival-rent").hide();
    });
    $('.dayrent, .batchrent, .festival-rent').live('mouseover', function () {
        $(this).show();
    });
    $('.dayrent, .batchrent, .festival-rent').live('mouseout', function () {
        $(this).hide();
    });

    //显示优惠信息
    Dom.CarTypeList.on("mouseover", "a.promotion", function () {
        var divString = $("#divpromotion").html(); //.get(0).outerHTML;
        $(this).parent().siblings(".promotionoverlay").html(divString).show();
    });
    //隐藏优惠信息
    Dom.CarTypeList.on("mouseout", "a.promotion", function () {
        $(this).parent().siblings(".promotionoverlay").hide();
    });

    // 查询车辆两周价格
    function SelectTwoWeek(obj) {
        var rent = obj.siblings(".dayrent").children(".showPrice-detail").children(".dayrent-list");
        var html = rent.children().html();
        if (html)
            return;
        obj.siblings(".dayrent").children(".showPrice-detail").children(".dayrent-list ul").remove();
        $(".dayrent .pageinfo-box").show();
        $.getJSON(Url.TwoWeekRents, {
            carTypeId: obj.attr("carTypeId")
        }, function (json) {
            pCalendar.refreshPriceBoard(json, rent[0], $(Dom.PickupDate).val(), $(Dom.ReturnDate).val());
            $(".dayrent .pageinfo-box").hide();
        });
    }

    // 查询车辆打包价格
    function SelectBatchRents(obj) {
        var rent = obj.siblings(".batchrent").children(".showPrice-detail").children(".batchrent-list");
        if (rent.children().html())
            return;
        obj.siblings(".batchrent").children(".showPrice-detail").children(".batchrent-list p, .batchrent-list div").remove();
        $(".batchrent .pageinfo-box").show();
        rent.load(Url.BatchRents, "carTypeId=" + obj.attr("carTypeId") + "&dependentStroeId=" + obj.attr("dsid"), function () {
            $(".batchrent .pageinfo-box").hide();
        });
    }
    var group = {
        id: 0
    }

    // 检查特殊车型限制
    function CheckSpecialCar(btn) {
        group.id = btn.data("gid");
        if (btn.hasClass("greenLimit")) {
            return greenLimitMsg;
        }

        if (btn.hasClass("vipLimit")) {
            return vipLimitMsg + btn.attr("viplimit") + "天!";
        }

        if (btn.hasClass("vipTimeLimit")) {
            return vipTimeLimitMsg;
        }

        if (btn.hasClass("vipCityLimit")) {
            return vipCityLimitMsg;
        }

        if (btn.hasClass("vipUserLimit")) {
            return vipUserLimitMsg;
        }

        return "";
    }

});



function InitChangeTimeCalendar() {
    var ctFromDateCtrlId = "ctpickDate";
    var ctToDateCtrlId = "ctreturnDate";
    var cttxtStartDate = $("#" + ctFromDateCtrlId).val();
    var cttxtEndDate = $("#" + ctToDateCtrlId).val();

    //出发时间实例    
    var octDepCal = new Calendar({
        id: "#" + ctFromDateCtrlId,
        //触发显示日历元素ID
        isPopup: !0,
        //弹出式日历
        isPrevBtn: !0,
        //显示上月按钮
        isNextBtn: !0,
        //显示下月按钮
        isCloseBtn: !0,
        //显示关闭按钮
        isHoliday: !0,
        //节假日特殊显示
        isHolidayTips: 0,
        //显示节假日1~3天/后1~3天信息
        isDateInfo: !0,
        //显示日期信息
        isMessage: !0,
        //有日历提示信息
        isCalStart: !0,
        //标记为开始时间
        dateInfoClass: "date-info-start",
        //开始时间icon样式
        range: {
            mindate: minDate,
            maxdate: "2020-12-31"
        },
        //限制范围（当天——2020-12-31）
        count: 2,
        //日历个数
        monthStep: 1,
        //切换上下月日历步长
        onSelectDate: ctfnSelectDate,
        //选择日期回调方法
        onClose: ctfnClose //关闭日历回调方法 
    });
    //返程时间实例
    var octBackCal = new Calendar({
        id: "#" + ctToDateCtrlId,
        //触发显示日历元素ID
        isPopup: !0,
        //弹出式日历
        isPrevBtn: !0,
        //显示上月按钮
        isNextBtn: !0,
        //显示下月按钮
        isCloseBtn: !0,
        //显示关闭按钮
        isHoliday: !0,
        //节假日特殊显示
        isHolidayTips: 0,
        //显示节假日1~3天/后1~3天信息
        isDateInfo: !0,
        //显示日期信息
        isMessage: !0,
        //有日历提示信息
        isCalEnd: !0,
        //标记为结束时间
        dateInfoClass: "date-info-end",
        //结束时间icon样式
        range: {
            mindate: cttxtStartDate,
            maxdate: "2020-12-31"
        },
        //限制范围（当天——2020-12-31）
        count: 2,
        //日历个数
        monthStep: 1,
        //切换上下月日历步长
        onSelectDate: ctfnSelectDate,
        //选择日期回调方法
        onClose: ctfnClose //关闭日历回调方法 
    });
    //为返程实例添加className, 主要为了样式需要
    octBackCal.container.className = "cal-end";
    //开启返程实例的鼠标移动范围
    octBackCal.showRange();

    //开启键盘事件
    octDepCal.CalStart = octBackCal.CalStart = octDepCal;
    octDepCal.CalEnd = octBackCal.CalEnd = octBackCal;
    octDepCal.keyup();
    octBackCal.keyup();

    //选择日期回调函数
    function ctfnSelectDate(obj) {
        switch (this.triggerNode.id) {
            case ctFromDateCtrlId:
                octBackCal.startDate = this.startDate = obj["data-date"];
                octBackCal.range.mindate = this.startDate;
                octBackCal.render(this.startDate);
                this.render(this.startDate);
                octBackCal.focus();
                break;
            case ctToDateCtrlId:
                octDepCal.endDate = this.endDate = obj["data-date"];
                octDepCal.render(this.startDate);
                this.render(this.endDate);
                break;
        }
        var date1 = this.startDate + " " + $.trim($("#ctgetTime").val()) + ":00";
        var date2 = this.endDate + " " + $.trim($("#ctretTime").val()) + ":00";
        calcTenancy(date1, date2);
    }

    //关闭日历回调函数
    function ctfnClose() {
        this.hideMessage();
    }
    //默认出发时间和返程时间
    octDepCal.startDate = octBackCal.startDate = cttxtStartDate;
    octDepCal.endDate = octBackCal.endDate = cttxtEndDate;
    octDepCal.setDateInfo(cttxtStartDate);
    octBackCal.setDateInfo(cttxtEndDate);
}



function ShowVipSubmitBox() {
    $(".div-myshowbox").html($('.J_vipinfo-box').html());
}


/*function showMoreCars() {
    /// <summary>
    /// 显示排队车辆,并隐藏按钮
    /// </summary>
    $('.queue').show();
    $(".load-more-box").hide();
    var data = {
        PriceLevel: Filter.selectPriceLevel,
        Brands: Filter.getBrands(),
        Gear: Filter.selectGear,
        Type: Filter.selectType,
        Seat: Filter.selectSeat,
        SortBy: Filter.sortBy,
        IsEnterprise: Filter.IsEnterprise
    };
    $("#moreCarTypeImgLoad").show();
    carType.isCache = false;
    carType.ReqCarTypeData(Url.InStore,
        eHi.toJSONString(data),
        Dom.CarTypeList,
        "CarTypeAll",
        { "__RequestVerificationToken": $("input[name='__RequestVerificationToken']").val() },
        function (result) {
            carType.isCache = true;
            $("#moreCarTypeImgLoad").hide();
            $("#reservationList").append(function () {
                return result;
            });
            UpadateCarTypeCount();
            $("img.lazy").lazyload({
                effect: "fadeIn",
                threshold: 184
            });
        });
}*/


$(function () {
    // 新手车型提示
    $(".chkIsBeginner").mouseover(function () {
        var fltop = $(".field-level").position().top - 26 + "px";
        var flleft = $(".field-level").position().left - 30 + "px";
        $(".field-level-tip").css({
            "top": fltop,
            "left": flleft
        });
        $(".field-level-tip").show();
    });
    $(".chkIsBeginner").mouseout(function () {
        $(".field-level-tip").hide();
    });

    // 窗体说明显示隐藏
    $(".showhide").click(function () {
        if ($(this).hasClass("on")) {
            $(this).removeClass("on");
        } else {
            $(this).addClass("on");
        }
    });

    // 过滤筛选
    var tabT = $('.J_TabTitle > a'),
        tabC = $('.J_TabContent > div'),
        currentTitle;
    tabT.click(function () {
        currentTitle = $(this);
        currentTitle.addClass('ck').siblings().removeClass('ck');
        tabC.eq(tabT.index(currentTitle)).addClass('ck').siblings().removeClass('ck');
    });

    // 返回顶部
    $(window).scroll(function () {
        if ($(window).scrollTop() > 50) {
            $("#scrollTop").fadeIn(300);
        } else {
            $("#scrollTop").fadeOut(300);
        }
    });
    $("#scrollTop").mouseover(function () {
        $(".scrollIcon").hide();
        $(".scrollText").show();
    });
    $("#scrollTop").mouseout(function () {
        $(".scrollIcon").show();
        $(".scrollText").hide();
    });
    $("#scrollTop").click(function () {
        $('body, html').animate({ scrollTop: 0 }, 500);
        return false;
    });

    // 限行说明隐藏
    $("#limit-line-close").click(function () {
        $("#limit-line-box").hide();
    });
});

$(function () {

    $(document).on('click', '#mshowbox .save-rentcar', function () {

        var param = $('#mshowbox #fromchannel').serializeJson("json");
        if (!verify.phoneVerify(param.PhoneNumber) || !verify.cardNo(param.IdCardNo)) {
            return false;
        }
        $(".div-myshowbox #loading").removeClass("hidden");
        $(".edit-rentcar-box .btn-box .save-rentcar").hide();
        $.ajax({
            type: 'post',
            url: BookingAjax.Url.ChannelRegister + "?v=" + new Date().getTime(),
            data: param,
            dataType: "html",
            async: true,
            cache: false,
            success: function (data) {
                var json = JSON.parse(data);
                if (!json.IsSuccess) {
                    $(".div-myshowbox #loading").addClass("hidden");
                    $(".edit-rentcar-box .btn-box .save-rentcar").show();
                    alert(json.Message);
                    return;
                }
                window.location = location.href;
            }
        });

    });


    var verify = {
        phoneVerify: function(phone) {
            var reg = !(/^\d{7,15}$/.test(phone));
            if (phone.length === 0) {
                alert('请输入手机号');
                return false;
            } else if (phone.length < 7 || phone.length > 15) {
                alert("请输入7到15位手机号码");
                return false;
            } else if (phone.length > 0 && reg) {
                alert("手机号码格式错误");
                return false;
            }
            return true;
        },
        cardNo: function(cardNo) {
            var reg = !(/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(cardNo));
            if (cardNo.length === 0) {
                alert("请输入您的证件号码");
                return false;
            }
            if (reg) {
                alert("身份证格式不正确");
                return false;
            }

            return true;
        }
    };


    /**展开和关闭隐藏的城市**/
    $("#J_citymore").live("click", function () {
        $(".city-box ul:eq(0)").nextAll("ul").toggle();
        $(".city-more").toggleClass("city-moreup");
    });

    /*//刷新预订框提示文字
    refreshBookingBoxTips();*/

    //关闭尊享会员申请提示
    $('.J_BackStep2').live('click', function () {
        $(".myshowbox-container .btn-close, #bgScreen").trigger('click');
    });

    /**预订规则**/
    $(".step1-body-right").on('click', ".book-rulelink", function () {
        window.myshowBox('', '', '700', '540', 'false', 'window-scroll');
        $(".div-myshowbox").html($('#bookRuleBox').html());
    });

    /**返利价说明**/
    $(".step1-body-right").on('click', ".ReturnCash-link", function () {
        window.myshowBox('', '', '700', '260', 'false', 'show-div-ghmd');
        $(".div-myshowbox").html($('#returnCashBox').html());
    });



    /**升级租期**/
    Dom.CarTypeList.on('click', ".btn-next-price", function () {
        var rentDays = $(this).data('days');
        window.myshowBox('', '', '700', '182', 'false', 'show-div-ghmd');
        $(".div-myshowbox").html($('#leaseUpgrade').html()).find('.btn-upgrade-ok').data("days", rentDays);
    });

    //确定升级租期
    $(document).on('click', '.btn-upgrade-ok', function () {
        var rentDays = $(this).data('days');
        var pickuptime = moment(getPickupTimeStr());
        var nextReturntime = pickuptime.add(rentDays, "days");
        Dom.ReturnDate.val(nextReturntime.format("YYYY-MM-DD"));
        Dom.ReturnTime.val(nextReturntime.format("HH"));
        window.oDepCal.endDate = window.oBackCal.endDate = Dom.ReturnDate.val();
        window.oBackCal.setDateInfo(window.oBackCal.endDate);

        Dom.btnSubmit.trigger('click');
        window.closeMyShowBox();
    });




    //鼠标移入预订按钮
    $(document).on("mouseenter", ".licar-btn,.btn-yd,.typebtn", function () {
        $(this).parent().find(".typebtn").addClass("typedis");
    });
    //鼠标移出预订按钮
    $(document).on('mouseleave', ".licar-btn,.btn-yd,.typebtn", function () {
        $(this).parent().find(".typebtn").removeClass("typedis");
    });


    //图标浮动提示信息
    $(".sp-box").live('mouseover', function () {
        var top = $(this).offset().top + "px";
        var left = $(this).offset().left + "px";
        if ($(this).hasClass("sp-aczs")) {
            $(".ts-aczs").css({
                "top": top,
                "left": left
            }).show();
        }
        if ($(this).hasClass("icon-ticket")) {
            $(".ts-ticket").css({
                "top": top,
                "left": left
            }).show();
        }
        if ($(this).hasClass("icon-promote")) {
            $(".ts-promote").css({
                "top": top,
                "left": left
            }).show();
        }

        if ($(this).hasClass("icon-quickrent")) {
            $(".ts-quickrent").css({
                "top": ($(this).offset().top + 6) + "px",
                "left": ($(this).offset().left + 8) + "px"
            }).show();
        }
    });
    $(".sp-box").live('mouseout', function () {
        $(".ts-box").hide();
    });

    $("#J_choosemore").live("click", function () {
        var brandH = $(".brandlist").height();
        if (brandH == "66") {
            $(".brandlist").css({
                overflow: "auto",
                height: "auto"
            });
        } else {
            $(".brandlist").css({
                overflow: "hidden",
                height: "66px"
            });
        }
        $(".choose-branch .choose-ck:eq(1)").nextAll(".choose-ck").toggle();
        $(".choose-more").toggleClass("choose-moreup");
    })


    /**订单用途**/
    $("#J_Revise").live('click', function () {
        window.myshowBox('', '', '392', '280', 'false', 'show-div-ghmd');
        $(".div-myshowbox").html($('#purpose-select').html());
    });
    $("#purpose-btn").live("click", function () {
        carType.isCache = false;
        var purText = $("input:radio[name=purpose]:checked").val();
        $("#purPromptTxt").text(purText);
        closeMyShowBox();
        Filter.IsEnterprise = purText === "公司用途";
        queryCars(Url.Filter,"CarTypeAll");
        carType.isCache = true;
    });
});

//门店信息右侧浮动
$(function () {
    $(window).scroll(function () {
        var vtop = $(document).scrollTop(); //滚动条到浏览器窗口顶部的距离
        if (vtop >= 150) {
            $(".step1-body-right").addClass("step1-right-float");
        } else {
            $(".step1-body-right").removeClass("step1-right-float");
        }

        //var docHeight = $(document).height();
        //if ($(document).scrollTop() + $(window).height() >= docHeight - 500) {
        //    $(".step1-body-right").addClass("step1-right-floatBtm");
        //} else {
        //    $(".step1-body-right").removeClass("step1-right-floatBtm");
        //}
    });
});


//选择城市，改变表单中城市Id
$(function () {
    var isPickUpCity = true;
    $("#PickupCity").click(function () {
        isPickUpCity = true;
    });
    $("#ReturnCity").click(function () {
        isPickUpCity = false;
    });
    $("#ydcityBox dd span").click(function () {
        var id = $(this).data("id");
        if (isPickUpCity) $("#PickUpCityId,#ReturnCityId").val(id);
        else $("#ReturnCityId").val(id);
    });

    $("#SearchStore").keyup(function () {
        var city = BookingInfo.Type === "get" ? $(BookTarget.PickupCityId).attr("value") : $(BookTarget.ReturnCityId).attr("value");
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").attr("value") : $("#ReturnCityId").attr("value");
        var address = $(this).val();
        if (address.length < 2)
            return false;
        var param = "&cityId=" + cityId + "&address=" + address;
        setTimeout(function () {
            BookingAjax.ReqStore(BookingAjax.Url.MapPositionAddress, param, "MapPositionAddress", function (data) {
                MapCommon.func.GetPosition(city + address);
                $("#addresslist").html(data);
            });
        }, 100);
    });


    $("#addresslist").delegate("li", "click", function () {
        var obj = $(this);
        obj.addClass("send-cur").siblings().removeClass("send-cur");
        obj.find("input").removeClass("hidden").parents("li").siblings().find("input").addClass("hidden");
        setTimeout(function () {
            MapCommon.func.GetAddress(obj.attr("lng"), obj.attr("lat"));
        }, 100);
    });

    $("#addresslist").delegate("input", "click", function () {
        if (this.id === "btnStore") {
            return false;
        }
        var obj = $("#addresslist").find("li[class='send-cur']");
        var lat = obj.attr("lat");
        var lng = obj.attr("lng");
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").attr("value") : $("#ReturnCityId").attr("value");
        if (!IsAllowMapService(lng, lat, cityId)) {
            return false;
        }

        var addName = obj.find(".send-storename").text();
        var add = obj.find(".send-storearea").text();
        if (BookingInfo.Type === "get") {
            $("#getlng").val(lng);
            $("#getlat").val(lat);
            $(BookTarget.SendServiceId).val(addName);
            BookingInfo.SendCarHtml = '<li class="send-cur" lat="' + lat + '" lng="' + lng + '">' + obj.html() + "</li>";
            $("#getAddress").val(add);
        } else {
            $("#retlng").val(lng);
            $("#retlat").val(lat);
            $(BookTarget.ReturnServiceId).val(addName);
            BookingInfo.TakeCarHtml = '<li class="send-cur" lat="' + lat + '" lng="' + lng + '">' + obj.html() + "</li>";
            $("#retAddress").val(add);
        }
        $("#shcMapBox").addClass("hidden");
    });

    $("#addresslist").delegate("#btnStore", "click", function () {
        $("#shcMapBox").addClass("hidden");
        var name = $(this).attr("abbrname");
        var id = $(this).attr("sid");
        if (BookingInfo.Type === "get") {
            $(BookTarget.PickupStoreNameId).val(name);
            $("#getStoreId").val(id);
        } else {
            $("#retStoreId").val(id);
            $(BookTarget.ReturnStoreNameId).val(name);
        }
        BookingInfo.Type === "get" ? $(BookTarget.PickupStoreNameId).show() : $(BookTarget.ReturnStoreNameId).show();
        $("#" + BookingInfo.Type + "SendService").hide();
        $("#" + BookingInfo.Type + "Check").attr("checked", false);
    });
});
function initServiceMap(lat, lng, data, level) {
    var icon = BookingInfo.Type === "get" ? "https://booking.1hai.cn/Content/Images/Order/NewStep/car-send.png" : "https://booking.1hai.cn/Content/Images/Order/NewStep/car-take.png";
    MapCommon.Parameter.MapDivId = "container";//地图初始化容器ID
    MapCommon.Parameter.MapZoomLevel = level;
    MapCommon.Parameter.MarkerIcon = icon;//图标素材 地址
    MapCommon.Parameter.initialLat = lat;//维度
    MapCommon.Parameter.initialLng = lng;//经度
    MapCommon.Parameter.MapPolygonData = data;
    var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").val() : $("#ReturnCityId").val();
    MapCommon.Parameter.OutFun = function (lng, lat) {
        mapPositionAddress(lng, lat, cityId);
    };
    //执行点击图标在里面的方法函数
    MapCommon.Parameter.InFun = function (lng, lat) {
        var cityId = BookingInfo.Type === "get" ? $("#PickUpCityId").val() : $("#ReturnCityId").val();
        mapPositionAddress(lng, lat, cityId);
    };
    MapCommon.func.MapLoad();
}
function SetMapIcon() {
    var icon = BookingInfo.Type === "get" ? "https://booking.1hai.cn/Content/Images/Order/NewStep/car-send.png" : "https://booking.1hai.cn/Content/Images/Order/NewStep/car-take.png";
    MapCommon.Parameter.MarkerIcon = icon;
    MapCommon.func.MapLoad();
}
function mapPositionAddress(lng, lat, cityId) {
    var param = "&lat=" + lat + "&lng=" + lng + "&cityId=" + cityId;
    setTimeout(function () {
        window.BookingAjax.ReqStore(window.BookingAjax.Url.MapPositionPath, param, "MapPositionPath", function (data) {
            if (data === "" || data === undefined) {
                $("#inside").hide();
                $("#outside").show();
            } else {
                $("#inside").show();
                $("#outside").hide();
                $("#addresslist").html(data);
            }
        });
    }, 100);
}

function IsAllowMapService(lng, lat, cityId) {
    var param = "lat=" + lat + "&lng=" + lng + "&cityId=" + cityId;
    var result = false;
    BookingAjax.ReqStore(BookingAjax.Url.IsAllowMapService,
        param,
        "IsAllowMapService",
        function (data) {
            if (data == undefined) {
                alert('该范围暂不支持送/还车，请重新选择地址');
                return false;
            }
            if (!data.AllowService) {
                alert('该范围暂不支持送/还车，请重新选择地址');
                return false;
            } else {
                if (data.Price > 0) {
                    BookingInfo.Type === "get" ? $("#getIsFree").val(false) : $("#retIsFree").val(false);
                    var isconfirm = confirm('温馨提示：您的' + (BookingInfo.Type === "get" ? "送车" : "上门") + '地点需要收取' + (BookingInfo.Type === "get" ? "送车上门" : "上门取车") + '费￥' + data.Price + '元' + (data.EnjoyCarPrice > 0 ? "(高端车￥" + data.EnjoyCarPrice + "元）" : "") + '，确认是否选择？');
                    if (!isconfirm) {
                        return false;
                    }
                }
                result = true;
                return true;
            }
        });
    return result;
}
;
/**
 * JSLoad
 * Copyright (C) 2007-2008 Instructables
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Contact information:
 *   Eric Nguyen <ericn at instructables dot com>
 *
 * @version  0.9
 * @url      http://www.instructables.com
 */

function JSLoad (tags, path, version, executeAfterLoad, scriptConcatenatorURL) {
  // convert the tags array into a hash and keep a separate tagOrder array.
  if (!tags) { return; }
  var objectHash = {};
  var ordering = [];
  for (var i = 0; i < tags.length; i += 1) {
    var tag = tags[i];
    objectHash[tag.name] = tag;
    ordering.push(tag.name);
  }
  this.tags = objectHash;
  this.tagOrder = ordering;

  // set flags and one-time data
  this.path = path ? path : "";
  this.version = version;
  this.executeAfterLoad = executeAfterLoad ? true : false;
  this.scriptConcatenatorURL = scriptConcatenatorURL;

  // for Safari when using a scriptConcatenator
  if (this.scriptConcatenatorURL && /WebKit|khtml/i.test(navigator.userAgent)) {
    this.safariSetsLoaded = {}; 
  }

  // Initialize "Private" attributes
  this.tagsLoaded = {};
  this.sourceFileSetQueue = [];
  this.sourceFilesLoaded = {};
  this.ALLJS = true; // a constant
}

JSLoad.prototype.load = function (tagNames, callback, path, version, executeAfterLoad) {
  if (!tagNames) { return; } // tagNames required
  path = path || this.path;
  version = version || this.version;  
  executeAfterLoad = executeAfterLoad || this.executeAfterLoad;

  // Keep track of all the source files that we are about to load
  // This allows us to skip repeat calls to load a file, if it is pending.
  var srcToLoad = this.getSrcToLoad(tagNames, path);
  this.sourceFileSetQueue.push({
    srcToLoad: srcToLoad,
    callback: callback,
    version: version
  });

  // Finally, load all the source files. Only run loadScript if it's
  // not running. ExecuteAfterLoad will postpone all loading until after the page
  // has loaded.
  if (!this.sourceFileSetQueue.isRunning) {
    if (executeAfterLoad) {
      // Note: this is a dependency on prototype 1.6 that should probably be removed in the
      // public version of JSLoad. We could copy FastInit code into here, instead.
      var thisObj = this;      
      document.observe('dom:loaded', function() {
        thisObj.loadScript(thisObj.sourceFileSetQueue[0]);
      });
      // Don't have any more loadScript calls set. The first call after the 
      // page load will open this back up.
      this.sourceFileSetQueue.isRunning = true; 
    } else {
      this.loadScript(this.sourceFileSetQueue[0]);
    }
  }
};

JSLoad.prototype.getSrcToLoad = function(tagNames, path) {
  if (!path) { path = this.path; }

  // for closures in markDependentTags()
  var tags = this.tags;
  var dependentTags = {};
  
  // private function, to be called recursively
  function markDependentTags(tagName) {
    var tag = tags[tagName];
    if (!tag) { return; }
    dependentTags[tagName] = true;      
    if (!tag.requires) { return; }
    for (var i = 0; i < tag.requires.length; i += 1) {
      var requiredTagName = tag.requires[i];
      // only load if not already loaded
      if (!dependentTags[requiredTagName]) { 
        markDependentTags(requiredTagName);
      }
    }
  }

  // create the full set of dependent tags
  for (var i = 0; i < tagNames.length; i += 1) {
    markDependentTags(tagNames[i]);
  }

  // Using the tag order, figure out what source files to load.
  // Don't load a source file if any of the following is true:
  //  - the tag is not linked to a source file ("tagOnly")
  //  - the tag isn't marked for loading
  //  - the tag has an isLoaded test and that test returns true
  //  - the tag's source file has already been loaded
  //  - the tag's source file is in the queue for loading
  var srcToLoad = [];
  for (var j = 0; j < this.tagOrder.length; j += 1) {
    var tagName = this.tagOrder[j];
    var tag = this.tags[tagName];
    
    if (tag.tagOnly ||
        !dependentTags[tagName] ||
        (tag.isLoaded && tag.isLoaded())) { 
      continue; 
    }
    
    var filePath;
    
    if (tagName.indexOf("http://") > -1) {
      filePath = tagName;
    } else if (tag.path) {
      filePath = tag.path + tagName + '.js';
    } else {
      filePath = (path ? path : "") + tagName + '.js';
    }
    if (this.sourceFilesLoaded[filePath] || this.isQueued(filePath)) { 
      continue; 
    }

    srcToLoad.push(filePath);
  }
  
  return srcToLoad;
};

JSLoad.prototype.loadScript = function (srcSetObj, iteration) {
  this.sourceFileSetQueue.isRunning = true;
  var thisObj = this; // for closures
  var thisFn = arguments.callee;

  // This fires the callback when a srcSet is finished loading. First, it
  // executes the callback.
  function loadNext() {
    if (srcSetObj.callback) { srcSetObj.callback(); }
    thisObj.sourceFileSetQueue.shift();
    if (thisObj.sourceFileSetQueue.length > 0) {
      thisFn.call(thisObj, thisObj.sourceFileSetQueue[0]);
    } else {
      thisObj.sourceFileSetQueue.isRunning = false;
    }  
  }

  // Creates script el, adds onload handlers, and inserts into the dom.
  function createScriptEl(url, srcSetObj, iteration) {
    // Create script, set properties, load
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = url;
    // script onload, handling Safari 2.0
    function scriptOnLoad() { 
      if (script.readyState && script.readyState !== "loaded" && 
          script.readyState !== "complete") { return; }
      script.onreadystatechange = script.onload = null;
      // next iteration
      if (thisObj.scriptConcatenatorURL) {
        loadNext();
      } else {
        thisObj.loadScript(srcSetObj, iteration);
      }
    }
    if (thisObj.safariSetsLoaded) { // Safari hack
      var callbackTimer = setInterval(function() {
        if (thisObj.safariSetsLoaded[srcSetObj.srcToLoad.join(",")]) {
          clearInterval(callbackTimer);
          scriptOnLoad();
        }
      }, 100);
    } else {
      script.onload = script.onreadystatechange = scriptOnLoad;
    }
    document.getElementsByTagName("head")[0].appendChild(script);
  }

  // If there are no source files in this set, just execute the callback and
  // move on.
  if (srcSetObj.srcToLoad.length === 0) {
    loadNext();
    
  // If there are source files, run them and set the callbacks to run when
  // the source files finish.
  } else {
    var url;
    // If we're using a script concatenator on the server, then we load
    // all the scripts in one fell swoop.
    if (this.scriptConcatenatorURL) {
      // Mark all files as loaded
      for (var i = 0; i < srcSetObj.srcToLoad.length; i += 1) {
        url = srcSetObj.srcToLoad[i];
        this.sourceFilesLoaded[url] = true;
      }     
      createScriptEl( 
        this.scriptConcatenatorURL +
          srcSetObj.srcToLoad.join(",") +
          (srcSetObj.version ? "&version=" + srcSetObj.version : ""),
        srcSetObj
      );
    
    // If we're not using a script concatenator, then this function will
    // recurse through the each of the scripts in this srcSet.
    } else {
      // If we've hit the end of this srcSet, run loadNext()
      iteration = iteration || 0;
      if ( (iteration + 1) > srcSetObj.srcToLoad.length ) { 
        loadNext();
        return;
      }
      
      // Mark this file as loaded
      url = srcSetObj.srcToLoad[iteration];
      this.sourceFilesLoaded[url] = true;
      createScriptEl( 
        url + (srcSetObj.version ? "?version=" + srcSetObj.version : ""),
        srcSetObj,
        iteration + 1
      );
    }
  }
}; 

JSLoad.prototype.isQueued = function(url) {
  for (var i = 0; i < this.sourceFileSetQueue.length; i += 1) {
    var set = this.sourceFileSetQueue[i];
    for (var j = 0; j < set.srcToLoad.length; j += 1) {
      if (url === set.srcToLoad[j]) { return true; }
    }
  }
  return false;
};
;
/*!
 * Knockout JavaScript library v3.2.0
 * (c) Steven Sanderson - http://knockoutjs.com/
 * License: MIT (http://www.opensource.org/licenses/mit-license.php)
 */

(function() {(function(p){var s=this||(0,eval)("this"),v=s.document,L=s.navigator,w=s.jQuery,D=s.JSON;(function(p){"function"===typeof require&&"object"===typeof exports&&"object"===typeof module?p(module.exports||exports,require):"function"===typeof define&&define.amd?define(["exports","require"],p):p(s.ko={})})(function(M,N){function H(a,d){return null===a||typeof a in R?a===d:!1}function S(a,d){var c;return function(){c||(c=setTimeout(function(){c=p;a()},d))}}function T(a,d){var c;return function(){clearTimeout(c);
c=setTimeout(a,d)}}function I(b,d,c,e){a.d[b]={init:function(b,h,k,f,m){var l,q;a.s(function(){var f=a.a.c(h()),k=!c!==!f,z=!q;if(z||d||k!==l)z&&a.Y.la()&&(q=a.a.ia(a.f.childNodes(b),!0)),k?(z||a.f.T(b,a.a.ia(q)),a.Ca(e?e(m,f):m,b)):a.f.ja(b),l=k},null,{o:b});return{controlsDescendantBindings:!0}}};a.h.ha[b]=!1;a.f.Q[b]=!0}var a="undefined"!==typeof M?M:{};a.b=function(b,d){for(var c=b.split("."),e=a,g=0;g<c.length-1;g++)e=e[c[g]];e[c[c.length-1]]=d};a.A=function(a,d,c){a[d]=c};a.version="3.2.0";
a.b("version",a.version);a.a=function(){function b(a,b){for(var c in a)a.hasOwnProperty(c)&&b(c,a[c])}function d(a,b){if(b)for(var c in b)b.hasOwnProperty(c)&&(a[c]=b[c]);return a}function c(a,b){a.__proto__=b;return a}var e={__proto__:[]}instanceof Array,g={},h={};g[L&&/Firefox\/2/i.test(L.userAgent)?"KeyboardEvent":"UIEvents"]=["keyup","keydown","keypress"];g.MouseEvents="click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave".split(" ");b(g,function(a,b){if(b.length)for(var c=
0,d=b.length;c<d;c++)h[b[c]]=a});var k={propertychange:!0},f=v&&function(){for(var a=3,b=v.createElement("div"),c=b.getElementsByTagName("i");b.innerHTML="\x3c!--[if gt IE "+ ++a+"]><i></i><![endif]--\x3e",c[0];);return 4<a?a:p}();return{vb:["authenticity_token",/^__RequestVerificationToken(_.*)?$/],u:function(a,b){for(var c=0,d=a.length;c<d;c++)b(a[c],c)},m:function(a,b){if("function"==typeof Array.prototype.indexOf)return Array.prototype.indexOf.call(a,b);for(var c=0,d=a.length;c<d;c++)if(a[c]===
b)return c;return-1},qb:function(a,b,c){for(var d=0,f=a.length;d<f;d++)if(b.call(c,a[d],d))return a[d];return null},ua:function(m,b){var c=a.a.m(m,b);0<c?m.splice(c,1):0===c&&m.shift()},rb:function(m){m=m||[];for(var b=[],c=0,d=m.length;c<d;c++)0>a.a.m(b,m[c])&&b.push(m[c]);return b},Da:function(a,b){a=a||[];for(var c=[],d=0,f=a.length;d<f;d++)c.push(b(a[d],d));return c},ta:function(a,b){a=a||[];for(var c=[],d=0,f=a.length;d<f;d++)b(a[d],d)&&c.push(a[d]);return c},ga:function(a,b){if(b instanceof
Array)a.push.apply(a,b);else for(var c=0,d=b.length;c<d;c++)a.push(b[c]);return a},ea:function(b,c,d){var f=a.a.m(a.a.Xa(b),c);0>f?d&&b.push(c):d||b.splice(f,1)},xa:e,extend:d,za:c,Aa:e?c:d,G:b,na:function(a,b){if(!a)return a;var c={},d;for(d in a)a.hasOwnProperty(d)&&(c[d]=b(a[d],d,a));return c},Ka:function(b){for(;b.firstChild;)a.removeNode(b.firstChild)},oc:function(b){b=a.a.S(b);for(var c=v.createElement("div"),d=0,f=b.length;d<f;d++)c.appendChild(a.R(b[d]));return c},ia:function(b,c){for(var d=
0,f=b.length,e=[];d<f;d++){var k=b[d].cloneNode(!0);e.push(c?a.R(k):k)}return e},T:function(b,c){a.a.Ka(b);if(c)for(var d=0,f=c.length;d<f;d++)b.appendChild(c[d])},Lb:function(b,c){var d=b.nodeType?[b]:b;if(0<d.length){for(var f=d[0],e=f.parentNode,k=0,g=c.length;k<g;k++)e.insertBefore(c[k],f);k=0;for(g=d.length;k<g;k++)a.removeNode(d[k])}},ka:function(a,b){if(a.length){for(b=8===b.nodeType&&b.parentNode||b;a.length&&a[0].parentNode!==b;)a.shift();if(1<a.length){var c=a[0],d=a[a.length-1];for(a.length=
0;c!==d;)if(a.push(c),c=c.nextSibling,!c)return;a.push(d)}}return a},Nb:function(a,b){7>f?a.setAttribute("selected",b):a.selected=b},cb:function(a){return null===a||a===p?"":a.trim?a.trim():a.toString().replace(/^[\s\xa0]+|[\s\xa0]+$/g,"")},vc:function(a,b){a=a||"";return b.length>a.length?!1:a.substring(0,b.length)===b},cc:function(a,b){if(a===b)return!0;if(11===a.nodeType)return!1;if(b.contains)return b.contains(3===a.nodeType?a.parentNode:a);if(b.compareDocumentPosition)return 16==(b.compareDocumentPosition(a)&
16);for(;a&&a!=b;)a=a.parentNode;return!!a},Ja:function(b){return a.a.cc(b,b.ownerDocument.documentElement)},ob:function(b){return!!a.a.qb(b,a.a.Ja)},t:function(a){return a&&a.tagName&&a.tagName.toLowerCase()},n:function(b,c,d){var e=f&&k[c];if(!e&&w)w(b).bind(c,d);else if(e||"function"!=typeof b.addEventListener)if("undefined"!=typeof b.attachEvent){var g=function(a){d.call(b,a)},h="on"+c;b.attachEvent(h,g);a.a.w.da(b,function(){b.detachEvent(h,g)})}else throw Error("Browser doesn't support addEventListener or attachEvent");
else b.addEventListener(c,d,!1)},oa:function(b,c){if(!b||!b.nodeType)throw Error("element must be a DOM node when calling triggerEvent");var d;"input"===a.a.t(b)&&b.type&&"click"==c.toLowerCase()?(d=b.type,d="checkbox"==d||"radio"==d):d=!1;if(w&&!d)w(b).trigger(c);else if("function"==typeof v.createEvent)if("function"==typeof b.dispatchEvent)d=v.createEvent(h[c]||"HTMLEvents"),d.initEvent(c,!0,!0,s,0,0,0,0,0,!1,!1,!1,!1,0,b),b.dispatchEvent(d);else throw Error("The supplied element doesn't support dispatchEvent");
else if(d&&b.click)b.click();else if("undefined"!=typeof b.fireEvent)b.fireEvent("on"+c);else throw Error("Browser doesn't support triggering events");},c:function(b){return a.C(b)?b():b},Xa:function(b){return a.C(b)?b.v():b},Ba:function(b,c,d){if(c){var f=/\S+/g,e=b.className.match(f)||[];a.a.u(c.match(f),function(b){a.a.ea(e,b,d)});b.className=e.join(" ")}},bb:function(b,c){var d=a.a.c(c);if(null===d||d===p)d="";var f=a.f.firstChild(b);!f||3!=f.nodeType||a.f.nextSibling(f)?a.f.T(b,[b.ownerDocument.createTextNode(d)]):
f.data=d;a.a.fc(b)},Mb:function(a,b){a.name=b;if(7>=f)try{a.mergeAttributes(v.createElement("<input name='"+a.name+"'/>"),!1)}catch(c){}},fc:function(a){9<=f&&(a=1==a.nodeType?a:a.parentNode,a.style&&(a.style.zoom=a.style.zoom))},dc:function(a){if(f){var b=a.style.width;a.style.width=0;a.style.width=b}},sc:function(b,c){b=a.a.c(b);c=a.a.c(c);for(var d=[],f=b;f<=c;f++)d.push(f);return d},S:function(a){for(var b=[],c=0,d=a.length;c<d;c++)b.push(a[c]);return b},yc:6===f,zc:7===f,L:f,xb:function(b,c){for(var d=
a.a.S(b.getElementsByTagName("input")).concat(a.a.S(b.getElementsByTagName("textarea"))),f="string"==typeof c?function(a){return a.name===c}:function(a){return c.test(a.name)},e=[],k=d.length-1;0<=k;k--)f(d[k])&&e.push(d[k]);return e},pc:function(b){return"string"==typeof b&&(b=a.a.cb(b))?D&&D.parse?D.parse(b):(new Function("return "+b))():null},eb:function(b,c,d){if(!D||!D.stringify)throw Error("Cannot find JSON.stringify(). Some browsers (e.g., IE < 8) don't support it natively, but you can overcome this by adding a script reference to json2.js, downloadable from http://www.json.org/json2.js");
return D.stringify(a.a.c(b),c,d)},qc:function(c,d,f){f=f||{};var e=f.params||{},k=f.includeFields||this.vb,g=c;if("object"==typeof c&&"form"===a.a.t(c))for(var g=c.action,h=k.length-1;0<=h;h--)for(var r=a.a.xb(c,k[h]),E=r.length-1;0<=E;E--)e[r[E].name]=r[E].value;d=a.a.c(d);var y=v.createElement("form");y.style.display="none";y.action=g;y.method="post";for(var p in d)c=v.createElement("input"),c.type="hidden",c.name=p,c.value=a.a.eb(a.a.c(d[p])),y.appendChild(c);b(e,function(a,b){var c=v.createElement("input");
c.type="hidden";c.name=a;c.value=b;y.appendChild(c)});v.body.appendChild(y);f.submitter?f.submitter(y):y.submit();setTimeout(function(){y.parentNode.removeChild(y)},0)}}}();a.b("utils",a.a);a.b("utils.arrayForEach",a.a.u);a.b("utils.arrayFirst",a.a.qb);a.b("utils.arrayFilter",a.a.ta);a.b("utils.arrayGetDistinctValues",a.a.rb);a.b("utils.arrayIndexOf",a.a.m);a.b("utils.arrayMap",a.a.Da);a.b("utils.arrayPushAll",a.a.ga);a.b("utils.arrayRemoveItem",a.a.ua);a.b("utils.extend",a.a.extend);a.b("utils.fieldsIncludedWithJsonPost",
a.a.vb);a.b("utils.getFormFields",a.a.xb);a.b("utils.peekObservable",a.a.Xa);a.b("utils.postJson",a.a.qc);a.b("utils.parseJson",a.a.pc);a.b("utils.registerEventHandler",a.a.n);a.b("utils.stringifyJson",a.a.eb);a.b("utils.range",a.a.sc);a.b("utils.toggleDomNodeCssClass",a.a.Ba);a.b("utils.triggerEvent",a.a.oa);a.b("utils.unwrapObservable",a.a.c);a.b("utils.objectForEach",a.a.G);a.b("utils.addOrRemoveItem",a.a.ea);a.b("unwrap",a.a.c);Function.prototype.bind||(Function.prototype.bind=function(a){var d=
this,c=Array.prototype.slice.call(arguments);a=c.shift();return function(){return d.apply(a,c.concat(Array.prototype.slice.call(arguments)))}});a.a.e=new function(){function a(b,h){var k=b[c];if(!k||"null"===k||!e[k]){if(!h)return p;k=b[c]="ko"+d++;e[k]={}}return e[k]}var d=0,c="__ko__"+(new Date).getTime(),e={};return{get:function(c,d){var e=a(c,!1);return e===p?p:e[d]},set:function(c,d,e){if(e!==p||a(c,!1)!==p)a(c,!0)[d]=e},clear:function(a){var b=a[c];return b?(delete e[b],a[c]=null,!0):!1},F:function(){return d++ +
c}}};a.b("utils.domData",a.a.e);a.b("utils.domData.clear",a.a.e.clear);a.a.w=new function(){function b(b,d){var f=a.a.e.get(b,c);f===p&&d&&(f=[],a.a.e.set(b,c,f));return f}function d(c){var e=b(c,!1);if(e)for(var e=e.slice(0),f=0;f<e.length;f++)e[f](c);a.a.e.clear(c);a.a.w.cleanExternalData(c);if(g[c.nodeType])for(e=c.firstChild;c=e;)e=c.nextSibling,8===c.nodeType&&d(c)}var c=a.a.e.F(),e={1:!0,8:!0,9:!0},g={1:!0,9:!0};return{da:function(a,c){if("function"!=typeof c)throw Error("Callback must be a function");
b(a,!0).push(c)},Kb:function(d,e){var f=b(d,!1);f&&(a.a.ua(f,e),0==f.length&&a.a.e.set(d,c,p))},R:function(b){if(e[b.nodeType]&&(d(b),g[b.nodeType])){var c=[];a.a.ga(c,b.getElementsByTagName("*"));for(var f=0,m=c.length;f<m;f++)d(c[f])}return b},removeNode:function(b){a.R(b);b.parentNode&&b.parentNode.removeChild(b)},cleanExternalData:function(a){w&&"function"==typeof w.cleanData&&w.cleanData([a])}}};a.R=a.a.w.R;a.removeNode=a.a.w.removeNode;a.b("cleanNode",a.R);a.b("removeNode",a.removeNode);a.b("utils.domNodeDisposal",
a.a.w);a.b("utils.domNodeDisposal.addDisposeCallback",a.a.w.da);a.b("utils.domNodeDisposal.removeDisposeCallback",a.a.w.Kb);(function(){a.a.ba=function(b){var d;if(w)if(w.parseHTML)d=w.parseHTML(b)||[];else{if((d=w.clean([b]))&&d[0]){for(b=d[0];b.parentNode&&11!==b.parentNode.nodeType;)b=b.parentNode;b.parentNode&&b.parentNode.removeChild(b)}}else{var c=a.a.cb(b).toLowerCase();d=v.createElement("div");c=c.match(/^<(thead|tbody|tfoot)/)&&[1,"<table>","</table>"]||!c.indexOf("<tr")&&[2,"<table><tbody>",
"</tbody></table>"]||(!c.indexOf("<td")||!c.indexOf("<th"))&&[3,"<table><tbody><tr>","</tr></tbody></table>"]||[0,"",""];b="ignored<div>"+c[1]+b+c[2]+"</div>";for("function"==typeof s.innerShiv?d.appendChild(s.innerShiv(b)):d.innerHTML=b;c[0]--;)d=d.lastChild;d=a.a.S(d.lastChild.childNodes)}return d};a.a.$a=function(b,d){a.a.Ka(b);d=a.a.c(d);if(null!==d&&d!==p)if("string"!=typeof d&&(d=d.toString()),w)w(b).html(d);else for(var c=a.a.ba(d),e=0;e<c.length;e++)b.appendChild(c[e])}})();a.b("utils.parseHtmlFragment",
a.a.ba);a.b("utils.setHtml",a.a.$a);a.D=function(){function b(c,d){if(c)if(8==c.nodeType){var g=a.D.Gb(c.nodeValue);null!=g&&d.push({bc:c,mc:g})}else if(1==c.nodeType)for(var g=0,h=c.childNodes,k=h.length;g<k;g++)b(h[g],d)}var d={};return{Ua:function(a){if("function"!=typeof a)throw Error("You can only pass a function to ko.memoization.memoize()");var b=(4294967296*(1+Math.random())|0).toString(16).substring(1)+(4294967296*(1+Math.random())|0).toString(16).substring(1);d[b]=a;return"\x3c!--[ko_memo:"+
b+"]--\x3e"},Rb:function(a,b){var g=d[a];if(g===p)throw Error("Couldn't find any memo with ID "+a+". Perhaps it's already been unmemoized.");try{return g.apply(null,b||[]),!0}finally{delete d[a]}},Sb:function(c,d){var g=[];b(c,g);for(var h=0,k=g.length;h<k;h++){var f=g[h].bc,m=[f];d&&a.a.ga(m,d);a.D.Rb(g[h].mc,m);f.nodeValue="";f.parentNode&&f.parentNode.removeChild(f)}},Gb:function(a){return(a=a.match(/^\[ko_memo\:(.*?)\]$/))?a[1]:null}}}();a.b("memoization",a.D);a.b("memoization.memoize",a.D.Ua);
a.b("memoization.unmemoize",a.D.Rb);a.b("memoization.parseMemoText",a.D.Gb);a.b("memoization.unmemoizeDomNodeAndDescendants",a.D.Sb);a.La={throttle:function(b,d){b.throttleEvaluation=d;var c=null;return a.j({read:b,write:function(a){clearTimeout(c);c=setTimeout(function(){b(a)},d)}})},rateLimit:function(a,d){var c,e,g;"number"==typeof d?c=d:(c=d.timeout,e=d.method);g="notifyWhenChangesStop"==e?T:S;a.Ta(function(a){return g(a,c)})},notify:function(a,d){a.equalityComparer="always"==d?null:H}};var R=
{undefined:1,"boolean":1,number:1,string:1};a.b("extenders",a.La);a.Pb=function(b,d,c){this.target=b;this.wa=d;this.ac=c;this.Cb=!1;a.A(this,"dispose",this.K)};a.Pb.prototype.K=function(){this.Cb=!0;this.ac()};a.P=function(){a.a.Aa(this,a.P.fn);this.M={}};var G="change",A={U:function(b,d,c){var e=this;c=c||G;var g=new a.Pb(e,d?b.bind(d):b,function(){a.a.ua(e.M[c],g);e.nb&&e.nb()});e.va&&e.va(c);e.M[c]||(e.M[c]=[]);e.M[c].push(g);return g},notifySubscribers:function(b,d){d=d||G;if(this.Ab(d))try{a.k.Ea();
for(var c=this.M[d].slice(0),e=0,g;g=c[e];++e)g.Cb||g.wa(b)}finally{a.k.end()}},Ta:function(b){var d=this,c=a.C(d),e,g,h;d.qa||(d.qa=d.notifySubscribers,d.notifySubscribers=function(a,b){b&&b!==G?"beforeChange"===b?d.kb(a):d.qa(a,b):d.lb(a)});var k=b(function(){c&&h===d&&(h=d());e=!1;d.Pa(g,h)&&d.qa(g=h)});d.lb=function(a){e=!0;h=a;k()};d.kb=function(a){e||(g=a,d.qa(a,"beforeChange"))}},Ab:function(a){return this.M[a]&&this.M[a].length},yb:function(){var b=0;a.a.G(this.M,function(a,c){b+=c.length});
return b},Pa:function(a,d){return!this.equalityComparer||!this.equalityComparer(a,d)},extend:function(b){var d=this;b&&a.a.G(b,function(b,e){var g=a.La[b];"function"==typeof g&&(d=g(d,e)||d)});return d}};a.A(A,"subscribe",A.U);a.A(A,"extend",A.extend);a.A(A,"getSubscriptionsCount",A.yb);a.a.xa&&a.a.za(A,Function.prototype);a.P.fn=A;a.Db=function(a){return null!=a&&"function"==typeof a.U&&"function"==typeof a.notifySubscribers};a.b("subscribable",a.P);a.b("isSubscribable",a.Db);a.Y=a.k=function(){function b(a){c.push(e);
e=a}function d(){e=c.pop()}var c=[],e,g=0;return{Ea:b,end:d,Jb:function(b){if(e){if(!a.Db(b))throw Error("Only subscribable things can act as dependencies");e.wa(b,b.Vb||(b.Vb=++g))}},B:function(a,c,f){try{return b(),a.apply(c,f||[])}finally{d()}},la:function(){if(e)return e.s.la()},ma:function(){if(e)return e.ma}}}();a.b("computedContext",a.Y);a.b("computedContext.getDependenciesCount",a.Y.la);a.b("computedContext.isInitial",a.Y.ma);a.b("computedContext.isSleeping",a.Y.Ac);a.p=function(b){function d(){if(0<
arguments.length)return d.Pa(c,arguments[0])&&(d.X(),c=arguments[0],d.W()),this;a.k.Jb(d);return c}var c=b;a.P.call(d);a.a.Aa(d,a.p.fn);d.v=function(){return c};d.W=function(){d.notifySubscribers(c)};d.X=function(){d.notifySubscribers(c,"beforeChange")};a.A(d,"peek",d.v);a.A(d,"valueHasMutated",d.W);a.A(d,"valueWillMutate",d.X);return d};a.p.fn={equalityComparer:H};var F=a.p.rc="__ko_proto__";a.p.fn[F]=a.p;a.a.xa&&a.a.za(a.p.fn,a.P.fn);a.Ma=function(b,d){return null===b||b===p||b[F]===p?!1:b[F]===
d?!0:a.Ma(b[F],d)};a.C=function(b){return a.Ma(b,a.p)};a.Ra=function(b){return"function"==typeof b&&b[F]===a.p||"function"==typeof b&&b[F]===a.j&&b.hc?!0:!1};a.b("observable",a.p);a.b("isObservable",a.C);a.b("isWriteableObservable",a.Ra);a.b("isWritableObservable",a.Ra);a.aa=function(b){b=b||[];if("object"!=typeof b||!("length"in b))throw Error("The argument passed when initializing an observable array must be an array, or null, or undefined.");b=a.p(b);a.a.Aa(b,a.aa.fn);return b.extend({trackArrayChanges:!0})};
a.aa.fn={remove:function(b){for(var d=this.v(),c=[],e="function"!=typeof b||a.C(b)?function(a){return a===b}:b,g=0;g<d.length;g++){var h=d[g];e(h)&&(0===c.length&&this.X(),c.push(h),d.splice(g,1),g--)}c.length&&this.W();return c},removeAll:function(b){if(b===p){var d=this.v(),c=d.slice(0);this.X();d.splice(0,d.length);this.W();return c}return b?this.remove(function(c){return 0<=a.a.m(b,c)}):[]},destroy:function(b){var d=this.v(),c="function"!=typeof b||a.C(b)?function(a){return a===b}:b;this.X();
for(var e=d.length-1;0<=e;e--)c(d[e])&&(d[e]._destroy=!0);this.W()},destroyAll:function(b){return b===p?this.destroy(function(){return!0}):b?this.destroy(function(d){return 0<=a.a.m(b,d)}):[]},indexOf:function(b){var d=this();return a.a.m(d,b)},replace:function(a,d){var c=this.indexOf(a);0<=c&&(this.X(),this.v()[c]=d,this.W())}};a.a.u("pop push reverse shift sort splice unshift".split(" "),function(b){a.aa.fn[b]=function(){var a=this.v();this.X();this.sb(a,b,arguments);a=a[b].apply(a,arguments);this.W();
return a}});a.a.u(["slice"],function(b){a.aa.fn[b]=function(){var a=this();return a[b].apply(a,arguments)}});a.a.xa&&a.a.za(a.aa.fn,a.p.fn);a.b("observableArray",a.aa);var J="arrayChange";a.La.trackArrayChanges=function(b){function d(){if(!c){c=!0;var d=b.notifySubscribers;b.notifySubscribers=function(a,b){b&&b!==G||++g;return d.apply(this,arguments)};var f=[].concat(b.v()||[]);e=null;b.U(function(c){c=[].concat(c||[]);if(b.Ab(J)){var d;if(!e||1<g)e=a.a.Fa(f,c,{sparse:!0});d=e;d.length&&b.notifySubscribers(d,
J)}f=c;e=null;g=0})}}if(!b.sb){var c=!1,e=null,g=0,h=b.U;b.U=b.subscribe=function(a,b,c){c===J&&d();return h.apply(this,arguments)};b.sb=function(b,d,m){function l(a,b,c){return q[q.length]={status:a,value:b,index:c}}if(c&&!g){var q=[],h=b.length,t=m.length,z=0;switch(d){case "push":z=h;case "unshift":for(d=0;d<t;d++)l("added",m[d],z+d);break;case "pop":z=h-1;case "shift":h&&l("deleted",b[z],z);break;case "splice":d=Math.min(Math.max(0,0>m[0]?h+m[0]:m[0]),h);for(var h=1===t?h:Math.min(d+(m[1]||0),
h),t=d+t-2,z=Math.max(h,t),u=[],r=[],E=2;d<z;++d,++E)d<h&&r.push(l("deleted",b[d],d)),d<t&&u.push(l("added",m[E],d));a.a.wb(r,u);break;default:return}e=q}}}};a.s=a.j=function(b,d,c){function e(){a.a.G(v,function(a,b){b.K()});v={}}function g(){e();C=0;u=!0;n=!1}function h(){var a=f.throttleEvaluation;a&&0<=a?(clearTimeout(P),P=setTimeout(k,a)):f.ib?f.ib():k()}function k(b){if(t){if(E)throw Error("A 'pure' computed must not be called recursively");}else if(!u){if(w&&w()){if(!z){s();return}}else z=!1;
t=!0;if(y)try{var c={};a.k.Ea({wa:function(a,b){c[b]||(c[b]=1,++C)},s:f,ma:p});C=0;q=r.call(d)}finally{a.k.end(),t=!1}else try{var e=v,m=C;a.k.Ea({wa:function(a,b){u||(m&&e[b]?(v[b]=e[b],++C,delete e[b],--m):v[b]||(v[b]=a.U(h),++C))},s:f,ma:E?p:!C});v={};C=0;try{var l=d?r.call(d):r()}finally{a.k.end(),m&&a.a.G(e,function(a,b){b.K()}),n=!1}f.Pa(q,l)&&(f.notifySubscribers(q,"beforeChange"),q=l,!0!==b&&f.notifySubscribers(q))}finally{t=!1}C||s()}}function f(){if(0<arguments.length){if("function"===typeof O)O.apply(d,
arguments);else throw Error("Cannot write a value to a ko.computed unless you specify a 'write' option. If you wish to read the current value, don't pass any parameters.");return this}a.k.Jb(f);n&&k(!0);return q}function m(){n&&!C&&k(!0);return q}function l(){return n||0<C}var q,n=!0,t=!1,z=!1,u=!1,r=b,E=!1,y=!1;r&&"object"==typeof r?(c=r,r=c.read):(c=c||{},r||(r=c.read));if("function"!=typeof r)throw Error("Pass a function that returns the value of the ko.computed");var O=c.write,x=c.disposeWhenNodeIsRemoved||
c.o||null,B=c.disposeWhen||c.Ia,w=B,s=g,v={},C=0,P=null;d||(d=c.owner);a.P.call(f);a.a.Aa(f,a.j.fn);f.v=m;f.la=function(){return C};f.hc="function"===typeof c.write;f.K=function(){s()};f.Z=l;var A=f.Ta;f.Ta=function(a){A.call(f,a);f.ib=function(){f.kb(q);n=!0;f.lb(f)}};c.pure?(y=E=!0,f.va=function(){y&&(y=!1,k(!0))},f.nb=function(){f.yb()||(e(),y=n=!0)}):c.deferEvaluation&&(f.va=function(){m();delete f.va});a.A(f,"peek",f.v);a.A(f,"dispose",f.K);a.A(f,"isActive",f.Z);a.A(f,"getDependenciesCount",
f.la);x&&(z=!0,x.nodeType&&(w=function(){return!a.a.Ja(x)||B&&B()}));y||c.deferEvaluation||k();x&&l()&&x.nodeType&&(s=function(){a.a.w.Kb(x,s);g()},a.a.w.da(x,s));return f};a.jc=function(b){return a.Ma(b,a.j)};A=a.p.rc;a.j[A]=a.p;a.j.fn={equalityComparer:H};a.j.fn[A]=a.j;a.a.xa&&a.a.za(a.j.fn,a.P.fn);a.b("dependentObservable",a.j);a.b("computed",a.j);a.b("isComputed",a.jc);a.Ib=function(b,d){if("function"===typeof b)return a.s(b,d,{pure:!0});b=a.a.extend({},b);b.pure=!0;return a.s(b,d)};a.b("pureComputed",
a.Ib);(function(){function b(a,g,h){h=h||new c;a=g(a);if("object"!=typeof a||null===a||a===p||a instanceof Date||a instanceof String||a instanceof Number||a instanceof Boolean)return a;var k=a instanceof Array?[]:{};h.save(a,k);d(a,function(c){var d=g(a[c]);switch(typeof d){case "boolean":case "number":case "string":case "function":k[c]=d;break;case "object":case "undefined":var l=h.get(d);k[c]=l!==p?l:b(d,g,h)}});return k}function d(a,b){if(a instanceof Array){for(var c=0;c<a.length;c++)b(c);"function"==
typeof a.toJSON&&b("toJSON")}else for(c in a)b(c)}function c(){this.keys=[];this.hb=[]}a.Qb=function(c){if(0==arguments.length)throw Error("When calling ko.toJS, pass the object you want to convert.");return b(c,function(b){for(var c=0;a.C(b)&&10>c;c++)b=b();return b})};a.toJSON=function(b,c,d){b=a.Qb(b);return a.a.eb(b,c,d)};c.prototype={save:function(b,c){var d=a.a.m(this.keys,b);0<=d?this.hb[d]=c:(this.keys.push(b),this.hb.push(c))},get:function(b){b=a.a.m(this.keys,b);return 0<=b?this.hb[b]:p}}})();
a.b("toJS",a.Qb);a.b("toJSON",a.toJSON);(function(){a.i={q:function(b){switch(a.a.t(b)){case "option":return!0===b.__ko__hasDomDataOptionValue__?a.a.e.get(b,a.d.options.Va):7>=a.a.L?b.getAttributeNode("value")&&b.getAttributeNode("value").specified?b.value:b.text:b.value;case "select":return 0<=b.selectedIndex?a.i.q(b.options[b.selectedIndex]):p;default:return b.value}},ca:function(b,d,c){switch(a.a.t(b)){case "option":switch(typeof d){case "string":a.a.e.set(b,a.d.options.Va,p);"__ko__hasDomDataOptionValue__"in
b&&delete b.__ko__hasDomDataOptionValue__;b.value=d;break;default:a.a.e.set(b,a.d.options.Va,d),b.__ko__hasDomDataOptionValue__=!0,b.value="number"===typeof d?d:""}break;case "select":if(""===d||null===d)d=p;for(var e=-1,g=0,h=b.options.length,k;g<h;++g)if(k=a.i.q(b.options[g]),k==d||""==k&&d===p){e=g;break}if(c||0<=e||d===p&&1<b.size)b.selectedIndex=e;break;default:if(null===d||d===p)d="";b.value=d}}}})();a.b("selectExtensions",a.i);a.b("selectExtensions.readValue",a.i.q);a.b("selectExtensions.writeValue",
a.i.ca);a.h=function(){function b(b){b=a.a.cb(b);123===b.charCodeAt(0)&&(b=b.slice(1,-1));var c=[],d=b.match(e),k,n,t=0;if(d){d.push(",");for(var z=0,u;u=d[z];++z){var r=u.charCodeAt(0);if(44===r){if(0>=t){k&&c.push(n?{key:k,value:n.join("")}:{unknown:k});k=n=t=0;continue}}else if(58===r){if(!n)continue}else if(47===r&&z&&1<u.length)(r=d[z-1].match(g))&&!h[r[0]]&&(b=b.substr(b.indexOf(u)+1),d=b.match(e),d.push(","),z=-1,u="/");else if(40===r||123===r||91===r)++t;else if(41===r||125===r||93===r)--t;
else if(!k&&!n){k=34===r||39===r?u.slice(1,-1):u;continue}n?n.push(u):n=[u]}}return c}var d=["true","false","null","undefined"],c=/^(?:[$_a-z][$\w]*|(.+)(\.\s*[$_a-z][$\w]*|\[.+\]))$/i,e=RegExp("\"(?:[^\"\\\\]|\\\\.)*\"|'(?:[^'\\\\]|\\\\.)*'|/(?:[^/\\\\]|\\\\.)*/w*|[^\\s:,/][^,\"'{}()/:[\\]]*[^\\s,\"'{}()/:[\\]]|[^\\s]","g"),g=/[\])"'A-Za-z0-9_$]+$/,h={"in":1,"return":1,"typeof":1},k={};return{ha:[],V:k,Wa:b,ya:function(f,m){function e(b,m){var f;if(!z){var u=a.getBindingHandler(b);if(u&&u.preprocess&&
!(m=u.preprocess(m,b,e)))return;if(u=k[b])f=m,0<=a.a.m(d,f)?f=!1:(u=f.match(c),f=null===u?!1:u[1]?"Object("+u[1]+")"+u[2]:f),u=f;u&&h.push("'"+b+"':function(_z){"+f+"=_z}")}t&&(m="function(){return "+m+" }");g.push("'"+b+"':"+m)}m=m||{};var g=[],h=[],t=m.valueAccessors,z=m.bindingParams,u="string"===typeof f?b(f):f;a.a.u(u,function(a){e(a.key||a.unknown,a.value)});h.length&&e("_ko_property_writers","{"+h.join(",")+" }");return g.join(",")},lc:function(a,b){for(var c=0;c<a.length;c++)if(a[c].key==
b)return!0;return!1},pa:function(b,c,d,e,k){if(b&&a.C(b))!a.Ra(b)||k&&b.v()===e||b(e);else if((b=c.get("_ko_property_writers"))&&b[d])b[d](e)}}}();a.b("expressionRewriting",a.h);a.b("expressionRewriting.bindingRewriteValidators",a.h.ha);a.b("expressionRewriting.parseObjectLiteral",a.h.Wa);a.b("expressionRewriting.preProcessBindings",a.h.ya);a.b("expressionRewriting._twoWayBindings",a.h.V);a.b("jsonExpressionRewriting",a.h);a.b("jsonExpressionRewriting.insertPropertyAccessorsIntoJson",a.h.ya);(function(){function b(a){return 8==
a.nodeType&&h.test(g?a.text:a.nodeValue)}function d(a){return 8==a.nodeType&&k.test(g?a.text:a.nodeValue)}function c(a,c){for(var f=a,e=1,k=[];f=f.nextSibling;){if(d(f)&&(e--,0===e))return k;k.push(f);b(f)&&e++}if(!c)throw Error("Cannot find closing comment tag to match: "+a.nodeValue);return null}function e(a,b){var d=c(a,b);return d?0<d.length?d[d.length-1].nextSibling:a.nextSibling:null}var g=v&&"\x3c!--test--\x3e"===v.createComment("test").text,h=g?/^\x3c!--\s*ko(?:\s+([\s\S]+))?\s*--\x3e$/:/^\s*ko(?:\s+([\s\S]+))?\s*$/,
k=g?/^\x3c!--\s*\/ko\s*--\x3e$/:/^\s*\/ko\s*$/,f={ul:!0,ol:!0};a.f={Q:{},childNodes:function(a){return b(a)?c(a):a.childNodes},ja:function(c){if(b(c)){c=a.f.childNodes(c);for(var d=0,f=c.length;d<f;d++)a.removeNode(c[d])}else a.a.Ka(c)},T:function(c,d){if(b(c)){a.f.ja(c);for(var f=c.nextSibling,e=0,k=d.length;e<k;e++)f.parentNode.insertBefore(d[e],f)}else a.a.T(c,d)},Hb:function(a,c){b(a)?a.parentNode.insertBefore(c,a.nextSibling):a.firstChild?a.insertBefore(c,a.firstChild):a.appendChild(c)},Bb:function(c,
d,f){f?b(c)?c.parentNode.insertBefore(d,f.nextSibling):f.nextSibling?c.insertBefore(d,f.nextSibling):c.appendChild(d):a.f.Hb(c,d)},firstChild:function(a){return b(a)?!a.nextSibling||d(a.nextSibling)?null:a.nextSibling:a.firstChild},nextSibling:function(a){b(a)&&(a=e(a));return a.nextSibling&&d(a.nextSibling)?null:a.nextSibling},gc:b,xc:function(a){return(a=(g?a.text:a.nodeValue).match(h))?a[1]:null},Fb:function(c){if(f[a.a.t(c)]){var k=c.firstChild;if(k){do if(1===k.nodeType){var g;g=k.firstChild;
var h=null;if(g){do if(h)h.push(g);else if(b(g)){var t=e(g,!0);t?g=t:h=[g]}else d(g)&&(h=[g]);while(g=g.nextSibling)}if(g=h)for(h=k.nextSibling,t=0;t<g.length;t++)h?c.insertBefore(g[t],h):c.appendChild(g[t])}while(k=k.nextSibling)}}}}})();a.b("virtualElements",a.f);a.b("virtualElements.allowedBindings",a.f.Q);a.b("virtualElements.emptyNode",a.f.ja);a.b("virtualElements.insertAfter",a.f.Bb);a.b("virtualElements.prepend",a.f.Hb);a.b("virtualElements.setDomNodeChildren",a.f.T);(function(){a.J=function(){this.Yb=
{}};a.a.extend(a.J.prototype,{nodeHasBindings:function(b){switch(b.nodeType){case 1:return null!=b.getAttribute("data-bind")||a.g.getComponentNameForNode(b);case 8:return a.f.gc(b);default:return!1}},getBindings:function(b,d){var c=this.getBindingsString(b,d),c=c?this.parseBindingsString(c,d,b):null;return a.g.mb(c,b,d,!1)},getBindingAccessors:function(b,d){var c=this.getBindingsString(b,d),c=c?this.parseBindingsString(c,d,b,{valueAccessors:!0}):null;return a.g.mb(c,b,d,!0)},getBindingsString:function(b){switch(b.nodeType){case 1:return b.getAttribute("data-bind");
case 8:return a.f.xc(b);default:return null}},parseBindingsString:function(b,d,c,e){try{var g=this.Yb,h=b+(e&&e.valueAccessors||""),k;if(!(k=g[h])){var f,m="with($context){with($data||{}){return{"+a.h.ya(b,e)+"}}}";f=new Function("$context","$element",m);k=g[h]=f}return k(d,c)}catch(l){throw l.message="Unable to parse bindings.\nBindings value: "+b+"\nMessage: "+l.message,l;}}});a.J.instance=new a.J})();a.b("bindingProvider",a.J);(function(){function b(a){return function(){return a}}function d(a){return a()}
function c(b){return a.a.na(a.k.B(b),function(a,c){return function(){return b()[c]}})}function e(a,b){return c(this.getBindings.bind(this,a,b))}function g(b,c,d){var f,e=a.f.firstChild(c),k=a.J.instance,g=k.preprocessNode;if(g){for(;f=e;)e=a.f.nextSibling(f),g.call(k,f);e=a.f.firstChild(c)}for(;f=e;)e=a.f.nextSibling(f),h(b,f,d)}function h(b,c,d){var e=!0,k=1===c.nodeType;k&&a.f.Fb(c);if(k&&d||a.J.instance.nodeHasBindings(c))e=f(c,null,b,d).shouldBindDescendants;e&&!l[a.a.t(c)]&&g(b,c,!k)}function k(b){var c=
[],d={},f=[];a.a.G(b,function y(e){if(!d[e]){var k=a.getBindingHandler(e);k&&(k.after&&(f.push(e),a.a.u(k.after,function(c){if(b[c]){if(-1!==a.a.m(f,c))throw Error("Cannot combine the following bindings, because they have a cyclic dependency: "+f.join(", "));y(c)}}),f.length--),c.push({key:e,zb:k}));d[e]=!0}});return c}function f(b,c,f,g){var m=a.a.e.get(b,q);if(!c){if(m)throw Error("You cannot apply bindings multiple times to the same element.");a.a.e.set(b,q,!0)}!m&&g&&a.Ob(b,f);var l;if(c&&"function"!==
typeof c)l=c;else{var h=a.J.instance,n=h.getBindingAccessors||e,s=a.j(function(){(l=c?c(f,b):n.call(h,b,f))&&f.I&&f.I();return l},null,{o:b});l&&s.Z()||(s=null)}var v;if(l){var w=s?function(a){return function(){return d(s()[a])}}:function(a){return l[a]},A=function(){return a.a.na(s?s():l,d)};A.get=function(a){return l[a]&&d(w(a))};A.has=function(a){return a in l};g=k(l);a.a.u(g,function(c){var d=c.zb.init,e=c.zb.update,k=c.key;if(8===b.nodeType&&!a.f.Q[k])throw Error("The binding '"+k+"' cannot be used with virtual elements");
try{"function"==typeof d&&a.k.B(function(){var a=d(b,w(k),A,f.$data,f);if(a&&a.controlsDescendantBindings){if(v!==p)throw Error("Multiple bindings ("+v+" and "+k+") are trying to control descendant bindings of the same element. You cannot use these bindings together on the same element.");v=k}}),"function"==typeof e&&a.j(function(){e(b,w(k),A,f.$data,f)},null,{o:b})}catch(g){throw g.message='Unable to process binding "'+k+": "+l[k]+'"\nMessage: '+g.message,g;}})}return{shouldBindDescendants:v===p}}
function m(b){return b&&b instanceof a.N?b:new a.N(b)}a.d={};var l={script:!0};a.getBindingHandler=function(b){return a.d[b]};a.N=function(b,c,d,f){var e=this,k="function"==typeof b&&!a.C(b),g,m=a.j(function(){var g=k?b():b,l=a.a.c(g);c?(c.I&&c.I(),a.a.extend(e,c),m&&(e.I=m)):(e.$parents=[],e.$root=l,e.ko=a);e.$rawData=g;e.$data=l;d&&(e[d]=l);f&&f(e,c,l);return e.$data},null,{Ia:function(){return g&&!a.a.ob(g)},o:!0});m.Z()&&(e.I=m,m.equalityComparer=null,g=[],m.Tb=function(b){g.push(b);a.a.w.da(b,
function(b){a.a.ua(g,b);g.length||(m.K(),e.I=m=p)})})};a.N.prototype.createChildContext=function(b,c,d){return new a.N(b,this,c,function(a,b){a.$parentContext=b;a.$parent=b.$data;a.$parents=(b.$parents||[]).slice(0);a.$parents.unshift(a.$parent);d&&d(a)})};a.N.prototype.extend=function(b){return new a.N(this.I||this.$data,this,null,function(c,d){c.$rawData=d.$rawData;a.a.extend(c,"function"==typeof b?b():b)})};var q=a.a.e.F(),n=a.a.e.F();a.Ob=function(b,c){if(2==arguments.length)a.a.e.set(b,n,c),
c.I&&c.I.Tb(b);else return a.a.e.get(b,n)};a.ra=function(b,c,d){1===b.nodeType&&a.f.Fb(b);return f(b,c,m(d),!0)};a.Wb=function(d,f,e){e=m(e);return a.ra(d,"function"===typeof f?c(f.bind(null,e,d)):a.a.na(f,b),e)};a.Ca=function(a,b){1!==b.nodeType&&8!==b.nodeType||g(m(a),b,!0)};a.pb=function(a,b){!w&&s.jQuery&&(w=s.jQuery);if(b&&1!==b.nodeType&&8!==b.nodeType)throw Error("ko.applyBindings: first parameter should be your view model; second parameter should be a DOM node");b=b||s.document.body;h(m(a),
b,!0)};a.Ha=function(b){switch(b.nodeType){case 1:case 8:var c=a.Ob(b);if(c)return c;if(b.parentNode)return a.Ha(b.parentNode)}return p};a.$b=function(b){return(b=a.Ha(b))?b.$data:p};a.b("bindingHandlers",a.d);a.b("applyBindings",a.pb);a.b("applyBindingsToDescendants",a.Ca);a.b("applyBindingAccessorsToNode",a.ra);a.b("applyBindingsToNode",a.Wb);a.b("contextFor",a.Ha);a.b("dataFor",a.$b)})();(function(b){function d(d,f){var e=g.hasOwnProperty(d)?g[d]:b,l;e||(e=g[d]=new a.P,c(d,function(a){h[d]=a;delete g[d];
l?e.notifySubscribers(a):setTimeout(function(){e.notifySubscribers(a)},0)}),l=!0);e.U(f)}function c(a,b){e("getConfig",[a],function(c){c?e("loadComponent",[a,c],function(a){b(a)}):b(null)})}function e(c,d,g,l){l||(l=a.g.loaders.slice(0));var h=l.shift();if(h){var n=h[c];if(n){var t=!1;if(n.apply(h,d.concat(function(a){t?g(null):null!==a?g(a):e(c,d,g,l)}))!==b&&(t=!0,!h.suppressLoaderExceptions))throw Error("Component loaders must supply values by invoking the callback, not by returning values synchronously.");
}else e(c,d,g,l)}else g(null)}var g={},h={};a.g={get:function(a,c){var e=h.hasOwnProperty(a)?h[a]:b;e?setTimeout(function(){c(e)},0):d(a,c)},tb:function(a){delete h[a]},jb:e};a.g.loaders=[];a.b("components",a.g);a.b("components.get",a.g.get);a.b("components.clearCachedDefinition",a.g.tb)})();(function(){function b(b,c,d,e){function k(){0===--u&&e(h)}var h={},u=2,r=d.template;d=d.viewModel;r?g(c,r,function(c){a.g.jb("loadTemplate",[b,c],function(a){h.template=a;k()})}):k();d?g(c,d,function(c){a.g.jb("loadViewModel",
[b,c],function(a){h[f]=a;k()})}):k()}function d(a,b,c){if("function"===typeof b)c(function(a){return new b(a)});else if("function"===typeof b[f])c(b[f]);else if("instance"in b){var e=b.instance;c(function(){return e})}else"viewModel"in b?d(a,b.viewModel,c):a("Unknown viewModel value: "+b)}function c(b){switch(a.a.t(b)){case "script":return a.a.ba(b.text);case "textarea":return a.a.ba(b.value);case "template":if(e(b.content))return a.a.ia(b.content.childNodes)}return a.a.ia(b.childNodes)}function e(a){return s.DocumentFragment?
a instanceof DocumentFragment:a&&11===a.nodeType}function g(a,b,c){"string"===typeof b.require?N||s.require?(N||s.require)([b.require],c):a("Uses require, but no AMD loader is present"):c(b)}function h(a){return function(b){throw Error("Component '"+a+"': "+b);}}var k={};a.g.tc=function(b,c){if(!c)throw Error("Invalid configuration for "+b);if(a.g.Qa(b))throw Error("Component "+b+" is already registered");k[b]=c};a.g.Qa=function(a){return a in k};a.g.wc=function(b){delete k[b];a.g.tb(b)};a.g.ub={getConfig:function(a,
b){b(k.hasOwnProperty(a)?k[a]:null)},loadComponent:function(a,c,d){var e=h(a);g(e,c,function(c){b(a,e,c,d)})},loadTemplate:function(b,d,f){b=h(b);if("string"===typeof d)f(a.a.ba(d));else if(d instanceof Array)f(d);else if(e(d))f(a.a.S(d.childNodes));else if(d.element)if(d=d.element,s.HTMLElement?d instanceof HTMLElement:d&&d.tagName&&1===d.nodeType)f(c(d));else if("string"===typeof d){var k=v.getElementById(d);k?f(c(k)):b("Cannot find element with ID "+d)}else b("Unknown element type: "+d);else b("Unknown template value: "+
d)},loadViewModel:function(a,b,c){d(h(a),b,c)}};var f="createViewModel";a.b("components.register",a.g.tc);a.b("components.isRegistered",a.g.Qa);a.b("components.unregister",a.g.wc);a.b("components.defaultLoader",a.g.ub);a.g.loaders.push(a.g.ub);a.g.Ub=k})();(function(){function b(b,e){var g=b.getAttribute("params");if(g){var g=d.parseBindingsString(g,e,b,{valueAccessors:!0,bindingParams:!0}),g=a.a.na(g,function(d){return a.s(d,null,{o:b})}),h=a.a.na(g,function(d){return d.Z()?a.s(function(){return a.a.c(d())},
null,{o:b}):d.v()});h.hasOwnProperty("$raw")||(h.$raw=g);return h}return{$raw:{}}}a.g.getComponentNameForNode=function(b){b=a.a.t(b);return a.g.Qa(b)&&b};a.g.mb=function(c,d,g,h){if(1===d.nodeType){var k=a.g.getComponentNameForNode(d);if(k){c=c||{};if(c.component)throw Error('Cannot use the "component" binding on a custom element matching a component');var f={name:k,params:b(d,g)};c.component=h?function(){return f}:f}}return c};var d=new a.J;9>a.a.L&&(a.g.register=function(a){return function(b){v.createElement(b);
return a.apply(this,arguments)}}(a.g.register),v.createDocumentFragment=function(b){return function(){var d=b(),g=a.g.Ub,h;for(h in g)g.hasOwnProperty(h)&&d.createElement(h);return d}}(v.createDocumentFragment))})();(function(){var b=0;a.d.component={init:function(d,c,e,g,h){function k(){var a=f&&f.dispose;"function"===typeof a&&a.call(f);m=null}var f,m;a.a.w.da(d,k);a.s(function(){var e=a.a.c(c()),g,n;"string"===typeof e?g=e:(g=a.a.c(e.name),n=a.a.c(e.params));if(!g)throw Error("No component name specified");
var t=m=++b;a.g.get(g,function(b){if(m===t){k();if(!b)throw Error("Unknown component '"+g+"'");var c=b.template;if(!c)throw Error("Component '"+g+"' has no template");c=a.a.ia(c);a.f.T(d,c);var c=n,e=b.createViewModel;b=e?e.call(b,c,{element:d}):c;c=h.createChildContext(b);f=b;a.Ca(c,d)}})},null,{o:d});return{controlsDescendantBindings:!0}}};a.f.Q.component=!0})();var Q={"class":"className","for":"htmlFor"};a.d.attr={update:function(b,d){var c=a.a.c(d())||{};a.a.G(c,function(c,d){d=a.a.c(d);var h=
!1===d||null===d||d===p;h&&b.removeAttribute(c);8>=a.a.L&&c in Q?(c=Q[c],h?b.removeAttribute(c):b[c]=d):h||b.setAttribute(c,d.toString());"name"===c&&a.a.Mb(b,h?"":d.toString())})}};(function(){a.d.checked={after:["value","attr"],init:function(b,d,c){function e(){var e=b.checked,k=q?h():e;if(!a.Y.ma()&&(!f||e)){var g=a.k.B(d);m?l!==k?(e&&(a.a.ea(g,k,!0),a.a.ea(g,l,!1)),l=k):a.a.ea(g,k,e):a.h.pa(g,c,"checked",k,!0)}}function g(){var c=a.a.c(d());b.checked=m?0<=a.a.m(c,h()):k?c:h()===c}var h=a.Ib(function(){return c.has("checkedValue")?
a.a.c(c.get("checkedValue")):c.has("value")?a.a.c(c.get("value")):b.value}),k="checkbox"==b.type,f="radio"==b.type;if(k||f){var m=k&&a.a.c(d())instanceof Array,l=m?h():p,q=f||m;f&&!b.name&&a.d.uniqueName.init(b,function(){return!0});a.s(e,null,{o:b});a.a.n(b,"click",e);a.s(g,null,{o:b})}}};a.h.V.checked=!0;a.d.checkedValue={update:function(b,d){b.value=a.a.c(d())}}})();a.d.css={update:function(b,d){var c=a.a.c(d());"object"==typeof c?a.a.G(c,function(c,d){d=a.a.c(d);a.a.Ba(b,c,d)}):(c=String(c||""),
a.a.Ba(b,b.__ko__cssValue,!1),b.__ko__cssValue=c,a.a.Ba(b,c,!0))}};a.d.enable={update:function(b,d){var c=a.a.c(d());c&&b.disabled?b.removeAttribute("disabled"):c||b.disabled||(b.disabled=!0)}};a.d.disable={update:function(b,d){a.d.enable.update(b,function(){return!a.a.c(d())})}};a.d.event={init:function(b,d,c,e,g){var h=d()||{};a.a.G(h,function(k){"string"==typeof k&&a.a.n(b,k,function(b){var h,l=d()[k];if(l){try{var q=a.a.S(arguments);e=g.$data;q.unshift(e);h=l.apply(e,q)}finally{!0!==h&&(b.preventDefault?
b.preventDefault():b.returnValue=!1)}!1===c.get(k+"Bubble")&&(b.cancelBubble=!0,b.stopPropagation&&b.stopPropagation())}})})}};a.d.foreach={Eb:function(b){return function(){var d=b(),c=a.a.Xa(d);if(!c||"number"==typeof c.length)return{foreach:d,templateEngine:a.O.Oa};a.a.c(d);return{foreach:c.data,as:c.as,includeDestroyed:c.includeDestroyed,afterAdd:c.afterAdd,beforeRemove:c.beforeRemove,afterRender:c.afterRender,beforeMove:c.beforeMove,afterMove:c.afterMove,templateEngine:a.O.Oa}}},init:function(b,
d){return a.d.template.init(b,a.d.foreach.Eb(d))},update:function(b,d,c,e,g){return a.d.template.update(b,a.d.foreach.Eb(d),c,e,g)}};a.h.ha.foreach=!1;a.f.Q.foreach=!0;a.d.hasfocus={init:function(b,d,c){function e(e){b.__ko_hasfocusUpdating=!0;var f=b.ownerDocument;if("activeElement"in f){var g;try{g=f.activeElement}catch(h){g=f.body}e=g===b}f=d();a.h.pa(f,c,"hasfocus",e,!0);b.__ko_hasfocusLastValue=e;b.__ko_hasfocusUpdating=!1}var g=e.bind(null,!0),h=e.bind(null,!1);a.a.n(b,"focus",g);a.a.n(b,"focusin",
g);a.a.n(b,"blur",h);a.a.n(b,"focusout",h)},update:function(b,d){var c=!!a.a.c(d());b.__ko_hasfocusUpdating||b.__ko_hasfocusLastValue===c||(c?b.focus():b.blur(),a.k.B(a.a.oa,null,[b,c?"focusin":"focusout"]))}};a.h.V.hasfocus=!0;a.d.hasFocus=a.d.hasfocus;a.h.V.hasFocus=!0;a.d.html={init:function(){return{controlsDescendantBindings:!0}},update:function(b,d){a.a.$a(b,d())}};I("if");I("ifnot",!1,!0);I("with",!0,!1,function(a,d){return a.createChildContext(d)});var K={};a.d.options={init:function(b){if("select"!==
a.a.t(b))throw Error("options binding applies only to SELECT elements");for(;0<b.length;)b.remove(0);return{controlsDescendantBindings:!0}},update:function(b,d,c){function e(){return a.a.ta(b.options,function(a){return a.selected})}function g(a,b,c){var d=typeof b;return"function"==d?b(a):"string"==d?a[b]:c}function h(c,d){if(q.length){var e=0<=a.a.m(q,a.i.q(d[0]));a.a.Nb(d[0],e);n&&!e&&a.k.B(a.a.oa,null,[b,"change"])}}var k=0!=b.length&&b.multiple?b.scrollTop:null,f=a.a.c(d()),m=c.get("optionsIncludeDestroyed");
d={};var l,q;q=b.multiple?a.a.Da(e(),a.i.q):0<=b.selectedIndex?[a.i.q(b.options[b.selectedIndex])]:[];f&&("undefined"==typeof f.length&&(f=[f]),l=a.a.ta(f,function(b){return m||b===p||null===b||!a.a.c(b._destroy)}),c.has("optionsCaption")&&(f=a.a.c(c.get("optionsCaption")),null!==f&&f!==p&&l.unshift(K)));var n=!1;d.beforeRemove=function(a){b.removeChild(a)};f=h;c.has("optionsAfterRender")&&(f=function(b,d){h(0,d);a.k.B(c.get("optionsAfterRender"),null,[d[0],b!==K?b:p])});a.a.Za(b,l,function(d,e,f){f.length&&
(q=f[0].selected?[a.i.q(f[0])]:[],n=!0);e=b.ownerDocument.createElement("option");d===K?(a.a.bb(e,c.get("optionsCaption")),a.i.ca(e,p)):(f=g(d,c.get("optionsValue"),d),a.i.ca(e,a.a.c(f)),d=g(d,c.get("optionsText"),f),a.a.bb(e,d));return[e]},d,f);a.k.B(function(){c.get("valueAllowUnset")&&c.has("value")?a.i.ca(b,a.a.c(c.get("value")),!0):(b.multiple?q.length&&e().length<q.length:q.length&&0<=b.selectedIndex?a.i.q(b.options[b.selectedIndex])!==q[0]:q.length||0<=b.selectedIndex)&&a.a.oa(b,"change")});
a.a.dc(b);k&&20<Math.abs(k-b.scrollTop)&&(b.scrollTop=k)}};a.d.options.Va=a.a.e.F();a.d.selectedOptions={after:["options","foreach"],init:function(b,d,c){a.a.n(b,"change",function(){var e=d(),g=[];a.a.u(b.getElementsByTagName("option"),function(b){b.selected&&g.push(a.i.q(b))});a.h.pa(e,c,"selectedOptions",g)})},update:function(b,d){if("select"!=a.a.t(b))throw Error("values binding applies only to SELECT elements");var c=a.a.c(d());c&&"number"==typeof c.length&&a.a.u(b.getElementsByTagName("option"),
function(b){var d=0<=a.a.m(c,a.i.q(b));a.a.Nb(b,d)})}};a.h.V.selectedOptions=!0;a.d.style={update:function(b,d){var c=a.a.c(d()||{});a.a.G(c,function(c,d){d=a.a.c(d);if(null===d||d===p||!1===d)d="";b.style[c]=d})}};a.d.submit={init:function(b,d,c,e,g){if("function"!=typeof d())throw Error("The value for a submit binding must be a function");a.a.n(b,"submit",function(a){var c,e=d();try{c=e.call(g.$data,b)}finally{!0!==c&&(a.preventDefault?a.preventDefault():a.returnValue=!1)}})}};a.d.text={init:function(){return{controlsDescendantBindings:!0}},
update:function(b,d){a.a.bb(b,d())}};a.f.Q.text=!0;(function(){if(s&&s.navigator)var b=function(a){if(a)return parseFloat(a[1])},d=s.opera&&s.opera.version&&parseInt(s.opera.version()),c=s.navigator.userAgent,e=b(c.match(/^(?:(?!chrome).)*version\/([^ ]*) safari/i)),g=b(c.match(/Firefox\/([^ ]*)/));if(10>a.a.L)var h=a.a.e.F(),k=a.a.e.F(),f=function(b){var c=this.activeElement;(c=c&&a.a.e.get(c,k))&&c(b)},m=function(b,c){var d=b.ownerDocument;a.a.e.get(d,h)||(a.a.e.set(d,h,!0),a.a.n(d,"selectionchange",
f));a.a.e.set(b,k,c)};a.d.textInput={init:function(b,c,f){function k(c,d){a.a.n(b,c,d)}function h(){var d=a.a.c(c());if(null===d||d===p)d="";v!==p&&d===v?setTimeout(h,4):b.value!==d&&(s=d,b.value=d)}function u(){y||(v=b.value,y=setTimeout(r,4))}function r(){clearTimeout(y);v=y=p;var d=b.value;s!==d&&(s=d,a.h.pa(c(),f,"textInput",d))}var s=b.value,y,v;10>a.a.L?(k("propertychange",function(a){"value"===a.propertyName&&r()}),8==a.a.L&&(k("keyup",r),k("keydown",r)),8<=a.a.L&&(m(b,r),k("dragend",u))):
(k("input",r),5>e&&"textarea"===a.a.t(b)?(k("keydown",u),k("paste",u),k("cut",u)):11>d?k("keydown",u):4>g&&(k("DOMAutoComplete",r),k("dragdrop",r),k("drop",r)));k("change",r);a.s(h,null,{o:b})}};a.h.V.textInput=!0;a.d.textinput={preprocess:function(a,b,c){c("textInput",a)}}})();a.d.uniqueName={init:function(b,d){if(d()){var c="ko_unique_"+ ++a.d.uniqueName.Zb;a.a.Mb(b,c)}}};a.d.uniqueName.Zb=0;a.d.value={after:["options","foreach"],init:function(b,d,c){if("input"!=b.tagName.toLowerCase()||"checkbox"!=
b.type&&"radio"!=b.type){var e=["change"],g=c.get("valueUpdate"),h=!1,k=null;g&&("string"==typeof g&&(g=[g]),a.a.ga(e,g),e=a.a.rb(e));var f=function(){k=null;h=!1;var e=d(),f=a.i.q(b);a.h.pa(e,c,"value",f)};!a.a.L||"input"!=b.tagName.toLowerCase()||"text"!=b.type||"off"==b.autocomplete||b.form&&"off"==b.form.autocomplete||-1!=a.a.m(e,"propertychange")||(a.a.n(b,"propertychange",function(){h=!0}),a.a.n(b,"focus",function(){h=!1}),a.a.n(b,"blur",function(){h&&f()}));a.a.u(e,function(c){var d=f;a.a.vc(c,
"after")&&(d=function(){k=a.i.q(b);setTimeout(f,0)},c=c.substring(5));a.a.n(b,c,d)});var m=function(){var e=a.a.c(d()),f=a.i.q(b);if(null!==k&&e===k)setTimeout(m,0);else if(e!==f)if("select"===a.a.t(b)){var g=c.get("valueAllowUnset"),f=function(){a.i.ca(b,e,g)};f();g||e===a.i.q(b)?setTimeout(f,0):a.k.B(a.a.oa,null,[b,"change"])}else a.i.ca(b,e)};a.s(m,null,{o:b})}else a.ra(b,{checkedValue:d})},update:function(){}};a.h.V.value=!0;a.d.visible={update:function(b,d){var c=a.a.c(d()),e="none"!=b.style.display;
c&&!e?b.style.display="":!c&&e&&(b.style.display="none")}};(function(b){a.d[b]={init:function(d,c,e,g,h){return a.d.event.init.call(this,d,function(){var a={};a[b]=c();return a},e,g,h)}}})("click");a.H=function(){};a.H.prototype.renderTemplateSource=function(){throw Error("Override renderTemplateSource");};a.H.prototype.createJavaScriptEvaluatorBlock=function(){throw Error("Override createJavaScriptEvaluatorBlock");};a.H.prototype.makeTemplateSource=function(b,d){if("string"==typeof b){d=d||v;var c=
d.getElementById(b);if(!c)throw Error("Cannot find template with ID "+b);return new a.r.l(c)}if(1==b.nodeType||8==b.nodeType)return new a.r.fa(b);throw Error("Unknown template type: "+b);};a.H.prototype.renderTemplate=function(a,d,c,e){a=this.makeTemplateSource(a,e);return this.renderTemplateSource(a,d,c)};a.H.prototype.isTemplateRewritten=function(a,d){return!1===this.allowTemplateRewriting?!0:this.makeTemplateSource(a,d).data("isRewritten")};a.H.prototype.rewriteTemplate=function(a,d,c){a=this.makeTemplateSource(a,
c);d=d(a.text());a.text(d);a.data("isRewritten",!0)};a.b("templateEngine",a.H);a.fb=function(){function b(b,c,d,k){b=a.h.Wa(b);for(var f=a.h.ha,m=0;m<b.length;m++){var l=b[m].key;if(f.hasOwnProperty(l)){var q=f[l];if("function"===typeof q){if(l=q(b[m].value))throw Error(l);}else if(!q)throw Error("This template engine does not support the '"+l+"' binding within its templates");}}d="ko.__tr_ambtns(function($context,$element){return(function(){return{ "+a.h.ya(b,{valueAccessors:!0})+" } })()},'"+d.toLowerCase()+
"')";return k.createJavaScriptEvaluatorBlock(d)+c}var d=/(<([a-z]+\d*)(?:\s+(?!data-bind\s*=\s*)[a-z0-9\-]+(?:=(?:\"[^\"]*\"|\'[^\']*\'))?)*\s+)data-bind\s*=\s*(["'])([\s\S]*?)\3/gi,c=/\x3c!--\s*ko\b\s*([\s\S]*?)\s*--\x3e/g;return{ec:function(b,c,d){c.isTemplateRewritten(b,d)||c.rewriteTemplate(b,function(b){return a.fb.nc(b,c)},d)},nc:function(a,g){return a.replace(d,function(a,c,d,e,l){return b(l,c,d,g)}).replace(c,function(a,c){return b(c,"\x3c!-- ko --\x3e","#comment",g)})},Xb:function(b,c){return a.D.Ua(function(d,
k){var f=d.nextSibling;f&&f.nodeName.toLowerCase()===c&&a.ra(f,b,k)})}}}();a.b("__tr_ambtns",a.fb.Xb);(function(){a.r={};a.r.l=function(a){this.l=a};a.r.l.prototype.text=function(){var b=a.a.t(this.l),b="script"===b?"text":"textarea"===b?"value":"innerHTML";if(0==arguments.length)return this.l[b];var d=arguments[0];"innerHTML"===b?a.a.$a(this.l,d):this.l[b]=d};var b=a.a.e.F()+"_";a.r.l.prototype.data=function(c){if(1===arguments.length)return a.a.e.get(this.l,b+c);a.a.e.set(this.l,b+c,arguments[1])};
var d=a.a.e.F();a.r.fa=function(a){this.l=a};a.r.fa.prototype=new a.r.l;a.r.fa.prototype.text=function(){if(0==arguments.length){var b=a.a.e.get(this.l,d)||{};b.gb===p&&b.Ga&&(b.gb=b.Ga.innerHTML);return b.gb}a.a.e.set(this.l,d,{gb:arguments[0]})};a.r.l.prototype.nodes=function(){if(0==arguments.length)return(a.a.e.get(this.l,d)||{}).Ga;a.a.e.set(this.l,d,{Ga:arguments[0]})};a.b("templateSources",a.r);a.b("templateSources.domElement",a.r.l);a.b("templateSources.anonymousTemplate",a.r.fa)})();(function(){function b(b,
c,d){var e;for(c=a.f.nextSibling(c);b&&(e=b)!==c;)b=a.f.nextSibling(e),d(e,b)}function d(c,d){if(c.length){var e=c[0],g=c[c.length-1],h=e.parentNode,n=a.J.instance,t=n.preprocessNode;if(t){b(e,g,function(a,b){var c=a.previousSibling,d=t.call(n,a);d&&(a===e&&(e=d[0]||b),a===g&&(g=d[d.length-1]||c))});c.length=0;if(!e)return;e===g?c.push(e):(c.push(e,g),a.a.ka(c,h))}b(e,g,function(b){1!==b.nodeType&&8!==b.nodeType||a.pb(d,b)});b(e,g,function(b){1!==b.nodeType&&8!==b.nodeType||a.D.Sb(b,[d])});a.a.ka(c,
h)}}function c(a){return a.nodeType?a:0<a.length?a[0]:null}function e(b,e,h,l,q){q=q||{};var n=b&&c(b),n=n&&n.ownerDocument,t=q.templateEngine||g;a.fb.ec(h,t,n);h=t.renderTemplate(h,l,q,n);if("number"!=typeof h.length||0<h.length&&"number"!=typeof h[0].nodeType)throw Error("Template engine must return an array of DOM nodes");n=!1;switch(e){case "replaceChildren":a.f.T(b,h);n=!0;break;case "replaceNode":a.a.Lb(b,h);n=!0;break;case "ignoreTargetNode":break;default:throw Error("Unknown renderMode: "+
e);}n&&(d(h,l),q.afterRender&&a.k.B(q.afterRender,null,[h,l.$data]));return h}var g;a.ab=function(b){if(b!=p&&!(b instanceof a.H))throw Error("templateEngine must inherit from ko.templateEngine");g=b};a.Ya=function(b,d,h,l,q){h=h||{};if((h.templateEngine||g)==p)throw Error("Set a template engine before calling renderTemplate");q=q||"replaceChildren";if(l){var n=c(l);return a.j(function(){var g=d&&d instanceof a.N?d:new a.N(a.a.c(d)),p=a.C(b)?b():"function"===typeof b?b(g.$data,g):b,g=e(l,q,p,g,h);
"replaceNode"==q&&(l=g,n=c(l))},null,{Ia:function(){return!n||!a.a.Ja(n)},o:n&&"replaceNode"==q?n.parentNode:n})}return a.D.Ua(function(c){a.Ya(b,d,h,c,"replaceNode")})};a.uc=function(b,c,g,h,q){function n(a,b){d(b,s);g.afterRender&&g.afterRender(b,a)}function t(c,d){s=q.createChildContext(c,g.as,function(a){a.$index=d});var f=a.C(b)?b():"function"===typeof b?b(c,s):b;return e(null,"ignoreTargetNode",f,s,g)}var s;return a.j(function(){var b=a.a.c(c)||[];"undefined"==typeof b.length&&(b=[b]);b=a.a.ta(b,
function(b){return g.includeDestroyed||b===p||null===b||!a.a.c(b._destroy)});a.k.B(a.a.Za,null,[h,b,t,g,n])},null,{o:h})};var h=a.a.e.F();a.d.template={init:function(b,c){var d=a.a.c(c());"string"==typeof d||d.name?a.f.ja(b):(d=a.f.childNodes(b),d=a.a.oc(d),(new a.r.fa(b)).nodes(d));return{controlsDescendantBindings:!0}},update:function(b,c,d,e,g){var n=c(),t;c=a.a.c(n);d=!0;e=null;"string"==typeof c?c={}:(n=c.name,"if"in c&&(d=a.a.c(c["if"])),d&&"ifnot"in c&&(d=!a.a.c(c.ifnot)),t=a.a.c(c.data));
"foreach"in c?e=a.uc(n||b,d&&c.foreach||[],c,b,g):d?(g="data"in c?g.createChildContext(t,c.as):g,e=a.Ya(n||b,g,c,b)):a.f.ja(b);g=e;(t=a.a.e.get(b,h))&&"function"==typeof t.K&&t.K();a.a.e.set(b,h,g&&g.Z()?g:p)}};a.h.ha.template=function(b){b=a.h.Wa(b);return 1==b.length&&b[0].unknown||a.h.lc(b,"name")?null:"This template engine does not support anonymous templates nested within its templates"};a.f.Q.template=!0})();a.b("setTemplateEngine",a.ab);a.b("renderTemplate",a.Ya);a.a.wb=function(a,d,c){if(a.length&&
d.length){var e,g,h,k,f;for(e=g=0;(!c||e<c)&&(k=a[g]);++g){for(h=0;f=d[h];++h)if(k.value===f.value){k.moved=f.index;f.moved=k.index;d.splice(h,1);e=h=0;break}e+=h}}};a.a.Fa=function(){function b(b,c,e,g,h){var k=Math.min,f=Math.max,m=[],l,q=b.length,n,p=c.length,s=p-q||1,u=q+p+1,r,v,w;for(l=0;l<=q;l++)for(v=r,m.push(r=[]),w=k(p,l+s),n=f(0,l-1);n<=w;n++)r[n]=n?l?b[l-1]===c[n-1]?v[n-1]:k(v[n]||u,r[n-1]||u)+1:n+1:l+1;k=[];f=[];s=[];l=q;for(n=p;l||n;)p=m[l][n]-1,n&&p===m[l][n-1]?f.push(k[k.length]={status:e,
value:c[--n],index:n}):l&&p===m[l-1][n]?s.push(k[k.length]={status:g,value:b[--l],index:l}):(--n,--l,h.sparse||k.push({status:"retained",value:c[n]}));a.a.wb(f,s,10*q);return k.reverse()}return function(a,c,e){e="boolean"===typeof e?{dontLimitMoves:e}:e||{};a=a||[];c=c||[];return a.length<=c.length?b(a,c,"added","deleted",e):b(c,a,"deleted","added",e)}}();a.b("utils.compareArrays",a.a.Fa);(function(){function b(b,d,g,h,k){var f=[],m=a.j(function(){var l=d(g,k,a.a.ka(f,b))||[];0<f.length&&(a.a.Lb(f,
l),h&&a.k.B(h,null,[g,l,k]));f.length=0;a.a.ga(f,l)},null,{o:b,Ia:function(){return!a.a.ob(f)}});return{$:f,j:m.Z()?m:p}}var d=a.a.e.F();a.a.Za=function(c,e,g,h,k){function f(b,d){x=q[d];r!==d&&(A[b]=x);x.Na(r++);a.a.ka(x.$,c);s.push(x);w.push(x)}function m(b,c){if(b)for(var d=0,e=c.length;d<e;d++)c[d]&&a.a.u(c[d].$,function(a){b(a,d,c[d].sa)})}e=e||[];h=h||{};var l=a.a.e.get(c,d)===p,q=a.a.e.get(c,d)||[],n=a.a.Da(q,function(a){return a.sa}),t=a.a.Fa(n,e,h.dontLimitMoves),s=[],u=0,r=0,v=[],w=[];e=
[];for(var A=[],n=[],x,B=0,D,F;D=t[B];B++)switch(F=D.moved,D.status){case "deleted":F===p&&(x=q[u],x.j&&x.j.K(),v.push.apply(v,a.a.ka(x.$,c)),h.beforeRemove&&(e[B]=x,w.push(x)));u++;break;case "retained":f(B,u++);break;case "added":F!==p?f(B,F):(x={sa:D.value,Na:a.p(r++)},s.push(x),w.push(x),l||(n[B]=x))}m(h.beforeMove,A);a.a.u(v,h.beforeRemove?a.R:a.removeNode);for(var B=0,l=a.f.firstChild(c),G;x=w[B];B++){x.$||a.a.extend(x,b(c,g,x.sa,k,x.Na));for(u=0;t=x.$[u];l=t.nextSibling,G=t,u++)t!==l&&a.f.Bb(c,
t,G);!x.ic&&k&&(k(x.sa,x.$,x.Na),x.ic=!0)}m(h.beforeRemove,e);m(h.afterMove,A);m(h.afterAdd,n);a.a.e.set(c,d,s)}})();a.b("utils.setDomNodeChildrenFromArrayMapping",a.a.Za);a.O=function(){this.allowTemplateRewriting=!1};a.O.prototype=new a.H;a.O.prototype.renderTemplateSource=function(b){var d=(9>a.a.L?0:b.nodes)?b.nodes():null;if(d)return a.a.S(d.cloneNode(!0).childNodes);b=b.text();return a.a.ba(b)};a.O.Oa=new a.O;a.ab(a.O.Oa);a.b("nativeTemplateEngine",a.O);(function(){a.Sa=function(){var a=this.kc=
function(){if(!w||!w.tmpl)return 0;try{if(0<=w.tmpl.tag.tmpl.open.toString().indexOf("__"))return 2}catch(a){}return 1}();this.renderTemplateSource=function(b,e,g){g=g||{};if(2>a)throw Error("Your version of jQuery.tmpl is too old. Please upgrade to jQuery.tmpl 1.0.0pre or later.");var h=b.data("precompiled");h||(h=b.text()||"",h=w.template(null,"{{ko_with $item.koBindingContext}}"+h+"{{/ko_with}}"),b.data("precompiled",h));b=[e.$data];e=w.extend({koBindingContext:e},g.templateOptions);e=w.tmpl(h,
b,e);e.appendTo(v.createElement("div"));w.fragments={};return e};this.createJavaScriptEvaluatorBlock=function(a){return"{{ko_code ((function() { return "+a+" })()) }}"};this.addTemplate=function(a,b){v.write("<script type='text/html' id='"+a+"'>"+b+"\x3c/script>")};0<a&&(w.tmpl.tag.ko_code={open:"__.push($1 || '');"},w.tmpl.tag.ko_with={open:"with($1) {",close:"} "})};a.Sa.prototype=new a.H;var b=new a.Sa;0<b.kc&&a.ab(b);a.b("jqueryTmplTemplateEngine",a.Sa)})()})})();})();
;
eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('P V=(O(k,l,o,p){P q=0;P r=1;P s=2;P u=3;P w=4;P x=5;P y=6;P z=7;P A=8;P B=9;P C=42;P D="1Z-26-28\'T\'29:1W:2n(.2o)";P E=D+"1B";P F=[\'2G\',\'2H\',\'2u\',\'2K\',\'2R\',\'3l\',\'3x\',\'3y\',\'3K\'];P G=[\'3V\',\'3W\',\'3Z\'];P H=[12,31,24,1i,1i,1O,1];P I=W 2L("(([a-2Z-Z])\\\\2*)|"+"(\\\\("+"((\'.*?\'|\\\\(.*?\\\\)|.)*?)"+"\\\\))|"+"(\'(.*?)\')");P J=k.1s;P K=k.1q.1v;P L=V.1q;L.19=1;L.2E=o.1q.2E;O V(){N 1X((R 1K V)?R:W V(),1g)}O 1X(a,b){P c=b.19;P d;Q(1r(b[c-1])){d=b[--c];b=1d(b,0,c)}Q(!c){a[0]=W k()}X Q(c==1){P e=b[0];Q(e 1K k||2w(e)){a[0]=W k(+e)}X Q(e 1K V){a[0]=2v(e)}X Q(1t(e)){a[0]=W k(0);a=1N(e,d||1b,a)}}X{a[0]=W k(J.1u(k,b));Q(!d){a[0]=1p(a[0])}}Q(1r(d)){1e(a,d)}N a}L.11=1w(11);O 11(a){N a[0].1j===K};L.1e=1w(1e);O 1e(a,b,c){Q(b){Q(!11(a)){Q(c){a[0]=2t(a[0])}a[0].1j=K}}X{Q(11(a)){Q(c){a[0]=1p(a[0])}X{a[0]=W k(+a[0])}}}N a}L.1C=O(){Q(11(R)){N 0}X{N R[0].1C()}};1D(F,O(c,d){L[\'1E\'+c]=O(){N 17(R[0],11(R),d)};Q(d!=A){L[\'3d\'+c]=O(){N 17(R[0],1a,d)}}Q(d!=z){L[\'1G\'+c]=O(a){1H(R,d,a,1g,11(R));N R};Q(d!=A){L[\'3C\'+c]=O(a){1H(R,d,a,1g,1a);N R};L[\'3D\'+(G[d]||c)]=O(a,b){1I(R,d,a,b);N R};L[\'3M\'+(G[d]||c)]=O(a){N 1J(R,a,d)}}}});O 1H(a,b,c,d,e){P f=1c(17,a[0],e);P g=1c(1M,a[0],e);P h=b==r?c%12:f(r);P i=1b;Q(d.19==2&&1r(d[1])){i=d[1];d=[c]}g(b,d);Q(i&&f(r)!=h){g(r,[f(r)-1]);g(s,[1y(f(q),f(r))])}}O 1I(a,b,c,d){c=1k(c);P e=l.1P(c);a[\'1G\'+F[b]](a[\'1E\'+F[b]]()+e,d||1b);Q(e!=c&&b<y){1I(a,b+1,(c-e)*H[b],d)}}O 1J(a,b,c){a=a.21().1e(1a,1a);b=V(b).1e(1a,1a);P v=0;Q(c==q||c==r){1A(P i=y,2M;i>=c;i--){v/=H[i];v+=17(b,1b,i)-17(a,1b,i)}Q(c==r){v+=(b.1R()-a.1R())*12}}X Q(c==s){P d=a.1S().1Y(0,0,0,0);P e=b.1S().1Y(0,0,0,0);v=l.2k((e-d)/C)+((b-e)-(a-d))/C}X{v=(b-a)/[3t,3v,1O,1][c-3]}N v}L.1U=O(){N 1h(1c(17,R,1b))};L.3z=O(){N 1h(1c(17,R,1a))};L.3A=O(n,a){1T(R,n,a,1b);N R};L.3E=O(n,a){1T(R,n,a,1a);N R};L.3F=O(a){N R.3G(1k(a)*7)};L.3J=O(a){N 1J(R,a,s)/7};O 1h(a){N 1U(a(q),a(r),a(s))}O 1U(a,b,c){P d=W k(J(a,b,c));P e=1n(a);P f=e;Q(d<e){f=1n(a-1)}X{P g=1n(a+1);Q(d>=g){f=g}}N l.1P(l.2k((d-f)/C)/7)+1}O 1n(a){P d=W k(J(a,0,4));d.4A(d.1Q()-(d.3U()+6)%7);N d}O 1T(a,n,b,c){P e=1c(17,a,c);P f=1c(1M,a,c);P d=1n(b===p?e(q):b);Q(!c){d=1p(d)}a.1z(+d);f(s,[e(s)+(n-1)*7])}V.22=[23];V.1N=O(a){N+V(\'\'+a)};O 1N(a,b,c){P d=V.22;P i=0;P e;1A(;i<d.19;i++){e=d[i](a,b,c);Q(e){N e}}c[0]=W k(a);N c}O 23(a,b,c){P m=a.25(/^(\\d{4})(-(\\d{2})(-(\\d{2})([T ](\\d{2}):(\\d{2})(:(\\d{2})(\\.(\\d+))?)?(Z|(([-+])(\\d{2})(:?(\\d{2}))?))?)?)?)?$/);Q(m){P d=W k(J(m[1],m[3]?m[3]-1:0,m[5]||1,m[7]||0,m[8]||0,m[10]||0,m[12]?1k(\'0.\'+m[12])*1O:0));Q(m[13]){Q(m[14]){d.4t(d.27()+(m[15]==\'-\'?1:-1)*(1k(m[16])*1i+(m[18]?1k(m[18]):0)))}}X{Q(!b){d=1p(d)}}N c.1z(+d)}}L.1j=O(a,b,c){Q(a===p||!1m(R)){N R[0].1j()}X{N 1L(R,a,b,c,11(R))}};L.1v=L.2I=O(a,b,c){Q(a===p||!1m(R)){N R[0].1v()}X{N 1L(R,a,b,c,1a)}};L.2J=O(){N R.1v(E)};V.2a=\'\';V.2b={\'\':{2c:[\'2N\',\'2O\',\'2P\',\'2Q\',\'2d\',\'2S\',\'2T\',\'2U\',\'2V\',\'2W\',\'2X\',\'2Y\'],2e:[\'30\',\'33\',\'34\',\'35\',\'2d\',\'36\',\'37\',\'38\',\'39\',\'3a\',\'3b\',\'3c\'],2f:[\'3e\',\'3f\',\'3g\',\'3h\',\'3i\',\'3j\',\'3k\'],2g:[\'3m\',\'3n\',\'3o\',\'3p\',\'3q\',\'3r\',\'3s\'],2h:\'3u\',2i:\'3w\'}};V.2j={i:D,u:E};O 1L(b,c,d,e,f){P g=V.2b;P h=g[V.2a]||{};P j=1c(17,b,f);d=(1t(d)?g[d]:d)||{};O 2l(a){N d[a]||h[a]}O 2m(a){Q(e){P i=(a==z?s:a)-1;1A(;i>=0;i--){e.3B(j(i))}}N j(a)}N 1x(b,c,2m,2l,f)}O 1x(a,b,c,d,e){P m;P f;P g=\'\';1F(m=b.25(I)){g+=b.1f(0,m.2p);Q(m[1]){g+=2q(a,m[1],c,d,e)}X Q(m[3]){f=1x(a,m[4],c,d,e);Q(3H(f.3I(/\\D/g,\'\'),10)){g+=f}}X{g+=m[7]||"\'"}b=b.1f(m.2p+m[0].19)}N g+b}O 2q(a,b,c,d,e){P f=b.19;P g;P h=\'\';1F(f>0){g=2r(a,b.1f(0,f),c,d,e);Q(g!==p){h+=g;b=b.1f(f);f=b.19}X{f--}}N h+b}O 2r(a,b,c,e,f){P g=V.2j[b];Q(1t(g)){N 1x(a,g,c,e,f)}X Q(2s(g)){N g(a,f||1b,e)}3L(b){U\'2o\':N Y(c(y),3);U\'s\':N c(x);U\'2n\':N Y(c(x));U\'m\':N c(w);U\'1W\':N Y(c(w));U\'h\':N c(u)%12||12;U\'3N\':N Y(c(u)%12||12);U\'H\':N c(u);U\'29\':N Y(c(u));U\'d\':N c(s);U\'28\':N Y(c(s));U\'3O\':N e(\'2g\')[c(z)]||\'\';U\'3P\':N e(\'2f\')[c(z)]||\'\';U\'M\':N c(r)+1;U\'26\':N Y(c(r)+1);U\'3Q\':N e(\'2e\')[c(r)]||\'\';U\'3R\':N e(\'2c\')[c(r)]||\'\';U\'3S\':N(c(q)+\'\').3T(2);U\'1Z\':N c(q);U\'t\':N 1l(c,e).1f(0,1).2x();U\'3X\':N 1l(c,e).2x();U\'T\':N 1l(c,e).1f(0,1);U\'3Y\':N 1l(c,e);U\'z\':U\'2y\':U\'1B\':N f?\'Z\':2z(a,b);U\'w\':N 1h(c);U\'41\':N Y(1h(c));U\'S\':P d=c(s);Q(d>10&&d<20)N\'2A\';N[\'43\',\'44\',\'45\'][d%10-1]||\'2A\'}}O 2z(a,b){P c=a.1C();P d=c<0?\'+\':\'-\';P e=l.1P(l.2B(c)/1i);P f=l.2B(c)%1i;P g=e;Q(b==\'2y\'){g=Y(e)}X Q(b==\'1B\'){g=Y(e)+\':\'+Y(f)}N d+g}O 1l(a,b){N a(u)<12?b(\'2h\'):b(\'2i\')}1D([\'46\',\'47\',\'48\',\'49\',\'4a\',\'4b\',\'4c\',\'4d\'],O(a){L[a]=O(){N R[0][a]()}});L.1z=O(t){R[0].1z(t);N R};L.1m=1w(1m);O 1m(a){N!4e(+a[0])}L.21=O(){N W V(R)};L.2C=O(){N R.4f(0,0,0,0)};L.1S=O(){N W k(+R[0])};V.4g=O(){N+W k()};V.4h=O(){N W V().2C()};V.1s=J;V.1y=1y;O 2v(a){P d=W k(+a[0]);Q(11(a)){d.1j=K}N d}O 17(d,a,b){N d[\'1E\'+(a?\'1s\':\'\')+F[b]]()}O 1M(d,a,b,c){d[\'1G\'+(a?\'1s\':\'\')+F[b]].1u(d,c)}O 2t(a){N W k(J(a.1R(),a.4i(),a.4j(),a.4k(),a.4l(),a.4m(),a.4n()))}O 1p(a){N W k(a.4o(),a.4p(),a.1Q(),a.4q(),a.27(),a.4r(),a.4s())}O 1y(a,b){N 32-W k(J(a,b,32)).1Q()}O 1w(f){N O(){N f.1u(p,[R].2D(1d(1g)))}}O 1c(f){P a=1d(1g,1);N O(){N f.1u(p,a.2D(1d(1g)))}}O 1d(a,b,c){N o.1q.1d.4u(a,b||0,c===p?a.19:c)}O 1D(a,f){1A(P i=0;i<a.19;i++){f(a[i],i)}}O 1t(a){N 1o a==\'4v\'}O 2w(a){N 1o a==\'4w\'}O 1r(a){N 1o a==\'4x\'}O 2s(a){N 1o a==\'O\'}O Y(n,a){a=a||2;n+=\'\';1F(n.19<a){n=\'0\'+n}N n}Q(1o 1V!==\'4y\'&&1V.2F){1V.2F=V}N V})(2u,4z,40);',62,285,'|||||||||||||||||||||||||||||||||||||||||||||||||return|function|var|if|this|||case|XDate|new|else|zeroPad|||getUTCMode||||||_getField||length|true|false|curry|slice|setUTCMode|substr|arguments|_getWeek|60|toString|Number|_getDesignator|valid|getWeek1|typeof|coerceToLocal|prototype|isBoolean|UTC|isString|apply|toUTCString|methodize|_format|getDaysInMonth|setTime|for|zzz|getTimezoneOffset|each|get|while|set|_set|_add|_diff|instanceof|format|_setField|parse|1000|floor|getUTCDate|getFullYear|toDate|_setWeek|getWeek|module|mm|init|setUTCHours|yyyy||clone|parsers|parseISO||match|MM|getUTCMinutes|dd|HH|defaultLocale|locales|monthNames|May|monthNamesShort|dayNames|dayNamesShort|amDesignator|pmDesignator|formatters|round|getSetting|getFieldAndTrace|ss|fff|index|processTokenString|getTokenReplacement|isFunction|coerceToUTC|Date|_clone|isNumber|toLowerCase|zz|_getTZString|th|abs|clearTime|concat|splice|exports|FullYear|Month|toGMTString|toISOString|Hours|RegExp|methodName|January|February|March|April|Minutes|June|July|August|September|October|November|December|zA|Jan|||Feb|Mar|Apr|Jun|Jul|Aug|Sep|Oct|Nov|Dec|getUTC|Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Seconds|Sun|Mon|Tue|Wed|Thu|Fri|Sat|3600000|AM|60000|PM|Milliseconds|Day|getUTCWeek|setWeek|push|setUTC|add|setUTCWeek|addWeeks|addDays|parseInt|replace|diffWeeks|Year|switch|diff|hh|ddd|dddd|MMM|MMMM|yy|substring|getUTCDay|Years|Months|tt|TT|Days|Array|ww|86400000|st|nd|rd|getTime|valueOf|toDateString|toTimeString|toLocaleString|toLocaleDateString|toLocaleTimeString|toJSON|isNaN|setHours|now|today|getMonth|getDate|getHours|getMinutes|getSeconds|getMilliseconds|getUTCFullYear|getUTCMonth|getUTCHours|getUTCSeconds|getUTCMilliseconds|setUTCMinutes|call|string|number|boolean|undefined|Math|setUTCDate'.split('|'),0,{}));

function myshowBox(titles, urls, objWidth, objHeight, types, classname, classname2) {
    var _title = titles;
    var _url = urls;
    var _width = objWidth;
    var _height = objHeight;
    var _type = types;      //ture为iframe,false为div
    var _class = classname;
    var _class2 = classname2;

    /*浏览器高度宽度监测*/
    var findDimensions = function() {
        var winWidth = 0;
        var winHeight = 0;
        if (window.innerWidth) {
            winWidth = window.innerWidth;
        } else if ((document.body) && (document.body.clientWidth)) {
            winWidth = document.body.clientWidth;
        };
        if (window.innerHeight) {
            winHeight = window.innerHeight;
        } else if ((document.body) && (document.body.clientHeight)) {
            winHeight = document.body.clientHeight;
        };
        if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
            winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
        };
        return winWidth + "-" + winHeight;
    };
    var addHTML;
    if (_type == "iframe") {
        addHTML = "<iframe class='iframe-myshowbox' id='myshowbox' src='" + _url + "' frameborder='0' scrolling='no' width='" + _width + "' height='" + _height + "'></iframe>";

        //IE6 BUG fix
        var ieset = navigator.userAgent;
        if (ieset.indexOf("MSIE 6.0") > -1) {
            setTimeout('window.parent[\'myshowbox\'].location.reload();', 0);
        }
    } else {
        addHTML = "<div class='div-myshowbox' style='width:" + _width + "px; height:" + _height + "px;'></div>";
    };

    $("body").append("<div id='mshowbox' class='myshowbox " + _class2 + "'><div class='myshowbox-container " + _class + "'><a class='btn-close' href='javascript:;'><span></span></a><h3 class='title'>" + _title + "</h3>" + addHTML + "</div></div><div id='bgScreen' class='bgScreen'></div><iframe id='bgIFrame' src='about:blank'></iframe>");

    //判断是否有标题
    if (_title == "") {
        $(".myshowbox .title").hide();
    } else {
        $(".myshowbox .title").css("width", _width - 20 + "px");
    };

    /*box fixed*/
    var boxnFixed = function() {
        if (jQuery.browser.version == '6.0') {
            var _wh = findDimensions().split("-");
            $(".myshowbox").css({ "top": ((_wh[1] - $(".myshowbox").height()) / 2 + document.documentElement.scrollTop) + "px", "left": (_wh[0] / 2 + document.documentElement.scrollLeft) });
        }
    };

    $(".myshowbox-container").css("width", _width);
    $(".myshowbox").css("margin", (jQuery.browser.version == '6.0' ? 0 : -$(".myshowbox").height() / 2 - 5) + "px 0 0 " + -$(".myshowbox").width() / 2 + "px");
    $("#bgScreen, #bgIFrame").css("height", jQuery.browser.version == '6.0' ? window.screen.height - 160 : '100%');

    /*position fix*/
    if (jQuery.browser.version == '6.0') {
        boxnFixed();
        $(window).bind('scroll', function () {
            boxnFixed();
        });
        $(".myshowbox").css("left", document.documentElement.scrollLeft + document.documentElement.clientWidth - this.offsetWidth); 
    };

    //绑定关闭弹层事件
    if (HasOn()) {
        $(document).on('click', '.myshowbox-container .btn-close, .myshowbox-container .btn-upgrade-close', function () {
            closeMyShowBox();
        });
    } else {
        $('.myshowbox-container .btn-close, .myshowbox-container .btn-upgrade-close').on('click', function () {
            closeMyShowBox();
        });
    }
};

function closeMyShowBox() {
    /// <summary>
    /// 关闭myshowbox弹层
    /// </summary>
    $(".myshowbox, #bgScreen, #bgIFrame").hide().remove();
};

var HasOn = function () {
    var locaVer = $.fn.jquery;
    var locaVers = locaVer.split(".");
    return locaVers[0] > 1 || locaVers[1] >= 7;
};;


/*STEP2����ʱ��
----------------------------------------------------------------------------
    title:	���ڱ���
  content:  ����(��ѡ����Ϊ){ text | id | img | url | iframe }
    width:	���ݿ��
   height:	���ݸ߶�
	 drag:  �Ƿ�����϶�(tureΪ��,falseΪ��)
     time:	�Զ��رյȴ���ʱ�䣬Ϊ�������Զ��ر�
   showbg:	[��ѡ����]�����Ƿ���ʾ���ֲ�(0Ϊ����ʾ,1Ϊ��ʾ)
  cssName:  [��ѡ����]����class����
 ------------------------------------------------------------------------*/
var showWindown = true;

function tipsWindown(title,content,width,height,drag,time,showbg,cssName,backcall) {
	$("#windown-box").remove(); //�������
	var width = width>= 512?this.width=512:this.width=width;	    //������󴰿ڿ��
	var height = height>= 527?this.height=527:this.height=height;  //������󴰿ڸ߶�
	if(showWindown == true) {
		var simpleWindown_html = new String;
			simpleWindown_html = "<div id=\"windownbg\" style=\"height:"+$(document).height()+"px;filter:alpha(opacity=0);opacity:0;z-index: 9999\"></div>";
			simpleWindown_html += "<div id=\"windown-box\">";
			simpleWindown_html += "<div id=\"windown-title\"><h2></h2><span id=\"windown-close\">�ر�</span></div>";
			simpleWindown_html += "<div id=\"windown-content-border\"><div id=\"windown-content\"></div></div>"; 
			simpleWindown_html += "</div>";
			$("body").append(simpleWindown_html);
			show = false;
	}
	contentType = content.substring(0,content.indexOf(":"));
	content = content.substring(content.indexOf(":")+1,content.length);
	switch(contentType) {
		case "text":
		$("#windown-content").html(content);
		break;
		case "id":
		$("#windown-content").html($("#"+content+"").html());
		break;
		case "img":
		$("#windown-content").ajaxStart(function() {
			$(this).html("<img src='"+templateSrc+"/images/loading.gif' class='loading' />");
		});
		$.ajax({
			error:function(){
				$("#windown-content").html("<p class='windown-error'>�������ݳ���...</p>");
			},
			success:function(html){
				$("#windown-content").html("<img src="+content+" alt='' />");
			}
		});
		break;
		case "url":
		var content_array=content.split("?");
		$("#windown-content").ajaxStart(function(){
			$(this).html("<img src='"+templateSrc+"/images/loading.gif' class='loading' />");
		});
		$.ajax({
			type:content_array[0],
			url:content_array[1],
			data:content_array[2],
			error:function(){
				$("#windown-content").html("<p class='windown-error'>�������ݳ���...</p>");
			},
			success:function(html){
				$("#windown-content").html(html);
				if(backcall)
					backcall();
			}
		});
		break;
		case "iframe":
		$("#windown-content").ajaxStart(function(){
			$(this).html("<img src='"+templateSrc+"/images/loading.gif' class='loading' />");
		});
		$.ajax({
			error:function(){
				$("#windown-content").html("<p class='windown-error'>�������ݳ���...</p>");
			},
			success:function(html){
				$("#windown-content").html("<iframe src=\""+content+"\" width=\"100%\" height=\""+parseInt(height)+"px"+"\" scrolling=\"auto\" frameborder=\"0\" marginheight=\"0\" marginwidth=\"0\"></iframe>");
			}
		});
	}
	$("#windown-title h2").html(title);
	if(showbg == "true") {$("#windownbg").show();}else {$("#windownbg").remove();};
	$("#windownbg").animate({opacity:"0.5"},"normal");//����͸����
	$("#windown-box").show();
	if( height >= 527 ) {
		$("#windown-title").css({width:(parseInt(width))+"px"});
		$("#windown-content").css({width:(parseInt(width))+"px",height:height+"px"});
	}else {
		$("#windown-title").css({width:(parseInt(width))+"px"});
		$("#windown-content").css({width:width+"px",height:height+"px"});
	}
	var	cw = document.documentElement.clientWidth,ch = document.documentElement.clientHeight,est = document.documentElement.scrollTop; 
	var _version = $.browser.version;
	if ( _version == 6.0 ) {
		$("#windown-box").css({left:"50%",top:(parseInt((ch)/2)+est)+"px",marginTop: -((parseInt(height)+53)/2)+"px",marginLeft:-((parseInt(width)+32)/2)+"px",zIndex: "10000"});
	}else {
		$("#windown-box").css({left:"50%",top:"50%",marginTop:-((parseInt(height)+53)/2)+"px",marginLeft:-((parseInt(width)+32)/2)+"px",zIndex: "10000"});
	};
	var Drag_ID = document.getElementById("windown-box"),DragHead = document.getElementById("windown-title");
		
	var moveX = 0,moveY = 0,moveTop,moveLeft = 0,moveable = false;
		if ( _version == 6.0 ) {
			moveTop = est;
		}else {
			moveTop = 0;
		}
	var	sw = Drag_ID.scrollWidth,sh = Drag_ID.scrollHeight;
		DragHead.onmouseover = function(e) {
			if(drag == "true"){DragHead.style.cursor = "move";}else{DragHead.style.cursor = "default";}
		};
		DragHead.onmousedown = function(e) {
		if(drag == "true"){moveable = true;}else{moveable = false;}
		e = window.event?window.event:e;
		var ol = Drag_ID.offsetLeft, ot = Drag_ID.offsetTop-moveTop;
		moveX = e.clientX-ol;
		moveY = e.clientY-ot;
		document.onmousemove = function(e) {
				if (moveable) {
				e = window.event?window.event:e;
				var x = e.clientX - moveX;
				var y = e.clientY - moveY;
					if ( x > 0 &&( x + sw < cw) && y > 0 && (y + sh < ch) ) {
						Drag_ID.style.left = x + "px";
						Drag_ID.style.top = parseInt(y+moveTop) + "px";
						Drag_ID.style.margin = "auto";
						}
					}
				}
		document.onmouseup = function () {moveable = false;};
		Drag_ID.onselectstart = function(e){return false;}
	}
	$("#windown-content").attr("class","windown-"+cssName);
	if( time == "" || typeof(time) == "undefined") {
		$("#windown-close").click(function() {
			showselect('t123_')
			$("#windownbg").remove();
			$("#windown-box").fadeOut("slow",function(){$(this).remove();});
		});
	}else { 
		setTimeout(closeWindown,time);
	}
	hideselect('t123_');
}
var closeWindown = function() {
	showselect('t123_');
	$("#windownbg").remove();
	$("#windown-box").fadeOut("slow",function(){$(this).remove();});
}
function hideselect(per)
{
	var _version = $.browser.version;
	if ( _version == 6.0 ) {
		$("select",document).each(function(){
			if($(this).attr('name'))
			{
				if($(this).attr('name').substring(0,5)==per)
				{
					name = $(this).attr('name').substring(5);
					$(this).attr('name',name);
					$(this).css('display','');
				}
				if($(this).css('display')!='none')
				{
					name = per+$(this).attr('name');
					$(this).attr('name',name);
				}
				$(this).css('display','none');
			}
		});
	}
}
function showselect(per)
{
	var _version = $.browser.version;
	if ( _version == 6.0 ) {
		$("select",document).each(function(){
			if($(this).attr('name'))
			{
				if($(this).attr('name').substring(0,5)==per)
				{
					name = $(this).attr('name').substring(5);
					$(this).attr('name',name);
					$(this).css('display','');
				}
			}
		});
	}
}

/*
*������ҳָ��ID�������ڴ���
*id ָ����Ԫ�ص�id
*title:	window�������ı���
*width:	���ڵĿ�,height:���ڵĸ�
*/
function showTipsWindown(title,id,width,height){
	tipsWindown(title,"id:"+id,width,height,"true","","true",id);
}

function confirmTerm(s) {
	parent.closeWindown();
	if(s == 1) {
		parent.document.getElementById("isread").checked = true;
	}
}

//���������
function popTips(){
	showTipsWindown("", 'simTestContent', 512);
	$("#isread").attr("checked", false);
};
