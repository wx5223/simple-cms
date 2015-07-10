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
<!--JQ特效部分-->
<script>
    //有关下拉列表的函数
    function beforeClick(treeId, treeNode) {
        var check = (treeNode);
        //if (!check) alert("只能选择城市...");
        return check;
    }

    function onClick(e, treeId, treeNode) {
        console.log(treeNode);
        $("input[name='typeId']").val(treeNode.id);
        $("input[name='typeName']").val(treeNode.name);
        $("#treeShowName").html(treeNode.name);
        $('form').data('bootstrapValidator')
                .updateStatus('typeId', 'NOT_VALIDATED')
                .validateField('typeId');
    }

    function showMenu() {
        var cityObj = $("#modelSel");
        var cityOffset = $("#modelSel").offset();
        $("#menuContent").slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }
    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }
    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
        }
    }
</script>
<body>
<!--顶部开始-->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 col-xs-10">
            <h3 class="page-title bottomLine">产品管理&nbsp;
            <#--<#if product?has_content>
                <small>编辑</small>
            <#else>
                <small>添加</small>
            </#if>-->
            </h3>
        </div>
        <div class="col-md-2 col-xs-2 white padding0 ">
            <button class="btn btn-default pull-right" role="button" onclick="javascript:history.go(-1)">返回产品列表</button>
        </div>
    </div>
    <hr>
    <div class="row margin20">
        <form id="articleForm" class="form-horizontal" role="form" action="${ctx}/api/product/save" method="post">
            <!--网站标题-->
            <div class="form-group">
                <label class="col-md-2 control-label col-xs-3">产品标题:</label>
                <input type="hidden" class="form-control" name="id" id="articleID" value="${(product.id)!}">

                <div class="col-md-4  col-xs-6">
                    <input type="text" class="form-control" name="title" data-toggle="popover" placeholder="产品标题"
                           data-placement="right" data-content="" value="${(product.title)!""}">
                </div>
                <label for="ArticleList" class="col-md-1 control-label col-xs-3">自定义顺序:</label>

                <div class="col-md-1  col-xs-1">
                    <input type="text" class="form-control" placeholder="0" maxlength="8" name="articleFreeOrder"
                           data-toggle="popover" data-placement="right" data-content="" id="ArticleList" value="0">
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label col-xs-3">缩略图:</label>

                <div class="col-md-4 uploadImg  col-xs-6"><#--${article.basicThumbnails?default('')}-->
					    <@uploadImg path="/upload/article" inputName="thumbnail" size="1" filetype="" msg="缩略图" imgs="${(product.thumbnail)!}" maxSize="1"/>
                </div>
            </div>

            <div class="form-group">
                <label for="ArticleDeputy" class="col-md-2 control-label col-xs-3">类型:</label>
                <div class="col-md-3  col-xs-4">
                    <label id="menuBtn" role="button" data-toggle="dropdown" class="form-control"
                           onClick="showMenu(); return false;">
                        <span id="treeShowName" style="float: left;width: 85px;">请选择</span><span class="caret" style="float: right;margin-top: 8px;"></span>
                    </label>
                    <input type="hidden" name="typeId" value="${(product.typeId)!""}"/>
                    <input type="hidden" name="typeName" value="${(product.typeName)!""}"/>
                    <div id="menuContent" class="menuContent" style="display:none;">
                        <ul id="ztree1" class="ztree" style="margin-top:0; width:160px;">
                        </ul>
                    </div>
                </div>
            </div>

            <!--描述-->
            <div class="form-group">
                <label class="col-md-2 control-label col-xs-4">描述:</label>

                <div class="col-md-6  col-xs-9">
                    <textarea class="form-control " rows="4" name="brief" placeholder="产品的描述" data-toggle="popover"
                              data-placement="right" data-content="">${(product.brief)!}</textarea>
                </div>
            </div>

            <!--描述-->
            <div class="form-group">
                <label class="col-md-2 control-label col-xs-4">关键字:</label>

                <div class="col-md-6  col-xs-9">
                    <textarea class="form-control" rows="4" name="articleKeyword" placeholder="产品的关键字"
                              data-toggle="popover" data-placement="right" data-content=""></textarea>
                </div>
            </div>

            <!--版权信息-->
            <div class="form-group">
                <label class="col-md-2 control-label col-xs-4">产品内容:</label>

                <div class="col-md-10  col-xs-9"><#--${article.articleContent?default('')}-->
							<@smallUedit inputName="content" width="800"  height="400" content="${(product.content)!}"/>
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
                title: {
                    validators: {
                        notEmpty: {},
                        stringLength: {max: 50}
                    }
                },
                brief: {
                    validators: {
                        stringLength: {max: 500}
                    }
                },
                typeId: {
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
            $.post($form.attr('action'), $form.serialize(), function (result) {
                console.log(result);
                alert(result.msg);
                if(result.ret == 0) {
                    location.href=ctx+'/api/product/list';
                }
            });
        });
    });
    var setting;
    function checkForm(id) {
    }

    $(function () {
        checkForm("#articleForm");
        // ajax 给选择父模块下拉框赋值
        var treeJson = [
            {id: 1, pId: null, name: '001', type: '1s'},
            {id: 2, pId: 1, name: '002', type: 1},
            {id: 3, pId: 1, name: '003', type: 1}
        ];
        setting = {
            view: {
                dblClickExpand: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeClick: beforeClick,
                onClick: onClick
            }
        };
        $.fn.zTree.init($("#ztree1"), setting, treeJson);
        $.ajax({
            type: "post",
            url: ctx + "/manager/cms/column/queryJsonAll.do",
            dataType: "json",
            success: function (msg) {
                var modelList = $.parseJSON(msg.resultData);
                //获取栏目名
                for (var i = 0; i < modelList.length; i++) {
                    if ($("input[name='basicCategoryId']").val() == modelList[i].categoryId) {
                        $("#treeShowName").html(modelList[i].categoryTitle);
                    }
                }
                setting = {
                    view: {
                        dblClickExpand: false
                    },
                    data: {
                        simpleData: {
                            enable: true
                        }
                    },
                    callback: {
                        beforeClick: beforeClick,
                        onClick: onClick
                    }
                };
                var zNodes = new Array();
                for (var i = 0; i < modelList.length; i++) {
                    zNodes[i] = {
                        id: modelList[i].categoryId,
                        pId: modelList[i].categoryCategoryId,
                        name: modelList[i].categoryTitle,
                        type: modelList[i].columnType,
                        open: true
                    }
                }
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            },
        });

    });
</script>
</body>
</html>
	