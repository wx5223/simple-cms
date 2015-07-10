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
</style>
<body>
<#include "/include/navbar.ftl"/>
<div class="container body-container">
    <div class="row">
        <div class="col-sm-8"><h2>${(product.title)!}</h2></div>
        <div class="col-sm-4"><img class="product_img" src="${(product.thumbnail)!}"></div>
    </div>
    <hr class="margin-updown-20">
    <div class="row">
        ${(product.content)!}
    </div>
</div>
<#include "/include/foot.ftl"/>
</body>
</html>
	