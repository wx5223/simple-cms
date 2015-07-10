<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/> <!--调用head内样式信息-->
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
        min-height: 1px;
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
        width: 66.6666666666667%;
        text-align: left;
        font-size: 12px;
        padding-left: 10px;
    }
    .list-item>.name_bold {
        font-weight: bold;
    }
    .list-item>.count {
        float: right;
        width: 25%;
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
</style>
<body>
<#include "/include/navbar.ftl"/>
<div class="container body-container">
    <div class="row bottom-line">
        <div class="text-center">
            <input type="search" placeholder="搜索产品名称" class="form-control product-search">
        </div>
    </div>
    <div class="row">
        <div data-js="product-sidebar" class="product-sidebar">

            <ul class="list">
                <li class="list-item">
                    <input id="type_id_0" type="checkbox" class="check">
                    <label for="type_id_0" class="name name_bold">所有类型</label>
                </li>
                <#list treeList as list>
                    <li class="list-item">
                        <input id="type_id_${list.id}" type="checkbox" class="check">
                        <label for="type_id_${list.id}" class="name name_bold">${list.name}</label>
                        <label for="type_id_${list.id}" class="count">14</label>
                        <#if list.children?has_content>
                        <ul class="list">
                        <#list list.children as childList>
                            <li class="list-item">
                                <input id="type_id_${childList.id}" type="checkbox" class="check">
                                <label for="type_id_${childList.id}" class="name">&nbsp;&nbsp;&nbsp;&nbsp;${childList.name}</label>
                                <label for="type_id_${childList.id}" class="count">14</label>
                            </li>
                        </#list>
                        </ul>
                        </#if>
                    </li>
                </#list>
            </ul>
        </div>
        <div data-js="product-listing" class="product-listing">
            <h1>产品</h1>
            <div data-js="elements" class="product-listing-holder">
                <#if page.content?has_content>
                    <#list page.content as list>
                        <div>
                            <div name="${(list.id)!0}" class="row product-list-item">
                                <div class="col-md-2 col-xs-3">
                                    <img src="${list.thumbnail!}" alt="" class="product-thumbnail">
                                </div>
                                <div class="col-md-7 col-xs-6 product-main">
                                    <div>${list.title}</div>
                                    <div><#if list.typeId?exists><a href="${ctx}/products?type=${list.typeId}">${list.typeName!"未知"}</a></#if></div>
                                    <span>${(list.brief)!}</span>
                                </div>
                                <div class="col-xs-3 text-right">
                                    <p>${(list.updateTime)!""}</p>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>
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
                </div>
            </div>
            <#if !page.last>
            <div data-js="load-more-container" class="product-listing-loadmore">
                <div class="row">
                    <div class="col-md-12"><a data-js="load-more" href="#"><span
                            data-js="ready">载入更多...</span><span data-js="loading" class="hide">载入...</span></a>
                    </div>
                </div>
            </div>
            <#else>
                <div class="product-listing-bottomborder"></div>
            </#if>
        </div>
    </div>
</div>
<#include "/include/foot.ftl"/>
<script>
    $(function() {
        $("div.product-list-item").click(function() {
            var id = $(this).attr("name");
            location.href = "${ctx}/product/"+id;
        });
    });
</script>
</body>
</html>
	