

var msg = {};

function errorMsg(content)
{
    layer.msg(content.toString(), {icon:5});
}

function successMsg(content)
{
    layer.msg(content.toString(),{icon:1});
}

msg.isEmpty = function(obj)
{
    if(obj == null || obj.length == 0)
    {
        return true;
    }

    return false;
}