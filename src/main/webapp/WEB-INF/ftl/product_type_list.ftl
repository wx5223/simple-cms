<!DOCTYPE html>
<html lang="en">
<head>
<#include "/include/meta.ftl"/>
    <style>
        .panel-default {
            height: 500px;
            overflow: auto;
        }
    </style>
</head>
<body>
<div class="container-fluid link-style">
    <!--顶部   开始-->
    <div class="row rowpadding3">
        <div class="col-md-12">
            <h3 class="page-title bottomLine">
                <small>产品类型</small>
            </h3>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
            <#--<div class="panel-heading">
                <h4>类型树</h4>
            </div>-->
                <div class="panel-body">
                    <ul id="tree1" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-md-8">
            <div class="btn-group" role="group" aria-label="...">
                <button type="button" class="btn btn-default" onclick="addNode()">添加同级节点</button>
                <button type="button" class="btn btn-default" onclick="addChildNode()">添加子节点</button>
                <button type="button" class="btn btn-default" onclick="deleteNode()">删除节点</button>
            </div>
            <div class="panel panel-default panel-body">
            <form class="form-horizontal" action="${ctx}/api/product/type/save">
                <div class="form-group">
                    <label class="col-md-2 control-label col-xs-3">节点名称:</label>
                    <input type="hidden" class="form-control" name="id" value="">

                    <div class="col-md-6  col-xs-9">
                        <input type="text" class="form-control" name="name" data-toggle="popover" placeholder="名称"
                               data-placement="right" data-content="" value="">
                    </div>
                    <div class="col-md-2  col-xs-4">
                        <label class="control-label">排序:</label>
                    </div>
                    <div class="col-md-2  col-xs-4">
                        <input type="text" class="form-control" placeholder="0" maxlength="8" name="order"
                               data-toggle="popover" data-placement="right" data-content="" value="0">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label col-xs-3">父节点名称:</label>
                    <input type="hidden" class="form-control" name="pId" value="">
                    <div class="col-md-6  col-xs-9">
                        <input type="text" class="form-control" disabled name="pName" data-toggle="popover" placeholder=""
                               data-placement="right" data-content="" value="">
                    </div>
                    <div class="col-md-2  col-xs-4">
                        <button type="button" class="btn btn-default" id="setRoot">设置为根节点</button>
                    </div>
                </div>
                <#--<div class="form-group">
                    <label class="col-md-2 control-label col-xs-3">类型:</label>
                    <div class="col-md-6  col-xs-9">
                        <select name="type"  class="form-control">
                            <option>Enter</option>
                            <option>Your</option>
                            <option>Options</option>
                            <option>Here!</option>
                        </select>
                    </div>
                </div>-->
                <div class="form-group">
                    <label class="col-md-2 control-label col-xs-4">描述:</label>
                    <div class="col-md-6  col-xs-9">
                    <textarea class="form-control " rows="4" name="description" placeholder="描述" data-toggle="popover"
                              data-placement="right" data-content=""></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-2 col-md-2"></div>
                    <div class="col-xs-10  col-md-10 padding0">
                        <button type="submit" class="btn btn-success" id="save">保存</button>
                    </div>
                </div>
            </form>
            </div>
        </div>
    </div>
</div>

<!--页面刷新加载效果开始-->
<div id="loadingEffect" style="display:none;">
    <img src='${ctx}/images/lodingDit.gif'/>
</div>
<!--页面提示信息-->
<div class="alertWindows" style="min-width:240px; height:65px; background-color:green; color:white; font-size:14px;
			text-align:center; border:1px solid red; position:absolute; top:45%; left:37%; line-height:65px;
			opacity:0.8; border-radius:10px; display:none;">
</div>


<@warnModal modalName="deleteModel"/>
<SCRIPT type="text/javascript">
    selectedNode = null;
    <!--
    var setting = {
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
    function beforeClick(treeId, treeNode) {
        var check = (treeNode);
        //if (!check) alert("只能选择城市...");
        return check;
    }

    function onClick(e, treeId, treeNode) {
        selectedNode = treeNode;
        $("input[name='id']").val(treeNode.id);
        $("input[name='name']").val(treeNode.name);
        $("input[name='pId']").val(treeNode.pId);
        $("textarea[name='description']").text(treeNode.description);
        $("input[name='order']").val(treeNode.order);
        var pNode = treeNode.getParentNode();
        if(pNode != null) {
            $("input[name='pName']").val(pNode.name);
        } else {
            $("input[name='pName']").val('');
        }
    }
    function addNode() {
        if(selectedNode == null) {
            alert('请先选择一个节点');
            return;
        }
        $("input[name='id']").val('');
        $("input[name='name']").val('');
        $("input[name='pId']").val(selectedNode.pId);
        $("textarea[name='description']").text('');
        $("input[name='order']").val('0');
        var pNode = selectedNode.getParentNode();
        if(pNode != null) {
            $("input[name='pName']").val(pNode.name);
        } else {
            $("input[name='pName']").val('');
        }
    }
    function addChildNode() {
        if(selectedNode == null) {
            alert('请先选择一个节点');
            return;
        }
        $("input[name='id']").val('');
        $("input[name='name']").val('');
        $("input[name='pId']").val(selectedNode.id);
        $("textarea[name='description']").text('');
        $("input[name='order']").val('0');
        $("input[name='pName']").val(selectedNode.name);
    }

    function deleteNode() {
        if(selectedNode == null) {
            alert('请先选择一个节点');
            return;
        }
        warndeleteModel("确定要删除节点？", "删除", "deleteSelectedNode()");
    }
    function deleteSelectedNode() {
        $.post('${ctx}/api/product/type/delete/'+selectedNode.id, function(result) {
            if(result.ret == 0) {
                location.href=ctx+'/api/product/type/list';
            }
        });
    }

    $(document).ready(function () {
        $.post('${ctx}/api/product/type/json', function(data) {
            var treeObj = $.fn.zTree.init($("#tree1"), setting, data);
            treeObj.expandAll(true);
        });
        $('form').bootstrapValidator({
            excluded: [':disabled'],
            fields: {
                name: {
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
                    location.href=ctx+'/api/product/type/list';
                }
            });
        });
    });
    //-->
</SCRIPT>

</body>
</html>
