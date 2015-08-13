<#--分页-->
<#macro showPage page linkUrl>
<#--${page.totalPages}-${page.number}-${page.size}-<#if page.first>true</#if><#if page.last>true</#if>-->
<#if page?exists && page.totalPages gt 1>
	<ul class="pagination pull-right">
		<#--格式 <（上一页） 1 2 3 4 >(下一页) -->
		<li class="prev <#if (page.first)> disabled" ><a<#else> "><a href="${linkUrl}page=${page.number-1}" </#if>><i class="fa fa-angle-left">上一页</i></a></li>
			<#list 1..page.totalPages as i>
				<li <#if page.number+1==i>class="active" ><a<#else> ><a href='${linkUrl}page=${i-1}'</#if>>${i}</a></li>
			</#list>
		<li class="next <#if page.last>disabled" ><a<#else> "><a href="${linkUrl}page=${page.number+1}"</#if>><i class="fa fa-angle-right">下一页</i></a></li>
	</ul>
</#if>
</#macro>



<#--简易编辑器-->
<#--inputName:输入框名称-->
<#--width\height:编辑器的宽度高度-->
<#--content:初始化内容-->
<#macro smallUedit inputName width height content>
	    <script type="text/plain" id="editor_${inputName}" name="${inputName}">${content?default('')}</script>
		<script type="text/javascript">
		    	window.editor_${inputName} = new UE.ui.Editor({
					initialFrameWidth : ${width},
					initialFrameHeight : ${height}
				});
				window.editor_${inputName}.render("editor_${inputName}");
		</script>
</#macro>


<#--通用弹窗-->
<#--modalName:弹出窗的名称-->
<#--调用方法open弹出窗口名称，例如:窗口名称 abc ，调用openabc('展示内容','标题')-->
<#--注意使用的时候，message的内容只能是id或字符串对象-->
<#macro modalDialog modalName>
	<div class="modal fade" id="${modalName}Dialog" style="overflow-y: hidden;">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="${modalName}Title">
	        </h4>
	      </div>
	      <!--startprint-->
	      <div class="modal-body" id="${modalName}Body">
	      </div>
	      <!--添加其他信息-
	      <div class="modal-footer" id="${modalName}Footer">
	      </div>
	      -->
	      <!--endprint-->
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<script>
		function open${modalName}(message,title) {
		    if (title) {
				$("#${modalName}Title").html(title);
			}
			try {
				if (message) {
					message.show();
				}
			} catch(e){
				alert("文本");
			}	
			$("#${modalName}Body ").html(message);
			$('#${modalName}Dialog').modal();
		}
		 function close${modalName}() {
				$('#warn${modalName}Dialog').modal('hide');
			}
	</script>	
</#macro>

<#--通用警告弹窗-->
<#--warnModal:弹出窗的名称-->
<#--调用方法open弹出窗口名称，例如:窗口名称 abc ，调用openabc('展示内容','标题','点击确定按钮之后回调方法，如果没有则不会显示确认按钮')-->
<#macro warnModal  modalName>
	<div id="warn${modalName}Dialog" class="modal fade" tabindex="-1" data-focus-on="input:first">
	 <div class="modal-dialog">
	    <div class="modal-content">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title"  id="warn${modalName}Title">警告！</h4>
		</div>
		<div class="modal-body"  id="warn${modalName}Body">
		</div>
		<div class="modal-footer">
			<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
			<button type="button"  id="warn${modalName}Ok" class="btn btn-primary right" style="display:none">确定</button>
		</div>
		</div>
	 </div>
	</div>	
	<script>
		function warn${modalName}(message,title,func) {
		    if (title) {
				$("#warn${modalName}Title").html(title);
			}
			if(func) {
				$("#warn${modalName}Ok ").show();
				$("#warn${modalName}Ok ").one("click",function(){
					eval(func);
				});
			}
			$("#warn${modalName}Body ").html(message);
			$('#warn${modalName}Dialog').modal();
		}
		
		 function closewarn${modalName}() {
				$('#warn${modalName}Dialog').modal('hide');
			}
	</script>
</#macro>


<#macro ueUploadImg inputName img>
<script type="text/plain" id="upload_ue_${inputName}"></script>
<div id="upload_div_${inputName}">
    <style>
        .msUploadImgs{margin: 0;padding: 0;list-style: none;}
        .msUploadImgs li {list-style:none;float: left;text-align: center;border: 1px solid #F3F3F3;margin: 8px; width:100px;}
        .msUploadImgs img {width:100%; }
        .msUploadImgs li span {cursor: pointer;}
        .divUploader{clear:both}
        .product-picture {
            width: 200px;
            height: 140px;
            position: relative;
            cursor: pointer;
        }
        .product-picture .img-remove{
            position: absolute;
            top: -5px;
            right: -5px;
            cursor: pointer;
        }
        .product-picture .img-remove:hover {
            color: #337ab7;
        }
        .product-picture img {
            -webkit-border-radius: 0;
            border-radius: 0;
            border: 2px solid #eee;
            width: 200px;
            height: 140px;
        }
    </style>
    <div class="product-picture">
        <span class="glyphicon glyphicon-remove img-remove" onclick="clearImage${inputName}()"></span>
        <img id="${inputName}-preview" src="<#if img!="">${img}</#if>" class="small" style="display: inline;" onclick="upImage${inputName}()"/>
        <input type="hidden" size="100" name="${inputName}" id="${inputName}" value="${img?default('')}" />
    </div>
</div>
<script type="text/javascript">
var _editor = UE.getEditor('upload_ue_${inputName}');
_editor.ready(function () {
    _editor.setDisabled();
    _editor.hide();
    _editor.addListener('beforeInsertImage', function (t, arg) {
        $("#${inputName}").attr("value", arg[0].src);
        $("#${inputName}-preview").attr("src", arg[0].src);
    });
    /*_editor.addListener('afterUpfile', function (t, arg) {
        $("#file").attr("value", _editor.options.filePath + arg[0].url);
    });*/
});
function upImage${inputName}() {
    var myImage = _editor.getDialog("insertimage");
    myImage.open();
}
function clearImage${inputName}() {
    $("#${inputName}").attr("value", '');
    $("#${inputName}-preview").attr("src", '');
}
/*
function upFiles${inputName}() {
    var myFiles = _editor.getDialog("attachment");
    myFiles.open();
}*/
</script>
</#macro>
<#--上传控件-->
<#--path:上传路径-->
<#--inputName:name值-->
<#--filetype:上传规则-->
<#--size:上传数量-->
<#--msg:提示信息-->
<#--imgs:默认显示的图片-->
<#--maxSize:默认文件大小 单位m-->
<#--如果是反复显示图片需要调用showImgs(imgs地址可以包含"|"符合,input的名称)-->
<#macro uploadImg path inputName size filetype msg imgs maxSize>
	<div id="ms__uploadPic_${inputName}">
		<style>
			.msUploadImgs{margin: 0;padding: 0;list-style: none;}
			.msUploadImgs li {list-style:none;float: left;text-align: center;border: 1px solid #F3F3F3;margin: 8px; width:100px;}
			.msUploadImgs img {width:100%; }
			.msUploadImgs li span {cursor: pointer;}
			.divUploader{clear:both}
		</style>
		<ul class="msUploadImgs">
			<#if imgs!="">
				<#list imgs?split("|") as img>
					<#if img!="">
						<li id="SWFUpload_9_${img_index}">
							<div class="displayimg">
								<img src="${ctx}/${img}">
							</div>
							<span class="front-cover" onclick="removePreview(this,'${img}')"><a class="btn btn-xs red tooltips " data-original-title="点击删除图片"><i class="glyphicon glyphicon-trash"></i></a>
							</span>
						</li>
					</#if>			
				</#list>	
			</#if>
		</ul>
		<div class="divUploader"><input type="button" id="up_file_${inputName}" />
		<#if msg!="">
		<div class="alert alert-warning alert-dismissable">${msg}</div>
		</#if>
		</div>
		<input type="hidden" size="100" name="${inputName}" id="${inputName}" value="${imgs?default('')}" />
	</div>
	<script type="text/javascript">
		    $(function ()  {
                String.prototype.endWith=function(s){
                    if(s==null||s==""||this.length==0||s.length>this.length)
                        return false;
                    if(this.substring(this.length-s.length)==s)
                        return true;
                    else
                        return false;
                    return true;
                }
		        $('#ms__uploadPic_${inputName}').swfupload({
		            upload_url: "${ctx}/api/upload",
		            post_params:{"uploadPath":"/${path}","maxSize":"${maxSize}","allowedFile":"${filetype}","allowedFile":""},
                    file_post_name:"file",
		            file_size_limit: ${maxSize?default("1")}*1024,
		            file_types: "${filetype?default("*.jpg;*.png;*.gif;*.bmp;*.jpeg")}",
		            file_types_description: "Image files",
		            file_upload_limit: ${size?default("5")},
		            flash_url: "${ctx}/resources/jquery/swfupload/swfupload.swf",
		            button_image_url: "${ctx}/resources/jquery/swfupload/button.png",
		         	button_width: 92,
					button_height: 34,
		            button_placeholder: $('#up_file_${inputName}')[0],
		            debug: false
		        })
				.bind('fileQueued', function (event, file) {	
				   if ($("#ms__uploadPic_${inputName} .msUploadImgs").children().length>=${size?default("5")}) {
						  $(this).swfupload('cancelUpload');
						  alert("最多上传${size}个文件!");
					} else {
					    var listitem = '<li id="' + file.id + '"><div class="displayimg"><img src="${ctx}/resources/jquery/swfupload/load.gif" /></div><span class="front-cover">0%</span></li>';
			            $('#ms__uploadPic_${inputName} ul').append(listitem);
					    $(this).swfupload('startUpload');
				    }
				    
				})
				.bind('fileQueueError', function (event, file, errorCode, message) {
				    if (errorCode==-130) {
				    	alert('文件类型错误!');
				    } else if (errorCode==-100) {
				    	alert("最多上传${size}个文件!");
				    } else {
				    	alert(errorCode+'上传图片过多或上传图片过大!');
				    }
				})
				.bind('uploadStart', function (event, file) {
						$('#ms__uploadPic_${inputName} ul li#' + file.id).find('span.front-cover').text('0%');
				})
				.bind('uploadProgress', function (event, file, bytesLoaded) {
					   var percentage = Math.round((bytesLoaded / file.size) * 100);
				       $('#ms__uploadPic_${inputName} ul li#' + file.id).find('span.front-cover').text(percentage + '%');
				})
				.bind('uploadSuccess', function (event, file, serverData) {
				    var item = $('#ms__uploadPic_${inputName} ul li#' + file.id);
				    item.find('div.displayimg').html('<img src="${ctx}' + serverData + '" />');
				    item.find('span.front-cover').html('<a class="btn btn-xs red tooltips " data-original-title="点击删除图片"><i class="glyphicon glyphicon-trash"></i></a>');
				    if($('#${inputName}').val() == "") {
						$('#${inputName}').val(serverData);
					} else {
                        $('#${inputName}').val($('#${inputName}').val() + "|" + serverData);
                    }
				    $('#ms__uploadPic_${inputName} ul li#' + file.id + ' span.front-cover').bind('click', function () {
				        $('#ms__uploadPic_${inputName} ul li#' + file.id + '').slideUp('fast');
				        var swfu = $.swfupload.getInstance('#ms__uploadPic_${inputName}');
				        var stats = swfu.getStats();
				        stats.successful_uploads--;
				        swfu.setStats(stats);
                        $('#${inputName}').val($('#${inputName}').val().replace(serverData, ""));
                        var imgs = $('#${inputName}').val();
				        if (imgs != null && imgs != "" && imgs.substring(imgs.length-1) == "|") {
                            $('#${inputName}').val(imgs.substring(0, imgs.length - 1));
				        }
				        $('#ms__uploadPic_${inputName} ul li#' + file.id).remove();
				    });
				})
				.bind('uploadComplete', function (event, file) {
				    $(this).swfupload('startUpload');
				})
		    });
		    function removePreview(uid,imgPath) {
		        var swfu = $.swfupload.getInstance('#ms__uploadPic_${inputName}');
		        var stats = swfu.getStats();
		        stats.successful_uploads--;
		        swfu.setStats(stats);
		        if (imgPath.indexOf("|")>0) {
		        	$('#${inputName}').val($('#${inputName}').val().replace(imgPath+ "|", ""));
		        } else {
		        	$('#${inputName}').val($('#${inputName}').val().replace(imgPath, ""));
		        }
		        $('#ms__uploadPic_${inputName} ul li#' + uid.parentNode.id).slideUp('fast',function() {
		        	$(this).remove();
		        });
		    }
		    
		    /**
		    *提供给弹窗显示图片使用
		    */
		    function showImgs(imgs,inputName) {
		    	//var swfu = $.swfupload.getInstance('#ms__uploadPic_'+inputName);
		        //var stats = swfu.getStats();
		    	$(".msUploadImgs").children().remove();
		    	  if (imgs) {
		    	  var _imgs = imgs.split("\|");
		    	    for (i=0;i<_imgs.length;i++) {
		    	    	  if (_imgs[i]!="") {
								var imgLi = '<li id="SWFUpload_9_'+i+'">';
									imgLi+='<div class="displayimg">';
													imgLi+='<img src="${ctx}/'+_imgs[i]+'">';
									imgLi+='</div>';
									imgLi+='<span class="front-cover" onclick="removePreview(this,\''+_imgs[i]+'\')"><a class="btn btn-xs red tooltips " data-original-title="点击删除图片"><i class="glyphicon glyphicon-trash"></i></a>';
									imgLi+='</span>';
								imgLi+='</li>';
								$(".msUploadImgs").append(imgLi);;
								//stats.successful_uploads++;
								//swfu.setStats(stats);
							}
						}
				    }
		    }			
			</script>
</#macro>

<#--上传控件-->
<#--path:上传路径-->
<#--inputName:name值-->
<#--filetype:上传规则-->
<#--size:上传数量-->
<#--msg:提示信息-->
<#--callBack:回调提示信息-->
<#--isRename:是否重命名true:将使用时间命名，否则使用上传是文件名，可能会出现同名称覆盖的问题,中文也会存在问题-->
<#--maxSize:默认文件大小 单位m-->
<#macro uploadFile path inputName size filetype msg  maxSize callBack isRename>
	<div id="ms__uploadPic_${inputName}">
		<div class="divUploader"><input type="button" id="up_file_${inputName}" />
		<#if msg!="">
		<div class="alert alert-warning alert-dismissable">${msg}</div>
		</#if>
		</div>
		<input type="hidden" size="100" name="${inputName}" id="${inputName}" value="${imgs?default('')}" />
	</div>
	<script type="text/javascript">
		    $(function ()  {
		        $('#ms__uploadPic_${inputName}').swfupload({
		            upload_url: "${ctx}/upload",
		            post_params:{"uploadPath":"/${path}","isRename":"${isRename?default("true")}","maxSize":"${maxSize}","allowedFile":"${filetype}","allowedFile":""},
		            file_size_limit: ${maxSize?default("1")}*1024,
		            file_types: "${filetype?default("*.jpg;*.png;*.gif;*.bmp;*.jpeg")}",
		            file_types_description: "Image files",
		            file_upload_limit: ${size?default("5")},
		            flash_url: "${ctx}/jquery/swfupload/swfupload.swf",
		            button_image_url: "${ctx}/jquery/swfupload/button_file.png",
		         	button_width: 92,
					button_height: 34,
		            button_placeholder: $('#up_file_${inputName}')[0],
		            debug: false
		        })
				.bind('fileQueued', function (event, file) {	
				   if ($("#ms__uploadPic_${inputName} .msUploadImgs").children().length>=${size?default("5")}) {
						  $(this).swfupload('cancelUpload');
						  alert("最多上传${size}个文件!");
					} else {
					    $(this).swfupload('startUpload');
				    }
				    
				})
				.bind('fileQueueError', function (event, file, errorCode, message) {
				    if (errorCode==-130) {
				    	alert('文件类型错误!');
				    } else if (errorCode==-100) {
				    	alert("最多上传${size}个文件!");
				    } else {
				    	alert(errorCode+'上传图片过多或上传图片过大!');
				    }
				    <#if callBack!=""> 
				    	eval("${callBack}(errorCode)");
				    </#if>
				})
				.bind('uploadStart', function (event, file) {
						$('#ms__uploadPic_${inputName} ul li#' + file.id).find('span.front-cover').text('0%');
				})
				.bind('uploadProgress', function (event, file, bytesLoaded) {
					   var percentage = Math.round((bytesLoaded / file.size) * 100);
				})
				.bind('uploadSuccess', function (event, file, serverData) {
						$('#${inputName}').val(serverData);
						<#if callBack!=""> 
							eval("${callBack}(serverData)");
						<#else>
							alert("上传成功");
						</#if>
				})
				.bind('uploadComplete', function (event, file) {
				    $(this).swfupload('startUpload');
				})
		    });
			</script>
</#macro>



