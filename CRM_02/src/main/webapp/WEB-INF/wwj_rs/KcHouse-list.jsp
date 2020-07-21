<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>仓库管理</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 库存管理 <span class="c-gray en">&gt;</span> 仓库管理 <a class="btn btn-refresh radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);"  class="btn btn-success radius" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
<form action="Rsctrl/selectdepot.do" method="post" id="myform">
	<div class="text-c"> 日期范围：
		<input type="text" value="<fmt:formatDate value="${depot.datemin }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}' })" id="datemin" name="datemin" class="input-text Wdate" style="width:120px;">
		-
		<input type="text" value="<fmt:formatDate value="${depot.datemax }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d' })" id="datemax" name="datemax" class="input-text Wdate" style="width:120px;">
		<input type="text" value="${depot.warehouseName }" class="input-text" style="width:250px" placeholder="输入仓库名称" id="warehouseName" name="warehouseName">
		<input type="hidden" name="pageNum" id="pageNum" value="${p.pageNum }"><!-- 这个隐藏域是用来穿页数重新提交表单的 -->
		<button type="submit" class="btn btn-success radius" id="" name=""><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	    <button type="reset" onclick="cz()" class="btn btn-success radius" id="" name=""><i class="Hui-iconfont">&#xe6f7;</i> 重置</button>
	               <script type="text/javascript">
	                  function cz(){
	                     document.getElementById(datemin).value="";
	                     document.getElementById(datemax).value="";
	                     document.getElementById(warehouseName).value=""; 
	                  } 
	               </script>
	
	</div>
	 </form>
	 
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
	<a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> 
	<a href="javascript:;" onclick="member_add('添加仓库','Rsctrl/goadddepot.do','','320')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加仓库</a></span> 
	<span class="r">共有数据：${p.total } 条</span> </div>
	<div class="mt-20">
	
	<form action="Rsctrl/deletedepotall.do" method="post" id="myform1">
	<table class="table table-border table-bordered table-hover table-bg table-sort">
		<thead>
			<tr class="text-c">
				<th width="25"><input type="checkbox" name="" value=""></th>
				<th width="80">ID</th>
				<th width="100">仓库名称</th>
				<th width="200">备注信息</th>
				<th width="80">公司编号</th>
				<th width="150">最后修改时间</th>
				<th width="100">操作</th>
			</tr>
		</thead>
		<tbody>
		   <c:forEach items="${p.list }" var="depot">
				<tr class="text-c">
					<td><input type="checkbox" value="${depot.warehouseId }" name="ids"></td>
					<td>${depot.warehouseId }</td>
					<td><u style="cursor:pointer" class="text-primary" onclick="member_show('张三','member-show.html','10001','360','400')">${depot.warehouseName }</u></td>
					<td class="text-l">${depot.orderRemark }</td>
					<td>${depot.companyId }</td>
					<td>
					  <fmt:formatDate value="${depot.lastModifyDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td class="td-manage">
					<a title="查看商品" href="javascript:;" onclick="member_info('Rsctrl/gogoods.do?warehouseId=${depot.warehouseId }','','350')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe636;</i></a> 
                    <a title="编辑" href="javascript:;" onclick="member_edit('编辑仓库','Rsctrl/goadddepot.do','${depot.warehouseId }','','350')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>  					
					<a title="删除" href="javascript:;" onclick="member_del(this,'${depot.warehouseId }')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</form>
	
	</div>
	
	<div class="dataTables_info" role="status" aria-live="polite" style="float: left;margin-top: 10px;margin-bottom: 10px">当前第 ${p.pageNum }/${p.pages }页，共 ${p.total }条</div>
	<div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_paginate" style="float: right;margin-top: 10px;margin-bottom: 10px">
	<a class="paginate_button" aria-controls="DataTables_Table" id="DataTables_Table_previous" href="javascript:void(0)" onclick="gopage(${p.navigateFirstPage })">首页</a>
	<a class="paginate_button previous" aria-controls="DataTables_Table" id="DataTables_Table_previous" href="javascript:void(0)" onclick="gopage(${p.prePage })">上一页</a>
	<a class="paginate_button next" aria-controls="DataTables_Table" id="DataTables_Table_next" href="javascript:void(0)" onclick="gopage(${p.nextPage })">下一页</a>
	<a class="paginate_button" aria-controls="DataTables_Table" id="DataTables_Table_previous" href="javascript:void(0)" onclick="gopage(${p.navigateLastPage })">尾页</a>
	</div>
	
	
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="CrmStatic/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="CrmStatic/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="CrmStatic/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="CrmStatic/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="<%=basePath%>CrmStatic/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="CrmStatic/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="CrmStatic/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
$(function(){
	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,5]}// 制定列不参与排序
		],
		paging:false,
	});
	
	$("#DataTables_Table_0_info").hide();
	
	$("#DataTables_Table_0_filter").hide();
});
/*仓库-添加*/
function member_add(title,url,w,h){
	layer_show(title,url,w,h);
}
/*仓库-查看*/
function member_show(title,url,id,w,h){
   layer_show(title,url,w,h);
}

/*仓库-编辑*/
function member_edit(title,url,id,w,h){
	url=url+"?warehouseId="+id;
	layer_show(title,url,w,h);
}

/*仓库-删除*/
function member_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'Rsctrl/deletedepot.do',
			data: "warehouseId="+id,
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}

//分页
function gopage(pageNum){
   $("#pageNum").val(pageNum);
   $("#myform").submit();
}

//批量删除
function datadel(){
   
   $("input[name='ids']")
   
   if($("input[name='ids']:checked").length>=1){
   
	   layer.confirm('确认要删除这些数据吗？',function(index){
	      $("#myform1").submit();
	   });
   }else{
       layer.msg('请至少选择一条数据!',{icon:5,time:1000});
   }
}

function member_info(url){
   window.location.href=url;
}
</script> 
</body>
</html>