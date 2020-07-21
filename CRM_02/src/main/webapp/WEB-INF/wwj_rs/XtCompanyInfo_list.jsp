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
		公司 <span class="c-gray en">&gt;</span> 公司管理 <a
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
					添加公司
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
						<th width="30">公司编号</th>
						<th width="100">公司名称</th>
						<th width="100">公司代码</th>
						<th width="80">联系人</th>
						<th width="100">固定电话</th>
						<th width="100">移动电话</th>
						<th width="100">开户银行</th>
						<th width="100">银行账户</th>
						<th width="40">是否有效</th>
						<th width="40">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="p">
						<tr class="text-c">
							<td><input type="checkbox" name="one-check"
								value="${p.companyId }"></td>
							<td>${p.companyId }</td>
							<td>${p.companyName }</td>
							<td>${p.companyCode }</td>
							<td>${p.liaison }</td>
							<td>${p.tel }</td>
							<td>${p.mp }</td>
							<td>${p.bankDeposit }</td>
							<td>${p.bankAcc }</td>
							<td><c:if test="${p.effect=='是'}">
									<span class="label label-success radius">${p.effect}</span>
								</c:if> <c:if test="${p.effect=='否'}">
									<span class="label label-danger radius">${p.effect}</span>
								</c:if></td>
							<td class="td-manage"><a style="text-decoration:none"
								onClick="cksjxq(${p.companyId })" href="javascript:;" title="查看采购明细">
									<i class="Hui-iconfont">&#xe616;</i>
							</a> <a title="编辑" href="javascript:;" onclick="bj(${p.companyId })"
								class="ml-5" style="text-decoration:none"> <i
									class="Hui-iconfont">&#xe6df;</i>
							</a> <a title="删除" href="javascript:;"
								onclick="return sc(${p.companyId })" class="ml-5"
								style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i>
							</a>
							<a title="查看用户" href="javascript:;" onclick="member_info('Rsctrl/gouser.do?companyId=${{p.companyId }','','350')" 
							class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe636;</i></a>
							
							</td>
							
							
						</tr>
					</c:forEach>
					
					
				</tbody>
			</table>
			<div id="window-from" class="none">
				<form style="margin-left: 20px;" id="from" method="post">
					<table>
					<tr>
					<td>公司编号</td>
					<td><input type="text" id="companyId" name="companyId" readonly="readonly"></td>
					</tr>
						<tr>
							<td>公司名称</td>
							<td><input class="inputcl" type="text" id="companyName"
								name="companyName"> <input type="hidden" id="companyId"
								name="companyId"></td>
							<td>公司代码</td>
							<td><input type="text" id="companyCode" name="companyCode">
							</td>
						</tr>
						<tr>
							<td>联系人</td>
							<td><input type="text" id="liaison" name="liaison"></td>
							<td>固定电话</td>
							<td><input type="text" id="tel" name="tel"></td>
						</tr>
						<tr>
							<td>移动电话</td>
							<td><input type="text" id="mp" name="mp"></td>
							<td>传真</td>
							<td><input type="text" id="fax" name="fax"></td>
						</tr>
						
						<tr>
							<td>邮箱</td>
							<td><input type="email" id="emlil" name="emlil"></td>
							<td>公司地址</td>
							<td><input type="text" id="companyAdd" name="companyAdd"></td>
						</tr>
						
						<tr>
							<td>开户银行</td>
							<td>
							<select id="select" name="bankDeposit" class="selectbyzy">
									<option id="shi" value="中国银行">中国银行</option>
									<option id="fou" value="建设银行">建设银行</option>
									<option id="fou" value="农业银行">农业银行</option>
									<option id="fou" value="工商银行">工商银行</option>
									<option id="fou" value="交通银行">交通银行</option>
									<option id="fou" value="中信银行">中信银行</option>
									<option id="fou" value="华夏银行">华夏银行</option>
									<option id="fou" value="招商银行">招商银行</option>
									<option id="fou" value="兴业银行">兴业银行</option>
									<option id="fou" value="广发银行">广发银行</option>
									<option id="fou" value="浦发银行">浦发银行</option>
									<option id="fou" value="光大银行">光大银行</option>
							</select>
							</td>
							
							<td>银行账户</td>
							<td><input type="text" id="bankAcc" name="bankAcc"></td>
						</tr>
						
						<tr>
							<td>是否有效</td>
							<td><select id="select" name="effect" class="selectbyzy">
									<option id="shi" value="是">是</option>
									<option id="fou" value="否">否</option>
							</select></td>
							
						</tr>
						<tr>
							<td>公司</td>
							<td><select id="comp" name="companyId" class="selectbyzy">
							</select></td>
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
				  
				  location.href="Rsctrl/selectCompany.do?pageNum="+${page.navigateFirstPage }+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button onclick="syy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">上一页</button>
					<script type="text/javascript">
				  function syy(){
				 
				  location.href="Rsctrl/selectCompany.do?pageNum="+${page.prePage}+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button disabled="disabled"
						style=" width:26px;height:26px;background-color: rgb(90, 152, 222);border: 0px;border-radius: 5px;">${page.pageNum}</button>
					<button onclick="xyy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">下一页</button>
					<script type="text/javascript">
				     function xyy(){
				  		 
				      location.href="Rsctrl/selectCompany.do?pageNum="+${page.nextPage}+
				      "&name="+document.getElementById("sousuo").value
				    }
				   </script>
					<button onclick="wy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">尾页</button>
					<script type="text/javascript">
				     function wy(){
				     location.href="Rsctrl/selectCompany.do?pageNum="+${page.navigateLastPage }+
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
			location.href = "Rsctrl/selectCompany.do?name=" + sousuo
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
					location.href = "<%=basePath%>Rsctrl/deletsup1.do?" + id;
					return true;
				} else {
					return false;
				}
			}
		}
		/* 单个删除 */
		function sc(uid) {
			if (confirm("确认删除吗") == true) {
				location.href = "<%=basePath%>Rsctrl/deletsup1.do?id=" + uid;
				return true;
			}
		}
		/*供应商明细*/
		function cksjxq(id) {
			$.ajax({
				type : "post",
				url : "<%=basePath%>Rsctrl/selectCompanyid.do?id=" + id,
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{   
				    $("#a").html("公司编号：" + data.companyId);
					$("#a").html("公司名称：" + data.companyName);
					$("#b").html("公司代码：" + data.companyCode);
					$("#c").html("联系人：" + data.liaison);
					$("#d").html("固定电话：" + data.tel);
					$("#e").html("移动电话：" + data.mp);
					$("#f").html("传真：" + data.fax);
					$("#g").html("邮箱：" + data.emlil);
					$("#h").html("开户银行：" + data.bankDeposit);
					$("#i").html("银行账户：" + data.bankAcc);
					$("#j").html("公司地址：" + data.companyAdd);
					$("#nn").html("备注信息：" + data.orderRemark);
					$("#mm").html("公司：" + data.compname);
					var date = new Date(data.lastModifyDate);
					var Y = date.getFullYear() + '-';
					var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
					var D = date.getDate() + ' ';
					var H = date.getHours() + ':';
					var F = date.getMinutes() + ':';
					var S = date.getSeconds();
					$("#ll").html("最后修改时间：" + Y + M + D + H + F + S);
				}
			});
			layer.open({
				type : 1,
				area : [ '700px', '500px' ],
				fix : false, //不固定
				maxmin : true,
				shade : 0.4,
				title : '公司明细',
				content : $('#window-div')
			});
		}
		/* 编辑 */
		function bj(id) {
			var temp = 0;
			$("#companyId").val($("#ee").val());
			$.ajax({
				type : "post",
				url : "<%=basePath%>Rsctrl/selectCompanyid.do?id=" + id,
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
					$("#companyId").val(data.companyId);
					$("#companyName").val(data.companyName);
					$("#companyCode").val(data.companyCode);
					$("#liaison").val(data.liaison);
					$("#tel").val(data.tel);
					$("#mp").val(data.mp);
					$("#fax").val(data.fax);
					$("#emlil").val(data.emlil);
					$("#bankDeposit").val(data.bankDeposit);
					$("#bankAcc").val(data.bankAcc);
					$("#companyAdd").val(data.companyAdd);
					$("#orderRemark").val(data.orderRemark);
					if (data.effect == "是") {
						document.getElementById("shi").selected = true;
					}
					if (data.effect == "否") {
						document.getElementById("fou").selected = true;
					}
				
					$("#orderRemark").html(data.orderRemark);
					var op = "";
					op = "<option>请选择</option>";
					$.each(data.xtCompanyInfo, function(i, comp) {
						op += "<option value='" + comp.companyId + "'" + (comp.companyId == data.companyId ? 'selected' : '') + ">" + comp.companyName + "</option>"
					});
					$("#comp").html(op);
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
						url : "Rsctrl/updateCompany.do", //url地址
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
			$("#companyName").val($("#dd").val());
			$("#companyId").val($("#ee").val());
			$.ajax({
				type : "post",
				url : "<%=basePath%>Rsctrl/selectCompany.do",
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
						url : "Rsctrl/addCompany.do", //url地址
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
		
		function member_info(url){
   window.location.href=url;
}
	</script>
</body>
</html>