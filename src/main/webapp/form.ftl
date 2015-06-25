<!DOCTYPE html>
<html lang="zh-CN">
<head>
<#include "/include/meta.ftl"/> <!--调用head内样式信息-->
<script type="text/javascript" src="${ctx}/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="${ctx}/jquery/zTree_v3/zTreeStyle.css" type="text/css">
</head>
<style>
	.container{margin:0;padding:0;width:auto}
	hr{margin:0;padding:0;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.margin20{margin-top:20px;}
	.row {margin-left:0;margin-right:0;padding-bottom:4px;}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.control-label{font-weight:normal;font-size:14px;}
	.popover-content{min-width:205px;line-height:20px;}
	.control-label{width:15%;}
	.padding0{padding: 0;}
	#addColumn{font-size: 22px;line-height: 33px;cursor: pointer;}
	#columnList form .panel-heading label,#columnList form .panel-body label{padding-top: 0;}

	#menuBtn{margin:0}
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
	.red{
		color:red;
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
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			v = "";
			var parentId;
			var modelObj= $("input[name='basicCategoryId']");
			nodes.sort(function compare(a,b){return a.id-b.id;});
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				parentId=nodes[i].id;
				type=nodes[i].type;
			}
			
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			//if(parentId.length>0) parentId=parentId.substring(0, parentId.length-1);
			var cityObj = $("#columnSuperTitle");
			//栏目类型
			if(type!=2){
				modelObj.attr("value",parentId);
				cityObj.html(v);
			}else{
				alert("文章所属栏目不能为单页");
			}
		}

		function showMenu(){
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
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
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
						<#if article?has_content>
							<small>编辑产品</small>
						<#else>
							<small>添加产品</small>
						</#if>
					</h3>
				</div>
			<div class="col-md-2 col-xs-2 white padding0 ">
				<button class="btn btn-default pull-right" role="button" onclick="javascript:history.go(-1)">返回产品列表</button>
			</div>
		</div>
		<hr>
		<div class="row margin20" >
			<form id="articleForm" class="form-horizontal" role="form" action="">
				<!--网站标题-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3">产品标题:</label>
						<input type="hidden" class="form-control" name="basicId" id="articleID" value="<#--${article?c?default(0)}-->">
					<div class="col-md-4  col-xs-6">
						<input type="text" class="form-control" name="title" maxlength="30" data-toggle="popover"  placeholder="产品标题" data-placement="right" data-content="" value="">
					</div>
					<label for="ArticleList" class="col-md-1 control-label col-xs-3">自定义顺序:</label>
					<div class="col-md-1  col-xs-1">
						<input type="text" class="form-control" placeholder="0" maxlength="8" name="articleFreeOrder" data-toggle="popover" data-placement="right" data-content="" id="ArticleList" value="0">
					</div>
				</div>
				<!--域名:-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3">产品属性:</label>
					<div class="col-sm-5 col-xs-7" id="typeArticle">
                        <label class="checkbox-inline">
                            <input type="checkbox" name="checkbox" value="123">345
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name="checkbox" value="1234">2345
                        </label>
					    <#if articleType?has_content>
		        			<#list articleType as articleType>
		        				<label class="checkbox-inline">
  									<input type="checkbox" name="checkbox" value="${articleType.key}">${articleType.value}
								</label>
		        			</#list>
		        		</#if>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3">缩略图:</label>
					<div class="col-md-4 uploadImg  col-xs-6"><#--${article.basicThumbnails?default('')}-->
							<@uploadImg path="/upload/article" inputName="thumbnail" size="1" filetype="" msg="产品缩略图" imgs="" maxSize="1"/>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3" >产品来源:</label>
					<div class="col-md-3 col-xs-4">
						<input type="text"  class="form-control" maxlength="300" placeholder="无产品来源" name="articleSource" data-toggle="popover" data-placement="right" data-content=""  value="">
					</div>
					<label class="col-md-2 control-label col-xs-3">产品作者:</label>
					<div class="col-md-3   col-xs-3">
						<input type="text" class="form-control"  name="articleAuthor" placeholder="无产品作者" maxlength="12" data-toggle="popover" data-placement="right" data-content=""  value="">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3" >跳转网址:</label>
					<div class="col-md-4  col-xs-6">
						<!--用于在后台对在网站内加入其他网址的链接，选择跳转属性后直接跳转 -->
						<input type="text"  class="form-control" name="articleUrl" placeholder="http://"  maxlength="100" data-toggle="popover" data-placement="right" data-content="" value="">
					</div>
				</div>
				
				<div class="form-group">
					<label for="ArticleDeputy" class="col-md-2 control-label col-xs-3">所属栏目:</label>
					<div class="col-md-3  col-xs-4">
						<ul class="list">
							<li class="title">
								<label id="menuBtn" role="button" data-toggle="dropdown" class="form-control" onClick="showMenu(); return false;">
									<span id="columnSuperTitle" style="float: left;width: 85px;">请选择栏目</span><span class="caret" style="float: right;margin-top: 8px;"></span>
								</label>
								<input type="hidden" name="basicCategoryId" value="0" />
							</li>
						</ul>
						<div id="menuContent" class="menuContent" style="display:none;">
							<ul id="treeDemo" class="ztree" style="margin-top:0; width:160px;">
							</ul>
						</div>
						
					</div>
				</div>
				
				<!--描述-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-4">描述:</label>
					<div class="col-md-6  col-xs-9">
						<textarea class="form-control " rows="4" name="basicDescription" placeholder="产品的描述信息" data-toggle="popover" data-placement="right" data-content=""></textarea>
					</div>
				</div>
				
				<!--描述-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-4">关键字:</label>
					<div class="col-md-6  col-xs-9">
						<textarea class="form-control" rows="4" name="articleKeyword" placeholder="产品的关键字" data-toggle="popover" data-placement="right" data-content=""></textarea>
					</div>
				</div>
				
				<!--版权信息-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-4">产品内容:</label>
					<div class="col-md-10  col-xs-9"><#--${article.articleContent?default('')}-->
							<@smallUedit inputName="content" width="800"  height="400" content=""/>
					</div>
				</div>
				
				<!--按钮组-->
				<div class="form-group">
					<div class="col-xs-2 col-md-2"></div>
					<div class="col-xs-10  col-md-10 padding0">
						 <#--<#if article.basicTitle?has_content>-->
	    					<button type="button" class="btn btn-success" id="updateArticle">修改</button>
	    				<#--<#else>-->
							<button type="submit" class="btn btn-success" id="saveArticle">保存</button>
						<#--</#if>-->
	    			</div>
				</div>
			</form>
		</div>
	</div>
	
	<script>
        $(document).ready(function() {
            $('form').bootstrapValidator({
                submitHandler: function(validator, form, submitButton) {
                    //$(form).data('bootstrapValidator').validate();
                    /*$.post(form.attr('action'), form.serialize(), function(result) {
                        if (result.valid == true || result.valid == 'true') {
                            // You can reload the current location
                            window.location.reload();

                            // Or use Javascript to update your page, such as showing the account name
                            // $('#welcome').html('Hello ' + result.username);
                        } else {
                            // The account is not found
                            // Show the errors
                            $('#errors').html('The account is not found').removeClass('hide');

                            // Enable the submit buttons
                            $('#loginForm').bootstrapValidator('disableSubmitButtons', false);
                        }
                    }, 'json');*/
                    alert(1);
                },
                fields: {
                    //产品标题
                    title: {
                        validators: {
                            notEmpty: { message: '产品标题不能为空'},
                            stringLength: {max: 50,message: '产品标题长度不超过50个字符'}
                        }
                    }
                }
            });
        });
		var setting;
		function checkForm(id){
		}
		
		$(function() {
			
			//产品属性
			<#if article?has_content>
			//产品标题
			$("input[name='name']").val("${article.basicTitle?default('')}");
			//产品自定义排序
			$("input[name='articleFreeOrder']").val(${article.articleFreeOrder?c?default(0)});
			//产品来源
			$("input[name='articleSource']").val("${article.articleSource?default('')}");
			//产品作者
			$("input[name='articleAuthor']").val("${article.articleAuthor?default('')}");
			//产品跳转链接
			$("input[name='articleUrl']").val("${article.articleUrl?default("")}");
			//产品所属栏目
			$("input[name='basicCategoryId']").val(${article.basicCategoryId?c?default(0)});
			//产品描述
			$("textarea[name='basicDescription']").html("${article.basicDescription?default('')}");
			//产品关键字
			$("textarea[name='articleKeyword']").html("${article.articleKeyword?default('')}");
			
			var type="${article.articleType?default("")}";
			var articleType = new Array;
			$("#typeArticle input[name='checkbox']").each(function(){
				if(type!=""){
					 articleType = type.split(",");
					  for(i=0;i<articleType.length;i++){
						 if($(this).val()==articleType[i]){
							 $(this).attr("checked",'true');
						}
					}
				}
			})
			</#if>
			
			checkForm("#articleForm");
			// ajax 给选择父模块下拉框赋值
			$.ajax({
				type: "post",
				url:ctx+"/manager/cms/column/queryJsonAll.do",
				dataType:"json",
				success:function(msg){
					var modelList =  $.parseJSON(msg.resultData);
					//获取栏目名
					for(var i=0;i<modelList.length;i++){
						if($("input[name='basicCategoryId']").val()==modelList[i].categoryId){
							$("#columnSuperTitle").html(modelList[i].categoryTitle);
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
					var zNodes=new Array();
					for(var i=0;i<modelList.length;i++){
						zNodes[i]={id:modelList[i].categoryId, pId:modelList[i].categoryCategoryId, name:modelList[i].categoryTitle,type:modelList[i].columnType ,open:true}
					}
		 			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				},
			});	
			
			
			//修改表单
			$("#updateArticle").click(function(){
				//将表单序列化
				var updateArticle = $("#articleForm").serialize();
				var articleFreeOrder=$("input[name='articleFreeOrder']").val();
				var basicCategoryId=$("input[name='basicCategoryId']").val();
				//产品类型
				var checkboxType="";
				$("#typeArticle input[name='checkbox']").each(function(){
					if($(this).is(":checked")){
						checkboxType+=$(this).val()+",";
					}
				})
				$.ajax({
				   type: "post",
				   url:  ctx+"/manager/cms/article/update.do",
				   data: updateArticle+"&checkboxType="+checkboxType,
				   dataType:"Json",
				   success: function(msg){
				   		if(msg.result){
				   		}else{
				   			alert("修改请求成功系统异常！")
				   		}
				   },
				});
			});
			
			//保存表单
			/*$("#saveArticle1").click(function(){
				//将表单序列化
				var saveArticle = $("#articleForm").serialize();
				var articleFreeOrder=$("input[name='articleFreeOrder']").val();
				var basicCategoryId=$("input[name='basicCategoryId']").val();
				//产品属性
				var checkboxType="";
				$("#typeArticle input[name='checkbox']").each(function(){
					if($(this).is(":checked")){
						checkboxType+=$(this).val()+",";
					}
				});
				$.ajax({
				   type: "post",
				   url: ctx+"/api/save",
				   data: saveArticle+"&checkboxType="+checkboxType,
				   dataType:"Json",
				   success: function(msg){
				   		if(msg){
				   			location.href=ctx+"/manager/cms/article/list.do";
				   			alert("添加产品成功！");
				   		}else{
				   			alert("系统异常！")
				   		}
				   },
				});
			});*/
		});
	</script>
</body>
</html>
	