/// <reference path="jquery-1.4.4-vsdoc.js" />
/// <reference path="baidumap.api.vsdoc.js" />


$.fn.extend({
    setMap: function(centerpoint, zoom, isBaiduPoint) {
        /// <summary>
        /// 显示地图
        /// </summary>
        /// <param name="centerpoint">
        /// 地图中心坐标{longitude:经度,latitude:纬度}
        /// </param>
        /// <param name="zoom" type="Int" integer="true">地图显示级别</param>
        /// <param name="isBaiduPoint" type="Bool">传入的是否为百度坐标</param>
        try {
            var map = new BMap.Map($(this).get(0));
            //设置坐标中心点
            var ggPoint = new BMap.Point(centerpoint.longitude, centerpoint.latitude);

            //设置地图中心
            var setCenterPointAndZoom = function(point) {
                //展示地图
                map.centerAndZoom(point, zoom);
                map.enableScrollWheelZoom();

                var myIcon = new BMap.Icon('../../Content/Images/Order/NewStep/map_icon.gif', new BMap.Size(35, 54));
                var marker = new BMap.Marker(point, { icon: myIcon }); //创建marker对象
                map.addOverlay(marker);

            }

            if (isBaiduPoint) {
                setCenterPointAndZoom(ggPoint);
            } else {
                //0:GPS,2:Google坐标
                BMap.Convertor.translate(ggPoint, 2, setCenterPointAndZoom);
            }
        } catch (err) {
            document.getElementById("demo").innerHTML = err.message;
        }
    }
});
/*
function initMap() {
    /// <summary>
    /// 初始化加载地图
    /// </summary>
    var longi = $('#map').data('longitude');
    var lati = $('#map').data('latitude');
    var baLongi = $('#map').data('baiduLongitude');
    var baLati = $('#map').data('baiduLatitude');
    var isBaidu = !!baLongi && !!baLati;

    var pointData = isBaidu ? { longitude: baLongi, latitude: baLati } : { longitude: longi, latitude: lati };
    $('#map').setMap(pointData, 15, isBaidu);
}*/

/*
function errorCallBack() {
}
$(function () {
    initMap();
});*/
