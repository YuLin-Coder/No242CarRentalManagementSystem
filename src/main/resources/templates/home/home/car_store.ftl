<div id="showCarStoreBox" class="myshowbox" style="margin: -211px 0px 0px -410px;">
    <div class="myshowbox-container show-div-ghmd" style="width: 800px;">
        <a class="btn-close" href="javascript:;"><img src="/home/images/close.png" onclick="closeCarStore()"/></a>
        <h3 class="title" style="display: none;"></h3>
    <#if pageBeanCarStoreList.content ?size gt 0>
        <div class="div-myshowbox" style="width:800px; height:392px;">
            <div class="show-carlist show-ghmd">
                <h4 class="con-tit">现在有“<span id="gname">${introduceName}</span>”的门店</h4>
                <div class="showmd-title">
                    <div class="md-inf">有车门店</div>
                    <div class="distance">门店地址</div>
                    <div class="price-newinf">租金均价</div>
                </div>
                <div class="pagesize-list-box">
                    <ul class="showmd-list pagesize-list" style="top: 0px;">

                    <#list pageBeanCarStoreList.content as pageBeanCarStore>
                        <li class="licar-change bg-sp">
                            <div class="md-inf">
                                <div class="mdsub">
                                    <div class="mdcontent">
                                        <p class="inf-name">
                                            <span class="md"
                                                  title="${pageBeanCarStore.user.shopName}">${pageBeanCarStore.user.shopName}</span>
                                            <span class="inf-time"><span
                                                    class="begin">${pageBeanCarStore.user.openingHours}</span>
                                             - <span class="end">${pageBeanCarStore.user.closeOfBusiness}</span></span>
                                        </p>
                                        <p class="inf-txt"
                                           title="${pageBeanCarStore.user.site}">${pageBeanCarStore.user.site}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="distance">
                                <span>${pageBeanCarStore.user.site}</span>
                            </div>
                            <div class="price-newinf">
                                <span class="datetitle">日租价</span>
                                <span class="price"><em>¥</em>${pageBeanCarStore.automobileInformation.dailyRentalRate}<i>/日均</i></span>
                            </div>
                            <a class="btn-yd" data-value="${pageBeanCarStore.id}"
                               onclick="booking(this)" href="javascript:;">预 订</a>
                            <span class="typebtn btntop1" data-value="${pageBeanCarStore.id}" onclick="booking(this)">
                                <a href="javascript:;" class="btn-book type-four"
                                   data-price="${pageBeanCarStore.automobileInformation.dailyRentalRate}">
                                    <span>在线支付</span><i class="symbol">¥</i>
                                    <em class="total-price">${pageBeanCarStore.automobileInformation.dailyRentalRate}</em>
                                </a>
                        </span>
                        </li>
                    </#list>

                    </ul>
                </div>
                <div class="page-box" id="pageBox" data-total="${pageBeanCarStoreList.total}">
                    <div class="page-content">

                    </div>
                </div>
            </div>
        </div>
    <#else>
        <div class="div-myshowbox" style="width:800px; height:392px;">
            <div class="show-carlist show-ghmd">
                <div class="store-nocar">
                    <img src="/Content/Images/Order/NewStep/nocarpic.jpg">
                    <p id="ctip">${introduceName},所有门店均已售罄。</p>
                    <p>请尝试其它车型。</p>
                </div>
            </div>
        </div>
    </#if>
    </div>
</div>

