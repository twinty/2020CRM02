package com.sc.controller;

import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.sc.entity.CgSupMsg;
import com.sc.entity.Massage;
import com.sc.entity.XsConRecord;
import com.sc.entity.XsConnect;
import com.sc.entity.XsCustom;
import com.sc.service.XsCustomService;

import oracle.net.aso.c;

@Controller
@RequestMapping("/xscustomctrl")
public class XsCustomController {
	
	@Autowired
	XsCustomService xsCustomService;
	
	/* ***************************************************************/
	/* **********************从这里开始是客户信息表**************************/
	//查询 客户信息
	@RequestMapping("/selectcustom.do")
	public ModelAndView selectCustom(ModelAndView mav,
			@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
			@RequestParam(defaultValue = "5") Integer pageSize,
			XsCustom custom){
		
		System.out.println("进入查询客户信息表的分页方法了"+custom);
		System.out.println("--------------最小输入时间"+custom.getDatemin());//因为扩展属性是后加的，随意这里单独打印出来作为调试
		System.out.println("--------------最大输入时间"+custom.getDatemax());
		
		PageInfo<XsCustom> page= xsCustomService.selectCustom(pageNum, pageSize, custom);
		
		for (XsCustom cc : page.getList()) {
			System.out.println("@@@@@@@@@@@@@@@@@"+cc);
		}
		
		
		mav.addObject("p", page);
		//要往页面上访问数据就往模型里装
		mav.addObject("cus", custom);//前属性名，后属性值
		mav.setViewName("ty_xs/custom_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
		return mav;
	}

	//添加客户信息的跳转页面
	@RequestMapping("/goaddcustom.do")
	public ModelAndView goselectCustom(ModelAndView mav,XsCustom custom){
		System.out.println("进入添加客户页面"+custom);
		
		//修改操作
		if(custom.getCustomId()!=null){ //如果获取得到Id的话，
			custom=xsCustomService.getCustom(custom.getCustomId()); //就通过id获得整个对象
		}
		mav.setViewName("ty_xs/custom_add");
		mav.addObject("custom", custom);
		return mav;
	}

	//添加 客户信息方法
	@RequestMapping("/addcustom.do")    
	@ResponseBody
	public Massage goaddCustom(ModelAndView mav,XsCustom custom){
		System.out.println("进入添加客户方法了"+custom);
		if(custom.getCustomId()!=null){ //如果获取得到Id的话，就修改
			xsCustomService.updateCustom(custom);
			System.out.println("@@@@@@@@@@@@@@@@ 修改成功"+custom);
		}else{
			xsCustomService.addCustom(custom);
			System.out.println("@@@@@@@@@@@@@@@@ 添加成功"+custom);
		}
		
		return new Massage("1","success","成功");
		
	}
	
	//删除客户信息方法
	@RequestMapping("/deletecustom.do")    //需要返回json，所以添加了一个message
	@ResponseBody   //ResponseBody 配message
	public Massage deleteCustom(ModelAndView mav,XsCustom custom){
		System.out.println("进入删除客户方法了"+custom);
		xsCustomService.deleteCustom(custom.getCustomId());
		return new Massage("2","success","成功");
		
	}

	//批量删除客户信息方法
	@RequestMapping("/deletecustomall.do")    
	public String deleteCustomAll(ModelAndView mav,Long[] ids){  /*复选框name=ids，方法参数也要是ids*/ 
		System.out.println("进入批量删除客户信息方法了"+Arrays.toString(ids));//把数组转换成字符串
		if (ids != null && ids.length > 0) {
			for (Long long1 : ids) {
				xsCustomService.deleteCustom(long1);
			}
		}
		//这里用重定向
		return "redirect:selectcustom.do";//修改的页面调处来
	}
	
	
	// 根据id查询客户信息
	@RequestMapping("/getCustombyid.do")
	@ResponseBody   /*没有它就不能从笑脸显示内容*/
	public XsCustom getCustom(Long id) { //这个地方请一定要注意，你这里url : "<%=basePath%>xscustomctrl/getCustombyid.do?id=" + id, 
		System.out.println("进入根据id查询客户信息方法了"+id); //给的是什么，这里就要是什么！！！！！！！两次了 哥
		XsCustom custom = xsCustomService.getCustom(id);
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&"+custom.getNextTime());
		return custom;
	}
	
	
	/* ***************************************************************/
	/* **********************从这里开始是联系人表**************************/

	// 根据id查询联系人
	@RequestMapping("/getConnectbyid.do")
	@ResponseBody   
	public XsConnect getConnectById(Long id) { //这个地方请一定要注意，你这里url : "<%=basePath%>xscustomctrl/getCustombyid.do?id=" + id, 
		
		System.out.println("进入根据id查询客户联系人方法了"+id); //给的是什么，这里就要是什么！！！！！！！两次了 哥
		XsConnect connect = xsCustomService.getXsConnect(id);
		return connect;
	}
		
	//通过客户ID查询联系记录表
	@RequestMapping("/selectconnect.do")
	public ModelAndView selectConnect(ModelAndView mav,
			@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
			@RequestParam(defaultValue = "5") Integer pageSize,
			Long id,String name){
		
		System.out.println("进入通过客户ID查询联系人表方法了"+id);
		XsConnect getXsConnect =xsCustomService.getXsConnect(id);
		PageInfo<XsConnect> page= xsCustomService.selectoneXsConnectByid(pageNum, pageSize, id,name);
		
		for (XsConnect cc : page.getList()) {
			System.out.println("@@@@@@@@@@@@@@@@@"+cc);
		}
		
		mav.addObject("id1", id);
		mav.addObject("con", getXsConnect);
		mav.addObject("page", page);		
		mav.setViewName("ty_xs/connect_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
		return mav;
	}
	/*这里测试的时候发现一个bug，因为没有带Id,所以再次提交的时候，整个页面会出现所有的detail*/	
	//直接查询联系人，不通过id（通过id的模糊查询不行）
	@RequestMapping("/selectconnect1.do")
	public ModelAndView selectConnect1(ModelAndView mav,
			@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
			@RequestParam(defaultValue = "5") Integer pageSize,
			 XsConnect xsconnect){
			
		System.out.println("进入直接查询联系人方法了，不通过客户ID"+xsconnect);
		PageInfo<XsConnect> page= xsCustomService.selectoneXsConnect(pageNum, pageSize, xsconnect);
			
		for (XsConnect cc : page.getList()) {
			System.out.println("@@@@@@@@@@@@@@@@@"+cc);
		}
		
		mav.addObject("page", page);
		//要往页面上访问数据就往模型里装
		mav.addObject("xsconnect", xsconnect);//前属性名，后属性值
		mav.setViewName("ty_xs/connect_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
		return mav;
		}
	
		//删除   联系人方法
		@RequestMapping("/deleteconnect.do")    //需要返回json，所以添加了一个message
		@ResponseBody   //ResponseBody 配message
		public Massage deleteConnect(ModelAndView mav,XsConnect xsConnect){
			System.out.println("进入删除联系人方法了"+xsConnect);
			xsCustomService.deleteConnect(xsConnect.getConnectId());
			return new Massage("2","success","成功");
			
		}
		
		//批量删除联系人  方法
		@RequestMapping("/deleteconnectall.do")    
		public String deleteConnectAll(ModelAndView mav,Long[] ids){  /*复选框name=ids，方法参数也要是ids*/ 
			System.out.println("进入批量删除客户联系人方法了"+Arrays.toString(ids));//把数组转换成字符串
			if (ids != null && ids.length > 0) {
				for (Long long1 : ids) {
					xsCustomService.deleteConnect(long1);
				}
			}
			//这里用重定向
			return "redirect:selectconnect.do";
		}
				
		//添加客户联系人  的跳转页面
		@RequestMapping("/goaddconnect.do")
		public ModelAndView goselectConnect(ModelAndView mav,XsConnect xsConnect){
			System.out.println("进入添加联系人页面"+xsConnect);
			
			//修改操作
			if(xsConnect.getConnectId()!=null){ //如果获取得到Id的话，
				xsConnect=xsCustomService.getXsConnect(xsConnect.getConnectId()); //就通过id获得整个对象
			}
			mav.setViewName("ty_xs/connect_add");
			mav.addObject("connect", xsConnect);
			return mav;
		}
		
		// 联系人 添加方法
		@RequestMapping("/addconnect.do")    
		@ResponseBody
		public Massage goaddConnect(ModelAndView mav,XsConnect xsConnect/*,
				HttpServletRequest req,HttpSession session*/){
			
			System.out.println("进入添加联系人方法了"+xsConnect);

		/*String customIdstr = req.getParameter("customId");
		Long customid = Long.parseLong(customIdstr);*/
			
			if(xsConnect.getConnectId()!=null){ //如果获取得到Id的话，就修改
				/*xsConnect.setCustomId(customid);*/
				xsCustomService.updateConnect(xsConnect);
				
			}else{
				/*xsConnect.setCustomId(customid);*/
				xsCustomService.addConnect(xsConnect);
			}
			return new Massage("1","success","成功");
		}
		
/********************************************************/
/************************以下是联系记录表********************************/
		// 根据id查询联系人
		@RequestMapping("/getconRecordbyid.do")
		@ResponseBody   
		public XsConRecord getConRecordById(Long id) { //这个地方请一定要注意，你这里url : "<%=basePath%>xscustomctrl/getCustombyid.do?id=" + id, 
			
			System.out.println("进入根据id查询联系记录方法了"+id); //给的是什么，这里就要是什么！！！！！！！两次了 哥
			XsConRecord conRecord = xsCustomService.getConRecord(id);
			return conRecord;
		}
			
		//通过客户ID查询联系人表
		@RequestMapping("/selectconRecord.do")
		public ModelAndView selectConRecord(ModelAndView mav,
				@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
				@RequestParam(defaultValue = "5") Integer pageSize,
				Long id){
			
			System.out.println("进入通过客户ID查询联系记录表方法了"+id);
			XsConRecord ConRecord=xsCustomService.getConRecord(id);// 根据id查询联系人
			PageInfo<XsConRecord> page= xsCustomService.selectoneConRecordByid(pageNum, pageSize, id);
			
			for (XsConRecord cc : page.getList()) {
				System.out.println("@@@@@@@@@@@@@@@@@"+cc);
			}
			
			mav.addObject("id1", id);
			mav.addObject("ConRecord", ConRecord);
			mav.addObject("page", page);		
			mav.setViewName("ty_xs/ConRecord_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
			return mav;
		}
		/*这里测试的时候发现一个bug，因为没有带Id,所以再次提交的时候，整个页面会出现所有的detail*/	
		//直接查询联系人，不通过id（通过id的模糊查询不行）
		@RequestMapping("/selectConRecord1.do")
		public ModelAndView selectConRecord1(ModelAndView mav,
				@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
				@RequestParam(defaultValue = "5") Integer pageSize,
				XsConRecord conRecord){
				
			System.out.println("进入直接查询联系记录方法了，不通过客户ID"+conRecord);
			PageInfo<XsConRecord> page= xsCustomService.selectConRecord(pageNum, pageSize, conRecord);
				
			for (XsConRecord cc : page.getList()) {
				System.out.println("@@@@@@@@@@@@@@@@@"+cc);
			}
			
			mav.addObject("page", page);
			//要往页面上访问数据就往模型里装
			mav.addObject("c", conRecord);//前属性名，后属性值
			mav.setViewName("ty_xs/ConRecord_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
			return mav;
			}
		
			//删除   联系人方法
			@RequestMapping("/deleteconRecord.do")    //需要返回json，所以添加了一个message
			@ResponseBody   //ResponseBody 配message
			public Massage deleteConRecord(ModelAndView mav,XsConRecord conRecord){
				System.out.println("进入删除联系记录方法了"+conRecord);
				xsCustomService.deleteConnect(conRecord.getConRecordId());
				return new Massage("2","success","成功");
				
			}
			
			//批量删除联系人  方法
			@RequestMapping("/deleteconRecordtall.do")    
			public String deleteConRecordtAll(ModelAndView mav,Long[] ids){  /*复选框name=ids，方法参数也要是ids*/ 
				System.out.println("进入批量删除联系记录方法了"+Arrays.toString(ids));//把数组转换成字符串
				if (ids != null && ids.length > 0) {
					for (Long long1 : ids) {
						xsCustomService.deleteConRecord(long1);
					}
				}
				//这里用重定向
				return "redirect:selectconRecord.do";
			}
					
			//添加记录  的跳转页面
			@RequestMapping("/goaddconRecord.do")
			public ModelAndView goselectConRecord(ModelAndView mav,XsConRecord conRecord){
				System.out.println("@@@@@@@@@@@@@@@@@@@"+conRecord.getCustomId());
				
				//修改操作
				if(conRecord.getConRecordId()!=null){ //如果获取得到Id的话，
					conRecord=xsCustomService.getConRecord(conRecord.getConRecordId()) ;//就通过id获得整个对象
				}
				mav.setViewName("ty_xs/conRecord_add");
				mav.addObject("conRecord", conRecord);
				return mav;
			}
		
			// 联系记录 添加方法
			@RequestMapping("/addconRecord.do")    
			@ResponseBody
			public Massage goaddConRecord(ModelAndView mav,XsConRecord conRecord,
					HttpServletRequest req,HttpSession session
					){
				String customIdstr = req.getParameter("customIdty");
				Long customid = Long.parseLong(customIdstr);

				if(conRecord.getConRecordId()!=null){ //如果获取得到Id的话，就修改
					conRecord.setCustomId(customid);
					xsCustomService.updateConRecord(conRecord);
				}else{
				    
				    conRecord.setCustomId(customid);
					xsCustomService.addConRecord(conRecord);
					System.out.println("**********************添加成功"+conRecord);
					
					//根据customid 查询客户信息
					XsCustom custom=xsCustomService.getCustom(conRecord.getCustomId());
					
					System.out.println("时间未修改之前"+custom);
					//获取一个Calendar对象,并进行时间的计算
					Calendar c1 = Calendar.getInstance();
					//将下一次联系时间输入Calendar对象时间
					c1.setTime(custom.getNextTime());
					//时间加7
				/*	c1.add(Calendar.DAY_OF_MONTH, +7);*/
					c1.add(Calendar.DATE, 7);
					System.out.println("****************"+c1.getTime());
					//新时间存入custom
					custom.setNextTime(c1.getTime());
					System.out.println("时间修改之hou"+custom);
					//更新
					xsCustomService.updateCustom(custom);
			
			}
				return new Massage("2","success","成功");	
			}
}
