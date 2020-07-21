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

<!-- from表单样式 -->
<link rel="stylesheet" href="static/from/css/platform-1.css">

<!-- 下拉框多选 -->
<script src="static/duoxuan/asset/js/select.js"></script>
<script src="static/duoxuan/verSelector/verSelect.js"></script>
<script src="static/duoxuan/asset/js/jquery.min.js"></script>
	

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
		 发布查看短消息 <a
			class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
			
			<div style="border: 2px;">
			<form style="margin-left: 20px;" id="from" name="from" method="post">
				<table>
					<tr>
						<input type="hidden" id="smsId" name="smsId">
						<input type="hidden" id="informationState" name="informationState" value="0"><!-- 默认是未读 -->
					</tr>
					<tr>
						<td><input type="text" id="smsTitle" name="smsTitle" placeholder="标题"></td>
						<td><input type="hidden" id="smsSender" name="smsSender" placeholder="发布人" value="${user.workerName }"></td>
						<td style="width: 539px;height: 46px">接收人：
							<select style="width: 150px;height: 37.32px;border-radius: 5px;" id="receiverId" name="xianbuyong" data-selector data-selector-checks="true">${option }</select>
						</td>
					</tr>
					<tr>
						
					
						<td><textarea rows="4" cols="45" 
							id="smsContent" name="smsContent" placeholder="短消息具体内容"></textarea></td>
						<td><button type="button" class="btn btn-success radius"
							onclick="tj()">
							<i class="Hui-iconfont">&#xe645;</i> 发布短消息
						</button>
						</td>
					</tr>
										
				</table>
			</form>
			</div>
		
			
	
	<!-- 切换删除 -->
	
	<div class="page-container" style="display:block;" id="qhsc">	
		
		
		<div class="cl pd-5 bg-1 bk-gray mt-20">
		<span class="l">
				<a href="javascript:;" onclick="return plyidu()" class="btn btn-primary radius">
				<i class="Hui-iconfont">&#xe725;</i> 已阅</a>
				<a href="javascript:;" onclick="qhsc()" >
				<i class="Hui-iconfont">&#xe609;</i> 切换删除</a>				
		</span>
		<span class="r">
				<a href="javascript:;" onclick="return qbdxx()" class="btn btn-primary radius">
				<i class="Hui-iconfont">&#xe763;</i> 查看已发布短消息</a>			
		</span>
		
		</div>	
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" id="all-check"></th>
					<!-- <th width="40">ID</th> -->
					<th width="40">标题</th>
					<th width="100">任务具体内容</th>
					<th width="40">发布人</th>
					<th width="40">接受者</th>
					<th width="40">状态</th>
					<th width="20">操作</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${p.list }" var="p">
				<c:if test="${p.bgSmsDetail.receiverId==user.workerId }">
					<tr class="text-c">
						<td><input type="checkbox" name="one-check" value="${p.smsId }"></td>
						<td>${p.smsTitle }</td>
						<td><a onclick="" title="详情">${p.smsContent}</a></td>
						<td>${p.smsSender }</td>
						<td>${user.workerName }</td>
						<td>
							<c:if test="${p.bgSmsDetail.informationState=='0' }"><span style="color:red">未读</span></c:if>
							<c:if test="${p.bgSmsDetail.informationState=='1' }"><span style="color:green">已读</span></c:if>
						</td>	
						<td>
							<c:if test="${p.bgSmsDetail.informationState=='1' }">
							<a title="删除" onclick="return sc(${p.smsId })"><i class="Hui-iconfont">&#xe609;</i></a>
							</c:if>
							<c:if test="${p.bgSmsDetail.informationState=='0' }">
							<a title="已查阅" onclick="return yidu(${p.smsId })"><i class="Hui-iconfont">&#xe68e;</i></a>
							</c:if>
						</td>
					</tr>
				</c:if>
				</c:forEach>
			</tbody>
			
		</table><br>
		
		
	</div>



<!-- 切换已读 -->

	<div class="page-container" style="display:none;" id="qhyd">
		
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<span class="l">
				<a href="javascript:;" onclick="return plsc()" class="btn btn-danger radius">
				<i class="Hui-iconfont">&#xe609;</i> 批量删除</a>
				<a href="javascript:;" onclick="qhyd()" >
				<i class="Hui-iconfont">&#xe725;</i> 切换已阅</a>
		</span>
		<span class="r">
				<a href="javascript:;" onclick="return qbdxx()" class="btn btn-primary radius">
				<i class="Hui-iconfont">&#xe763;</i> 查看已发布短消息</a>			
		</span>
		</div>	
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" id="all-check"></th>
					<!-- <th width="40">ID</th> -->
					<th width="40">标题</th>
					<th width="100">任务具体内容</th>
					<th width="40">发布人</th>
					<th width="40">接受者</th>
					<th width="40">状态</th>
					<th width="20">操作</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${p.list }" var="p">
				<c:if test="${p.bgSmsDetail.receiverId==user.workerId }">
					<tr class="text-c">
						<td>
							<c:if test="${p.bgSmsDetail.informationState=='1' }">
							<input type="checkbox" name="one-check" value="${p.smsId }">
							</c:if>
							<c:if test="${p.bgSmsDetail.informationState=='0' }">
							<a title="已查阅" onclick="return yidu(${p.smsId })"><i class="Hui-iconfont">&#xe68e;</i></a>
							</c:if>
						</td>
						<td>${p.smsTitle }</td>
						<td><a onclick="" title="详情">${p.smsContent}</a></td>
						<td>${p.smsSender }</td>
						<td>${user.workerName }</td>
						<td>
							<c:if test="${p.bgSmsDetail.informationState=='0' }"><span style="color:red">未读</span></c:if>
							<c:if test="${p.bgSmsDetail.informationState=='1' }"><span style="color:green">已读</span></c:if>
						</td>	
						<td>
							<c:if test="${p.bgSmsDetail.informationState=='1' }">
							<a title="删除" onclick="return sc(${p.smsId })"><i class="Hui-iconfont">&#xe609;</i></a>
							</c:if>
							<c:if test="${p.bgSmsDetail.informationState=='0' }">
							<a title="已查阅" onclick="return yidu(${p.smsId })"><i class="Hui-iconfont">&#xe68e;</i></a>
							</c:if>
						</td>
					</tr>
				</c:if>
				</c:forEach>
			</tbody>
			
		</table><br>
		
	</div>
	
	
	
<!-- 切换到已发布都所有短消息 -->
	
	<div class="page-container" style="display:none;" id="qbdxx">	
		
		
		<div class="cl pd-5 bg-1 bk-gray mt-20">
		<span class="l">
				<a href="javascript:;" onclick="return plsc()" class="btn btn-danger radius">
				<i class="Hui-iconfont">&#xe609;</i> 批量删除</a>
				<a href="javascript:;" onclick="qhyd()" >
				<i class="Hui-iconfont">&#xe725;</i> 切换已阅</a>
		</span>
		</div>	
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" id="all-check"></th>
					<!-- <th width="40">ID</th> -->
					<th width="40">标题</th>
					<th width="100">任务具体内容</th>
					<th width="40">发布人</th>
					<th width="40">接受者</th>
					<th width="40">状态</th>
					<th width="20">操作</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${p.list }" var="p">
				<c:if test="${p.smsSender==user.workerName }">
					<tr class="text-c">
						<td><input type="checkbox" name="one-check" value="${p.smsId }"></td>
						<td>${p.smsTitle }</td>
						<td><a onclick="" title="详情">${p.smsContent}</a></td>
						<td>${p.smsSender }</td>
						<td>
							<c:forEach items="${selectuser }" var="u"> 
								<c:if test="${p.bgSmsDetail.receiverId==u.workerId }">
									${u.workerName }
								</c:if>
							</c:forEach>
						</td>
						<td>
							<c:if test="${p.bgSmsDetail.informationState=='0' }"><span style="color:red">未读</span></c:if>
							<c:if test="${p.bgSmsDetail.informationState=='1' }"><span style="color:green">已读</span></c:if>
						</td>	
						<td>
							<a title="删除" onclick="return sc(${p.smsId })"><i class="Hui-iconfont">&#xe609;</i></a>
						</td>
					</tr>
				</c:if>
				</c:forEach>
			</tbody>
			
		</table><br>
		
		
	</div>
	
	
	
	<script type="text/javascript">
		/* 搜索 */
		function sousuo() {
		alert(document.getElementById("sousuo").value);
			var sousuo = document.getElementById("sousuo").value;
			location.href = "Bgctrl/yyy.do?sousuo="+sousuo;
		}
		/* 批量阅读 */
		var nodeAll = document.getElementById("all-check");
		nodeAll.onclick = function() {
			//name可以重复id只能有一个
			var nodes = document.getElementsByName("one-check");
			var flag = nodeAll.checked;
			for (var i = 0; i < nodes.length; i++) {
				nodes[i].checked = flag;
			}
		}
		function plyidu() {
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
				
					location.href = "<%=basePath%>Bgctrl/updateBgSms.do?" + id;
					return true;
			
			}
		}
		
		/* 批量删除 */
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
					location.href = "<%=basePath%>Bgctrl/deleteBgSms.do?" + id;
					return true;
				} else {
					return false;
				}
			}
		}
		
		/* 单个阅读 */
		function yidu(id) {
			
				location.href = "<%=basePath%>Bgctrl/updateBgSms.do?id=" + id;
				return true;
			
		}
		/* 单个删除*/
		function sc(id) {
			if(confirm("是否删除？")==true){
				location.href = "<%=basePath%>Bgctrl/deleteBgSms.do?id=" + id;
				layer.msg("已删除", {
					icon : 6,
					time : 2000
				});
				return true;
			}
			
		}
		
		/* 添加 */
		function tj() {
			var id = "";
			$(".actives").each(function(i, e) {
				id += "id=" + $(this).attr("data-value") + "&";
			});
			var temp1=1;
			
			/* 必须全填才能提交 */
			if (
				document.from.smsTitle.value==''||
				document.from.receiverId.value==''||
				document.from.smsContent.value=='') {
				alert('有未填项！');temp1=0;
				};
			
				
			/* 没有问题可以提交 */
			if (temp1 == 1) {
				/* 输出序列后的值，name一定要和bean的一样 */
				$.ajax({
					type : "post", //请求方式
					url : "Bgctrl/addBgSms.do?"+ id, //url地址
					data : $('#from').serialize(), //序列化表单的参数
					dataType : "json", //响应类型
				});
				
				layer.msg("添加成功", {
					icon : 6,
					time : 2000
				});
			}
		}
			
	
	
		/*查看考核指标*/
		function ckxg(sousuo) {
			$.ajax({
				type : "post",//请求方式
				url : "<%=basePath%>Bgctrl/yyy.do?sousuo=" + sousuo, //请求地址
				dataType : "json", //响应类型
				});
				
		}

		//样式的开启和关闭
		function qhyd() {
		/* alert("切换已阅") */
			var qh = document.getElementById("qhsc").style.display;
			if (qh == "none") {
				document.getElementById("qhyd").style.display = "none";
				document.getElementById("qhsc").style.display = "block";
				document.getElementById("qbdxx").style.display = "none";
			}
		}
		function qhsc() {
		/* alert("切换删除") */
			var qh = document.getElementById("qhyd").style.display;
			if (qh == "none") {
				document.getElementById("qhsc").style.display = "none";
				document.getElementById("qhyd").style.display = "block";
				document.getElementById("qbdxx").style.display = "none";
			}
		}
		function qbdxx() {
		/* alert("切换全部短信息") */
			var qh = document.getElementById("qbdxx").style.display;
			if (qh == "none") {
				document.getElementById("qbdxx").style.display = "block";
				document.getElementById("qhsc").style.display = "none";
				document.getElementById("qhyd").style.display = "none";
			}
		}
		
		
		
	</script>
	<script>
	new verSelector();
	</script>
</body>
</html>