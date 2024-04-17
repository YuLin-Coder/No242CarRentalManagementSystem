<script type="text/javascript" src="/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="/admin/js/bootstrap.min.js"></script>
<!--对话框-->
<script src="/admin/js/jconfirm/jquery-confirm.min.js"></script>
<script src="/admin/js/common.js"></script>
<script type="text/javascript">
    /*$(document).ready(function(){
        var currentUrl = window.location.pathname;
        var curs = currentUrl.split("/");
        currentUrl = curs[1];
        $(".second-menu").each(function(i,e){
            if($(e).children("a").attr('href').indexOf(currentUrl) == 1){
                $(e).addClass('active');
                $(e).parent("ul").parent("li").addClass("active open")
            }
        });
    });*/

    $(document).ready(function(){
        var currentUrl = window.location.pathname;
        var curs = currentUrl.split("/");
        currentUrl = curs[2];

        $(".second-menu").each(function(i,e){
            var secondUrl = $(e).children("a").attr('href').split('/');
            if(secondUrl[2] == currentUrl){
                $(e).addClass('active');
                $(e).parent("ul").parent("li").addClass("active open")
            }
        });

        if(isMuilt()){
            //如果同时高亮的有两个
            var currentUrl = window.location.pathname;
            var curs = currentUrl.split("/");
            currentUrl = curs[3];

            $(".second-menu").each(function(i,e){
                if($(e).hasClass('active')){
                    $(e).removeClass('active')
                    var secondUrl = $(e).children("a").attr('href').split('/');
                    if(secondUrl[3] == currentUrl){
                        $(e).addClass('active');
                        $(e).parent("ul").parent("li").addClass("active open")
                    }
                }
            });
        }

    });


    function isMuilt(){
        var flag = 0;
        $(".second-menu").each(function(i,e){
            if($(e).hasClass('active')){
                flag++;
            }
        });
        return flag > 1;
    }

</script>
