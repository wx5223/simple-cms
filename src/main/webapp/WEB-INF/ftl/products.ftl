<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/>
<#include "/include/title.ftl"/>
</head>
<style>
	.product_img {
		width: 200px;
		height: 140px;
	}
	.rc-NewPageHeader {
		color: #757575;
		background-color: #fff;
		-webkit-box-shadow: 0 1px #d9d9d9;
		-moz-box-shadow: 0 1px #d9d9d9;
		-ms-box-shadow: 0 1px #d9d9d9;
		-o-box-shadow: 0 1px #d9d9d9;
		box-shadow: 0 1px #d9d9d9;
		position: relative;
		margin-bottom: 1px;
	}
    .product-search {
        margin-bottom: 10px;
        width: 50%;
        border-radius: 0;
    }
    .product-sidebar {
        position: relative;
        float: left;
        width: 25%;
        min-height: 500px;
        padding-right: 15px;
        padding-right: 10px;
        border-right: 1px solid #ccc;
    }
    .product-listing {
        position: relative;
        float: left;
        width: 75%;
        min-height: 1px;
        padding-left: 15px;
        padding-right: 15px;
        padding: 0;
        margin-left: -1px;
    }
    .list-item .title {
        font-size: 12px;
        font-weight: bold;
    }
    ul.list {
        padding-left: 0px;
        margin-top:15px;
        line-height: 20px;
    }
    .list-item {
        display:block;
    }
    .list-item:after {
        content: " ";
        display: table;
        clear: both;
    }
    .list-item label {
        font-weight: normal;
        margin-bottom: 5px;
        cursor: pointer;
    }
    .list-item>.check {
        float: left;
        width: 8.3333333333333%;
    }
    .list-item>.name {
        float: left;
        width: 70%;
        text-align: left;
        font-size: 12px;
        padding-left: 10px;
    }
    .list-item>.name_bold {
        font-weight: bold;
    }
    .list-item>.count {
        float: right;
        width: 20%;
        text-align: right;
        font-size: 12px;
    }
    .product-listing h1 {
        font-size: 24px;
        padding: 0 10px;
        margin: 15px 0 3px 0;
    }
    .product-listing-loadmore,.product-listing-holder .product-list-item {
        border: 1px solid #ccc;
        padding: 12px;
        position: relative;
        border-width: 1px 1px 0 1px;
    }
    .product-listing-loadmore {
        border-bottom: 1px solid #ccc;
    }
    .product-list {
        /*color: black;*/
        font-family: 'sofiapro-light',Arial,sans-serif;
    }
    .product-thumbnail {
        width: 120px;
        height: 68px;
        padding-left: 0;
        -webkit-box-shadow: 0 0 2px 0 rgba(0,0,0,0.45);
        box-shadow: 0 0 2px 0 rgba(0,0,0,0.45);
        position: relative;
        background-repeat: no-repeat;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        background-size: cover;
        background-position: center;
    }
    .product-main {
        padding-left: 30px;
    }
    .product-listing-loadmore:hover,.product-listing-holder .product-list-item:hover {
        background-color: rgba(0,0,0,0.05);
        cursor: pointer;
    }
    .product-listing-bottomborder {
        width: 100%;
        height: 1px;
        border-top: 1px solid #ccc;
    }
    .display-none {
        display: none;
    }
</style>
<body>
<#include "/include/navbar.ftl"/>
<div class="container body-container">
    <div class="row bottom-line">
        <div class="text-center">
            <input id="keyword" type="search" name="keyword" placeholder="搜索产品名称" class="form-control product-search">
        </div>
    </div>
    <div class="row">
        <div data-js="product-sidebar" class="product-sidebar">

            <ul class="list">
                <li class="list-item"><label class="col-xs-8 title">符合条件</label></li>
                <li class="list-item">
                    <input id="type_id_recommend" type="checkbox" class="check">
                    <label for="type_id_recommend" class="name">推荐</label>
                </li>
                <li class="list-item">
                    <input id="type_id_hot" type="checkbox" class="check">
                    <label for="type_id_hot" class="name">热门</label>
                </li>
                <li class="list-item"><hr></li>
                <li class="list-item">
                    <input id="type_id_0" type="checkbox" class="check">
                    <label for="type_id_0" class="name name_bold">所有类型</label>
                </li>
                <#list productService.treeList as list>
                    <li class="list-item">
                        <input id="type_id_${list.id}" data-name="${list.id}" type="checkbox" class="check" value="${list.id}">
                        <label for="type_id_${list.id}" class="name name_bold">${list.name}</label>
                        <label for="type_id_${list.id}" class="count">${list.count}</label>
                        <#if list.children?has_content>
                        <ul class="list">
                        <#list list.children as childList>
                            <li class="list-item">
                                <input id="type_id_${childList.id}" data-name="${childList.id}" type="checkbox" class="check" value="${childList.id}">
                                <label for="type_id_${childList.id}" class="name">${childList.name}</label>
                                <label for="type_id_${childList.id}" class="count">${childList.count}</label>
                            </li>
                        </#list>
                        </ul>
                        </#if>
                    </li>
                </#list>
            </ul>
        </div>
        <div data-js="product-listing" class="product-listing">
            <div id="product-listing-loading" class="product-listing-loading display-none">
                <div class="row">
                    <div class="text-center"><h3>载入...</h3></div>
                </div>
                <div class="row">
                    <div class="text-center">
                        <div class="loading-dots dark-gray"><i></i><i></i><i></i><i></i></div>
                    </div>
                </div>
            </div>
            <div id="product-listing-holder" class="product-listing-holder display-none">
                <#--
                <div class="row">
                    <div class="text-center col-md-4 col-md-offset-4"><h3>载入...</h3></div>
                </div>
                <div class="row">
                    <div class="text-center col-md-4 col-md-offset-4">
                        <div class="coursera-loading-icon">
                            <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="100px" height="80px" xml:space="preserve" viewBox="-5 0 450 223.727"><path stroke="#4089c8" stroke-width="4.3" fill="#DCDCDC" d="M 185.56 16.417 C 185.56 16.417 177.006 12.068 167.595 8.528 C 167.231 8.389 166.867 8.25 166.496 8.12 C 165.367 7.712 164.244 7.312 163.099 6.932 C 153.088 3.596 142.586 1.52 131.764 0.586999 L 131.771 0.579999 C 131.488 0.550999 131.206 0.527999 130.923 0.506999 C 129.259 0.390999 127.578 0.194999 125.922 0.113999 C 124.109 0.0409991 122.294 0.00399907 120.503 -0.00300093 H 119.493 C 99.588 0.065 81.097 4.138 64.202 12.216 C 45.272 21.338 29.91 34.632 18.551 51.766 C 7.202 68.886 1.003 87.898 0.119 108.298 C 0.045 110.045 0 111.767 0 113.484 C -0.023 142.018 10.391 167.108 31.053 188.177 C 52.637 210.264 80.711 222.182 114.426 223.58 C 116.588 223.666 118.722 223.726 120.847 223.726 C 139.919 223.726 157.549 220.317 173.38 213.556 C 177.327 211.867 181.17 209.884 185.094 207.67 C 187.227 206.446 189.241 205.136 191.241 203.736 L 192.72 202.745 L 195.21 201.026 C 198.206 198.897 201 196.567 203.736 194.09 L 204.68 193.186 C 206.285 191.671 207.883 190.127 209.399 188.526 L 215.071 182.114 L 217.233 179.404 L 218.245 177.946 L 219.256 176.489 C 227.684 162.329 255.124 110.802 255.124 110.802 V 110.699 L 256.752 107.553 L 258.119 105.09 C 262.171 97.732 265.08 92.503 268.945 86.996 L 269.056 86.841 C 278.079 73.752 293.581 64.441 311.862 62.867 C 342.539 60.23 369.4 80.379 371.868 107.872 C 374.327 135.378 351.458 159.81 320.784 162.445 C 314.406 162.997 308.196 162.56 302.336 161.278 L 302.202 161.333 C 279.693 156.638 265.367 140.242 258.304 132.906 L 228.795 187.167 C 228.795 187.167 237.963 196.405 244.247 201.018 C 250.532 205.629 258.662 210.174 265.157 212.973 C 280.915 219.702 298.033 223.725 316.948 223.725 C 319.156 223.725 318.703 223.725 320.992 223.637 C 354.677 222.239 384.675 209.33 406.318 187.214 C 426.824 166.234 437.951 142.25 438.047 113.889 V 113.076 C 438.039 111.503 438 109.915 437.935 108.326 C 437.86 106.607 437.748 104.918 437.6 103.228 C 437.6 103.228 437.6 103.212 437.6 103.197 C 437.6 103.197 437.6 103.182 437.6 103.171 C 435.965 84.694 429.863 67.414 419.509 51.795 C 414.878 44.831 409.601 38.508 403.692 32.826 C 395.042 24.521 385.052 17.637 373.784 12.202 C 356.823 4.1 338.079 0.0139968 318.077 0.0139968 C 316.123 0.0139968 314.093 0.0429968 312.02 0.123997 C 297.964 0.764997 284.385 3.423 271.624 8.122 C 258.744 12.777 247.542 18.925 238.37 26.297 C 236.498 27.769 234.468 29.59 232.291 31.601 L 230.715 33.146 L 228.568 35.418 H 228.583 H 228.599 L 227.594 36.409 L 227.103 36.948 L 224.546 39.643 C 222.651 41.771 220.839 43.898 219.151 45.996 L 219.135 45.967 L 219.076 45.909 C 215.568 50.178 212.319 54.592 209.94 58.57 C 208.32 61.12 206.737 63.742 205.221 66.364 L 184.284 108.689 L 184.314 108.718 L 183.213 110.861 L 180.901 115.552 C 176.323 124.825 171.41 134.091 165.917 141.726 C 153.653 155.161 139.806 161.715 122.005 161.715 C 120.757 161.715 119.479 161.656 118.186 161.599 C 107.468 161.162 98.259 158.626 90.105 153.79 C 89.229 153.265 88.38 152.742 87.563 152.186 C 80.903 147.756 75.798 142.076 71.978 134.964 C 67.644 126.923 65.72 118.728 66.001 109.998 C 66.016 109.779 66.023 109.576 66.023 109.373 C 66.61 95.503 71.902 84.72 82.553 75.394 C 85.132 73.18 87.845 71.286 90.677 69.596 C 91.079 69.363 91.473 69.131 91.873 68.926 C 99.789 64.613 108.798 62.473 119.129 62.473 L 122.339 62.559 C 138.743 63.186 151.378 68.315 161.472 78.308 L 193.12 21.487  Z"></path></svg>
                        </div>
                    </div>
                </div>-->

            <h1>产品</h1>
            <div id="product-listing" class="product-listing-holder">
                <#--
                <#if page.content?has_content>
                    <#list page.content as list>
                        <div>
                            <div name="${(list.id)!0}" class="row product-list-item">
                                <div class="col-md-2 col-xs-3">
                                    <img src="${ctx}/${list.thumbnail!}" alt="" class="product-thumbnail">
                                </div>
                                <div class="col-md-7 col-xs-6 product-main">
                                    <div>${list.title}</div>
                                    <div><#if list.typeId?exists><a href="javascript:void(0)" data-name="type_id_${list.typeId}" class="check-link">${list.typeName!"未知"}</a></#if></div>
                                    <span>${(list.brief)!}</span>
                                </div>
                                <div class="col-xs-3 text-right">
                                    <p>${(list.updateTime)!""}</p>
                                    <#if (list.recommend)??&&list.recommend == 1>
                                    <a href="javascript:void(0)" data-name="type_id_recommend" class="btn btn-info btn-xs check-link" onclick="check()">推荐</a>
                                    </#if>
                                    <#if (list.hot)??&&list.hot == 1>
                                        <a href="javascript:void(0)" data-name="type_id_hot" class="btn btn-success btn-xs check-link" onclick="check()">热门</a>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>-->
                <#--
                <div>
                    <a href="${ctx}/product">
                    <div class="row product-list-item">
                        <div class="col-md-2 col-xs-3">
                            <img src="http://www.njht.net/uploadfile/200904/10/1930466201.jpg" alt="" class="product-thumbnail">
                        </div>
                        <div class="col-md-7 col-xs-6 product-main">
                            <div>产品名称</div>
                            <div><a href="${ctx}/products?type=1">产品类型</a></div>
                            <span>产品描述</span>
                        </div>
                        <div class="col-xs-3 text-right">
                            <p>2015年7月6日<br>4 个星期</p>
                        </div>
                    </div>
                    </a>
                </div>-->
            </div>
            <#--<#if !page.last>-->
                <div class="product-listing-loadmore display-none">
                    <div class="row">
                        <div class="col-md-12"><a id="listing-load-more" href="javascript:query(true);"><span
                                data-js="ready">载入更多...</span><span id="listing-loading" class="hide">载入...</span></a>
                        </div>
                    </div>
                </div>
                <div class="product-listing-bottomborder"></div>
            <#--</#if>-->
            </div>
        </div>
    </div>
</div>
<#include "/include/foot.ftl"/>
<script>
    page=0;
    var check = function(event){
        event.stopPropagation();
        var checkId = $(this).attr("data-name");
        $("#" + checkId).click();
    };
    var itemclick = function() {
        var id = $(this).attr("name");
        location.href = "${ctx}/product/"+id;
    };
    Date.prototype.format = function(fmt) {
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "h+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt))
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)
            if(new RegExp("("+ k +")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        return fmt;
    };
    function query(next) {
        var pageTemp = 0;
        if(next) {
            pageTemp = page + 1;
            $("#listing-load-more").hide();
            $("#listing-loading").show();
        } else {
            page = 0;
            $("#product-listing-loading").show();
            $("#product-listing").empty();
            $("#product-listing-holder").hide();
            $(".product-listing-loadmore").hide();
        }

        var recommend = null;
        var hot = null;
        var ids = null;
        var idsArray = [];
        $("input:checkbox").each(function(){
            var id = $(this).attr("id");
            if($(this).is(":checked") == true){
                if(id == 'type_id_recommend') {
                    recommend = 1;
                } else if(id == 'type_id_hot') {
                    hot = 1;
                } else if(id != 'type_id_0') {
                    var id_value = $(this).val();
                    idsArray.push(id_value);
                    ids = idsArray.join(",");
                }
            }
        });
        $.post("${ctx}/products/query", {
            keyword:$("input[name=keyword]").val(),
            recommend: recommend,
            hot: hot,
            ids: ids,
            page:pageTemp
        }, function(data){
            if(next) {
                page++;
            }
            for (var i in data.content){
                //alert( i + "," + data.context[i]);
                var obj = data.content[i];
                var typeName = "未知";
                if(obj.typeId != null) {
                    typeName = obj.typeName;
                }
                var updateTime = "";
                if(obj.updateTime != null) {
                    var updateTimeDate = new Date(obj.updateTime);
                    updateTime = updateTimeDate.format("yyyy年MM月dd日 hh:mm:ss");
                }
                var brief = "";
                if(obj.brief != null) {
                    brief = obj.brief;
                }
                var tip = "";
                if(obj.recommend != null) {
                    tip+="<a href=\"javascript:void(0)\" data-name=\"type_id_recommend\" class=\"btn btn-info btn-xs check-link\" >推荐</a>";
                }
                if(obj.hot != null) {
                    tip+="&nbsp;<a href=\"javascript:void(0)\" data-name=\"type_id_hot\" class=\"btn btn-success btn-xs check-link\">热门</a>";
                }
                var div = "<div><div name="+obj.id+" class=\"row product-list-item\"><div class=\"col-md-2 col-xs-3\">" +
                        "<img src=\"${ctx}"+obj.thumbnail+"\" class=\"product-thumbnail\"></div>" +
                        "<div class=\"col-md-7 col-xs-6 product-main\"><div>"+obj.title+"</div><div>"+
                        "<a href=\"javascript:void(0)\" data-name=\"type_id_"+obj.typeId+"\" class=\"check-link\">"+typeName+"</a></div><span>"+brief+"</span></div>"+
                        "<div class=\"col-xs-3 text-right\"><p>"+updateTime+"</p>"+tip+"</div></div></div>";
                $("#product-listing").append($(div));
                $('a.check-link').unbind('click').click(check);
                $("div.product-list-item").unbind('click').click(itemclick);
            }
            $("#product-listing-loading").hide();
            if(data.lastPage) {
                $(".product-listing-loadmore").hide();
            } else {
                $(".product-listing-loadmore").show();
                $("#listing-loading").hide();
                $("#listing-load-more").show();
            }
            $("#product-listing-holder").show();
        });
    }
    $(function() {
        $('input:checkbox').change(function () {
            var id = $(this).attr("id");
            if(id == 'type_id_0') {
                $('input:checkbox[data-name]').removeAttr("checked");
            } else if(id != 'type_id_recommend'&& id != 'type_id_hot') {
                $("#type_id_0").removeAttr("checked");
            }
            query();
        });
        $('#keyword').keydown(function(e){
            if(e.keyCode==13){
                query();
            }
        });
        /*$("div.product-list-item").click(itemclick);
        $('a.check-link').click(check);*/
        var type_id = '${(RequestParameters.type)!"0"}';
        $('#type_id_'+type_id).attr('checked', 'checked');
        query();
    });
</script>
</body>
</html>
	