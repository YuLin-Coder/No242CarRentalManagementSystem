<#if rentFull??>
    <#list rentFull as rent>
    <div class="det-carlist">
        <ul>
            <li class="licar-picbox">
                <div class="licar-picinfo">
                    <img src="/photo/view?filename=${rent.automobileInformation.automobilePicturePath}">
                    <span id="carListVideo" data-cartypeids="${rent.automobileInformation.id}"
                          class="video-playbtn video-total"></span>
                </div>
            </li>
            <li class="licar-namebox">
                <div class="licar-nameinfo">
                    <p class="car-nameinfo">
                        <span>${rent.automobileInformation.introduceName}</span>
                        <a href="javascript:void(0);" class="sp-aczs sp-box"><i class="lv5"></i></a>
                    </p>
                    <p class="car-introinfo">
                        <span>${rent.automobileInformation.vehicleDisplacement}</span>
                        |${rent.automobileInformation.automobileStalls.getName()}|
                        ${rent.automobileInformation.automobileSeat.getName()}
                        |
                        <a href="javascript:void(0)" id="carDetail" onclick="viewCarVideo(this)"
                           data-cartypeids="${rent.automobileInformation.id}">车辆详情&gt;</a>
                    </p>
                    <p class="car-typeinfo">
                        <span></span>
                    </p>
                </div>
            </li>

            <li class="licar-operatebox">
                <p><span class="licar-btn btn-change-store" onclick="changingStores(this)" data-name="${rent.automobileInformation.introduceName}">换门店</span></p>
            </li>
        </ul>
    </div>
    </#list>
</#if>
