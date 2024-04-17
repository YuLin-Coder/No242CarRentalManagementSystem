<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>${siteName!""}|汽车信息管理-添加汽车信息</title>
<#include "../common/header.ftl"/>
</head>

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
        <link rel="stylesheet" href="/admin/jquery-tags-input/jquery.tagsinput.min.css">
        <link href="/admin/css/style.min.css" rel="stylesheet">
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
              <div class="card-header"><h4>添加汽车信息</h4></div>
              <div class="card-body">
                <form action="add" id="user-add-form" method="post" class="row">
                  <div class="form-group col-md-12">
                    <label>汽车介绍图片上传</label>
                    <div class="form-controls">
                      <ul class="list-inline clearfix lyear-uploads-pic">
                        <li class="col-xs-4 col-sm-3 col-md-2">
                          <figure>
                            <img src="/admin/images/default-head.jpg" id="show-picture-img" alt="默认汽车介绍图片">
                          </figure>
                        </li>
                        <input type="hidden" name="automobilePicturePath" id="headPic">
                        <input type="file" id="select-file" style="display:none;" onchange="upload('show-picture-img','headPic')">
                        <li class="col-xs-4 col-sm-3 col-md-2">
                          <a class="pic-add" id="add-pic-btn" href="javascript:void(0)" title="点击上传"></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="form-group col-md-12">
                    <label>汽车介绍视频上传</label>
                    <div class="form-controls">
                      <ul class="list-inline clearfix lyear-uploads-pic">
                        <li class="col-xs-4 col-sm-3 col-md-2">
                          <figure>
                            <video controlsList='nodownload noremote footbar' width="260px" height="260px" src="/admin/images/看妞.mp4" id="show-picture-video" controls="controls" >
                            </video>
                          </figure>
                        </li>
                        <input type="hidden" name="automobileVideoPath" id="headVideo">
                        <input type="file" id="select-video-file" style="display:none;" onchange="uploadVideo('show-picture-video','headVideo')">
                        <li class="col-xs-4 col-sm-3 col-md-2">
                          <a class="pic-add" id="add-video-pic-btn" href="javascript:void(0)" title="点击上传"></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车介绍名称</span>
                    <input type="text" class="form-control required" id="introduceName" name="introduceName" value="" placeholder="请输入汽车介绍名称" tips="请填写汽车介绍名称" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车类型:</span>
                    <select name="automobileType" class="form-control" id="automobileType">
                      <#if automobileType??>
                        <#list automobileType as automobileType>
                          <option value="${automobileType}" style="font-weight:bold;">${automobileType.getName()}</option>
                        </#list>
                      </#if>
                    </select>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车品牌:</span>
                    <select name="automobileBrand.id" class="form-control" id="automobileBrand">
                    	<#list automobileBrands as automobileBrand>
                    	<option value="${automobileBrand.id}">${automobileBrand.brand}</option>
                    	</#list>
                    </select>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车挡位:</span>
                    <select name="automobileStalls"  class="form-control" id="automobileGear">
                      <#if automobileStalls??>
                        <#list automobileStalls as automobileStalls>
                          <option value="${automobileStalls}" style="font-weight:bold;">${automobileStalls.getName()}</option>
                        </#list>
                      </#if>
                    </select>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车座位:</span>
                    <select name="automobileSeat" class="form-control" id="automobileGear">
                      <#if automobileSeat??>
                        <#list automobileSeat as automobileSeat>
                          <option value="${automobileSeat}" style="font-weight:bold;">${automobileSeat.getName()}</option>
                        </#list>
                      </#if>
                    </select>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车排量:</span>
                    <input type="text" class="form-control required" maxlength="3" id="vehicleDisplacementInput" onkeyup="clearNoNum(this)" placeholder="请输入汽车排量" tips="请填写汽车排量" />
                    <select  class="form-control" id="vehicleDisplacementSelect">
                      <option value="T">T</option>
                      <option value="M">M</option>
                      <option value="L">L</option>
                      <option value="i">i</option>
                    </select>
                    <input type="hidden" name="vehicleDisplacement"  id="vehicleDisplacement">
                  </div>

                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车标签:</span>
                    <input class="form-control required js-tags-input" tips="请填写汽车标签"   type="text" id="example-tags" name="introductionLabels"  placeholder="请输入标签" >
                  </div>

                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车日租金额(元)</span>
                    <input type="number" class="form-control required" id="dailyRentalRate"
                           onkeyup="inputDouble(this)"
                           name="dailyRentalRate" value="" tips="请填写汽车日租金额(元)"  placeholder="请输入汽车日租金额" tips="请输入汽车日租金额" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">汽车押金金额(元)</span>
                    <input type="number" class="form-control required" id="vehicleDeposit"
                           onkeyup="inputDouble(this)"
                           name="vehicleDeposit" value="" tips="请填写汽车押金金额(元)"  placeholder="请输入汽车押金金额" tips="请输入汽车押金金额" />
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">违章押金金额(元)</span>
                    <input type="number" class="form-control required" id="violationOfTheDeposit"
                           onkeyup="inputDouble(this)"
                           name="violationOfTheDeposit" tips="请填写违章押金金额(元)" value="" placeholder="请输入违章押金金额" tips="请输入违章押金金额" />
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
<script type="text/javascript" src="/admin/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="/admin/js/main.min.js"></script>
<script src="/admin/jquery-tags-input/jquery.tagsinput.min.js"></script>
<script type="text/javascript">
  function inputDouble(obj){
    obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
    obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字
    obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个, 清除多余的
    obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
  }
  function clearNoNum(obj){
    obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
      obj.value= parseFloat(obj.value);
    }
    if($(obj).val().length>=2){
      if ($(obj).val().charAt(1).indexOf('.')==-1){
        $(obj).val("");
        showErrorMsg("请输入正确排量格式如2.0");
      }else {
        $(obj).val();
      }
    }

  }

$(document).ready(function(){
	//提交按钮监听事件
	$("#add-form-submit-btn").click(function(){
      let vehicleDisplacementInputVal = $('#vehicleDisplacementInput').val();
      let vehicleDisplacementSelectVal = $('#vehicleDisplacementSelect').val();

      $('#vehicleDisplacement').val(vehicleDisplacementInputVal+vehicleDisplacementSelectVal);


		if(!checkForm("user-add-form")){
			return;
		}

      var data = $("#user-add-form").serialize();

		$.ajax({
			url:'add',
			type:'POST',
			data:data,
			dataType:'json',
			success:function(data){
				if(data.code == 0){
					showSuccessMsg('汽车信息添加成功!',function(){
						window.location.href = 'list';
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

  //监听上传视频按钮
  $("#add-video-pic-btn").click(function(){
    $("#select-video-file").click();
  });
});

</script>
</body>
</html>