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
<!-- 新货表单样式 -->
<link rel="stylesheet" media="screen"
	href="static/fenbuform/css/zzsc.css" />
<script src="static/fenbuform/js/jquery.easing.min.js"
	type="text/javascript"></script>
<script src="static/fenbuform/js/zzsc.js" type="text/javascript"></script>
<title>用户管理</title>

<style type="text/css">
.none { /* 弹层默认隐藏 */
	display: none;
}

/* .inputcl{
width: 140px;
height: 37.27px;
border-radius: 5px;
font-size: 15px;
padding-left:5px;
border: 1px  rgb(194, 187, 191) solid;
outline: none;
} */
</style>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		用户中心 <span class="c-gray en">&gt;</span> 用户管理 <a
			class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="text-c">
			采购日期范围： <input type="text"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
				value="<fmt:formatDate value='${time1}' pattern='yyyy-MM-dd HH:mm:ss'/>"
				id="time1" class="input-text Wdate" style="width:200px;"> -
			<input type="text"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
				value="<fmt:formatDate value='${time2}' pattern='yyyy-MM-dd HH:mm:ss'/>"
				id="time2" class="input-text Wdate" style="width:200px;"> <input
				type="text" class="input-text" style="width:250px"
				placeholder="对采购标题模糊搜索" value="${ssz}" id="sousuo">
			<button type="button" class="btn btn-success radius"
				onclick="return sousuo()">
				<i class="Hui-iconfont">&#xe665;</i> 搜索
			</button>
			<button onclick="cla()" type="reset"
				style="background-color: pink;border: 0px;"
				class="btn btn-success radius">
				<i class="Hui-iconfont">&#xe68f;</i>重置
			</button>
		</div>
		<script type="text/javascript">
			function cla() {
				document.getElementById("time1").value = "";
				document.getElementById("time2").value = "";
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
			</a> 
			</span> <span class="r">共有数据：<strong>${page.total}</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" id="all-check"></th>
						<th width="80">ID</th>
						<th width="100">采购主题</th>
						<th width="100">采购日期</th>
						
						<th width="40">采购进展</th>
						<th width="70">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="p">
						<tr class="text-c">
							<td><input type="checkbox" name="one-check"
								value="${p.cgId }"></td>
							<td>${p.cgId }</td>
							<td> ${p.cgTitle }</td>
							<td><fmt:formatDate value="${p.cgDate }"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							
							<td>
							<span class="label label-success radius">${p.cgJz}</span>
							</td>
							<td class="td-manage">
							<a style="text-decoration:none"
								onClick="cksjxq(${p.cgId })" href="javascript:;" title="查看明细">
									<i class="Hui-iconfont">&#xe616;</i>
							</a> 
							<a title="删除" href="javascript:;"
								onclick="return sc(${p.cgId })" class="ml-5"
								style="text-decoration:none;"> <i class="Hui-iconfont">&#xe6e2;</i>
							</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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
								<li><a id="j" class="hvr-rectangle-in button">^_^!</a> <a
									id="k" class="hvr-rectangle-out button">^_^!</a></li>
								<br>
								<li><a id="i" class="hvr-radial-out button">^_^!</a></li>
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
				  
				  location.href="purctrl/purlistused.do?pageNum="+${page.navigateFirstPage }+
				      "&title="+document.getElementById("sousuo").value+
				      "&time1="+document.getElementById("time1").value+
				      "&time2="+document.getElementById("time2").value;
				  }
				  </script>
					<button onclick="syy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">上一页</button>
					<script type="text/javascript">
				  function syy(){
				 
				  location.href="purctrl/purlistused.do?pageNum="+${page.prePage}+
				      "&title="+document.getElementById("sousuo").value+
				      "&time1="+document.getElementById("time1").value+
				      "&time2="+document.getElementById("time2").value;
				  }
				  </script>
					<button disabled="disabled"
						style=" width:26px;height:26px;background-color: rgb(90, 152, 222);border: 0px;border-radius: 5px;">${page.pageNum}</button>
					<button onclick="xyy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">下一页</button>
					<script type="text/javascript">
				     function xyy(){
				  		 
				      location.href="purctrl/purlistused.do?pageNum="+${page.nextPage}+
				      "&title="+document.getElementById("sousuo").value+
				      "&time1="+document.getElementById("time1").value+
				      "&time2="+document.getElementById("time2").value;
				    }
				   </script>
					<button onclick="wy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">尾页</button>
					<script type="text/javascript">
				     function wy(){
				     location.href="purctrl/purlistused.do?pageNum="+${page.navigateLastPage }+
				      "&title="+document.getElementById("sousuo").value+
				      "&time1="+document.getElementById("time1").value+
				      "&time2="+document.getElementById("time2").value;
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
				var time1 = document.getElementById("time1").value;
				var time2 = document.getElementById("time2").value;
				if (time1 != "" & time2 != "") {
					if (time2 < time1) {
						alert("不符合时间搜索逻辑,请重新选择(后面的时间应比前面大)");
						return false;
					}
				}
				if (time1 != "" & time2 != "" & time2 == time1) {
					alert("不符合时间搜索逻辑,请重新选择(选择的时间不能相同)");
					return false;
				}
				location.href = "purctrl/purlistused.do?title=" + sousuo + "&time1=" + time1 + "&time2=" + time2;
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
						location.href = "<%=basePath%>purctrl/deleteusedpur.do?" + id;
						return true;
					} else {
						return false;
					}
				}
			}
			/* 单个删除 */
			function sc(uid) {
				if (confirm("确认删除吗") == true) {
					location.href = "<%=basePath%>purctrl/deleteusedpur.do?id=" + uid;
					return true;
				}
			}
			/*采购明细*/
			function cksjxq(id) {
				$.ajax({
					type : "post",
					url : "<%=basePath%>purctrl/selectpurone.do?id=" + id,
					dataType : "json",
					success : function(data) //从前台回调回来的数组，处理后的数据
					{
						$("#a").html("供应商：" + data.gysmc);
						$("#b").html("贷款金额：" + data.dkJe);
						$("#c").html("发票号码：" + data.fpNumber);
						$("#d").html("付款情况：" + data.fkQk);
		
						/* 得先把ajak返回的json时间格式转为普通时间格式 */
						var date = new Date(data.cgDate);
						var Y = date.getFullYear() + '-';
						var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
						var D = date.getDate() + ' ';
						var H = date.getHours() + ':';
						var F = date.getMinutes() + ':';
						var S = date.getSeconds();
		
						$("#e").html("交货时间：" + Y + M + D + H + F + S);
						$("#f").html("交货地点：" + data.jhAddress);
						$("#g").html("交货方式：" + data.jhFs);
						$("#h").html("操作人员：" + data.czrmc);
						$("#i").html("备注信息：" + data.bzXx);
						$("#j").html("公司：" + data.gsmc);
		
						/* 得先把ajak返回的json时间格式转为普通时间格式 */
						var date = new Date(data.lastTime);
						var Y = date.getFullYear() + '-';
						var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
						var D = date.getDate() + ' ';
						var H = date.getHours() + ':';
						var F = date.getMinutes() + ':';
						var S = date.getSeconds();
						$("#k").html("最后修改时间：" + Y + M + D + H + F + S);
					}
				});
				layer.open({
					type : 1,
					area : [ '700px', '500px' ],
					fix : false, //不固定
					maxmin : true,
					shade : 0.4,
					title : '明细',
					content : $('#window-div')
				});
			}
		</script>
</body>
</html>