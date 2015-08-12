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
</style>
<body>
<#include "/include/navbar.ftl"/>
<div class="container body-container">
    <div class="row">
        <div class="col-sm-8"><h2>${(product.title)!}</h2></div>
        <div class="col-sm-4"><img class="product_img" src="${ctx}/${(product.thumbnail)!}"></div>
    </div>
    <hr class="margin-updown-20">
    <div class="row">
        ${(product.content)!}
    </div>
</div>
<#include "/include/foot.ftl"/>
</body>
</html>
	