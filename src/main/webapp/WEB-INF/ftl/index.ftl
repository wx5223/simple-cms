<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/>
<#include "/include/title.ftl"/>
</head>
<style>
    .product-picture {
        display: block;
        float: left;
        height: 250px;
        margin: 10px 10px;
        display: inline-block;
        text-align: center;
        cursor: pointer;
        border: 2px solid #fafafa;
    }
    .product-picture:hover {
        background-color: #eee;
        border: 2px solid #ccc;
    }
    .product-picture img {
        -webkit-border-radius: 0;
        border-radius: 0;
        border: 2px solid #eee;
        width: 200px;
        height: 140px;
        /*border: 3px solid #ccc;*/
    }
</style>
<body>
<#include "/include/navbar.ftl"/>
<div class="container">
    <div class="jumbotron">
        <h1>南京皇拓</h1>
        <p class="lead">华东最大的望远镜，夜视仪，手电筒 天文望远镜等光学产品的批发商。是德国蔡司，德国视得乐，美国博士能，日本尼康等品牌在国内的授权代理。南京公司地址：中山东路198号龙台国际大厦1218室，公司在北京设有分公司，负责大北方地区的销售，北京公司地址：北京市朝阳区大屯路2号南沙滩36号楼2204室。公司主要业务是望远镜和夜视仪手电筒 等光学器材的批发，目前已开始在淘宝商城和京东商城 亚马逊 等商家平台开展网络的零售业务。因为专业，所以前景广阔。</p>
        <#--<p><a class="btn btn-lg btn-success" href="#" role="button">Sign up today</a></p>-->
    </div>

    <#--<div class="row marketing">
        <div class="col-lg-6">
            <h4>Subheading</h4>
            <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>

            <h4>Subheading</h4>
            <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>

            <h4>Subheading</h4>
            <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
        </div>

        <div class="col-lg-6">
            <h4>Subheading</h4>
            <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>

            <h4>Subheading</h4>
            <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>

            <h4>Subheading</h4>
            <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
        </div>
    </div>-->
    <div class="row">
        <div style="font-size: 24px;text-align: center;padding: 15px;">推荐产品</div>
        <hr>
    </div>
    <div class="row">
        <#if (productService.productRecommendPage.content)?has_content>
            <#list productService.productRecommendPage.content as list>
                <div name="${(list.id)!0}" class="product-picture">
                    <img src="${ctx}/${list.thumbnail!}" class="small" style="display: inline;"/>
                    <h5>${list.title}</h5>
                    <h5><a href="${ctx}/products?type=${list.typeId}">${list.typeName}</a></h5>
                </div>
            </#list>
        </#if>
    </div>
    <div class="row">
        <div style="font-size: 24px;text-align: center;padding: 15px;">热门产品</div>
        <hr>
    </div>
    <div class="row">
    <#if (productService.productHotPage.content)?has_content>
        <#list productService.productHotPage.content as list>
            <div name="${(list.id)!0}" class="product-picture">
                <img src="${ctx}/${list.thumbnail!}" class="small" style="display: inline;"/>
                <h5>${list.title}</h5>
                <h5><a href="${ctx}/products?type=${list.typeId}">${list.typeName}</a></h5>
            </div>
        </#list>
    </#if>
    </div>
</div>
<#include "/include/foot.ftl"/>
<script>
    var itemclick = function() {
        var id = $(this).attr("name");
        location.href = "${ctx}/product/"+id;
    };
    $(function() {
        $("div.product-picture").click(itemclick);
    });
</script>
</body>
</html>
	