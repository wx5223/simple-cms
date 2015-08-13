<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/>
</head>
<style>
    .container {
        margin: 0;
        padding: 0;
        width: auto
    }

    hr {
        margin: 0;
        padding: 0;
    }

    .ms-button-group {
        padding: 0px 0px 8px 0px
    }

    .margin20 {
        margin-top: 20px;
    }

    .row {
        margin-left: 0;
        margin-right: 0;
        padding-bottom: 4px;
    }

    .form-horizontal .form-group {
        margin-left: 0;
        margin-right: 0
    }

    .control-label {
        font-weight: normal;
        font-size: 14px;
    }

    .popover-content {
        min-width: 205px;
        line-height: 20px;
    }

    .control-label {
        width: 15%;
    }

    .padding0 {
        padding: 0;
    }

    #addColumn {
        font-size: 22px;
        line-height: 33px;
        cursor: pointer;
    }

    #columnList form .panel-heading label, #columnList form .panel-body label {
        padding-top: 0;
    }

    #menuBtn {
        margin: 0
    }

    #menuContent {
        overflow: auto;
        max-height: 240px;
        width: 88%;
        display: none;
        z-index: 999;
        position: absolute;
        float: left;
        padding: 5px 0;
        margin: 2px 0 0;
        background-color: #ffffff;
        border: 1px solid rgba(0, 0, 0, 0.15);
        border-radius: 4px;
        -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
        background-clip: padding-box;
    }

    .red {
        color: red;
    }
</style>
<body>
<!--顶部开始-->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 col-xs-10">
            <h3 class="page-title bottomLine">
                <small>修改密码&nbsp;</small>
            </h3>
        </div>
    </div>
    <hr>
    <div class="row margin20">
        <form id="articleForm" class="form-horizontal" role="form" action="${ctx}/api/update/password" method="post">
            <div class="form-group">
                <label class="col-md-2 control-label col-xs-3">原密码:</label>
                <div class="col-md-4  col-xs-6">
                    <input type="password" class="form-control" name="oldPassword">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label col-xs-3">新密码:</label>
                <div class="col-md-4  col-xs-6">
                    <input type="password" class="form-control" name="password">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label col-xs-3">重复密码:</label>
                <div class="col-md-4  col-xs-6">
                    <input type="password" class="form-control" name="password2">
                </div>
            </div>
            <!--按钮组-->
            <div class="form-group">
                <div class="col-xs-2 col-md-2"></div>
                <div class="col-xs-10  col-md-10 padding0">
                    <button type="submit" class="btn btn-success" id="saveArticle">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('form').bootstrapValidator({
            excluded: [':disabled'],
            fields: {
                oldPassword: {
                    validators: {
                        notEmpty: {},
                        stringLength: {min:6, max: 20}
                    }
                },
                password: {
                    validators: {
                        notEmpty: {},
                        stringLength: {min:6, max: 20}
                    }
                },
                password2: {
                    validators: {
                        identical: {
                            field: 'password'
                        }
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
            $.post($form.attr('action'), $form.serialize(), function (result) {
                alert(result.msg);
                if(result.ret == 0) {
                    location.href=ctx+'/api/password';
                }
            });
        });
    });
</script>
</body>
</html>
	