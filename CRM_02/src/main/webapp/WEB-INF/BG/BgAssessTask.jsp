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
		 任务发布管理 <a
			class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	
	<div class="page-container">
	
		<div class="text-c">
			任务名称： <input type="text" id="sousuo" style="width:200px;">
			<button type="button" class="btn btn-success radius"
				onclick="return sousuo()">
				<i class="Hui-iconfont">&#xe683;</i> 搜索
			</button>
		</div>
		
		<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
			<a href="javascript:;" onclick="return plsc()" class="btn btn-danger radius">
			<i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
			<a href="javascript:;" onclick="add()" class="btn btn-primary radius">
			<i class="Hui-iconfont">&#xe600;</i> 添加新的任务</a></span>
			
			<%-- <span class="r">共有数据：<strong>${p.total}</strong> 条</span> --%>
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
					<th width="40">状态</th>
					<th width="20">操作</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${p.list }" var="p">
				<c:if test="${p.taskPromulgator==dluser.workerName }">
					<tr class="text-c">
						<td><input type="checkbox" name="one-check" value="${p.taskId }"></td>
						<%-- <td>${p.taskId }</td> --%>
						<td>${p.taskTitle }</td>
						<td><a onclick="" title="详情">${p.taskSpecificContrnt}</a></td>
						<td>${p.taskPromulgator }</td>
						<td>
							<c:forEach items="${user }" var="u">
								<c:if test="${p.bgTaskDetail.acceptUserId==u.workerId }">
									${u.workerName }
								</c:if>
							</c:forEach>
						</td>
						<td>
							<c:forEach items="${selectBgAssessIndex }" var="sbai">
								<c:if test="${p.assessIndex==sbai.indexId }"><!-- 对比id查出考核名称 -->
									<a title="查看考核指标" onclick='ck(${sbai.indexId })'>${sbai.assessIndex }</a>
								</c:if>
							</c:forEach>
						</td>	
						<td><fmt:formatDate value="${p.taskStartTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><fmt:formatDate value="${p.taskFinishTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td>
							<c:if test="${p.bgTaskDetail.whetherComplete=='0' }"><span style="color:red">未完成</span></c:if>
							<c:if test="${p.bgTaskDetail.whetherComplete=='1' }"><span style="color:green">完成</span></c:if>
						</td>
						<td>
							<c:if test="${p.bgTaskDetail.state=='0' }"><span style="color:red">未读</span></c:if>
							<c:if test="${p.bgTaskDetail.state=='1' }"><span style="color:green">已读</span></c:if>
						</td>	
						<td>
							<a title="删除" onclick="return sc(${p.taskId })"><i class="Hui-iconfont">&#xe6e2;</i></a>
						</td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
			
		</table><br>
			
		<div>
		
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
		</div>
	</div>
	<div id="window-from1" class="none">
		<form style="margin-left: 20px;" id="from1" method="post">
			<table>
				<br>
				<tr>
					<td>ID:</td>
					<td><input type="text" id="indexId" name="indexId" readonly="readonly"></td>
				</tr>
				<tr>
					<td>考核指标:</td>
					<td><input type="text" id="assessIndex" name="assessIndex" readonly="readonly"></td>
				</tr>
				<tr>
					<td>备注:</td> 
					<td><textarea style="float: left;" rows="5" cols="70" readonly="readonly"
										id="remark" name="remark"></textarea></td>
				</tr>
					
			</table>
		</form>
	</div>
	<div id="window-from" class="none">
		<form style="margin-left: 20px;" id="from" name="from" method="post">
			<table>
				<tr>
					<td></td>
					<td><input type="hidden" id="taskId" name="taskId">
						<input type="hidden" id="state" name="state" value="0"><!-- 默认是未读 -->
						<input type="hidden" id="whetherComplete" name="whetherComplete" value="0"><!-- 默认未完成 -->
						<input type="hidden" id="taskPromulgator" name="taskPromulgator" value="${dluser.workerName }">
					</td>
				</tr>
				<tr>
					<td>任务标题:</td>
					<td><input type="text" id="taskTitle" name="taskTitle"></td>
				</tr>
				<tr>
					<td>考核指标:</td>
					<td style="width: 539px;height: 51px">
					<select id="khzb" name="assessIndex" style="width: 150px;height: 37.32px;border-radius: 5px;"></select></td>
				</tr>
				<tr>
					<td>接受者:</td>
					<td style="width: 539px;height: 46px">
						<select style="width: 150px;height: 37.32px;border-radius: 5px;"
						id="acceptUserId" name=xianbuyongzheg data-selector data-selector-checks="true">
							<option>请输入</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>开始时间:</td>
					<td><input type="text" id="taskStartTime" name="taskStartTime" class="input-text Wdate" style="width:200px;"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
					</td>
				</tr>
				<tr>
					<td>结束时间:</td>
					<td><input type="text" id="taskFinishTime" name="taskFinishTime" class="input-text Wdate" style="width:200px;"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
					</td>
				</tr>
				
				<tr>
					<td>任务具体内容:</td> 
					<td><textarea style="float: left;" rows="5" cols="70" 
						id="taskSpecificContrnt" name="taskSpecificContrnt"></textarea></td>
				</tr>
					<a style="position: absolute;top:440px;left:560px;" class="btn btn-success radius" onclick="tj()">提交 </a>
			</table>
		</form>
	</div>
	

	<script type="text/javascript">
		/* 搜索 */
		function sousuo() {
			var sousuo = document.getElementById("sousuo").value;
			if(sousuo!=""&&sousuo!=null){
			location.href = "Bgctrl/selectBgAssessTask.do?sousuo="+sousuo;
			return true;
			}else{
			alert("请输入值");
			return false;
			}
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
					location.href = "<%=basePath%>Bgctrl/deleteBgAssessTask.do?" + id;
					return true;
				} else {
					return false;
				}
			}
		}
		
		/* 单个删除 */
		function sc(id) {
			if (confirm("确认删除吗") == true) {
				location.href = "<%=basePath%>Bgctrl/deleteBgAssessTask.do?id=" + id;
				return true;
			}
		}
		
		
		/* 添加 */
		var index = "";
		function add() {
			$.ajax({
				type : "post",
				url : "<%=basePath%>Bgctrl/goaddtBgAssessTask.do",
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
					var opg = "";
					opg = "<option>请选择</option>";
					$.each(data.selectBgAssessIndex, function(i, selectBgAssessIndex) {
						opg += "<option value='" + selectBgAssessIndex.indexId + "'>" + selectBgAssessIndex.assessIndex + "</option>"
					});
					$("#khzb").html(opg);
					var op = "";
					$.each(data.selectXtUserInfo, function(i, selectXtUserInfo) {
						
						op += "<option value='" + selectXtUserInfo.workerId + "'>" + selectXtUserInfo.workerName + "</option>"		
						
					});
					$("#acceptUserId").html(op);
				}
				});
		index = layer.open({
			type : 1,
			area : [ '630px', '530px' ],
			fix : false, //不固定
			maxmin : true,
			shade : 0.4,
			title : '添加',
			content : $('#window-from'),
			//end是关闭窗口时自动执行
			end : function() {
				setTimeout(function() {
				location.replace(location.href);
			}, 1000)
			}
			
			});
		}
		function tj() {
			var id = "";
			$(".actives").each(function(i, e) {
				id += "id=" + $(this).attr("data-value") + "&";
			});
			var temp1=1;
			var time1 = document.getElementById("taskStartTime").value;
			var time2 = document.getElementById("taskFinishTime").value;
			if (time1 != "" & time2 != "") {/* 时间判断 ，开始必须小于结束*/
				if (time2 < time1) {
					alert("时间选择不规范");
					 document.getElementById("taskStartTime").value="";
					 temp1=0;
				};
			};
				if (time1 != "" & time2 != "" & time2 == time1) {
					alert("时间选择不规范");
					 document.getElementById("taskStartTime").value="";
					 document.getElementById("taskFinishTime").value="";
					 temp1=0;
				};
			
			/* 必须全填才能提交 */
			if (document.from.taskPromulgator.value==''||
				document.from.assessIndex.value==''||
				document.from.acceptUserId.value==''||
				document.from.taskStartTime.value==''||
				document.from.taskFinishTime.value==''||
				document.from.taskTitle.value==''||
				document.from.taskSpecificContrnt.value=='') {
				alert('有未填项！');temp1=0;
				};
			
				
			/* 没有问题可以提交 */
			if (temp1 == 1) {
				/* 输出序列后的值，name一定要和bean的一样 */
				$.ajax({
					type : "post", //请求方式
					url : "Bgctrl/addBgAssessTask.do?"+ id, //url地址
					data : $('#from').serialize(), //序列化表单的参数
					dataType : "json", //响应类型
					
				});
				
				//关闭弹层
				layer.close(index);
				
				layer.msg("添加成功", {
					icon : 6,
					time : 2000
				});
			};
			
		}
			

		/*查看考核指标*/
		function ck(id) {
			$.ajax({
				type : "post",//请求方式
				url : "<%=basePath%>Bgctrl/getBgAssessIndex.do?id=" + id, //请求地址
				dataType : "json", //响应类型
				success : function(ck) //从前台回调回来的数组，处理后的数据
				{	
					$("#indexId").val(ck.indexId);
					$("#assessIndex").val(ck.assessIndex);
					$("#remark").val(ck.remark);
				}
					});
					
			var index = layer.open({
				type : 1,
				area : [ '550px', '400px' ],
				fix : false, //不固定
				maxmin : true,
				shade : 0.4,
				title : '考核指标详情',
				content : $('#window-from1'),
				//end是关闭窗口时自动执行
				end : function() {
					/* alert("关闭后刷新页面"); */
					window.location.reload(); //关闭弹窗后刷新页面
				}
				});
					
					
		}
		
		
	</script>
	<script>
	new verSelector();
	</script>
	
</body>
</html>