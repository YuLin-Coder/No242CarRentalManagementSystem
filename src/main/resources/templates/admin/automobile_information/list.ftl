<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, automobileInformation-scalable=no" />
<title>${siteName!""}|汽车信息管理-${title!""}</title>
<#include "../common/header.ftl"/>
<style>
td{
	vertical-align:middle;
}
</style>
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
              <div class="card-toolbar clearfix">
                <form class="pull-right search-bar" method="get" action="list" role="form">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button style="position: absolute;left: -290px;top: 0px; width: 110px" class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                        汽车介绍名称 <#--<span class="caret"></span>-->
                      </button>
                      <ul style="position: absolute;left: -290px;top: 38px;" class="dropdown-menu">
                        <li>  <a tabindex="-1" href="javascript:void(0)" data-field="title">汽车介绍名称</a> </li>
                      </ul>
                    </div>
                    <input style="position: absolute;left: -180px;top: 0px; width:166px" type="text" class="form-control" value="${introduceName!""}" name="introduceName" placeholder="请输入汽车介绍名称">
                    <div  class="input-group-btn">
                      <button class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                        汽车品牌 <#--<span class="caret"></span>-->
                      </button>
                      <ul class="dropdown-menu">
                        <li> <a tabindex="-1" href="javascript:void(0)" data-field="title">汽车品牌</a> </li>
                      </ul>
                    </div>
                    <input type="text" class="form-control js-datetimepicker" value="${brand!""}" name="brand" placeholder="请输入汽车品牌"
                           data-side-by-side="true" data-locale="zh-cn" data-format="YYYY-MM-DD">
                    <span class="input-group-btn">
                      <button class="btn btn-primary" type="submit">搜索</button>
                    </span>
                  </div>
                </form>
                <#include "../common/third-menu.ftl"/>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>
                          <label class="lyear-checkbox checkbox-primary">
                            <input type="checkbox" id="check-all"><span></span>
                          </label>
                        </th>
                        <th>汽车介绍图片</th>
                        <th>汽车介绍视频</th>
                        <th>汽车介绍名称</th>
                        <th>汽车类型</th>
                        <th>汽车品牌</th>
                        <th>汽车挡位</th>
                        <th>汽车座位</th>
                        <th>汽车日租金额(元)</th>
                        <th>汽车押金(元)</th>
                        <th>违章押金(元)</th>
                        <th>添加时间</th>
                      </tr>
                    </thead>
                    <tbody>
                      <#if pageBean.content?size gt 0>
                      <#list pageBean.content as automobileInformation>
                      <tr>
                        <td style="vertical-align:middle;">
                          <label class="lyear-checkbox checkbox-primary">
                            <input type="checkbox" name="ids[]" value="${automobileInformation.id}"><span></span>
                          </label>
                        </td>
                        <td style="vertical-align:middle;">
                        	<#if automobileInformation.automobilePicturePath??>
                        		<#if automobileInformation.automobilePicturePath?length gt 0>
                        		<img src="/photo/view?filename=${automobileInformation.automobilePicturePath}" width="60px" height="60px">
                        		<#else>
                        		<img src="/admin/images/default-head.jpg" width="60px" height="60px">
                        		</#if>
                        	</#if>
                        </td>
                        <td style="vertical-align:middle;">
                          <#if automobileInformation.automobileVideoPath??>
                            <#if automobileInformation.automobileVideoPath?length gt 0>
                              <video width="100px" height="60px" src="/photo/view?filename=${automobileInformation.automobileVideoPath}"  controlsList='nodownload noremote footbar'  controls="controls" >
                              </video>
                            <#else>
                              <video width="100px" controlsList='nodownload noremote footbar' height="60px" src="/admin/images/看妞.mp4" id="show-picture-video" controls="controls" >
                              </video>
                            </#if>
                          </#if>
                        </td>
                        <td style="vertical-align:middle;">${automobileInformation.introduceName}</td>
                        <td style="vertical-align:middle;">${automobileInformation.automobileType.getName()}</td>
                        <td style="vertical-align:middle;">${automobileInformation.automobileBrand.brand}</td>
                        <td style="vertical-align:middle;">${automobileInformation.automobileStalls.getName()}</td>
                        <td style="vertical-align:middle;">${automobileInformation.automobileSeat.getName()}</td>
                        <td style="vertical-align:middle;">${automobileInformation.dailyRentalRate}</td>
                        <td style="vertical-align:middle;">${automobileInformation.vehicleDeposit!""}</td>
                        <td style="vertical-align:middle;">${automobileInformation.violationOfTheDeposit!""}</td>
                        <td style="vertical-align:middle;" style="vertical-align:middle;"><font class="text-success">${automobileInformation.createTime}</font></td>
                      </tr>
                    </#list>
                    <#else>
                    <tr align="center"><td colspan="12">这里空空如也！</td></tr>
					</#if>
                    </tbody>
                  </table>
                </div>
                <#if pageBean.total gt 0>
                <ul class="pagination ">
                  <#if pageBean.currentPage == 1>
                  <li class="disabled"><span>«</span></li>
                  <#else>
                  <li><a href="list?introduceName=${introduceName!""}&brand=${brand!""}&currentPage=1">«</a></li>
                  </#if>
                  <#list pageBean.currentShowPage as showPage>
                  <#if pageBean.currentPage == showPage>
                  <li class="active"><span>${showPage}</span></li>
                  <#else>
                  <li><a href="list?introduceName=${introduceName!""}&brand=${brand!""}&currentPage=${showPage}">${showPage}</a></li>
                  </#if>
                  </#list>
                  <#if pageBean.currentPage == pageBean.totalPage>
                  <li class="disabled"><span>»</span></li>
                  <#else>
                  <li><a href="list?introduceName=${introduceName!""}&brand=${brand!""}&currentPage=${pageBean.totalPage}">»</a></li>
                  </#if>
                  <li><span>共${pageBean.totalPage}页,${pageBean.total}条数据</span></li>
                </ul>
                </#if>
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
<script type="text/javascript">
$(document).ready(function(){
	
});
function del(url){
	if($("input[type='checkbox']:checked").length != 1){
		showWarningMsg('请选择一条数据进行删除！');
		return;
	}
	var id = $("input[type='checkbox']:checked").val();
	$.confirm({
        title: '确定删除？',
        content: '删除后数据不可恢复，请慎重！',
        buttons: {
            confirm: {
                text: '确认',
                action: function(){
                    deleteReq(id,url);
                }
            },
            cancel: {
                text: '关闭',
                action: function(){
                    
                }
            }
        }
    });
}
//打开编辑页面
function edit(url){
	if($("input[type='checkbox']:checked").length != 1){
		showWarningMsg('请选择一条数据进行编辑！');
		return;
	}
	window.location.href = url + '?id=' + $("input[type='checkbox']:checked").val();
}
//调用删除方法
function deleteReq(id,url){
	$.ajax({
		url:url,
		type:'POST',
		data:{id:id},
		dataType:'json',
		success:function(data){
			if(data.code == 0){
				showSuccessMsg('汽车信息删除成功!',function(){
					$("input[type='checkbox']:checked").parents("tr").remove();
				})
			}else{
				showErrorMsg(data.msg);
			}
		},
		error:function(data){
			alert('网络错误!');
		}
	});
}
</script>
</body>
</html>