<div id="navbar" class="navbar-collapse collapse rc-NewPageHeader">
    <div class="container">
        <ul class="nav navbar-nav">
            <li class="active"><a href="#">
                <img src=""></img>
            </a></li>
            <li><a href="${ctx}/index">首页</a></li>
            <li><a href="${ctx}/products?type=recommend">推荐产品</a></li>
            <li><a href="${ctx}/products?type=hot">热门产品</a></li>
            <#--<li><a href="#contact">相关知识</a></li>-->
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">产品 <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="${ctx}/products">所有产品</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">类型</li>
                    <#list productService.treeList as list>
                        <li><a href="${ctx}/products?type=${list.id}">${list.name}</a></li>
                    </#list>
                    <#--<li><a href="#">Another action</a></li>
                    <li><a href="#">Something else here</a></li>
                    <li><a href="#">Separated link</a></li>
                    <li><a href="#">One more separated link</a></li>-->
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="${ctx}/partners">合作伙伴</a></li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">购买&联系<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="${ctx}/buy_first">购买必读</a></li>
                    <li><a href="${ctx}/send">配送方式</a></li>
                    <li><a href="${ctx}/order">订购方式</a></li>
                    <li><a href="${ctx}/buy">付款方式</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>