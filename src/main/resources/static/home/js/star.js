
function mobile_hide(mobile) {
var newTest = '';
    if(mobile.length>0){
        for(var i=0;i<mobile.length;i++){
            if(i<3||i>=mobile.length-3){
                newTest+=mobile[i];
            }
            else{
                newTest+='*';
            }
        }
    }
    return newTest;
}
