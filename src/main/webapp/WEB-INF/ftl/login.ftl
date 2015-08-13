<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/>
<link type="text/css" href="${ctx}/resources/cdn/jquery-ui-bootstrap/0.5pre/css/custom-theme/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
<link type="text/css" href="${ctx}/resources/cdn/jquery-ui-bootstrap/0.5pre/assets/css/font-awesome.min.css" rel="stylesheet" />
<!--[if IE 7]>
<link rel="stylesheet" href="${ctx}/resources/cdn/jquery-ui-bootstrap/0.5pre/assets/css/font-awesome-ie7.min.css">
<![endif]-->
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/cdn/jquery-ui-bootstrap/0.5pre/css/custom-theme/jquery.ui.1.10.0.ie.css"/>
<![endif]-->
<script src="${ctx}/resources/cdn/jquery-ui-bootstrap/0.5pre/assets/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<style>
    .light-login .widget-box {
        padding: 1px 1px 0;
        -webkit-box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.12);
        box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.12);
        border-bottom: 1px solid rgba(50, 50, 50, 0.33);
    }
    .login-container {
        width: 375px;
        margin: 0 auto;
    }
    @media only screen and (max-width: 540px) {
        .login-layout .widget-box .widget-main {
            padding: 16px;
        }
        .login-container {
            width: 98%;
        }
        .login-layout .widget-box {
            padding: 0;
        }
        .login-layout .main-content {
            padding-left: 6px;
            padding-right: 6px;
        }
        .login-box .toolbar > div {
            width: auto;
        }
    }
    .red {
        color: #dd5a43 !important;
    }
    .grey {
        color: #777777 !important;
    }
    .blue {
        color: #478fca !important;
    }
    h4 {
        font-size: 18px;
        font-weight: normal;
        font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
    }
    h1 {
        font-size: 32px;
        font-weight: normal;
        font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
    }
    .login-box {
        padding: 0;
        -webkit-box-shadow: none;
        box-shadow: none;
        margin: 3px 0;
        border: 1px solid #CCC;
        padding: 1px 1px 0;
        -webkit-box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.12);
        box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.12);
        border-bottom: 1px solid rgba(50, 50, 50, 0.33);
        -moz-transform: scale(1,1) translate(0);
        -webkit-transform: scale(1,1) translate(0);
        -o-transform: scale(1,1) translate(0);
        -ms-transform: scale(1,1) translate(0);
        transform: scale(1,1) translate(0);
        transition: transform .3s ease;
        -moz-transition: -moz-transform 0.3s ease;
        -webkit-transition: -webkit-transform 0.3s ease;
        -o-transition: -o-transform 0.2s ease;
        background-color: #BCC6CF;
        background-color: rgba(100, 110, 120, 0.4);
        visibility: visible;
        position: relative;
        z-index: auto;
        border-width: 0;
    }
    .widget-body {
        background-color: #FFF;
    }
    .widget-main {
        padding: 16px 36px 36px;
        background: #F7F7F7;
        padding-bottom: 16px;
    }
    .header.blue {
        border-bottom-color: #d5e3ef;
    }
    h4.bigger {
        font-size: 19px;
    }
    .header {
        line-height: 28px;
        margin-bottom: 16px;
        margin-top: 18px;
        padding-bottom: 4px;
        border-bottom: 1px solid #CCC;
    }
    .lighter {
        font-weight: lighter;
    }
    .space-6 {
        max-height: 1px;
        min-height: 1px;
        overflow: hidden;
        margin: 6px 0 5px;
    }
    .login-layout label {
        margin-bottom: 11px;
    }
    label {
        font-weight: normal;
        font-size: 14px;
        display: inline-block;
        max-width: 100%;
        margin-bottom: 5px;
    }
    textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
        border-radius: 0 !important;
        color: #858585;
        background-color: #ffffff;
        border: 1px solid #d5d5d5;
        padding: 5px 4px 6px;
        font-size: 14px;
        font-family: inherit;
        -webkit-box-shadow: none !important;
        box-shadow: none !important;
        -webkit-transition-duration: 0.1s;
        transition-duration: 0.1s;
    }
    .form-control {
        display: block;
        /*width: 100%;*/
        height: 34px;
        padding: 6px 12px;
        font-size: 14px;
        line-height: 1.42857143;
        color: #555;
        background-color: #fff;
        background-image: none;
        border: 1px solid #ccc;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
        box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
        -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
        -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    }
    .btn {
        display: inline-block;
        color: #FFF !important;
        text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25) !important;
        background-image: none !important;
        /*border: 5px solid #FFF;*/
        border-radius: 0;
        box-shadow: none !important;
        -webkit-transition: background-color 0.15s, border-color 0.15s, opacity 0.15s;
        -o-transition: background-color 0.15s, border-color 0.15s, opacity 0.15s;
        transition: background-color 0.15s, border-color 0.15s, opacity 0.15s;
        cursor: pointer;
        vertical-align: middle;
        margin: 0;
        position: relative;
    }
    .btn-primary, .btn-primary:focus {
        background-color: #428bca !important;
        border-color: #428bca;
    }
    .btn-primary:hover, .btn-primary:active, .open .btn-primary.dropdown-toggle {
        background-color: #1b6aaa !important;
        border-color: #428bca;
    }
    .btn-sm {
        border-width: 4px;
        font-size: 13px;
        padding: 4px 9px;
        line-height: 1.39;
    }
    .space {
        max-height: 1px;
        min-height: 1px;
        overflow: hidden;
    }
    .width-35 {
        width: 35% !important;
    }
    .width-40 {
        width: 40% !important;
    }
    .width-100 {
        width: 100% !important;
    }
    .bigger-110 {
        font-size: 110% !important;
    }
    #code {
        cursor: pointer;
    }
</style>
</head>
<body class="login-layout light-login">
<div class="main-container">
    <div class="main-content">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="login-container">
                    <div class="text-center">
                        <h1>
                            <i class="ace-icon fa fa-leaf green"></i>
                            <span class="red">后台管理</span>
                            <span class="grey" id="id-text2">系统</span>
                        </h1>
                        <h4 class="blue" id="id-company-text">&copy; 南京皇拓</h4>
                    </div>
                    <div class="space-6"></div>
                    <div class="position-relative">
                        <div id="login-box" class="login-box visible widget-box no-border">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h4 class="header blue lighter bigger">
                                        <i class="ace-icon fa fa-coffee green"></i>
                                        请输入登录信息
                                    </h4>
                                    <div class="space-6"></div>
                                    <form action="${ctx}/api/login">
                                        <fieldset>
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="account" placeholder="账号">
                                            </div>
                                            <div class="form-group">
                                                <input type="password" class="form-control" name="password" placeholder="密码">
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control width-35" name="code" placeholder="验证码">
                                                <span class="width-35 pull-right">
                                                    <img id="code" src="${ctx}/code.jpg"/>
                                                </span>
                                            </div>
                                            <#--
                                            <label class="block clearfix width-100">
                                                <span class="block input-icon input-icon-right">
                                                    <input type="text" class="form-control" name="account"
                                                           placeholder="账号"/>
                                                    <i class="ace-icon fa fa-user"></i>
                                                </span>
                                            </label>
                                            <label class="block clearfix width-100">
                                                <span class="block input-icon input-icon-right">
                                                    <input type="password" class="form-control" name="password"
                                                           placeholder="密码"/>
                                                    <i class="ace-icon fa fa-lock"></i>
                                                </span>
                                            </label>
                                            <label class="block clearfix width-100">
                                                <span class="block input-icon input-icon-right width-35 pull-left">
                                                    <input type="password" class="form-control" name="code"
                                                           placeholder="验证码"/>
                                                    <i class="ace-icon fa fa-lock"></i>
                                                </span>
                                                <span class="block pull-right width-35">
                                                    <img id="code" src="${ctx}/code.jpg"/>
                                                </span>
                                            </label>-->
                                            <div class="space-6"></div>
                                            <div class="clearfix">
                                                <!-- <label class="inline">
                                                    <input type="checkbox" class="ace" />
                                                    <span class="lbl"> 记住我</span>
                                                </label> -->
                                                <button id="login-btn" type="submit"
                                                        class="width-35 pull-right btn btn-sm btn-primary">
                                                    <i class="ace-icon fa fa-key"></i>
                                                    <span class="bigger-110">登录</span>
                                                </button>
                                            </div>
                                            <div class="space-6"></div>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--static dialog-->
<div id="dialog-message" title="提示"><p></p></div>
<!--end static dialog-->
<!-- inline scripts related to this page -->
<script type="text/javascript">
    jQuery(function ($) {
        $('form').bootstrapValidator({
            excluded: [':disabled'],
            fields: {
                title: {
                    validators: {
                        notEmpty: {}
                    }
                },
                account: {
                    validators: {
                        notEmpty: {}
                    }
                },
                password: {
                    validators: {
                        notEmpty: {}
                    }
                },
                code: {
                    validators: {
                        notEmpty: {}
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            // Prevent submit form
            e.preventDefault();
            // Get the form instance
            var $form = $(e.target);
            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');
            // Use Ajax to submit form data
            $.post($form.attr('action'), $form.serialize(), function (data) {
                if(data.ret != 0) {
                    $("#dialog-message p").text(data.msg);
                    $("#dialog-message").dialog( "open" );
                    $('#login-btn').removeAttr('disabled');
                    code();
                } else {
                    location.href = '${ctx}/api/main';
                }
            });
        });
        $("#dialog-message").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            buttons: {
                Ok: function () {
                    $(this).dialog("close");
                }
            }
        });
/*
        $('#login-btn').click(function () {
            $.post('${ctx}/api/login',{
                account:'',
                password:'',
                code:''
            }, function(data){
                if(data.ret != 0) {
                    $("#dialog-message p").text(data.msg);
                    $("#dialog-message").dialog( "open" );
                } else {
                    location.href = '${ctx}/api/main';
                }
            });
        });*/
        function code() {//生成验证码
            $('#code').hide().attr('src', '${ctx}/code.jpg?' + Math.floor(Math.random()*100) ).fadeIn();
        }
        $('#code').click(code);
    });
</script>
</body>
</html>
	