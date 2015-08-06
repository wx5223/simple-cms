<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/> <!--调用head内样式信息-->
</head>
<style>
    .sidebar {
        width: 220px;
        float: left;
        position: relative;
        border: 1px solid #ccc;
        border-width: 0 1px 0 0;
        background-color: #f2f2f2;
    }
    .sidebar:before {
        content: "";
        display: block;
        width: 220px;
        position: fixed;
        bottom: 0;
        top: 0;
        z-index: -1;
        background-color: #f2f2f2;
        border: 1px solid #ccc;
        border-width: 0 1px 0 0;
    }
    .content {
        margin-left: 220px;
        height:100%;
    }

    #main-nav {
        margin-left: 1px;
    }

    #main-nav.nav-tabs.nav-stacked > li > a {
        padding: 10px 8px;
        font-size: 12px;
        font-weight: 600;
        color: #4A515B;
        background: #E9E9E9;
        background: -moz-linear-gradient(top, #FAFAFA 0%, #E9E9E9 100%);
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FAFAFA), color-stop(100%,#E9E9E9));
        background: -webkit-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
        background: -o-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
        background: -ms-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
        background: linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9');
        -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9')";
        border: 1px solid #D5D5D5;
        border-radius: 4px;
    }

    #main-nav.nav-tabs.nav-stacked > li > a > span {
        color: #4A515B;
    }

    #main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover {
        color: #FFF;
        background: #3C4049;
        background: -moz-linear-gradient(top, #4A515B 0%, #3C4049 100%);
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#4A515B), color-stop(100%,#3C4049));
        background: -webkit-linear-gradient(top, #4A515B 0%,#3C4049 100%);
        background: -o-linear-gradient(top, #4A515B 0%,#3C4049 100%);
        background: -ms-linear-gradient(top, #4A515B 0%,#3C4049 100%);
        background: linear-gradient(top, #4A515B 0%,#3C4049 100%);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049');
        -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049')";
        border-color: #2B2E33;
    }

    #main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover > span {
        color: #FFF;
    }

    #main-nav.nav-tabs.nav-stacked > li {
        margin-bottom: 4px;
    }
    /*控制菜单箭头*/
    .nav-header.collapsed > span.glyphicon-chevron-toggle:before {
        content: "\e114";
    }

    .nav-header > span.glyphicon-chevron-toggle:before {
        content: "\e113";
    }

    /*定义二级菜单样式*/
    .secondmenu a {
        font-size: 12px;
        color: #4A515B;
        /*text-align: center;*/
    }

    .secondmenu li.active {
        background-color: #eee;
        border-color: #428bca;
    }

    .navbar-static-top {
        background-color: #212121;
        margin-bottom: 5px;
    }

    .navbar-brand {
        background: url('') no-repeat 10px 8px;
        display: inline-block;
        vertical-align: middle;
        padding-left: 50px;
        color: #fff;
    }
</style>
<body>
<div class="navbar navbar-duomi navbar-static-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="${ctx}/api/home" id="logo">后台管理系统
            </a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="javascript:void(0)">admin</a></li>
            <li><a href="#">退出</a></li>
        </ul>
    </div>
</div>
<div>
    <div class="sidebar">
        <ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
            <li<#-- class="active"-->>
                <a href="#">
                    <i class="glyphicon glyphicon-th-large"></i>
                    首页
                </a>
            </li>
            <li>
                <a href="#product" class="nav-header collapsed" data-toggle="collapse">
                    <i class="glyphicon glyphicon-cog"></i>
                    产品管理
                    <span class="pull-right glyphicon glyphicon-chevron-toggle"></span>
                </a>
                <ul id="product" class="nav nav-list collapse secondmenu" style="height: 0px;">
                    <li>
                        <a href="${ctx}/api/product/list" target="mainFrame">
                        <i class="glyphicon glyphicon-list"></i>
                        产品管理
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/api/product/type/list" target="mainFrame">
                            <i class="glyphicon glyphicon-list"></i>
                            产品类型管理
                        </a>
                    </li>
                </ul>

            </li>
            <#--<li>
                <a href="#systemSetting" class="nav-header collapsed" data-toggle="collapse">
                    <i class="glyphicon glyphicon-cog"></i>
                    系统管理
                    <span class="pull-right glyphicon glyphicon-chevron-toggle"></span>
                </a>
                <ul id="systemSetting" class="nav nav-list collapse secondmenu" style="height: 0px;">
                    <li class="active"><a href="#"><i class="glyphicon glyphicon-user"></i> 用户管理</a></li>
                    <li><a href="#"><i class="glyphicon glyphicon-th-list"></i> 菜单管理</a></li>
                    <li><a href="#"><i class="glyphicon glyphicon-asterisk"></i> 角色管理</a></li>
                    <li><a href="#"><i class="glyphicon glyphicon-edit"></i> 修改密码</a></li>
                    <li><a href="#"><i class="glyphicon glyphicon-eye-open"></i> 日志查看</a></li>
                </ul>
            </li>
            <li>
                <a href="./plans.html">
                    <i class="glyphicon glyphicon-credit-card"></i>
                    物料管理
                </a>
            </li>
            <li>
                <a href="./grid.html">
                    <i class="glyphicon glyphicon-globe"></i>
                    分发配置
                    <span class="label label-warning pull-right">5</span>
                </a>
            </li>
            <li>
                <a href="./charts.html">
                    <i class="glyphicon glyphicon-calendar"></i>
                    图表统计
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="glyphicon glyphicon-fire"></i>
                    关于系统
                </a>
            </li>-->
        </ul>
    </div>
    <div class="content">
        <iframe src="${ctx}/index" id="iframepage" name="mainFrame" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" width="100%" style="height:expression(document.body.clientHeight-200);" onLoad="iFrameHeight()"></iframe>
    </div>
</div>


</div>
<script type="text/javascript" language="javascript">
    function iFrameHeight() {
        var ifm= document.getElementById("iframepage");
        var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;
        if(ifm != null && subWeb != null) {
            ifm.height = subWeb.body.scrollHeight;
            ifm.width = subWeb.body.scrollWidth;
        }
    }
</script>
</body>
</html>
	