<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/>
    <script type="text/javascript" src="${ctx}/resources/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script>
    <link rel="stylesheet" href="${ctx}/resources/jquery/zTree_v3/zTreeStyle.css" type="text/css">
</head>
<body>
<div class="container-fluid link-style">
    <div class="row">
        <div></div>
            <div class="row rowpadding3">
                <div class="col-md-12">
                    <h3 class="page-title bottomLine">
                        <small>产品列表</small>
                    </h3>
                </div>
            </div>
            <hr>

            <div class="row" id="articlePage">
                <!--功能按键部分 开始-->
                <div class="form-group">
                    <button type="button" class="btn btn-success col-md" id="addArticleButton">新增&nbsp;<span
                            class="glyphicon glyphicon-plus"></span></button>
                    <button type="button" class="btn btn-danger btn-md" id="allDelete">批量删除 <span
                            class="glyphicon glyphicon-trash"></button>
                </div>
                <!--功能按键部分 结束-->
                <!--搜索框  开始-->
                <div class="form-inline form-group searchForm" role="form">
                    <form method="post">
                        <div class="form-group">
                            <label for="kayword" class="sr-only">关键字</label>
                            <input type="text" class="form-control" name="keyword" placeholder="输入关键字"
                                   value="${keyword?default('')}">
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary" id="search">搜索</button>
                        </div>
                    </form>
                </div>
                <!--搜索框的使用 结束-->

                <!--列表 开始-->
                <table class="table table-bordered">
                    <!--表格栏目属性 开始-->
                    <thead>
                    <tr>
                        <th class="width-5 text-center">
                            <input type="checkbox" id="allCheck" value="全选" data-original-title="点击全选"
                                   data-toggle="tooltip">
                        </th>
                        <th class="width-5 text-center">ID</th>
                        <th class="width-20 text-center">类型</th>
                        <th class="width-30 text-left">标题</th>
                        <th class="width-20 text-center">描述</th>
                        <th class="width-5 text-center">推荐</th>
                        <th class="width-5 text-center">热门</th>
                        <th class="width-10 text-center">操作</th>
                    </tr>
                    </thead>
                    <!--表格栏目属性 结束-->
                    <!--表格内容  开始-->
                    <tbody>
                    <#if page.content?has_content>
                        <#list page.content as list>
                        <tr id="tableArticle">
                            <td class="text-center">
                                <input type="checkbox" name="checkbox" value="${list.id!0}">
                            </td>
                            <td class="text-center articleId">${list.id!0}</td>
                            <td class="text-center"><#if list.typeId?exists>${list.typeName?default("")}</#if></td>
                            <td class="text-left">
		            	<span class="updateArticle" data-toggle="tooltip" data-original-title="点击修改文章"
                              data-id="${list.id!0}">
		            		<#if keyword?has_content>
                            ${list.title?default("无标题")?replace(keyword,"<font color='red'>"+keyword+"</font>")}
                            <#else>
                            ${list.title?default("无标题")}
                            </#if>
                            <span style="color:red">

                            <#--<#if articleTypeList?has_content>
		        			<#list articleTypeList as at>
		        				
		        				<#if at.key?default("")?string?trim == list.articleType?default("")?string?trim?replace(","," ")>
		        					[${at.value}]
  									<#break>
  								</#if>
		        			</#list>
		        		</#if>-->
                            </span>
		            	</span>
                            </td>
                            <td class="text-center">${(list.brief)!}</td>
                            <td class="text-center"><#if (list.recommend)?? &&list.recommend=1>是</#if></td>
                            <td class="text-center"><#if (list.hot)?? && list.hot=1>是</#if></td>
                            <td class="text-center">
                                <a class="btn btn-xs red tooltips del-btn deleteArticle" data-toggle="tooltip"
                                   data-original-title="删除" data-id="${(list.id)!0}">
                                    <i class="glyphicon glyphicon-trash"></i>
                                </a>
                                <a class="btn btn-xs red tooltips  updateArticle" data-toggle="tooltip"
                                   data-original-title="修改" data-id="${(list.id)!0}">
                                    <i class="glyphicon glyphicon-pencil"></i>
                                </a>
                                <a class="btn btn-xs red tooltips del-btn preview" data-toggle="tooltip"
                                   data-original-title="预览" data-id="${(list.id)!0}">
                                    <i class=" glyphicon glyphicon-globe"></i>
                                </a>
                            </td>
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
            <!--列表结束-->
            <!--分页样式 开始-->
            <div class="container-fluid">
            <#if page?has_content>
			<@showPage page=page linkUrl="${ctx}/api/product/list?"/>
		</#if>
    </div>
</div>

</div>


<!--引用弹出框插件-->
<@warnModal modalName="Model"/>
<!--JQ特效部分-->
<script>

    //有关下拉列表的函数
    function beforeClick(treeId, treeNode) {
        var check = (treeNode);
        return check;
    }

    function onClick(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = zTree.getSelectedNodes(),
                v = "";
        var parentId;
        var modelObj = $("input[name='basicCategoryId']");
        nodes.sort(function compare(a, b) {
            return a.id - b.id;
        });
        for (var i = 0, l = nodes.length; i < l; i++) {
            v = nodes[i].name;
            parentId = nodes[i].id;
        }
        var cityObj = $("#menuBtn");
        modelObj.attr("value", parentId);
        cityObj.attr("value", v);
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
    //确认删除
    function right(id) {
        $.ajax({
            type: "POST",
            url: ctx + "/api/product/delete/" + id,
            dataType: "Json",
            success: function (msg) {
                if (msg.ret == 0) {
                    location.href.reload();
                } else {
                    alert("失败！")
                }
            },
        });
    }

    $(function () {
        //预览文章
        $("#articlePage").delegate("table tr .preview", "click", function () {
            var id = $(this).attr("data-id");
            window.open("${ctx}/product/" + id);
        });

        //删除文章
        $("#articlePage").delegate("table tr .deleteArticle", "click", function () {
            var id = $(this).attr("data-id");
            warnModel("确定要删除？", "删除", "right(" + id + ")");
        });

        //添加文章
        $("#articlePage").delegate("#addArticleButton", "click", function () {
            location.href = ctx + "/api/product/add";
        });

        //编辑文章
        $("#articlePage").delegate("table tr td .updateArticle", "click", function () {
            var id = $(this).attr("data-id");
            location.href = ctx + "/api/product/update/" + id;
        });

        //返回文章列表
        $("#articlePage").delegate("#returnButton", "click", function () {
            location.href = ctx + "/api/product/list";
        });

        //点击搜索进行文章搜索
        $("#articlePage").delegate("#search", "click", function () {
            var columnId = $('[name="basicCategoryId"]').val();
            var articleType = $(".searchForm .attribute").val();
            var keyword = $('[name="keyword"]').val();

            location.href = ctx + "/manager/cms/article/${categoryId?default(0)}/list.do?keyword=" + keyword + "&articleType=" + articleType;
        });
        //启用工具提示
        $("[data-toggle='tooltip']").tooltip();

        //全选
        $("#allCheck").click(function () {
            if (this.checked) {
                $("input[name='checkbox']").each(function () {
                    this.checked = true;
                });
            } else {
                $("input[name='checkbox']").each(function () {
                    this.checked = false;
                });
            }
        });

        //多选删除
        $("#allDelete").click(function () {
            warnModel("确定要批量删除？", "批量删除", "allRight()");
        });
    });

    //批量删除
    function allRight() {
        //将checkbox序列化
        var checkboxData = $("input[name='checkbox']").serialize();
        if (checkboxData != "") {
            $.ajax({
                type: "POST",
                url: ctx + "/api/product/delete/batch",
                data: checkboxData,
                dataType: "Json",
                success: function (msg) {
                    if (msg.ret == 0) {
                        alert("批量删除成功！")
                        location.href.reload();
                    } else {
                        alert("批量删除失败");
                    }

                }
            });
        } else {
            alert("请选择！");
        }
    }
</script>
</body>
</html>
