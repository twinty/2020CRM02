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
		员工信息<span class="c-gray en">&gt;</span>员工管理 <a
			class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="text-c">
				<from action=""> 
				<input type="text" value="${ssz}"
				class="input-text" style="width:250px" placeholder="姓名模糊搜索"
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
		function cla(){
		document.getElementById("sousuo").value="";
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
					录入员工信息
			</a>
			</span> <span class="r">共有数据：<strong>${p.total}</strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" id="all-check"></th>
						<th width="80">ID</th>
						<th width="60">员工姓名</th>
						<th width="35">性别</th>
						<th width="40">员工照片</th>
						<th width="50">现在住址</th>
						<th width="40">联系电话</th>
						<th width="40">审核状态</th>
						<th width="40">职务编号</th>
						<th width="40">员工状态</th>
						<th width="40">公司编号</th>
						<th width="40">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${p.list }" var="p">
						<tr class="text-c">
							<td><input type="checkbox" name="one-check"
								value="${p.workerId }"></td>
							<td>${p.workerId }</td>
							<td>${p.workerName }</td>
							<td>${p.workerSex }</td>
							<td>${p.workerPhoto }
							<img alt="暂无图片" src="<%=basePath%>upload/${p.workerPhoto }" width="100px" height="60px">
							</td>
							<td>${p.nowAdd }</td>
							<td>${p.workerTel }</td>
							<td>${p.audIt }</td>
							<td>${p.dutiesId }</td>
							<td>${p.workerSta }</td>
							<td>${p.companyId }</td>
							<td class="td-manage"><a style="text-decoration:none"
								onClick="cksjxq(${p.workerId })" href="javascript:;" title="查看员工明细">
									<i class="Hui-iconfont">&#xe616;</i>
							</a> <a title="编辑" href="javascript:;" onclick="bj(${p.workerId })"
								class="ml-5" style="text-decoration:none"> <i
									class="Hui-iconfont">&#xe6df;</i>
							</a> <a title="删除" href="javascript:;"
								onclick="return sc(${p.workerId })" class="ml-5"
								style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i>
							</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="window-from" class="none">
				<form style="margin-left: 20px;" id="from"   method="post" enctype="multipart/form-data">
					<table>
					<tr>
							<td>员工姓名</td>
							<td><input class="inputcl" type="text" id="ygXm"
								name="workerName"> 
								<input type="hidden" id="workerId"name="workerId"></td>
							<td>性别</td>
							<td><input type="text" id="sex" name="workerSex">
							</td>
						</tr>
						<tr>
							<td>照片</td>
							<td><input class="inputcl" type="file" name="upload" >
							<input type="hidden" id="workerPhoto"name="workerPhoto"></td>
                             
							<td>员工身份证号</td>
							<td><input type="text" id="Sfz" name="idCard">
							</td>
						</tr>
						<tr>
							<td>家乡住址</td>
							<td><input type="text" id="JxDz" name="homeAdd"></td>
							<td>现在住址</td>
							<td><input type="text" id="XzDz" name="nowAdd"></td>
						</tr>
						<tr>
							<td>员工学历</td>
							<td><input type="text" id="YgXl" name="workerEdu"></td>
							<td>政治面貌</td>
							<td><input type="text" id="ZzMm" name="politics"></td>
						</tr>
						<tr>
							<td>毕业学校</td>
							<td><input type="text" id="ByXx" name="school"></td>
							<td>联系电话</td>
							<td><input type="text" id="LxDh" name="workerTel"></td>
						</tr>
						<tr>
						    <td>网上联系方式</td>
							<td><input type="text" id="WebLxFx" name="webRelation"></td>
							<td>网上联系详情</td>
							<td><input type="text" id="WebLxXq" name="webDeta"></td>						
						</tr>
						<tr>
						    <td>审核状态</td>
							<td><input type="text" id="ShZt" name="audIt"></td>
							<td>职务编号</td>
							<td><input type="text" id="ZwBm" name="dutiesId"></td>						
						</tr>
						
						<tr>
						    <td>员工状态</td>
							<td><input type="text" id="YgZt" name="workerSta"></td>	
							<td>公司编号</td>
							<td><input type="text" id="companyId" name="companyId" class="selectbyzy">
							</td>
						</tr>
						
						
						<tr>
							<td><div>备注信息</div></td>
							<td colspan="3">
								<div>
									<textarea style="float: left;" rows="5" cols="70" id="bzXx"
										name="orderRemark"></textarea>
								</div>
							</td>
						</tr>
						<tr>
						<td>
						<span id="xianshi"></span>
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
								<br>
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
				<span>当前${p.pageNum}/${p.pages}页</span>
				<div style="float: right;">
					<button onclick="sy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">首页</button>
					<script type="text/javascript">
				  function sy(){
				  
				  location.href="Rsctrl/selectSup.do?pageNum="+${p.navigateFirstPage }+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button onclick="syy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">上一页</button>
					<script type="text/javascript">
				  function syy(){
				 
				  location.href="Rsctrl/selectSup.do?pageNum="+${p.prePage}+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button disabled="disabled"
						style=" width:26px;height:26px;background-color: rgb(90, 152, 222);border: 0px;border-radius: 5px;">${p.pageNum}</button>
					<button onclick="xyy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">下一页</button>
					<script type="text/javascript">
				     function xyy(){
				  		 
				      location.href="Rsctrl/selectSup.do?pageNum="+${p.nextPage}+
				      "&name="+document.getElementById("sousuo").value
				    }
				   </script>
					<button onclick="wy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">尾页</button>
					<script type="text/javascript">
				     function wy(){
				     location.href="Rsctrl/selectSup.do?pageNum="+${p.navigateLastPage }+
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
			alert(document.getElementById("sousuo").value)
				var sousuo = document.getElementById("sousuo").value;
				location.href = "Rsctrl/selectSup.do?name=" + sousuo
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
						location.href = "<%=basePath%>Rsctrl/deletsup.do?" + id;
						return true;
					} else {
						return false;
					}
				}
			}
			/* 单个删除 */
			function sc(uid) {
				if (confirm("确认删除吗") == true) {
					location.href = "<%=basePath%>Rsctrl/deletsup.do?id=" + uid;
					return true;
				}
			}
			/*供应商明细*/
			function cksjxq(id) {
				$.ajax({
					type : "post",
					url : "<%=basePath%>Rsctrl/selectuserid.do?id=" + id,
					dataType : "json",
					success : function(data) //从前台回调回来的数组，处理后的数据
					{
						$("#a").html("员工姓名：" + data.workerName);
						$("#b").html("性别：" + data.workerSex);
						$("#c").html("身份证号：" + data.idCard);
						$("#d").html("家乡住址：" + data.homeAdd);
						$("#e").html("现在住址：" + data.nowAdd);
						$("#f").html("员工学历：" + data.workerEdu);
						$("#g").html("政治面貌：" + data.politics);
						$("#h").html("毕业学校：" + data.school);
						$("#i").html("联系电话：" + data.workerTel);
						$("#j").html("网上联系方式：" + data.webRelation);
						$("#k").html("网上联系详情：" + data.webDeta);
						$("#nn").html("审核状态：" + data.audIt);
						$("#nn").html("职务编号：" + data.dutiesId);
						$("#nn").html("员工状态：" + data.workerSta);
						$("#nn").html("备注说明：" + data.orderRemark);
						$("#mm").html("公司编号：" + data.companyId);
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
					title : '员工信息明细',
					content : $('#window-div')
				});
			}
			
			/* 编辑 */
			var indexcs="";
			function bj(id) {
			document.getElementById("from").action="Rsctrl/updateuserid.do"
			//alert(document.getElementById("from").action)
			$("#xianshi").html('<input type="button" onclick="xg()" value="提交">')
				$("#workerId").val($("#ee").val());
				$.ajax({
					type : "post",
					url : "<%=basePath%>Rsctrl/selectuserid.do?id=" + id,
					dataType : "json",
					success : function(data) //从前台回调回来的数组，处理后的数据
					{
					//alert(data.workerId+"  "+data.idCard)
						$("#workerId").val(data.workerId);
						$("#ygXm").val(data.workerName);
						$("#sex").val(data.workerSex);
						 //$("#YgZp").val(data.workerPhoto);
						$("#Sfz").val(data.idCard);
						$("#JxDz").val(data.homeAdd);
						$("#XzDz").val(data.nowAdd);
						$("#dz").val(data.address);
						$("#YgXl").val(data.workerEdu);
						$("#ZzMm").val(data.politics);
						$("#ByXx").val(data.school);
						$("#LxDh").val(data.workerTel);
						$("#WebLxFx").val(data.webRelation);
						$("#WebLxXq").val(data.webDeta);
						$("#ShZt").val(data.audIt);
						$("#ZwBm").val(data.dutiesId);s
						$("#YgZt").val(data.workerSta);
						$("#companyId").val(data.companyId);
						$("#bzXx").val(data.orderRemark);
						$("#lastModifyDate").html(data.lastModifyDate);
					}
				});
		            indexcs = layer.open({
					type : 1,
					area : [ '600px', '550px' ],
					fix : false, //不固定
					maxmin : true,
					shade : 0.4,
					title : '修改员工信息',
					content : $('#window-from'),
					yes : function() {
						/* 输出序列后的值，name一定要和bean的一样 */
						 /* alert($('#from').serialize());  */
						$.ajax({
							type : "post", //请求方式
							url : "Rsctrl/updateuserid.do", //url地址
							data : $('#from').serialize(), //序列化表单的参数
							dataType : "json" //响应类型
						});
						//提交完成后关闭弹层
						layer.close(index);
					},
					//end是关闭窗口时自动执行
					end : function() {
						/* alert("关闭后刷新页面"); */
						window.location.reload(); //关闭弹窗后刷新页面
					}
				});
			//弹层全屏
			//layer.full(index);
			}
		
			/* 添加 */
			var indexcs="";
			function add() {
			document.getElementById("from").action="Rsctrl/add.do"
			alert(document.getElementById("from").action)
			$("#xianshi").html('<input type="button" onclick="tj()" value="提交">')
				$("#workerName").val($("#dd").val());
				$("#workerId").val($("#ee").val());
				$.ajax({
					type : "post",
					url : "<%=basePath%>Rsctrl/selectuserid.do",
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
				indexcs = layer.open({
					type : 1,
					area : [ '600px', '550px' ],
					fix : false, //不固定
					maxmin : true,
					shade : 0.4,
					title : '添加员工信息',
					content : $('#window-from'),
					
					//end是关闭窗口时自动执行
					end : function() {
						/* alert("关闭后刷新页面"); */
						setTimeout(function() {
							window.location.reload(); //关闭弹窗后刷新页面
						}, 2000)
						
					}
				});
			//弹层全屏
			//layer.full(index);
			}
			
			
			function tj(){
			$("#from").submit();
			layer.close(indexcs);
			layer.msg("添加成功",{icon:6,time:1000})
	        }
			
	       function xg(){
			$("#from").submit();
			layer.close(indexcs);
			layer.msg("修改成功",{icon:6,time:1000})
	        }
		</script>
</body>
</html>