<script type="text/javascript" src="//api.map.baidu.com/api?v=2.0&ak=4cA0Y6UGwGGogWDdrWkvZQfH4nhAj1bD"></script>
<div id="divBookingInfo">
    <div class="step1-map">
        <div style="width: 270px; height: 270px">
            <div id="allmap"style="width: 100%; height: 100%">
            </div>
        </div>
    </div>
    <input type="hidden" id="longitudeAndLatitude" value="${user.longitudeAndLatitude}">
    <input id="shopName" type="hidden" value="${user.shopName}">
    <input id="site" type="hidden" value="${user.site}" >
    <div class="step1-storeinfo">
        <ul>
            <li>取车门店：</li>
            <li><span id="setStore">${user.shopName}</span></li>
            <li ><span id="setSite">${user.site}</span></li>
            <li><em>门店电话：</em><em ><span id="setPhone">${user.mobile}</span></em></li>
            <li><em>营业时间：</em><em><span id="setBusinessHoursStart">${user.openingHours}</span>-<span id="setBusinessHoursEnd">${user.closeOfBusiness}</span></em></li>
        </ul>
    </div>
</div>

<script type="text/javascript">

    let longitudeAndLatitudeVal = $('#longitudeAndLatitude').val();
    let longitudeAndLatitudeArr = longitudeAndLatitudeVal.split(",");
    let number = Number(longitudeAndLatitudeArr[0]);
    let number1 = Number(longitudeAndLatitudeArr[1]);
    let shopName = $('#shopName').val;
    let site = $('#site').val;
    // 百度地图API功能
    var map = new BMap.Map("allmap"); // 创建Map实例
    var point = new BMap.Point(number,number1);
    map.centerAndZoom(point, 19); // 初始化地图,设置中心点坐标和地图级别

    var marker = new BMap.Marker(point); // 创建标注
    map.addOverlay(marker); // 将标注添加到地图中
    
    //添加地图类型控件
    map.addControl(new BMap.MapTypeControl({
        mapTypes: [
            BMAP_NORMAL_MAP,
            BMAP_HYBRID_MAP
        ]
    }));
    // map.setCurrentCity("上海");          // 设置地图显示的城市 此项是必须设置的
    map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
</script>