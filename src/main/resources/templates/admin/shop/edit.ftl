<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>${siteName!""}|店铺|送车点管理-编辑店铺|送车点</title>
<#include "../common/header.ftl"/>
<link href="/admin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">
</head>
  <style>
    .bootstrap-datetimepicker-widget{
      text-align: center;
    }
    .spanSheng{
      border-color: #ebebeb;
      background-color: #f9fafb;
      -webkit-border-radius: 2px;
      border-radius: 2px;
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
      border-right: 0;
      padding: 13px 19px 9px;
      font-size: 14px;
      font-weight: 400;
      line-height: 1;
      color: #555;
      text-align: center;
      background-color: #f9fafb;
      border: 1px solid #ebebeb;
      border-radius: 4px;
      width: 50px;
      white-space: nowrap;
      vertical-align: middle;
      position: absolute;
      left: 0px;
      top: 0px;
    }

    .spanS{
      border-color: #ebebeb;
      background-color: #f9fafb;
      -webkit-border-radius: 2px;
      border-radius: 2px;
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
      border-right: 0;
      padding: 13px 19px 9px;
      font-size: 14px;
      font-weight: 400;
      line-height: 1;
      color: #555;
      text-align: center;
      background-color: #f9fafb;
      border: 1px solid #ebebeb;
      border-radius: 4px;
      width: 50px;
      white-space: nowrap;
      vertical-align: middle;
      position: absolute;
      left: 229px;
      top: 0px;
    }
    .spanQ{
      border-color: #ebebeb;
      background-color: #f9fafb;
      -webkit-border-radius: 2px;
      border-radius: 2px;
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
      border-right: 0;
      padding: 13px 19px 9px;
      font-size: 14px;
      font-weight: 400;
      line-height: 1;
      color: #555;
      text-align: center;
      background-color: #f9fafb;
      border: 1px solid #ebebeb;
      border-radius: 4px;
      width: 50px;
      white-space: nowrap;
      vertical-align: middle;
      position: absolute;
      left: 458px;
      top: 0px;
    }
  </style>
<body>
<div class="lyear-layout-web">
  <div class="lyear-layout-container">
    <!--左侧导航-->
    <aside class="lyear-layout-sidebar">
      
      <!-- logo -->
      <div id="logo" class="sidebar-header">
        <a href="/system/index"><img src="/admin/images/logo-sidebar.png" title="${siteName!""}" alt="${siteName!""}" /></a>
      </div>
      <div class="lyear-layout-sidebar-scroll"> 
        <#include "../common/left-menu.ftl"/>
      </div>
      
    </aside>
    <!--End 左侧导航-->
    
    <#include "../common/header-menu.ftl"/>
    
     <!--页面主要内容-->
    <main class="lyear-layout-content">
      
      <div class="container-fluid">
        
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-header"><h4>编辑店铺|送车点</h4></div>
              <div class="card-body">
                <form action="add" id="user-add-form" method="post" class="row">
                  <input type="hidden" name="id" value="${user.id}">
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">名称</span>
                    <input type="text" class="form-control" placeholder="请输入店铺|送车点名称" tips="请填写店铺|送车点名称" id="shopName" name="shopName" value="${user.shopName}" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">登陆名称</span>
                    <input type="text" class="form-control required" id="username" name="username" value="${user.username}" placeholder="请输入登陆名称" tips="请填写登陆名称" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">登录密码</span>
                    <input type="password" class="form-control required" id="password" name="password" value="${user.password}" placeholder="请输入登录密码" tips="请填写登录密码" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">电话</span>
                    <input type="tel" class="form-control" minlength="1"  placeholder="请输入电话" maxlength="13" id="mobile" name="mobile" value="${user.mobile}" tips="请填写电话号" />
                  </div>
                  <div class="input-group m-b-10 input-daterange input-group" style="width: 30%;">
                    <span class="input-group-addon">营业时间</span>
                    <input type="text" autocomplete="off" tips="请填写营业时间" class="form-control required js-datetimepicker"
                           id="start-time" align="center" name="openingHours" value="${user.openingHours}" placeholder="从"
                           data-side-by-side="true" data-locale="zh-cn" data-format="HH:mm"/>
                    <span class="input-group-addon"><i class="mdi mdi-chevron-right"></i></span>
                    <input type="text" autocomplete="off" class="form-control required js-datetimepicker"
                           id="end-time" name="closeOfBusiness"  tips="请填写营业时间" value="${user.closeOfBusiness}" placeholder="至"
                           data-side-by-side="true" data-locale="zh-cn" data-format="HH:mm"/>
                  </div>
                  <div class="input-group m-b-10">
                    <input type="text" style="visibility:hidden" value="1111" class="form-control required">
                    <div id="distpicker5">
                      <span class="spanSheng">省</span>
                      <select  class="form-control" name="province" id="province10" style="position: absolute;left: 49px;top: 0px;" ></select>
                      <span class="spanS">市</span>
                      <select  class="form-control" id="city10" name="city" style="position: absolute;left: 278px;top: 0px;"></select>
                      <span class="spanQ">区</span>
                      <select class="form-control" id="district10" name="district" style="position: absolute;left: 507px;top: 0px;"></select>
                    </div>
                    <input type="hidden" id="myprovince" value="${user.province}" />
                    <input type="hidden" id="mycity" value="${user.city}" />
                    <input type="hidden" id="myarea" value="${user.district}" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">详细地址</span>
                    <textarea class="form-control" placeholder="请输入详细地址(无需省市区)"  tips="请填写详细地址(无需省市区)" id="site" name="site">${user.site}</textarea>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">服务费(元)</span>
                    <input type="number" class="form-control required" id="serviceCharge"
                           onkeyup="inputDouble(this)"
                           name="serviceCharge" value="${user.serviceCharge}" placeholder="请输入服务费" tips="请填写服务费"  tips="请输入服务费" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">经纬度</span>
                    <input type="tel" class="form-control" value="${user.longitudeAndLatitude}" tips="请填写经纬度" maxlength="100"placeholder="请前往百度地图拾取坐标系统获取坐标并输入(不使用百度地图拾取坐标系统获取的坐标将无法完成定位)"  id="longitudeAndLatitude" name="longitudeAndLatitude"/>
                  </div>
                  <div class="input-group" style="margin-top:15px;margin-bottom:15px;padding-left:25px;">
                    类型：
                    <label class="lyear-radio radio-inline radio-primary" style="margin-left:30px;">
                      <input type="radio" name="type" value="1" <#if user.type == 1> checked </#if> >
                      <span>店铺</span>
                      <label class="lyear-radio radio-inline radio-primary">
                        <input type="radio" name="type" value="2" <#if user.type == 2> checked </#if>>
                        <span>送车点</span>
                  </div>
                  <div class="input-group" style="margin-top:15px;margin-bottom:15px;padding-left:25px;">
                    状态：
                    <label class="lyear-radio radio-inline radio-primary" style="margin-left:30px;">
                    <input type="radio" name="status" value="1" <#if user.status == 1> checked </#if>>
                    <span>正常</span>
                    <label class="lyear-radio radio-inline radio-primary">
                    <input type="radio" name="status" value="0" <#if user.status == 0> checked </#if>>
                    <span>冻结</span>
                  </label>
                  </div>
                  <div class="form-group col-md-12">
                    <button type="button" class="btn btn-primary ajax-post" id="add-form-submit-btn">确 定</button>
                    <button type="button" class="btn btn-default" onclick="javascript:history.back(-1);return false;">返 回</button>
                  </div>
                </form>
       
              </div>
            </div>
          </div>
          
        </div>
        
      </div>
      
    </main>
    <!--End 页面主要内容-->
  </div>
</div>
<#include "../common/footer.ftl"/>
<script src="/admin/bootstrap-datetimepicker/moment.min.js"></script>
<script src="/admin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script src="/admin/bootstrap-datetimepicker/locale/zh-cn.js"></script>
<script src="/admin/Distpicker/js/distpicker.data.js"></script>
<script src="/admin/Distpicker/js/distpicker.js"></script>
<script src="/admin/Distpicker/js/main.js"></script>
<script type="text/javascript" src="/admin/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="/admin/js/main.min.js"></script>
<script>
  function inputDouble(obj){
    obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
    obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字
    obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个, 清除多余的
    obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
  }
  $(function () {
    var province = $("#myprovince").val();
    var city = $("#mycity").val();
    var area = $("#myarea").val();
    $('#distpicker5').distpicker('destroy');
    $("#distpicker5").distpicker({
      province: province,
      city: city,
      district:area
    });
  })
</script>
<script type="text/javascript">
  $('#longitudeAndLatitude').one('click',function(){
    showWarningMsg("请前往百度地图拾取坐标系统获取坐标并输入(不使用百度地图拾取坐标系统获取的坐标将无法完成定位)")
  })
$(document).ready(function(){
	//提交按钮监听事件
	$("#add-form-submit-btn").click(function(){
		if(!checkForm("user-add-form")){
			return;
		}
		var data = $("#user-add-form").serialize();
		$.ajax({
			url:'shopEdit',
			type:'POST',
			data:data,
			dataType:'json',
			success:function(data){
				if(data.code == 0){
					showSuccessMsg('店铺|送车点编辑成功!',function(){
						window.location.href = 'shopList';
					})
				}else{
					showErrorMsg(data.msg);
				}
			},
			error:function(data){
				alert('网络错误!');
			}
		});
	});
	//监听上传图片按钮
	$("#add-pic-btn").click(function(){
		$("#select-file").click();
	});
});
</script>
</body>
</html>