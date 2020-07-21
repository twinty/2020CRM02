<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" type="text/css"
	href="CrmStatic/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="CrmStatic/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="CrmStatic/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css"
	href="CrmStatic/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css"
	href="CrmStatic/static/h-ui.admin/css/style.css" />

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript"
	src="CrmStatic/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="CrmStatic/lib/layer/2.4/layer.js"></script>
<script type="text/javascript"
	src="CrmStatic/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript"
	src="CrmStatic/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript"
	src="<%=basePath%>CrmStatic/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript"
	src="CrmStatic/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript"
	src="CrmStatic/lib/laypage/1.2/laypage.js"></script>

<!-- 采购明细样式 -->
<link href="static/zy_css/style.css" rel='stylesheet' type='text/css' />
<!-- from表单样式 -->
<link rel="stylesheet" href="static/from/css/platform-1.css">

<title>用户管理</title>

<style type="text/css">
.none { /* 弹层默认隐藏 */
	display: none;
}
</style>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		职务<span class="c-gray en">&gt;</span> 职务管理 <a
			class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="text-c">
			<from action=""> <input type="text" value="${ssz}"
				class="input-text" style="width:250px" placeholder="供货商名称模糊搜索"
				id="sousuo">
			<button type="button" class="btn btn-success radius"
				onclick="return sousuo()">
				<i class="Hui-iconfont">&#xe665;</i> 搜索
			</button>
			<button onclick="cla()" type="reset"
				style="background-color: pink;border: 0px;"
				class="btn btn-success radius">
				<i class="Hui-iconfont">&#xe68f;</i>重置
			</button>
			</from>
		</div>
		<script type="text/javascript">
			function cla() {
				document.getElementById("sousuo").value = "";
			}
		</script>
		<c:if test="${temp=='no'}">
			<h1>暂无数据</h1>
		</c:if>

		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"> <a href="javascript:;"
				onclick="return plsc()" class="btn btn-danger radius"> <i
					class="Hui-iconfont">&#xe6e2;</i> 批量删除
			</a> <a href="javascript:;" onclick="add()"
				class="btn btn-primary radius"> <i class="Hui-iconfont">&#xe600;</i>
					添加职务
			</a> <!-- <a href="javascript:;" onclick="daochu()"
				style="background-color: pink; border: 0px;"
				class="btn btn-primary radius"> <i class="Hui-iconfont">&#xe600;</i>
					导出到excel
			</a> -->
			</span>
			<script type="text/javascript">
				function daochu() {
					location.href = "<%=basePath%>Rsctrl/daochu.do"
				}
			</script>
			<span class="r">共有数据：<strong>${page.total}</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" id="all-check"></th>
						<th width="30"> 职务编号</th>
						<th width="100">职位名称 </th>
						<th width="100">部门编号</th>
						<th width="100">备注说明 </th>
						<th width="100">公司编号 </th>
						<th width="40">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="p">
						<tr class="text-c">
							<td><input type="checkbox" name="one-check"
								value="${p.dutiesId }"></td>
							<td>${p.dutiesId }</td>
							<td>${p.dutiesName }</td>
							<td>${p.sectionId }</td>
							<td>${p.orderRemark }</td>	
							<td>${p.companyId }</td>
							<td class="td-manage">
							<%-- <a style="text-decoration:none"
								onClick="cksjxq(${p.dutiesId })" href="javascript:;" title="查看采购明细">
									<i class="Hui-iconfont">&#xe616;</i>
							</a> --%> 
							<a title="编辑" href="javascript:;" onclick="bj(${p.dutiesId })"
								class="ml-5" style="text-decoration:none"> <i
									class="Hui-iconfont">&#xe6df;</i>
							</a> <a title="删除" href="javascript:;"
								onclick="return sc(${p.dutiesId })" class="ml-5"
								style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i>
							</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="window-from" class="none">
				<form style="margin-left: 20px;" id="from" method="post">
					<table>
					<tr>
					<td>职务编号</td>
					<td><input type="text" id="dutiesId" name="dutiesId" readonly="readonly"></td>
					</tr>
						<tr>
							<td>职位名称 </td>
							<td><input class="inputcl" type="text" id="dutiesName"
								name="dutiesName"> 
							</td>
							<td>部门编号</td>
							<td><input type="text" id="sectionId" name="sectionId">
							</td>
						</tr>
						<tr>
							<td>公司编号</td>
							<td><input type="text" id="companyId" name="companyId"></td>
							
						</tr>
					
						<tr>
							<td><div>备注信息</div></td>
							<td colspan="3">
								<div>
									<textarea style="float: left;" rows="5" cols="70" id="orderRemark"
										name="orderRemark"></textarea>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div id="window-div" class="none" style="width: 750px;">
				<div class="hover-buttons">
					<div class="wrap">
						<div class="bg-effect">
							<ul class="bt-list">
								<li><a id="a" class="hvr-back-pulse button">^_^!</a> <a
									id="b" class="hvr-sweep-to-right button">^_^!</a> <a id="c"
									class="hvr-sweep-to-left button">^_^!</a></li>
								<li><a id="d" class="hvr-sweep-to-bottom button">^_^!</a> <a
									id="e" class="hvr-sweep-to-top button">^_^!</a> <a id="f"
									class="hvr-bounce-to-right button">^_^!</a></li>
								<li><a id="g" class="hvr-bounce-to-bottom button">^_^!</a>
									<a id="h" class="hvr-bounce-to-top button">^_^!</a></li>
								<li><a id="i" class="hvr-rectangle-in button">^_^!</a> <a
									id="j" class="hvr-rectangle-out button">^_^!</a></li>
								<li><a id="k" class="hvr-radial-out button">^_^!</a></li>
								<li><a id="ll" class="hvr-rectangle-in button">^_^!</a> <a
									id="mm" class="hvr-rectangle-out button">^_^!</a></li>
								<li><a id="nn" class="hvr-rectangle-in button">^_^!</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<br>
			<div>
				<span>当前${page.pageNum}/${page.pages}页</span>
				<div style="float: right;">
					<button onclick="sy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">首页</button>
					<script type="text/javascript">
				  function sy(){
				  
				  location.href="Rsctrl/selectDuties.do?pageNum="+${page.navigateFirstPage }+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button onclick="syy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">上一页</button>
					<script type="text/javascript">
				  function syy(){
				 
				  location.href="Rsctrl/selectDuties.do?pageNum="+${page.prePage}+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button disabled="disabled"
						style=" width:26px;height:26px;background-color: rgb(90, 152, 222);border: 0px;border-radius: 5px;">${page.pageNum}</button>
					<button onclick="xyy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">下一页</button>
					<script type="text/javascript">
				     function xyy(){
				  		 
				      location.href="Rsctrl/selectDuties.do?pageNum="+${page.nextPage}+
				      "&name="+document.getElementById("sousuo").value
				    }
				   </script>
					<button onclick="wy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">尾页</button>
					<script type="text/javascript">
				     function wy(){
				     location.href="Rsctrl/selectDuties.do?pageNum="+${page.navigateLastPage }+
				      "&name="+document.getElementById("sousuo").value
				    }
				  </script>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		/* 搜索 */
		function sousuo() {
			var sousuo = document.getElementById("sousuo").value;
			location.href = "Rsctrl/selectDuties.do?name=" + sousuo
		}
		/* 批量删除 */
		var nodeAll = document.getElementById("all-check");
		nodeAll.onclick = function() {
			//name可以重复id只能有一个
			var nodes = document.getElementsByName("one-check");
			var flag = nodeAll.checked;
			for (var i = 0; i < nodes.length; i++) {
				nodes[i].checked = flag;
			}
		}
		function plsc() {
			var id = "";
			var temp = "";
			var onecheck = document.getElementsByName("one-check");
			for (var i = 0; i < onecheck.length; i++) {
				if (onecheck[i].checked == true) {
					id += "id=" + onecheck[i].value + "&";
					temp = 1;
				}
			}
			if (temp != 1) {
				alert("您未勾选");
				return false;
			}
			if (temp == 1) {
				if (confirm("确认删除吗") == true) {
					location.href = "<%=basePath%>Rsctrl/deletsup2.do?" + id;
					return true;
				} else {
					return false;
				}
			}
		}
		/* 单个删除 */
		function sc(uid) {
			if (confirm("确认删除吗") == true) {
				location.href = "<%=basePath%>Rsctrl/deletsup2.do?id=" + uid;
				return true;
			}
		}
		
		/* 编辑 */
		function bj(id) {
			var temp = 0;
			$("#dutiesId").val($("#ee").val());
			$.ajax({
				type : "post",
				url : "<%=basePath%>Rsctrl/selectDutiesInfo1.do?id=" + id,
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
					$("#dutiesId").val(data.dutiesId);
					$("#dutiesName").val(data.dutiesName);
					$("#sectionId").val(data.sectionId);
					$("#companyId").val(data.companyId);
					$("#orderRemark").val(data.orderRemark);
				}
			});
	
			var index = layer.open({
				type : 1,
				area : [ '600px', '550px' ],
				btn : [ '提交', '取消' ],
				fix : false, //不固定
				maxmin : true,
				shade : 0.4,
				title : '编辑',
				content : $('#window-from'),
				yes : function() {
					temp = 1;
					/* 输出序列后的值，name一定要和bean的一样 */
					/* alert($('#from').serialize()); */
					$.ajax({
						type : "post", //请求方式
						url : "Rsctrl/updateDutiesInfo.do", //url地址
						data : $('#from').serialize(), //序列化表单的参数
						dataType : "json" //响应类型
					});
					//提交完成后关闭弹层
					layer.close(index);
					if (temp == 1) {
						layer.msg("修改成功", {
							icon : 6,
							time : 2000
						});
					}
				},
				//end是关闭窗口时自动执行
				end : function() {
					/* alert("关闭后刷新页面"); */
					setTimeout(function() {
						location.replace(location.href);
					}, 1000)
				}
			});
		//弹层全屏
		//layer.full(index);
		}
	
		/* 添加 */
		function add() {
			var temp = 0;
			$("#dutiesName").val($("#dd").val());
			$("#dutiesId").val($("#ee").val());
			$.ajax({
				type : "post",
				url : "<%=basePath%>Rsctrl/selectDuties.do",
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
					var h = "";
					h = "<option>请选择</option>";
					$.each(data, function(i, comp) {
						h += "<option value='" + comp.companyId + "'>" + comp.companyName + "</option>"
					});
					$("#comp").html(h);
				}
			});
			var index = layer.open({
				type : 1,
				area : [ '600px', '550px' ],
				btn : [ '提交', '取消' ],
				fix : false, //不固定
				maxmin : true,
				shade : 0.4,
				title : '录入供应商',
				content : $('#window-from'),
				yes : function() {
					temp = 1;
					/* 输出序列后的值，name一定要和bean的一样 */
					/* alert($('#from').serialize()); */
					$.ajax({
						type : "post", //请求方式
						url : "Rsctrl/addDutiesInfo.do", //url地址
						data : $('#from').serialize(), //序列化表单的参数
						dataType : "json" //响应类型
	
					});
					//提交完成后关闭弹层
					layer.close(index);
					if (temp == 1) {
						layer.msg("添加成功", {
							icon : 6,
							time : 2000
						});
					}
				},
				//end是关闭窗口时自动执行
				end : function() {
					/* alert("关闭后刷新页面"); */
					setTimeout(function() {
						location.replace(location.href);
					}, 1000)
	
				}
			});
		//弹层全屏
		//layer.full(index);
		}
	</script>
</body>
</html>