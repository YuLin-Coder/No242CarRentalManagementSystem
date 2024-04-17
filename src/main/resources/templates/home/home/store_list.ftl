
    <!--区域列表-->
    <h3 class="store-inquire clearfix">
        <span class="iqst-all iqst-current">行政区</span>
    </h3>
    <div class="wrap-title">
        <ul id="setAllStore" class="list-area tabHF-title">
            <#list districtList as district>
                <li date-value="${district.district}" onmouseover=wrapContent(this)>${district.district}</li>
            </#list>

        </ul>
    </div>
    <!--门店列表-->
    <div class="wrap-content" id="wrap-content">
        <ul class="tabHF-content list-mendian">
            <li class="">
                <div class="mendian-wrap">
                    <dl class="dl-mendian clearfix">

                    </dl>
                </div>
            </li>
        </ul>
    </div>
    <div class="inf-box">
        <ul class="inf-address clearfix">
            <li class="key">地址：</li>
            <li class="value">
                <span class="address"></span>
                <span style="display: inline-block; white-space: nowrap;">
            </span>
                <div id="jsj" style="display: none;"></div>
            </li>
        </ul>
        <div class="inf-time">
            <div class="txt-time">
                营业时间：<span class="time"><span class="get-hour"></span>-<span class="ret-hour"></span></span>
            </div>
            <div class="storephone">电话：<span class="time"></span></div>
        </div>
    </div>
    <div class="near-search" id="NearSearch">

    </div>