<#assign bootstrap="bootstrap3.3.0">
<#assign ctx=rc.contextPath>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<!-- pace & custom cover -->
<link rel="stylesheet" href="${ctx}/resources/pace/pace1.0.2_cover.css" />
<link rel="stylesheet" href="${ctx}/resources/cdn/pace/1.0.2/themes/blue/pace-theme-minimal.css" />
<script type="text/javascript">
    paceOptions = {
        ajax: false, // disabled
        document: true, // disabled
        eventLag: false
    };
</script>
<!-- <script src="http://cdn.bootcss.com/pace/1.0.2/pace.js"></script> -->
<script src="${ctx}/resources/pace/pace1.0.2_cover.js"></script>
<script>
    Pace.on("done", function(){
        $(".browser-screen-loading").hide();
    });
</script>

<!-- Bootstrap -->
<link rel="stylesheet" href="${ctx}/resources/cdn/bootstrap/3.3.4/css/bootstrap.min.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="${ctx}/resources/cdn/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="${ctx}/resources/cdn/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="${ctx}/resources/cdn/jquery/1.11.2/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="${ctx}/resources/cdn/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link href="${ctx}/resources/cdn/jquery.bootstrapvalidator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet"/>
<script src="${ctx}/resources/cdn/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>
<script src="${ctx}/resources/cdn/jquery.bootstrapvalidator/0.5.3/js/language/zh_CN.js"></script>
<#--<script src="http://cdn.bootcss.com/jquery-validate/1.13.1/jquery.validate.min.js"></script>-->

<script type="text/javascript" src="${ctx}/resources/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/jquery/zTree_v3/zTreeStyle.css" type="text/css">
<#--<link rel="stylesheet" type="text/css" href="${ctx}/css/animate.css" media="all" />

<link rel="stylesheet" type="text/css" href="${ctx}/js/mobile/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/${bootstrap}/css/bootstrap.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctx}/${bootstrap}/css/bootstrap-switch.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctx}/${bootstrap}/css/bootstrapValidator.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctx}/${bootstrap}/css/bootstrap-notify.css" media="all" />

<link rel="stylesheet" type="text/css" href="${ctx}/css/ms.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctx}/jquery/zTree_v3/zTreeStyle.css" media="all" />
<script type="text/javascript" src="${ctx}/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${ctx}/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/${bootstrap}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/${bootstrap}/js/bootstrap-switch.min.js"></script>
<script type="text/javascript" src="${ctx}/${bootstrap}/js/bootstrapValidator.js"></script>
<script type="text/javascript" src="${ctx}/${bootstrap}/js/bootstrap-notify.js"></script>

<script type="text/javascript" src="${ctx}/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/jquery/jquery.tmpl.min.js"></script>
<link href="${ctx}/css/daterangepicker.css" rel="stylesheet">
<script type="text/javascript" src="${ctx}/jquery/moment.js"></script>
<script type="text/javascript" src="${ctx}/jquery/daterangepicker.js"></script>
<!-- Just for debugging purposes. Don't actually copy these 2 lines! &ndash;&gt;
<!--[if lt IE 9]><script src="${ctx}/../../assets/js/ie8-responsive-file-warning.js"></script><![endif]&ndash;&gt;
<script src="${ctx}/bootstrap3.0.3/ie-emulation-modes-warning.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug &ndash;&gt;
<script src="${ctx}/bootstrap3.0.3/ie10-viewport-bug-workaround.js"></script>

<script type="text/javascript" src="${ctx}/resources/jquery/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/jquery//swfupload/jquery.swfupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/jquery//swfupload/fileprogress.js"></script>

-->
<#include "/include/macro.ftl"/>
<script>
  var basePath = "${ctx}";
  var ctx = "${ctx}";
  $(function() {
      $("[data-toggle='tooltip']").tooltip();
      $("[data-toggle='popover']").popover({html:true});
  });
</script>
<link href="${ctx}/resources/css/common.css" rel="stylesheet"/>