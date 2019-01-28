var timeUtils = {
    timeStamp2Str: function(timestamp){
        timestamp *= 1000;
        var d = new Date(timestamp);
        var dStr = (d.getFullYear()) + '-' + (d.getMonth()+1) + '-' + (d.getDate()) + ' ' + (d.getHours()) + ':' + (d.getMinutes()) + ':' + (d.getSeconds());
        return dStr;
    }
};

export default timeUtils;