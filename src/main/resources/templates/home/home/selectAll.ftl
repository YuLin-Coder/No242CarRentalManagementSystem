<div id="reservationList" data-count="37" data-nostockcount="5">
<#if listAll?size gt 0>
    <#list listAll as releaseVehicleInformation>
            <div class="det-carlist available">
                <ul>
                    <li class="licar-picbox">
                        <div class="licar-picinfo">
                            <input type="hidden" value="${releaseVehicleInformation.id}"/>
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
                                <span>${releaseVehicleInformation.automobileInformation.introduceName}</span>
                                <a href="javascript:void(0);" class="sp-aczs sp-box"></a>
                            </p>
                            <p class="car-introinfo">
                                <span>${releaseVehicleInformation.automobileInformation.vehicleDisplacement}</span>|
                                ${releaseVehicleInformation.automobileInformation.automobileStalls.getName()}
                                |
                                ${releaseVehicleInformation.automobileInformation.automobileSeat.getName()}
                                |
                                <a href="javascript:void(0)" id="carDetail" onclick="viewCarVideo(this)"
                                   data-cartypeids="${releaseVehicleInformation.automobileInformation.id}">车辆详情&gt;</a>
                            </p>
                            <p class="car-activeinfo">
                        <#if releaseVehicleInformation.automobileInformation.introductionLabels??>
                            <#list releaseVehicleInformation.automobileInformation.introductionLabels?split(",") as Labels>
                                <span class="shalloworg">${Labels}</span>
                            </#list>
                        </#if>
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
                            <span class="licar-btn btnopen1" onmousemove="viewDet(this)">预订</span>
                            <span class="typebtn btntop1 " onmouseout="deDet(this)"
                                  data-value="${releaseVehicleInformation.id}" onclick="booking(this)">
                        <a href="javascript:;" class="type-four  btn-book" data-ipcar="False"
                           data-price="90" data-ishicar="False"
                           data-price-type="1" data-cid="hG9sR6XPHfU=" data-gid="BKg1Aofv7wM=">
                           <span>
                               在线预付<br>
                           </span><i class="symbol">¥</i>
                            <em class="total-price">${releaseVehicleInformation.automobileInformation.dailyRentalRate}</em>
                        </a>
                    </span>
                        </p>
                    </li>
                </ul>
            </div>
    </#list>
<#else>
    <div id="nocar" style="display: block;">
        <img src="/home/images/nocar.png" alt="">
        <div class="nocar-explain">
            <p class="nocar-text1">对不起，当前门店该时间段内车辆已经租满。</p>
            <p class="nocar-text2">您可以重新选择其他门店。</p>
        </div>
    </div>
</#if>
    <div class="load-more-box" id="loadMore" style="display: block">
        <a href="javascript:void(0)" onclick="loadMordBox()" >本市其他店铺其他车型</a>
    </div>
</div>