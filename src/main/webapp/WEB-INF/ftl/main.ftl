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
    .ms-m-body {
        MARGIN: 0px auto;height: 100%; margin-left: 10px
    }
    .frame {
        PADDING-BOTTOM: 10px; BACKGROUND-COLOR: #ffffff; MARGIN: 0px auto; PADDING-LEFT: 10px; WIDTH: 98%; height: 100%;PADDING-RIGHT: 0px; PADDING-TOP: 10px; border-radius: 10px; -moz-border-radius: 10px; -webkit-border-radius: 10px
    }
    .navi {
        margin: 20px 0 20px 0;
        width: 220px;
        float: left;
    }
    .content {
        margin-left: 220px;
    }
</style>
<body>
<div id="navbar" class="navbar-collapse collapse rc-NewPageHeader">
        <ul class="nav navbar-nav">
            <li class="active"><a href="#">
                <img src=""></img>
            </a></li>
            <li><a href="javascript:void(0)">后台管理系统</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="javascript:void(0)">admin</a></li>
            <li><a href="#">退出</a></li>
        </ul>
</div>
<div>
    <div class="navi"></div>
    <div class="content">
        <iframe src="${ctx}/index" id="iframepage" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="100%" onLoad="iFrameHeight()"></iframe>
    </div>
</div> <!-- /container -->
<#include "/include/foot.ftl"/>
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
	