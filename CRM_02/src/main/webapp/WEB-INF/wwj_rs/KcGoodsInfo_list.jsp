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
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
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
	
	<!-- 采购明细样式 -->
<link href="static/zy_css/style.css" rel='stylesheet' type='text/css' />
<!-- from表单样式 -->
<link rel="stylesheet" href="static/from/css/platform-1.css">

<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>商品信息表</title>
<style type="text/css">
.none { /* 弹层默认隐藏 */
	display: none;
}
</style>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>商品管理 (仓库编号:${sessionScope.nowhuseInfoid })<span class="c-gray en">&gt;</span>商品信息管理 <a class="btn btn-refresh radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="page-container">
		<div class="text-c">
				<from action=""> 
				<input type="text" value="${ssz}"
				class="input-text" style="width:250px" placeholder="商品名称模糊搜索"
				id="sousuo">
			<button type="button" class="btn btn-success radius"
				onclick="return sousuo()">
				<i class="Hui-iconfont">&#xe665;</i> 搜索
			</button>
			<button id="cz" onclick="cla()" type="reset"
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
	
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<span class="l">
		<a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> 
		<a href="Rsctrl/selectdepot.do"  class="btn btn-primary radius"><i class="Hui-iconfont">&#xe6f7;</i> 返回仓库</a>
		<!-- <a href="javascript:;" onclick="member_add('添加客户','xscustomctrl/goaddcustom.do','','520')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加客户</a> -->
		</a> <a href="javascript:;" onclick="daochu()"
				style="background-color: pink; border: 0px;"
				class="btn btn-primary radius"> <i class="Hui-iconfont">&#xe600;</i>
					导出到excel
			</a>
		</span> 
		<script type="text/javascript">
				function daochu() {
					location.href = "<%=basePath%>Rsctrl/daochu.do"
				}
			</script>
		<span class="r">共有数据：<strong>${p.total}</strong> 条</span> 
	</div>
	

<div class="mt-20">
	<form action="Rsctrl/deletegoodsAll.do" method="post" id="myform1"> <!-- 这里点击确定不出来是因为你写的name="myform1" -->
	<table class="table table-border table-bordered table-hover table-bg table-sort">
		<thead>
			<tr class="text-c">
				<th width="25"><input type="checkbox" id=""></th>
				<th width="30">商品编号</th>
				<th width="50">商品名称 </th>
				<th width="50">商品类别 </th>
				<th width="50">仓库编号</th>
				<th width="50"> 库存数量 </th>
				<th width="50">成本价</th>
				<th width="50"> 零售价</th>
				<th width="80">最后修改时间</th>
				<th width="60">操作</th>
			</tr>
			
		</thead>
		<tbody>
		   <c:forEach items="${p.list }" var="p">
				<tr class="text-c">
					<td><input type="checkbox" value="${p.productId }"  name="ids"> </td> <!-- 这里所有的复选框都叫ids -->
					<td>${p.productId}</td>								<!-- 复选框name=ids，方法参数也要是ids -->
					<td>${p.productName }</td>
					<td>${p.productType  }</td>
					<td>${p.warehouseId  }</td>
					<td>${p.kcNum  }</td>
					<td>${p.cost  }</td>
					<td>${p.renall  }</td>
					<td>
					  <fmt:formatDate value="${p.lastModifyDate  }" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					
					<td class="td-manage">
					<a style="text-decoration:none" onClick="cksjxq(${p.productId })" href="javascript:;" title="查看商品基本信息"><i class="Hui-iconfont">&#xe616;</i></a>
								
					<!-- 根据id来区分是编辑还是删除 -->
				</a> <a title="编辑" href="javascript:;" onclick="bj(${p.productId })"
								class="ml-5" style="text-decoration:none"> <i
									class="Hui-iconfont">&#xe6df;</i>
							</a>
                    <%-- <a title="修改商品基本信息" href="javascript:;" onclick="member_edit('编辑商品信息','Rsctrl/goaddcustom.do','${p.productId }','520')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> --%>
					<a title="删除" href="javascript:;" onclick="member_del(this,'${p.productId}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
				 </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</form><!--  这个表单用来批量删除-->	
	
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
								<li><a id="i" class="hvr-rectangle-in button">^_^!</a> 
								
								<br>
								
								<li><a id="x" class="hvr-rectangle-in button">^_^!</a></li>
								<li><a id="y" class="hvr-rectangle-in button">^_^!</a></li>
								<!-- <li><a id="z" class="hvr-rectangle-in button">^_^!</a></li> -->
							</ul>
						</div>
					</div>
				</div>
			</div>
	
	
	
</div>

	
	<div>
				<span>当前${p.pageNum}/${p.pages}页</span>
				<div style="float: right;">
					<button onclick="sy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">首页</button>
					<script type="text/javascript">
				  function sy(){
				  
				  location.href="Rsctrl/selectgoodsInfo.do?pageNum="+${p.navigateFirstPage }+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button onclick="syy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">上一页</button>
					<script type="text/javascript">
				  function syy(){
				 
				  location.href="Rsctrl/selectgoodsInfo.do?pageNum="+${p.prePage}+
				      "&name="+document.getElementById("sousuo").value
				  }
				  </script>
					<button disabled="disabled"
						style=" width:26px;height:26px;background-color: rgb(90, 152, 222);border: 0px;border-radius: 5px;">${p.pageNum}</button>
					<button onclick="xyy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">下一页</button>
					<script type="text/javascript">
				     function xyy(){
				  		 
				      location.href="Rsctrl/selectgoodsInfo.do?pageNum="+${p.nextPage}+
				      "&name="+document.getElementById("sousuo").value
				    }
				   </script>
					<button onclick="wy()"
						style="height: 26px;width: 50px;border: 0px;border-radius: 5px;">尾页</button>
					<script type="text/javascript">
				     function wy(){
				     location.href="Rsctrl/selectgoodsInfo.do?pageNum="+${p.navigateLastPage }+
				      "&name="+document.getElementById("sousuo").value
				    }
				  </script>
				</div>
				<script type="text/javascript">
					function gopage(pageNum){
					/* alert("拿到的pageNum"+pageNum)  */
					   $("#pageNum").val(pageNum);
					   $("#myform").submit();  
				  location.href="Rsctrl/selectgoodsInfo.do"
					}
				</script> 
	</div>
</div>

             <div id="window-from" class="none">
				<form style="margin-left: 20px;" id="from"  >
					<table>
					<tr>
					<td>商品编号</td>
					<td><input type="text" id="productId" name="productId"></td>
					
					</tr>
					
					
					<tr>
							<td>商品名称</td>
							<td><input type="text" id="productName" name="productName">
							</td>
							<td>商品类别</td>
							<td><input type="text" id="productType" name="productType">
							</td>
						</tr>
						<tr>
							<td>规格说明</td>
							<td><input class="inputcl" type="text" name="ggsm" id="ggsm">
							</td>
							<td>单位</td>
							<td><input type="text" id="unit" name="unit">
							</td>
						</tr>
						<tr>
							<td>仓库编号</td>
							<td><input type="text" id="warehouseId" name="warehouseId"></td>
							<td>库存数量</td>
							<td><input type="text" id="kcNum" name="kcNum"></td>
						</tr>
						<tr>
							<td>成本价</td>
							<td><input type="text" id="cost" name="cost"></td>
							<td>零售价</td>
							<td><input type="text" id="renall" name="renall"></td>
						</tr>

						<tr>						   
							<td>公司编号</td>
							<td><input type="text" id="companyId" name="companyId" class="selectbyzy">
							</td>
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
						<tr>
						<td>
						<span id="xianshi"></span>
						</td>
						</tr>
					</table>
				</form>
			</div>
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
	
<script type="text/javascript">
/*
	参数解释：
	title	标题
	url		请求的url
	id		需要操作的数据id
	w		弹出层宽度（缺省调默认值）
	h		弹出层高度（缺省调默认值）
*/

$(function(){
	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,8]}// 制定列不参与排序
		]
	});
	
});

/* 搜索 */
			function sousuo() {
			alert(document.getElementById("sousuo").value)
				var sousuo = document.getElementById("sousuo").value;
				location.href = "Rsctrl/selectgoodsInfo.do?name=" + sousuo
			}


/*查看客户基本信息*/
			 function cksjxq(id) {
			 //alert("拿到的id"+id) 
				$.ajax({
					type : "post",
					url : "<%=basePath%>Rsctrl/selectgoodsxq.do?id=" + id,   /*  这里的引号错了*/
					dataType : "json",
					success : function(data) //从前台回调回来的数组，处理后的数据
					{
				 	//alert(data.productName); 
				 		$("#a").html("商品编号：" + data.productId);
						$("#a").html("商品名称：" + data.productName);
						$("#b").html("商品类别 ：" + data.productType);
						$("#c").html("规格说明：" + data.ggsm);
						$("#d").html("单位：" + data.unit);
						$("#e").html("仓库编号：" + data.warehouseId);
						$("#f").html(" 库存数量：" + data.kcNum);
						$("#g").html("成本价：" + data.cost);
						$("#h").html("零售价：" + data.renall);
						$("#i").html("经销价：" + data.sell);
						$("#x").html("备注信息：" + data.orderRemark);
						$("#y").html("公司编号：" + data.companyId);
						
						var date = new Date(data.lastModifyDate);
						var Y = date.getFullYear() + '-';
						var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
						var D = date.getDate() + ' ';
						var H = date.getHours() + ':';
						var F = date.getMinutes() + ':';
						var S = date.getSeconds();
						$("#y").html("最后修改时间：" + Y + M + D + H + F + S);
					}
				});
				layer.open({
					type : 1,
					area : [ '700px', '500px' ],
					fix : false, //不固定
					maxmin : true,
					shade : 0.4,
					title : '商品信息详情',
					content : $('#window-div')
				});
			} 
/*客户信息-添加*/
function member_add(title,url,w,h){
	layer_show(title,url,w,h);
}


/*客户信息-编辑*/
function member_edit(title,url,id,w,h){
	url=url+"?productId="+id;
	layer_show(title,url,w,h);
}
/*客户信息批量-删除*/
function datadel(){
   
   //$("input[name='ids']")
   
   if($("input[name='ids']:checked").length>=1){
   
	   layer.confirm('确认要删除这些数据吗？',function(index){
	      $("#myform1").submit();
	   });
   }else{
       layer.msg('请至少选择一条数据!',{icon:5,time:1000});
   }
}
/*客户信息-删除*/
function member_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'Rsctrl/deletegoods.do',
			data: "productId="+id,
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



/* 编辑 */
		function bj(id) {
			var temp = 0;
			$("#productId").val($("#ee").val()); 
			$.ajax({
				type : "post",
				url : "<%=basePath%>Rsctrl/selectgoodsxq.do?id=" + id,
				dataType : "json",
				success : function(data) //从前台回调回来的数组，处理后的数据
				{
				        $("#productId").val(data.productId);
					    $("#productName").val(data.productName);
						$("#productType").val(data.productType);
						$("#ggsm").val(data.ggsm);
						$("#unit").val(data.unit);
						$("#warehouseId").val(data.warehouseId);
						$("#kcNum").val(data.kcNum);
						$("#cost").val(data.cost);
						$("#renall").val(data.renall);
						$("#sell").val(data.sell);
						$("#companyId").val(data.companyId);
						$("#orderRemark").val(data.orderRemark);
						
					$("#czrname").val(data.xtUserInfo.workerName);
					if (data.sfYx == "是") {
						document.getElementById("shi").selected = true;
					}
					if (data.sfYx == "否") {
						document.getElementById("fou").selected = true;
					}
					$("#czry").val(data.operaterId);
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
					//alert($('#from').serialize());
					$.ajax({
						type : "post", //请求方式
						url : "<%=basePath%>Rsctrl/updategoods.do", //url地址
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
	
</script> 
</body>
</html>