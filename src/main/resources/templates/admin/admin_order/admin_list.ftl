<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>${siteName!""}|订单管理-${title!""}</title>
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
                <form class="pull-right search-bar" method="get" action="findAllList" role="form">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button style="position: absolute;left: -290px;top: 0px; width: 110px"
                              class="btn btn-default dropdown-toggle" id="search-btn"
                              data-toggle="dropdown" type="button" aria-haspopup="true"
                              aria-expanded="false">
                        订单号 <#--<span class="caret"></span>-->
                      </button>
                      <ul style="position: absolute;left: -290px;top: 38px;"
                          class="dropdown-menu">
                        <li><a tabindex="-1" href="javascript:void(0)"
                               data-field="title">订单号</a></li>
                      </ul>
                    </div>
                    <input style="position: absolute;left: -180px;top: 0px; width:166px" type="text"
                           class="form-control" value="${outTradeNo!""}" name="outTradeNo"
                           placeholder="请输入订单号">
                    <div class="input-group-btn">
                      <button class="btn btn-default dropdown-toggle" id="search-btn"
                              data-toggle="dropdown" type="button" aria-haspopup="true"
                              aria-expanded="false">
                        店铺名称 <#--<span class="caret"></span>-->
                      </button>
                      <ul class="dropdown-menu">
                        <li><a tabindex="-1" href="javascript:void(0)"
                               data-field="title">店铺名称</a></li>
                      </ul>
                    </div>
                    <input type="text" class="form-control js-datetimepicker" value="${shopName!""}"
                           name="shopName" placeholder="请输入店铺名称"
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
                        <th>订单号</th>
                        <th>车辆租车发布信息编号</th>
                        <th>店铺名称</th>
                        <th>下单人手机号</th>
                        <th>状态</th>
                        <th>下单时间</th>
                      </tr>
                    </thead>
                    <tbody>
                      <#if pageBean.content?size gt 0>
                      <#list pageBean.content as order>
                      <tr>
                        <td style="vertical-align:middle;">${order.outTradeNo}</td>
                        <td style="vertical-align:middle;">${order.releaseVehicleInformation.id}</td>
                        <td style="vertical-align:middle;">${order.releaseVehicleInformation.user.shopName}</td>
                        <td style="vertical-align:middle;">${order.deskUser.phone}</td>
                        <td style="vertical-align:middle;">
                          <#if order.type == 1>
                            <font class="text-success">预约中</font>
                          <#elseif order.type == 2>
                            <font class="text-success">租赁中</font>
                          <#elseif order.type == 3>
                            <font class="text-success">已完成</font>
                          <#elseif order.type == 0>
                            <font class="text-success">已取消</font>
                          </#if>
                        </td>
                        <td style="vertical-align:middle;" style="vertical-align:middle;"><font class="text-success">${order.createTime}</font></td>
                      </tr>
                    </#list>
                    <#else>
                    <tr align="center"><td colspan="9">这里空空如也！</td></tr>
					</#if>
                    </tbody>
                  </table>
                </div>
                <#if pageBean.total gt 0>
                <ul class="pagination ">
                  <#if pageBean.currentPage == 1>
                  <li class="disabled"><span>«</span></li>
                  <#else>
                  <li><a href="findAllList?outTradeNo=${outTradeNo!""}&shopName=${shopName!""}&currentPage=1">«</a></li>
                  </#if>
                  <#list pageBean.currentShowPage as showPage>
                  <#if pageBean.currentPage == showPage>
                  <li class="active"><span>${showPage}</span></li>
                  <#else>
                  <li><a href="findAllList?outTradeNo=${outTradeNo!""}&shopName=${shopName!""}&currentPage=${showPage}">${showPage}</a></li>
                  </#if>
                  </#list>
                  <#if pageBean.currentPage == pageBean.totalPage>
                  <li class="disabled"><span>»</span></li>
                  <#else>
                  <li><a href="findAllList?outTradeNo=${outTradeNo!""}&shopName=${shopName!""}&currentPage=${pageBean.totalPage}">»</a></li>
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

</body>
</html>