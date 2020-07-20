<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="CrmStatic/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="CrmStatic/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="CrmStatic/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="CrmStatic/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="CrmStatic/static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<!--/meta 作为公共模版分离出去-->

<title>添加联系记录</title>
<meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<article class="page-container">
	<form action="xscustomctrl/addconRecord.do" method="post" class="form form-horizontal" id="form-member-add">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">联系标题：</label>
			<div class="formControls col-xs-8 col-sm-9">
			    <!-- 如果是添加，则没有id；如果是修改就有id -->
			  <input type="hidden" value="${conRecord.conRecordId }"  id="conRecordId" name="conRecordId">
			<input type="text" class="input-text" value="${conRecord.conTheme }" placeholder="请输入联系标题" id="conTheme" name="conTheme">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>联系时间：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<%-- <input type="text" class="input-text" value="${custom.nextTime }" placeholder="" id="nextTime" name="nextTime"> --%>
				<input style="width: 180px;height: 37.27px" type="text"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
								value="<fmt:formatDate value="${conRecord.conTime }" pattern="yyyy-MM-dd"/>" 
								class="input-text Wdate" type="text" id="" name="conTime">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">客户编号：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${conRecord.customId  }" placeholder="" id="customId" name="customIdty">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">联系内容：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${conRecord.conContent  }" placeholder="" id="conContent" name="conContent">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">公司编号：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${conRecord.companyId  }" placeholder="" id="companyId" name="companyId">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">最后修改时间：</label>
			<div class="formControls col-xs-8 col-sm-9">
			     <%Date date=new Date();
			       SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			       String nowtime=sdf.format(date);
			      %>
				<input type="hidden" class="input-text" value="<%=nowtime %>" id="lastModifyDate" name="lastModifyDate">
			    <%=nowtime %>
			</div>
		</div>

		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="CrmStatic/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="CrmStatic/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="CrmStatic/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="CrmStatic/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript" src="<%=basePath%>CrmStatic/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="CrmStatic/lib/jquery.validation/1.14.0/jquery.validate.js"></script> 
<script type="text/javascript" src="CrmStatic/lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="CrmStatic/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript" src="CrmStatic/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="CrmStatic/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form-member-add").validate({
		rules:{
			/* customName:{
				required:true,
			} */
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$(form).ajaxSubmit();
			var index = parent.layer.getFrameIndex(window.name);
			//parent.$('#btn-refresh').click();
			window.parent.location.reload();//刷新父页面
			parent.layer.msg('操作成功!',{icon: 6,time:1000});
			parent.layer.close(index);
			
		}
	});
});
</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>