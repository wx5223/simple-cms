<#assign bootstrap="bootstrap3.3.0">
<#assign ctx=rc.contextPath>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link href="http://cdn.bootcss.com/jquery.bootstrapvalidator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet"/>
<script src="http://cdn.bootcss.com/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>
<script src="http://cdn.bootcss.com/jquery.bootstrapvalidator/0.5.3/js/language/zh_CN.js"></script>
<script src="http://cdn.bootcss.com/jquery-validate/1.13.1/jquery.validate.min.js"></script>

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
<script type="text/javascript" src="${ctx}/${bootstrap}/js/bootstrap-notify.js"></script>-->
  
<#--  <script type="text/javascript" src="${ctx}/jquery/jquery.validate.min.js"></script>
 <script type="text/javascript" src="${ctx}/jquery/jquery.tmpl.min.js"></script>
<link href="${ctx}/css/daterangepicker.css" rel="stylesheet">
<script type="text/javascript" src="${ctx}/jquery/moment.js"></script>
<script type="text/javascript" src="${ctx}/jquery/daterangepicker.js"></script>
<!-- Just for debugging purposes. Don't actually copy these 2 lines! &ndash;&gt;
<!--[if lt IE 9]><script src="${ctx}/../../assets/js/ie8-responsive-file-warning.js"></script><![endif]&ndash;&gt;
<script src="${ctx}/bootstrap3.0.3/ie-emulation-modes-warning.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug &ndash;&gt;
<script src="${ctx}/bootstrap3.0.3/ie10-viewport-bug-workaround.js"></script>-->

<!----上传图片--->
<script type="text/javascript" src="${ctx}/resources/jquery/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/jquery//swfupload/jquery.swfupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/jquery//swfupload/fileprogress.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/manager/ms.manager.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ms.web.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ms.validate.js"></script>



<#-- <script type="text/javascript" src="${ctx}/jquery/bootstrap_select2/select2.min.js"></script>
<link rel="stylesheet" href="${ctx}/jquery/bootstrap_select2/select2.css" type="text/css">-->
<#include "/include/macro.ftl"/>
<script>
  var basePath = "${ctx}";
  var ctx = "${ctx}";
  $(function() {
              //启用工具提示
          $("[data-toggle='tooltip']").tooltip();
          $("[data-toggle='popover']").popover({html:true});
  })
  var websiteId= "0" ;
</script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="${ctx}/https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="${ctx}/https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<link href="${ctx}/resources/css/common.css" rel="stylesheet"/>

<script type="text/javascript" charset="utf-8" src="${ctx}/resources/ueditor1_3_6/ueditor.config.msg.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/ueditor1_3_6/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/ueditor1_3_6/ueditor.parse.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/ueditor1_3_6/lang/zh-cn/zh-cn.js"></script>
