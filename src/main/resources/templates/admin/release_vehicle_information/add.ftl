<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>${siteName!""}|租车信息发布管理-添加租车发布信息</title>
<#include "../common/header.ftl"/>
  <link rel="stylesheet" href="/admin/bootstrap-select/dist/css/bootstrap-select.min.css">
</head>
<style>
  .spanT{
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
    background-color: #eee;
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 1%;
    white-space: nowrap;
    vertical-align: middle;
    position: absolute;
    left: 265px;
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
              <div class="card-header"><h4>添加租车发布信息</h4></div>
              <div class="card-body">
                <form action="add" id="user-add-form" method="post" class="row">
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">车型信息</span>
                    <select name="automobileInformation.id" class="form-control selectpicker" multiple data-live-search="true" data-max-options="1" id="automobileInformation">
                      <#list automobileInformations as automobileInformation>
                        <option  value="${automobileInformation.id}">
                          汽车介绍名称:${automobileInformation.introduceName}&nbsp;&nbsp;&nbsp
                          汽车品牌:${automobileInformation.automobileBrand.brand}&nbsp;&nbsp;&nbsp
                          汽车类型:${automobileInformation.automobileType.getName()}&nbsp;&nbsp;&nbsp
                          汽车日租价格(元):${automobileInformation.dailyRentalRate}
                        </option>
                      </#list>
                    </select>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">其他服务</span>
                    <select name="otherServicesIems" class="form-control selectpicker" multiple data-live-search="true" id="otherServicesIemsSelect">
                      <#list otherServicesIems as otherServicesIems>
                        <option  value="${otherServicesIems.id}">
                          ${otherServicesIems.name}
                        </option>
                      </#list>
                    </select>
                  </div>
                  <div class="input-group m-b-10">
                    <span class="input-group-addon">可租车数量:</span>
                    <input type="number" name="mindmapTopiccarNumber" id="mindmapTopiccarNumber" min="1" max="100" placeholder="请输入可租车数量" class="form-control required" tips="请填写可租车数量" style="width: 180px" >
                    <span class="spanT" >辆</span>
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
<script type="text/javascript" src="/admin/bootstrap-select/js/bootstrap-select.js"></script>
<script type="text/javascript" src="/admin/bootstrap-select/js/i18n/defaults-zh_CN.js"></script>
<script type="text/javascript" src="/admin/js/main.min.js"></script>
<script type="text/javascript">
  $('#otherServicesIemsSelect').on('changed.bs.select', function(e) {
    $("#otherServicesIemsList").val($(this).val());
  });

$(document).ready(function(){
	//提交按钮监听事件
	$("#add-form-submit-btn").click(function(){
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
					showSuccessMsg('租车发布信息添加成功!',function(){
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

  $("#mindmapTopiccarNumber").keyup(function () {
    this.value=this.value.replace(/\D|^[0]+/g,'');
    var reward = $(this).val() == "" ? 0 : $(this).val();
    if ( reward > 10000 ) {
      $(this).val(10000);
    }
  });

</script>
</body>
</html>