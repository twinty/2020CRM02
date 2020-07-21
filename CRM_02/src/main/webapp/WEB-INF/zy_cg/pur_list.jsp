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
			</a> <a href="javascript:;" onclick="add()"
				class="btn btn-primary radius"> <i class="Hui-iconfont">&#xe600;</i>制定新货采购
			</a> <c:if test="${zt=='no' || zt=='noneed'}">
					<a href="javascript:;" onclick="aa()"
						class="btn btn-success radius"> <i class="Hui-iconfont">&#xe600;</i>制定补货采购
					</a>
				</c:if> <c:if test="${zt=='need' }">
					<a href="javascript:;" onclick="add1()"
						class="btn btn-success radius"> <i class="Hui-iconfont">&#xe600;</i>制定补货采购
					</a>
					<span style="color:red;" id="sp">有货物需要补充，请尽快处理</span>
				</c:if> <script type="text/javascript">
					function aa() {
						layer.msg("无需补货商品");
					}
				</script> </script>
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
						<th width="60">付款情况</th>
						<th width="40">采购进展</th>
						<th width="70">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="p">
						<tr class="text-c">
							<td id="inpid${p.cgId }"><input type="checkbox"
								name="one-check" value="${p.cgId }"></td>
							<c:if test="${p.fkQk=='已付款'}">
								<script type="text/javascript">
                                $("#inpid"+${p.cgId }).html('<input disabled="disabled" type="checkbox">');
                                </script>
							</c:if>
							<td>${p.cgId }</td>
							<td><a style="text-decoration:underline;"
								href="purctrl/selectorderanddel.do?cgid=${p.cgId }"
								title="查看采购详情单"> ${p.cgTitle } </a></td>
							<td><fmt:formatDate value="${p.cgDate }"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>

							<td><c:if test="${p.fkQk=='未付款'}">
									<span class="label label-danger radius">${p.fkQk}</span>
								</c:if> <c:if test="${p.fkQk=='已付款'}">
									<span class="label label-success radius">${p.fkQk}</span>
								</c:if></td>
							<td>
									<span class="label label-danger radius">${p.cgJz}</span>
							</td>
							<td class="td-manage"><c:if test="${p.fkQk=='未付款'}">
									<a style="text-decoration:none" onClick="cksjxq(${p.cgId })"
										href="javascript:;" title="查看明细"> <i class="Hui-iconfont">&#xe616;</i>
									</a>
									<a onclick="change(${p.cgId })" title="付款" class="ml-5"
										style="text-decoration:none;"> <i class="Hui-iconfont">&#xe6e1;</i>
									</a>
									<a title="编辑" href="javascript:;" onclick="bj(${p.cgId })"
										class="ml-5" style="text-decoration:none;"> <i
										class="Hui-iconfont">&#xe6df;</i>
									</a>
									<a title="删除" href="javascript:;"
										onclick="return sc(${p.cgId })" class="ml-5"
										style="text-decoration:none;"> <i class="Hui-iconfont">&#xe6e2;</i>
									</a>
								</c:if> <c:if test="${p.fkQk=='已付款'}">
									<a style="text-decoration:none" onClick="cksjxq(${p.cgId })"
										href="javascript:;" title="查看明细"> <i class="Hui-iconfont">&#xe616;</i>
									</a>
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="window-from" class="none">
				<form style="margin-left: 20px;" id="from" method="post">
					<table>
						<tr>
							<td>采购主题</td>
							<td><input class="inputcl" type="text" id="l" name="cgTitle">
								<input type="hidden" id="z" name="cgId"></td>
							<td>采购日期</td>
							<td><input style="width: 160px;height: 37.27px" type="text"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								class="input-text Wdate" id="m" name="cgDate"></td>
						</tr>
						<tr>
							<td>采购进展</td>
							<td><input readonly="readonly" type="text" id="n"
								name="cgJz"></td>
							<td>供应商</td>
							<td><select id="gyss" name="gysId" class="selectbyzy">
							</select></td>
						</tr>
						<tr>
							<td>贷款金额</td>
							<td><input type="text" id="p" name="dkJe"></td>
							<td>发票号码</td>
							<td><input type="text" id="q" name="fpNumber"></td>
						</tr>
						<tr>
							<td>付款情况</td>
							<td><input readonly="readonly" type="text" id="r"
								name="fkQk"></td>
							<td>交货时间</td>
							<td><input style="width: 160px;height: 37.27px" type="text"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								class="input-text Wdate" type="text" id="s" name="jhDate">
							</td>
						</tr>
						<tr>
							<td>交货地点</td>
							<td><input type="text" id="t" name="jhAddress"></td>
							<td>交货方式</td>
							<td><input type="text" id="u" name="jhFs"></td>
						</tr>
						<tr>
							<td>操作人员</td>
							<td><input type="text" readonly="readonly" id="v"> <input
								type="hidden" value="${public.czrid}" name="operaterId">
							</td>
							<td>公司</td>
							<td><select id="comp" name="companyId" class="selectbyzy">
							</select></td>
						</tr>
						<tr>
							<td><div>备注信息</div></td>
							<td colspan="3"><textarea
									style="float: left;margin-top: 55px;" rows="5" cols="70" id="y"
									name="bzXx"></textarea></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="window-from1" class="none">
				<form style="margin-left: 20px;" id="myfrom1" method="post">
					<div id="one" style="display: block;">
						<table>
							<tr>
								<td>采购主题</td>
								<td><input class="inputcl" type="text" id="l"
									name="cgTitle"> <input type="hidden" id="z" name="cgId"></td>
								<td>采购日期</td>
								<td><input style="width: 160px;height: 37.27px" type="text"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									class="input-text Wdate" id="m" name="cgDate"></td>
							</tr>
							<tr>
								<td>采购进展</td>
								<td><input type="text" readonly="readonly" id="n"
									name="cgJz" value="正在采购"></td>
								<td>供应商</td>
								<td><select id="gysss" name="gysId" class="selectbyzy">
								</select></td>
							</tr>
							<tr>
								<td>贷款金额</td>
								<td><input type="text" id="p" name="dkJe"></td>
								<td>发票号码</td>
								<td><input type="text" id="q" name="fpNumber"></td>
							</tr>
							<tr>
								<td>付款情况</td>
								<td><input readonly="readonly" type="text" id="r"
									name="fkQk" value="未付款"></td>
								<td>交货时间</td>
								<td><input style="width: 160px;height: 37.27px" type="text"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									class="input-text Wdate" type="text" id="s" name="jhDate">
								</td>
							</tr>
							<tr>
								<td>交货地点</td>
								<td><input type="text" id="t" name="jhAddress"></td>
								<td>交货方式</td>
								<td><input type="text" id="u" name="jhFs"></td>
							</tr>
							<tr>
								<td>操作人员</td>
								<td><input type="text" readonly="readonly"
									value="${public.czrmc}"> <input type="hidden" id="v"
									value="${public.czrid}" name="operaterId"></td>
								<td>公司</td>
								<td><select id="compsss" name="companyId"
									class="selectbyzy">
								</select></td>
							</tr>
							<tr>
								<td><div>备注信息</div></td>
								<td colspan="3"><textarea
										style="float: left;margin-top: 55px;" rows="5" cols="70"
										id="y" name="bzXx"></textarea></td>
							</tr>
							<a style="position: absolute;top:440px;left:500px;"
								href="javascript:;" onclick="next()"
								class="btn btn-primary radius">填写商品&nbsp> </a>
							<tr>
						</table>
					</div>
					<div id="two" style="display: none;">
						<table>
							<tr>
								<td>产品名称</td>
								<td><input type="text" id="cpNamejc" onblur="jc()"
									name="cpName"> <span style="color: red;" id="span"></span>
									<span style="color:green;" id="span1"></span></td>

							</tr>
							<tr>
								<td>产品单价</td>
								<td><input type="text" id="cpdj"></td>

							</tr>
							<tr>
								<td>产品数量</td>
								<td><input oninput="cs()" type="text" id="cpsl"
									name="cpNum"></td>
								<script>
									function cs() {
										$("#cpzj").val($("#cpdj").val() * $("#cpsl").val())
									}
								</script>
							</tr>
							<tr>
								<td>产品总价</td>
								<td><input readonly="readonly" type="text" id="cpzj"
									name="cpJg"></td>
							</tr>
							<tr>
								<td><div>备注信息</div></td>
								<td colspan="3"><textarea style="float: left;" rows="5"
										cols="70" id="bzxx" name="bzXx"></textarea></td>
							</tr>
							<a style="position: absolute;top:440px;left:480px;"
								href="javascript:;" onclick="fh()"
								class="btn btn-primary radius"><&nbsp返回 </a>
							<a style="position: absolute;top:440px;left:560px;"
								href="javascript:;" onclick="tj()"
								class="btn btn-success radius">提交 </a>

						</table>
					</div>
				</form>
			</div>
			<div id="window-from2" class="none">
				<form style="margin-left: 20px;" id="myfrom2" method="post">
					<div id="three" style="display: block;">
						<table>
							<tr>
								<td>采购主题</td>
								<td><input class="inputcl" type="text" id="l"
									name="cgTitle"> <input type="hidden" id="z" name="cgId"></td>
								<td>采购日期</td>
								<td><input style="width: 160px;height: 37.27px" type="text"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									class="input-text Wdate" id="m" name="cgDate"></td>
							</tr>
							<tr>
								<td>需采购商品单</td>
								<td><select
									style="width: 150px;height: 37.32px;border-radius: 5px;"
									name="searchs" id="searchs" data-selector
									data-selector-checks="true">
										<option>请选择</option>
								</select></td>
								<td>操作人员</td>
								<td><input type="text" readonly="readonly"
									value="${public.czrmc}"> <input type="hidden" id="v"
									value="${public.czrid}" name="operaterId"></td>
							</tr>
							<tr>
								<td>采购进展</td>
								<td><input readonly="readonly" type="text" id="n"
									value="正在采购" name="cgJz"></td>
								<td>供应商</td>
								<td><select id="gyssss" name="gysId" class="selectbyzy">
								</select></td>
							</tr>
							<tr>
								<td>贷款金额</td>
								<td><input type="text" id="p" name="dkJe"></td>
								<td>发票号码</td>
								<td><input type="text" id="q" name="fpNumber"></td>
							</tr>
							<tr>
								<td>付款情况</td>
								<td><input readonly="readonly" type="text" id="r"
									name="fkQk" value="未付款"></td>
								<td>交货时间</td>
								<td><input style="width: 160px;height: 37.27px" type="text"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									class="input-text Wdate" type="text" id="s" name="jhDate">
								</td>
							</tr>
							<tr>
								<td>交货地点</td>
								<td><input type="text" id="t" name="jhAddress"></td>
								<td>交货方式</td>
								<td><input type="text" id="u" name="jhFs"></td>
							</tr>

							<tr>
								<td>公司</td>
								<td><select id="compssss" name="companyId"
									class="selectbyzy">
								</select></td>
							</tr>

							<tr>
								<td><div>备注信息</div></td>
								<td colspan="3"><textarea style="float: left;" rows="5"
										cols="70" id="y" name="bzXx"></textarea></td>
							</tr>
						</table>
					</div>
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
				  
				  location.href="purctrl/purlist.do?pageNum="+${page.navigateFirstPage }+
				      "&title="+document.getElementById("sousuo").value+
				      "&time1="+document.getElementById("time1").value+
				      "&time2="+document.getElementById("time2").value;
				  }
				  </script>
					<button onclick="syy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">上一页</button>
					<script type="text/javascript">
				  function syy(){
				 
				  location.href="purctrl/purlist.do?pageNum="+${page.prePage}+
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
				  		 
				      location.href="purctrl/purlist.do?pageNum="+${page.nextPage}+
				      "&title="+document.getElementById("sousuo").value+
				      "&time1="+document.getElementById("time1").value+
				      "&time2="+document.getElementById("time2").value;
				    }
				   </script>
					<button onclick="wy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">尾页</button>
					<script type="text/javascript">
				     function wy(){
				     location.href="purctrl/purlist.do?pageNum="+${page.navigateLastPage }+
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
			location.href = "purctrl/purlist.do?title=" + sousuo + "&time1=" + time1 + "&time2=" + time2;
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
					location.href = "<%=basePath%>purctrl/deletepur.do?" + id;
					return true;
				} else {
					return false;
				}
			}
		}
		/* 单个删除 */
		function sc(uid) {
			if (confirm("确认删除吗") == true) {
				location.href = "<%=basePath%>purctrl/deletepur.do?id=" + uid;
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
		/* 编辑 */
		function bj(id) {
			temp = 0;
			$.ajax({
				type : "post",
				url : "<%=basePath%>purctrl/selectpurone.do?id=" + id,
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
					$("#z").val(data.cgId);
					/* $("#o").val(data.gysId); */
					var opg = "";
					opg = "<option>请选择</option>";
					$.each(data.cgSupMsg, function(i, comp) {
						opg += "<option value='" + comp.gysId + "'" + (comp.gysId == data.gysId ? 'selected' : '') + ">" + comp.gysName + "</option>"
					});
					$("#gyss").html(opg);
					$("#l").val(data.cgTitle);
					$("#n").val(data.cgJz);
					$("#p").val(data.dkJe);
					$("#q").val(data.fpNumber);
					$("#r").val(data.fkQk);
	
					/* 得先把ajak返回的json时间格式转为普通时间格式 */
					var date = new Date(data.cgDate);
					var Y = date.getFullYear() + '-';
					var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
					var D = date.getDate() + ' ';
					var H = date.getHours() + ':';
					var F = date.getMinutes() + ':';
					var S = date.getSeconds();
	
					$("#m").val(Y + M + D + H + F + S);
	
					/* 得先把ajak返回的json时间格式转为普通时间格式 */
					var date = new Date(data.jhDate);
					var Y = date.getFullYear() + '-';
					var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
					var D = date.getDate() + ' ';
					var H = date.getHours() + ':';
					var F = date.getMinutes() + ':';
					var S = date.getSeconds();
	
					$("#s").val(Y + M + D + H + F + S);
					$("#t").val(data.jhAddress);
					$("#u").val(data.jhFs);
					$("#v").val(data.czrmc);
					$("#y").html(data.bzXx);
					/* $("#w").val(data.companyId); */
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
				area : [ '600px', '530px' ],
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
						url : "purctrl/update.do", //url地址
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
					if (temp == 1) {
					setTimeout(function() {
						location.replace(location.href);
					}, 1000)
					}
				}
			});
		//弹层全屏
		//layer.full(index);
		}
	
		/* 新货添加 */
		var index = "";
		var temp1 = 0;
		function add() {
			$.ajax({
				type : "post",
				url : "<%=basePath%>purctrl/selectsupandcomp.do",
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
					var opg = "";
					opg = "<option>请选择</option>";
					$.each(data.sup, function(i, sup) {
						opg += "<option value='" + sup.gysId + "'>" + sup.gysName + "</option>"
					});
					$("#gysss").html(opg);
					var op = "";
					op = "<option>请选择</option>";
					$.each(data.comp, function(i, comp) {
						op += "<option value='" + comp.companyId + "'>" + comp.companyName + "</option>"
					});
					$("#compsss").html(op);
				}
			});
			index = layer.open({
				type : 1,
				area : [ '630px', '530px' ],
				fix : false, //不固定
				maxmin : true,
				shade : 0.4,
				title : '新货添加',
				content : $('#window-from1'),
				//end是关闭窗口时自动执行
				end : function() {
				   if (temp1 == 1) {
					setTimeout(function() {
						location.replace(location.href);
					}, 1000)
					}
	
				}
			});
		}
		function tj() {
			temp1 = 1;
			/* 输出序列后的值，name一定要和bean的一样 */
			$.ajax({
				type : "post", //请求方式
				url : "purctrl/addnew.do", //url地址
				data : $('#myfrom1').serialize(), //序列化表单的参数
				dataType : "json" //响应类型
			});
			//提交完成后关闭弹层
			layer.close(index);
			if (temp1 == 1) {
				layer.msg("添加成功", {
					icon : 6,
					time : 2000
				});
			}
		}
	
	
		/* 补货添加 */
		function add1() {
			var temp = 0;
			$.ajax({
				type : "post",
				url : "<%=basePath%>purctrl/selectsupandcomp.do",
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
	
					var opg = "";
					opg = "<option>请选择</option>";
					$.each(data.sup, function(i, sup) {
						opg += "<option value='" + sup.gysId + "'>" + sup.gysName + "</option>"
					});
					$("#gyssss").html(opg);
					var op = "";
					op = "<option>请选择</option>";
					$.each(data.comp, function(i, comp) {
						op += "<option value='" + comp.companyId + "'>" + comp.companyName + "</option>"
					});
					$("#compssss").html(op);
	
					var h = "";
					$.each(data.crp, function(i, xbh) {
						if (xbh.cgOrderDetail.cgId == 0) {
							h += "<option value='" + xbh.cpId + "'>" + xbh.kcGoodsInfo.productName + "</option>"
						}
					});
					$("#searchs").html(h);
				}
			});
			index = layer.open({
				type : 1,
				area : [ '630px', '560px' ],
				fix : false, //不固定
				btn : [ '提交', '取消' ],
				maxmin : true,
				shade : 0.4,
				title : '添加',
				content : $('#window-from2'),
				//end是关闭窗口时自动执行
				yes : function() {
					temp = 1;
					var id = "";
					$(".actives").each(function(i, e) {
						id += "id=" + $(this).attr("data-value") + "&";
					});
					$.ajax({
						type : "post", //请求方式
						url : "purctrl/add.do?" + id, //url地址
						data : $('#myfrom2').serialize(), //序列化表单的参数
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
				end : function() {
				if (temp == 1) {
					setTimeout(function() {
						location.replace(location.href);
					}, 1000)
					}
				}
			});
		}
	
	
		function next() {
			document.getElementById("one").style.display = "none";
			document.getElementById("two").style.display = "block";
		}
		function fh() {
			document.getElementById("one").style.display = "block";
			document.getElementById("two").style.display = "none";
		}
		function next1() {
			document.getElementById("three").style.display = "none";
			document.getElementById("four").style.display = "block";
		}
		function fh1() {
			document.getElementById("three").style.display = "block";
			document.getElementById("four").style.display = "none";
		}
	
		function change(id) {
			$.ajax({
				type : "post",
				url : "<%=basePath%>purctrl/changefkqk.do?id=" + id,
				dataType : "json",
				success : function(data) {
					if (data == 1) {
						layer.msg("操作成功", {
							icon : 6
						});
						setTimeout(function() {
							location.replace(location.href);
						}, 1000)
					}
				}
			});
		}
	
		function jc() {
			var name = $("#cpNamejc").val();
			$.ajax({
				type : "post",
				url : "<%=basePath%>purctrl/jccpname.do?name=" + name,
				dataType : "json",
				success : function(data) {
					if (data == 1) {
						$("#span").html('<i class="Hui-iconfont">&#xe706;</i>仓库已有该商品');
						$("#span1").html('');
						$("#cpNamejc").focus();
					}
					if (data == 0) {
						$("#span1").html('<i class="Hui-iconfont">&#xe676;</i>');
						$("#span").html('');
					}
				}
			});
		}
	</script>
</body>
<script>
	new verSelector();
</script>
</html>