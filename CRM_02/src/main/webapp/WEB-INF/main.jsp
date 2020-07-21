<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="Bookmark" href="/favicon.ico">
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
	src="CrmStatic/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>

<title>主页面</title>
<meta name="keywords"
	content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description"
	content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
	<header class="navbar-wrapper">
		<div class="navbar navbar-fixed-top">
			<div class="container-fluid cl">
				<a class="logo navbar-logo f-l mr-10 hidden-xs">欢迎来到crm</a> <a
					class="logo navbar-logo-m f-l mr-10 visible-xs"
					href="/aboutHui.shtml">H-ui</a> <span
					class="logo navbar-slogan f-l mr-10 hidden-xs">SC</span> <a
					aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs"
					href="javascript:;">&#xe667;</a>
				<nav class="nav navbar-nav">
					<ul class="cl">
						<li class="dropDown dropDown_hover"><a href="javascript:;"
							class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 新增 <i
								class="Hui-iconfont">&#xe6d5;</i></a>
							<ul class="dropDown-menu menu radius box-shadow">
								<li><a href="javascript:;"
									onclick="article_add('添加资讯','article-add.html')"><i
										class="Hui-iconfont">&#xe616;</i> 资讯</a></li>
								<li><a href="javascript:;"
									onclick="picture_add('添加资讯','picture-add.html')"><i
										class="Hui-iconfont">&#xe613;</i> 图片</a></li>
								<li><a href="javascript:;"
									onclick="product_add('添加资讯','product-add.html')"><i
										class="Hui-iconfont">&#xe620;</i> 产品</a></li>
								<li><a href="javascript:;"
									onclick="member_add('添加用户','member-add.html','','510')"><i
										class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
							</ul></li>
					</ul>
				</nav>
				<nav id="Hui-userbar"
					class="nav navbar-nav navbar-userbar hidden-xs">
					<ul class="cl">
						<li>超级管理员</li>
						<li class="dropDown dropDown_hover"><a href="#"
							class="dropDown_A">${empty sessionScope.nowuser.userName ? "游客":nowuser.userName }<i
								class="Hui-iconfont">&#xe6d5;</i></a>
							<ul class="dropDown-menu menu radius box-shadow">
								<li><a href="javascript:;" onClick="myselfinfo()">个人信息</a></li>
								<li><a href="javascript:void();"
									onclick="location.href='logout.do'">切换账户</a></li>

								<li><a href="<%=basePath%>logout.do"
									onclick="return window.confirm('是否确定退出系统？')">退出</a></li>
							</ul></li>
						<li id="Hui-msg"><a href="#" title="消息"><span
								class="badge badge-danger">1</span><i class="Hui-iconfont"
								style="font-size:18px">&#xe68a;</i></a></li>
						<li id="Hui-skin" class="dropDown right dropDown_hover"><a
							href="javascript:;" class="dropDown_A" title="换肤"><i
								class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
							<ul class="dropDown-menu menu radius box-shadow">
								<li><a href="javascript:;" data-val="default"
									title="默认（黑色）">默认（黑色）</a></li>
								<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
								<li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
								<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
								<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
								<li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
							</ul></li>
					</ul>
				</nav>
			</div>
		</div>
	</header>
	<aside class="Hui-aside">
		<div class="menu_dropdown bk_2">
			<dl id="menu-article">
				<dt>
					<i class="Hui-iconfont">&#xe616;</i> 账户管理<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				<dd>
					<ul>
						<li><a data-href="#"
							data-title="账户列表" href="javascript:void(0)">账户列表</a></li>
					</ul>
				</dd>
			</dl>
			<dl id="menu-picture">
				<dt>
					<i class="Hui-iconfont">&#xe613;</i> 图片管理<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				<dd>
					<ul>
						<li><a data-href="picture-list.html" data-title="图片管理"
							href="javascript:void(0)">图片管理</a></li>
					</ul>
				</dd>
			</dl>
			<dl id="menu-product">
				<dt>
					<i class="Hui-iconfont">&#xe620;</i> 销售管理<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				<dd>
					<ul>
						
						<li><span style="margin-left: 24px;cursor:pointer;"
						onclick="cc1()" >客户管理</span></li>
						
							<ul id="ulty" style="display: none;">
								<li><a data-href="xscustomctrl/selectcustom.do"
									data-title="客户信息表"> <i class="Hui-iconfont">&#xe623;</i>&nbsp客户信息管理
								</a></li>
								<li><a data-href=" " data-title="客户流失表">
										<i class="Hui-iconfont">&#xe623;</i>&nbsp客户流失管理
								</a></li>
							</ul>
							<script>
							//样式的开启和关闭
							function cc1() {
								var ztty = document.getElementById("ulty").style.display;
								/* alert("这是我自己写的树状列表，你们需要的话就看代码，当前状态："+zt); */
								if (ztty == "none") {
									document.getElementById("ulty").style.display = "block";
								}
								if (ztty == "block") {
									document.getElementById("ulty").style.display = "none";
								}
							}
						</script>
						<li><a data-href="xssalectrl/selectxsOut.do" data-title="销售出库管理"
						href="javascript:void(0)">销售管理</a></li>
						
					</ul>
				</dd>
			</dl>
			
			<dl id="menu-comments">
			
				<dt>
					<i class="Hui-iconfont">&#xe70d;</i> 办公管理<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				
				<dd>
					<ul>
						<li><a data-href="Bgctrl/selectBgSms.do"
							data-title="短消息" href="javascript:;">
							<i class="Hui-iconfont">&#xe6c5;</i>&nbsp;短消息</a></li>
						<li><a data-href="Bgctrl/selectBgAssessIndex.do"
							data-title="考核指标" href="javascript:;">
							<i class="Hui-iconfont">&#xe6b6;</i>&nbsp;考核指标</a></li>
						<li><a data-href="Bgctrl/selectBgAssessTask.do" 
							data-title="发布任务" href="javascript:void(0)">
							<i class="Hui-iconfont">&#xe655;</i>&nbsp;发布任务</a></li>
						<li><span style="margin-left: 24px;cursor:pointer;"
							onclick="yangshi()" ><i class="Hui-iconfont">&#xe725;</i>&nbsp;查看任务</span>
							
							<ul id="ckrw" style="display: none;">
								<li><a data-href="Bgctrl/Querystate.do" data-title="查看未读任务"> 
									<i class="Hui-iconfont">&#xe6c4;</i>&nbsp;查看未读任务
								</a></li>
								
								<li><a data-href="Bgctrl/QueryComplete.do" data-title="查看未完成任务">
									<i class="Hui-iconfont">&#xe606;</i>&nbsp;查看未完成任务
								</a></li>
							</ul>
							
							<script>
							//样式的开启和关闭
							function yangshi() {
								var ckrwzt = document.getElementById("ckrw").style.display;
								if (ckrwzt == "none") {
									document.getElementById("ckrw").style.display = "block";
								}
								if (ckrwzt == "block") {
									document.getElementById("ckrw").style.display = "none";
								}
							}
							</script>
							<li><a data-href="<%=basePath%>Bgctrl/cs.do"
							data-title="个人日程" href="javascript:;">
							<i class="Hui-iconfont">&#xe72b;</i>&nbsp;个人日程</a></li>
					</ul>
					
				</dd>
				
			</dl>
			
			<dl>
				<dt>
					<i class="Hui-iconfont">&#xe600;</i> 采购管理<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				<dd>
					<ul>

						<li><span style="margin-left: 24px;cursor:pointer;"
							onclick="cc()">补货管理</span></li>
						<ul id="ul" style="display: none;">
							<li><a data-href="purctrl/seKcGoodsInfo.do"
								data-title="缺货商品表"> <i class="Hui-iconfont">&#xe623;</i>&nbsp缺货商品表
							</a></li>
							<li><a data-href="purctrl/selectcgr.do" data-title="需采购商品表">
									<i class="Hui-iconfont">&#xe623;</i>&nbsp需补货商品详情
							</a></li>
						</ul>
						<script>
							//样式的开启和关闭
							function cc() {
								var zt = document.getElementById("ul").style.display;
								/* alert("这是我自己写的树状列表，你们需要的话就看代码，当前状态："+zt); */
								if (zt == "none") {
									document.getElementById("ul").style.display = "block";
								}
								if (zt == "block") {
									document.getElementById("ul").style.display = "none";
								}
							}
						</script>
						<li><span style="margin-left: 24px;cursor:pointer;"
							onclick="ccz()">入库管理</span></li>
						<ul id="ulz" style="display:none;">
							<li><a data-href="purctrl/enter.do"
								data-title="未入库商品"> <i class="Hui-iconfont">&#xe623;</i>&nbsp入库单
							</a></li>
							<li><a data-href="purctrl/enterused.do" data-title="已入库商品">
									<i class="Hui-iconfont">&#xe623;</i>&nbsp已入库商品
							</a></li>
						</ul>
						<script>
							//样式的开启和关闭
							function ccz() {
								var zt = document.getElementById("ulz").style.display;
								/* alert("这是我自己写的树状列表，你们需要的话就看代码，当前状态："+zt); */
								if (zt == "none") {
									document.getElementById("ulz").style.display = "block";
								}
								if (zt == "block") {
									document.getElementById("ulz").style.display = "none";
								}
							}
						</script>
							<li><span style="margin-left: 24px;cursor:pointer;"
							onclick="cczy()">采购单管理</span></li>
						<ul id="ulzy" style="display:none;">
							<li><a data-href="purctrl/purlist.do"
								data-title="未处理采购单"> <i class="Hui-iconfont">&#xe623;</i>&nbsp采购单
							</a></li>
							<li><a data-href="purctrl/purlistused.do" data-title="已处理采购单">
									<i class="Hui-iconfont">&#xe623;</i>&nbsp已处理采购单
							</a></li>
						</ul>
						<script>
							//样式的开启和关闭
							function cczy() {
								var zt = document.getElementById("ulzy").style.display;
								/* alert("这是我自己写的树状列表，你们需要的话就看代码，当前状态："+zt); */
								if (zt == "none") {
									document.getElementById("ulzy").style.display = "block";
								}
								if (zt == "block") {
									document.getElementById("ulzy").style.display = "none";
								}
							}
						</script>
						<li><a data-href="purctrl/selectSup.do" data-title="供应商"
							href="javascript:;">供应商管理</a></li>
						<!-- <li><a data-href="member-level.html" data-title="等级管理" href="javascript:;">等级管理</a></li>
					<li><a data-href="member-scoreoperation.html" data-title="积分管理" href="javascript:;">积分管理</a></li>
					<li><a data-href="member-record-browse.html" data-title="浏览记录" href="javascript:void(0)">浏览记录</a></li>
					<li><a data-href="member-record-download.html" data-title="下载记录" href="javascript:void(0)">下载记录</a></li>
					<li><a data-href="member-record-share.html" data-title="分享记录" href="javascript:void(0)">分享记录</a></li> -->
					</ul>
				</dd>
			</dl>
			<dl id="menu-admin">
				<dt>
					<i class="Hui-iconfont">&#xe62d;</i> 余志豪<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				<dd>
					<ul>
					    <li><a data-href="xturolesctrl/selectUR.do" data-title="用户角色管理"
							href="javascript:void(0)">用户角色管理</a></li>
						<li><a data-href="xtrolesctrl/selectroles.do" data-title="角色管理"
							href="javascript:void(0)">角色管理</a></li>
						<li><a data-href="xtperctrl/selectper.do" data-title="权限管理"
							href="javascript:void(0)">权限管理</a></li>
						<li><a data-href="xtuserctrl/selectuser.do" data-title="管理员列表"
							href="javascript:void(0)">管理员列表</a></li>
							<li><a data-href="xtjournalctrl/selectJournal.do" data-title="系统日志"
							href="javascript:void(0)">系统日志</a></li>
					</ul>
				</dd>
			</dl>
			<dl id="menu-tongji">
				<dt>
					<i class="Hui-iconfont">&#xe61a;</i> 人事管理<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				<dd>
					<ul>
						<li><a data-href="Rsctrl/selectuserinfo.do" data-title="员工信息表"
							href="javascript:void(0)">员工信息表</a></li>
						<li><a data-href="Rsctrl/selectdepot.do" data-title="仓库管理"
							href="javascript:void(0)">仓库管理</a></li>
						<li><a data-href="Rsctrl/selectXtSection.do" data-title="部门信息表"
							href="javascript:void(0)">部门信息表</a></li>
						<li><a data-href="Rsctrl/selectCompany.do" data-title="公司管理"
							href="javascript:void(0)">公司管理</a></li>
						<li><a data-href="Rsctrl/selectDuties.do" data-title="职务表"
							href="javascript:void(0)">职务表</a></li>
						
					</ul>
				</dd>
			</dl>
			<dl id="menu-system">
				<dt>
					<i class="Hui-iconfont">&#xe62e;</i> 余志豪<i
						class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
				</dt>
				<dd>
					<ul>
						<li><a data-href="system-base.html" data-title="系统设置"
							href="javascript:void(0)">系统设置</a></li>
						<li><a data-href="system-category.html" data-title="栏目管理"
							href="javascript:void(0)">栏目管理</a></li>
						<li><a data-href="system-data.html" data-title="数据字典"
							href="javascript:void(0)">数据字典</a></li>
						<li><a data-href="system-shielding.html" data-title="屏蔽词"
							href="javascript:void(0)">屏蔽词</a></li>						
					</ul>
				</dd>
			</dl>
		</div>
	</aside>
	<div class="dislpayArrow hidden-xs">
		<a class="pngfix" href="javascript:void(0);"
			onClick="displaynavbar(this)"></a>
	</div>
	<section class="Hui-article-box">
		<div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
			<div class="Hui-tabNav-wp">
				<ul id="min_title_list" class="acrossTab cl">
					<li class="active">
					<span title="我的桌面" data-href="<%=basePath%>publicctrl/welcome.do?userId=${nowuser.userId}">我的桌面</span> <em></em></li>
				</ul>
			</div>
			<div class="Hui-tabNav-more btn-group">
				<a id="js-tabNav-prev" class="btn radius btn-default size-S"
					href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a
					id="js-tabNav-next" class="btn radius btn-default size-S"
					href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a>
			</div>
		</div>
		<div id="iframe_box" class="Hui-article">
			<div class="show_iframe">
				<div style="display:none" class="loading"></div>
				<iframe scrolling="yes" frameborder="0" src="<%=basePath%>publicctrl/welcome.do?userId=${nowuser.userId}"></iframe>
			</div>
		</div>
	</section>

	<div class="contextMenu" id="Huiadminmenu">
		<ul>
			<li id="closethis">关闭当前</li>
			<li id="closeall">关闭全部</li>
		</ul>
	</div>
	<script type="text/javascript">
/*个人信息*/
function myselfinfo(){
	layer.open({
		type: 1,
		area: ['300px','200px'],
		fix: false, //不固定
		maxmin: true,
		shade:0.4,
		title: '查看信息',
		content: '<div>管理员信息</div>'
	});
}

/*资讯-添加*/
function article_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*图片-添加*/
function picture_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*产品-添加*/
function product_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*用户-添加*/
function member_add(title,url,w,h){
	layer_show(title,url,w,h);
}
</script>
</body>
</html>