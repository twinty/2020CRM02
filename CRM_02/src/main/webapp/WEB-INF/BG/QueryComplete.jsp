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
		 查看未完成任务 <a
			class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	
		<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
			<a href="javascript:;" onclick="return plyiyue()" class="btn btn-danger radius">
			选择已完成</a></span>
		</div>
				
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" id="all-check"></th>
					<!-- <th width="40">ID</th> -->
					<th width="40">任务标题</th>
					<th width="100">任务具体内容</th>
					<th width="40">发布人</th>
					<th width="40">接受者</th>
					<th width="60">考核指标</th>
					<th width="100">任务开始时间</th>
					<th width="100">任务结束时间</th>
					<th width="40">是否完成</th>
					<th width="20">操作</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${p.list }" var="p">
					<c:if test="${p.bgTaskDetail.acceptUserId==user.workerId }">
					<c:if test="${p.bgTaskDetail.state=='1' }">
					<c:if test="${p.bgTaskDetail.whetherComplete=='0' }">
						<tr class="text-c">
							<td><input type="checkbox" name="one-check" value="${p.taskId }"></td>
							<%-- <td>${p.taskId }</td> --%>
							<td>${p.taskTitle }</td>
							<td><a onclick="" title="详情">${p.taskSpecificContrnt}</a></td>
							<td>${p.taskPromulgator }</td>
							<td>${user.workerName }</td>
							<td>
								<c:forEach items="${selectBgAssessIndex }" var="sbai">
									<c:if test="${p.assessIndex==sbai.indexId }"><!-- 对比id查出考核名称 -->
										<a title="查看考核指标" onclick="ckxg(${sbai.assessIndex })">${sbai.assessIndex }</a>
									</c:if>
								</c:forEach>
							</td>
							<td><fmt:formatDate value="${p.taskStartTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${p.taskFinishTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${p.bgTaskDetail.whetherComplete=='0' }"><span style="color:red"><i class="Hui-iconfont">&#xe688;</i>未完成</span></c:if>
								<c:if test="${p.bgTaskDetail.whetherComplete=='1' }"><span style="color:green">完成</span></c:if>
							</td>
							<%-- <td>
								<c:if test="${p.bgTaskDetail.state=='0' }"><span style="color:red">未读</span></c:if>
								<c:if test="${p.bgTaskDetail.state=='1' }"><span style="color:green">已读</span></c:if>
							</td>	 --%>
							<td>
								<a title="已完成" onclick="return yiyue(${p.taskId })"><i class="Hui-iconfont">&#xe660;</i></a>
							</td>
						</tr>
					</c:if>
					</c:if>
					</c:if>
				</c:forEach>
			</tbody>
			
		</table><br>
			
		<%-- <div>
		
			<span>当前${p.pageNum}/${p.pages}页</span>
			
			<div style="float: right;">
			
			<button onclick="sy()"
			style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">首页</button>
			  <script type="text/javascript">
			  function sy(){
			  location.href="Bgctrl/selectBgAssessTask.do?pageNum="+${p.navigateFirstPage }}
			  </script>
			  
			<button onclick="syy()" 
			style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">上一页</button>
			  <script type="text/javascript">
			  function syy(){
			  location.href="Bgctrl/selectBgAssessTask.do?pageNum="+${p.prePage}}
			  </script>
			  
			<button disabled="disabled"
			style=" width:26px;height:26px;background-color: rgb(90, 152, 222);border: 0px;border-radius: 5px;">${p.pageNum}</button>
			<button onclick="xyy()"
			style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">下一页</button>
				<script type="text/javascript">
			    function xyy(){
			    location.href="Bgctrl/selectBgAssessTask.do?pageNum="+${p.nextPage}}
			    </script>
			   
			<button onclick="wy()"
			style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">尾页</button>
				 <script type="text/javascript">
			     function wy(){
			     location.href="Bgctrl/selectBgAssessTask.do?pageNum="+${p.navigateLastPage }}
			  	 </script>
			</div>
		</div>--%>


	<script type="text/javascript">
		
		
		/* 批量已完成 */
		var nodeAll = document.getElementById("all-check");
		nodeAll.onclick = function() {
			//name可以重复id只能有一个
			var nodes = document.getElementsByName("one-check");
			var flag = nodeAll.checked;
			for (var i = 0; i < nodes.length; i++) {
				nodes[i].checked = flag;
			}
		}
		function plyiyue() {
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
				
				location.href = "<%=basePath%>Bgctrl/updateQueryComplete.do?" + id;
				layer.msg("已完成", {
					icon : 6,
					time : 2000
				});
				return true;
				
			}
		}
		
		/* 单个已完成 */
		function yiyue(id) {
			location.href = "<%=basePath%>Bgctrl/updateQueryComplete.do?id=" + id;
			layer.msg("已完成", {
					icon : 6,
					time : 2000
				});
			return true;
			
		}
	
		/*查看考核指标*/
		function ckxg(sousuo) {
			$.ajax({
				type : "post",//请求方式
				url : "<%=basePath%>Bgctrl/selectBgAssessIndex.do?sousuo=" + sousuo, //请求地址
				dataType : "json", //响应类型
				});
				
		}

		
		
		
	</script>
	<script>
	new verSelector();
	</script>
	
</body>
</html>