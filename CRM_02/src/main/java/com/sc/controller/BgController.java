package com.sc.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.sc.entity.BgAssessIndex;
import com.sc.entity.BgAssessTask;
import com.sc.entity.BgSms;
import com.sc.entity.BgSmsDetail;
import com.sc.entity.BgTaskDetail;
import com.sc.entity.XtUserInfo;
import com.sc.entity.XtUserNum;
import com.sc.service.BgService;
import com.sc.service.XtUserInfoService;
import com.sc.service.XtUserNumService;

@Controller
@RequestMapping("Bgctrl")
public class BgController {
	
	@Autowired
	BgService bgService;
	@Autowired
	XtUserInfoService xtUserInfoService;
	//XtUserInfo xtUserInfo;//登录者员工信息
	//XtUserNumService xtUserNumService;//登录账号密码
	
	
	//**********//
	//bgAssessIndex
	
	//分页查询
	@RequestMapping("selectBgAssessIndex.do")
	public ModelAndView selectBgAssessIndex(ModelAndView mav,@RequestParam(defaultValue="1") Integer pageNum,@RequestParam(defaultValue="5") Integer pageSize,BgAssessIndex bgAssessIndex,String sousuo){
		System.out.println("---进入查询控制器");
		System.out.println("---获取搜索框的值:"+sousuo);
			PageInfo<BgAssessIndex> page= bgService.selectBgAssessIndex(pageNum, pageSize, bgAssessIndex,sousuo);
			System.out.println(page);
			mav.addObject("p", page);
			mav.setViewName("BG/BgAssessIndex");
			return mav;
		
	}
	
	//添加
	@RequestMapping("addBgAssessIndex.do")
	@ResponseBody
	public void addBgAssessIndex(ModelAndView mav,BgAssessIndex bgAssessIndex) {
		System.out.println("2.进入添加控制器");
		System.out.println("添加获取到的数据:"+bgAssessIndex);
		
		Date date = new Date();
		bgAssessIndex.setLastModifyDtae(date);
		System.out.println(bgAssessIndex.getLastModifyDtae());
		
		SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println("当前时间"+dateFormat.format(date));
		bgAssessIndex.setLastModifyDtae(date);
		System.out.println(bgAssessIndex.getLastModifyDtae());
		
		bgService.addBgAssessIndex(bgAssessIndex);
		mav.setViewName("redirect:selectBgAssessIndex.do");
	}
	
	
	
	//通过id查询
	@RequestMapping("getBgAssessIndex.do")
	@ResponseBody
	public BgAssessIndex goupdateBgAssessIndex(long id) {
		System.out.println("---通过id获取考核指标");
		BgAssessIndex bgAssessIndex=bgService.getBgAssessIndex(id);
		System.out.println(bgAssessIndex);
		return bgAssessIndex;
	}
	
	//通过id查询,从其他页面查找
	@RequestMapping("getindexIdBgAssessIndex.do")
	public BgAssessIndex getindexIdBgAssessIndex(long indexId) {
		System.out.println("---通过id获取考核指标");
		BgAssessIndex bgAssessIndex=bgService.getBgAssessIndex(indexId);
		System.out.println(bgAssessIndex);
		return bgAssessIndex;
	}
	
	//修改考核任务
	@RequestMapping("updateBgAssessIndex.do")
	public ModelAndView updateBgAssessIndex(ModelAndView mav,BgAssessIndex bgAssessIndex) {
		System.out.println("---修改考核信息---");
		System.out.println("---修改获取到的数据:"+bgAssessIndex+"---"+bgAssessIndex.getIndexId());
		
		Date date = new Date();
		bgAssessIndex.setLastModifyDtae(date);
		
		bgService.updateBgAssessIndex(bgAssessIndex);
		mav.setViewName("redirect:selectBgAssessIndex.do");
		return mav;
	}
	
	//删除考核任务,批量删除
	@RequestMapping("deleteBgAssessIndex.do")
	public ModelAndView deleteBgAssessIndex(ModelAndView mav,BgAssessIndex bgAssessIndex,long[] id) {
		System.out.println("---删除考核信息---");
		if (id != null && id.length > 0) {
			for (Long long1 : id) {
				bgAssessIndex.setIndexId(long1);
				bgService.deleteBgAssessIndex(bgAssessIndex.getIndexId());
			}
		};
		
		mav.setViewName("redirect:selectBgAssessIndex.do");
		return mav;
	}
	
	
	
	//**********//
	//BgAssessTask
	
	
	//分页查询
	@RequestMapping("selectBgAssessTask.do")
	public ModelAndView selectBgTaskDetail(ModelAndView mav,
			@RequestParam(defaultValue="1") Integer pageNum,
			@RequestParam(defaultValue="5") Integer pageSize,
			BgAssessTask bgAssessTask,String sousuo){
		System.out.println("---进入selectBgAssessTask查询控制器");
		System.out.println("---分页查询发布任务");
		System.out.println("---获取搜索框的值:"+sousuo);
		PageInfo<BgAssessTask> pageInfo = bgService.selectBgAssessTask(pageNum, pageSize, bgAssessTask, sousuo);
		List<XtUserInfo> selectXtUserInfo = bgService.selectXtUserInfo();//在页面通过id获取员工姓名
		List<BgAssessIndex> selectBgAssessIndex = bgService.selectBgAssessIndex();//通过id查询考核名称
		System.out.println(pageInfo);
		
		//获取登录用户的id
		Subject subject = SecurityUtils.getSubject();// 获取主体
		XtUserNum nowuser = (XtUserNum) subject.getPrincipal();// 获取当前用户对象
		System.out.println("---登录用户的id："+nowuser.getStaffId());
		XtUserInfo userInof = xtUserInfoService.getXtUserInof(nowuser.getStaffId());
		System.out.println("---获取的登录员工信息："+userInof);
		
		mav.addObject("dluser", userInof);
		mav.addObject("user", selectXtUserInfo);
		mav.addObject("selectBgAssessIndex", selectBgAssessIndex);
		mav.addObject("p", pageInfo);
		mav.setViewName("BG/BgAssessTask");
		return mav;
	}
	
	
	//添加
	//查询考核任务，接受人，返回给添加页供选择
	@RequestMapping("goaddtBgAssessTask.do")
	@ResponseBody
	public Map<String, List<?>> goaddtBgAssessTask(){
		System.out.println("---进入goaddtBgAssessTask控制器");
		Map<String, List<?>> map = new HashMap<String, List<?>>();
		List<BgAssessIndex> selectBgAssessIndex = bgService.selectBgAssessIndex();
		List<BgAssessTask> selectBgAssessTask = bgService.selectBgAssessTask();
		List<XtUserInfo> selectXtUserInfo = bgService.selectXtUserInfo();
		System.out.println("---selectBgAssessTask"+selectBgAssessTask);
		System.out.println("---selectBgAssessIndex"+selectBgAssessIndex);
		System.out.println("---selectXtUserInfo"+selectXtUserInfo);
		map.put("selectBgAssessTask", selectBgAssessTask);
		map.put("selectBgAssessIndex", selectBgAssessIndex);
		map.put("selectXtUserInfo", selectXtUserInfo);
		return map;
	}
	
	
	//终极添加
	@RequestMapping("addBgAssessTask.do")
	public void addBgAssessTask(ModelAndView mav,BgAssessTask bgAssessTask,BgTaskDetail bgTaskDetail,Long[] id) {
		System.out.println("---addtBgAssessTask添加方法");
		System.out.println("--------------------------------独门标记");		
		//添加,考核任务，考核任务详情
		bgService.addbgAssessTask(bgAssessTask, bgTaskDetail,id);
		System.out.println();
	}
	
	//删除考核任务,批量删除
	@RequestMapping("deleteBgAssessTask.do")
	public ModelAndView deleteBgAssessTask(ModelAndView mav,long[] id) {
		System.out.println("---删除考核任务，加详情---");
		if (id != null && id.length > 0) {
			for (Long taskId : id) {
				BgAssessTask bgAssessTask=new BgAssessTask();
				//设置id后，找到删除
				System.out.println("---(考核任务)主键："+taskId);
				bgAssessTask.setTaskId(taskId);
				bgService.deleteBgAssessTask(taskId);
				
				//通过关联键找到数据，通过taskId找到数据
				BgTaskDetail bgTaskDetail = bgService.getBgTaskDetail(taskId);
				//通过关联的id，找到主键把相应关联表删除;
				System.out.println("---(考核任务详情)主键，编号:"+bgTaskDetail.getTaskDetailId());
				if(bgTaskDetail.getTaskDetailId()!=null){
					bgService.deleteBgTaskDetail(bgTaskDetail.getTaskDetailId());
				}
			}
		};
		mav.setViewName("redirect:selectBgAssessTask.do");
		return mav;
	}
	
	
	//分页查询，查看未完成任务
	@RequestMapping("QueryComplete.do")
	public ModelAndView QueryComplete(ModelAndView mav,
			@RequestParam(defaultValue="1") Integer pageNum,
			@RequestParam(defaultValue="100") Integer pageSize,
			BgAssessTask bgAssessTask,String sousuo){
		System.out.println("---进入QueryComplete查询控制器");
		System.out.println("---分页查看未完成任务");
		System.out.println("---获取搜索框的值:"+sousuo);
		PageInfo<BgAssessTask> pageInfo = bgService.selectBgAssessTask(pageNum, pageSize, bgAssessTask, sousuo);
		List<XtUserInfo> selectXtUserInfo = bgService.selectXtUserInfo();//在页面通过id获取员工姓名
		List<BgAssessIndex> selectBgAssessIndex = bgService.selectBgAssessIndex();//通过id查询考核名称
		System.out.println(pageInfo);
		
		//获取登录用户的id
		Subject subject = SecurityUtils.getSubject();// 获取主体
		XtUserNum nowuser = (XtUserNum) subject.getPrincipal();// 获取当前用户对象
		System.out.println("---登录用户的id："+nowuser.getStaffId());
		XtUserInfo userInof = xtUserInfoService.getXtUserInof(nowuser.getStaffId());
		System.out.println("---获取的登录员工信息："+userInof);
		
		
		mav.addObject("user", userInof);
		mav.addObject("selectBgAssessIndex", selectBgAssessIndex);
		mav.addObject("p", pageInfo);
		mav.setViewName("BG/QueryComplete");
		return mav;
	}
	
	//分页查询，查看未读任务
	@RequestMapping("Querystate.do")
	public ModelAndView Querystate(ModelAndView mav,
			@RequestParam(defaultValue="1") Integer pageNum,
			@RequestParam(defaultValue="100") Integer pageSize,
			BgAssessTask bgAssessTask,String sousuo){
		System.out.println("---进入Querystate查询控制器");
		System.out.println("---分页查看未读任务");
		System.out.println("---获取搜索框的值:"+sousuo);
		PageInfo<BgAssessTask> pageInfo = bgService.selectBgAssessTask(pageNum, pageSize, bgAssessTask, sousuo);
		List<XtUserInfo> selectXtUserInfo = bgService.selectXtUserInfo();//在页面通过id获取员工姓名
		List<BgAssessIndex> selectBgAssessIndex = bgService.selectBgAssessIndex();//通过id查询考核名称
		System.out.println(pageInfo);
		
		//获取登录用户的id
		Subject subject = SecurityUtils.getSubject();// 获取主体
		XtUserNum nowuser = (XtUserNum) subject.getPrincipal();// 获取当前用户对象
		System.out.println("---登录用户的id："+nowuser.getStaffId());
		XtUserInfo userInof = xtUserInfoService.getXtUserInof(nowuser.getStaffId());
		System.out.println("---获取的登录员工信息："+userInof);
		
		mav.addObject("user", userInof);
		mav.addObject("selectBgAssessIndex", selectBgAssessIndex);
		mav.addObject("p", pageInfo);
		mav.setViewName("BG/Querystate");
		
		
		
		return mav;
	}
	
	//获取状态，修改状态为已读
	@RequestMapping("updateQuerystate.do")
	public ModelAndView updateQuerystate(ModelAndView mav,long[] id) {
		System.out.println("---修改状态为已读");
			if (id != null && id.length > 0) {
				for (Long taskId : id) {
					//通过其条件查询
					BgTaskDetail bgTaskDetail = bgService.getBgTaskDetail(taskId);
					bgTaskDetail.setState("1");
					bgService.updateBgTaskDetail(bgTaskDetail);
				}
			}	
		mav.setViewName("redirect:Querystate.do");
		return mav;
	}
	
	//获取状态，将未完成修改为已完成
	@RequestMapping("updateQueryComplete.do")
	public ModelAndView updateQueryComplete(ModelAndView mav,long[] id) {
		System.out.println("---修改为已完成");
			if (id != null && id.length > 0) {
				for (Long taskId : id) {
					//通过其条件查询
					BgTaskDetail bgTaskDetail = bgService.getBgTaskDetail(taskId);
					bgTaskDetail.setWhetherComplete("1");
					bgService.updateBgTaskDetail(bgTaskDetail);
				}
			}	
		mav.setViewName("redirect:QueryComplete.do");
		return mav;
	}
	
	
	
	
	
//***************//
	//BgSms
	
	//分页查询短消息
	@RequestMapping("selectBgSms.do")
	public ModelAndView selectBgSms(ModelAndView mav,
			@RequestParam(defaultValue="1") Integer pageNum,
			@RequestParam(defaultValue="5") Integer pageSize,
			BgSms bgSms,String sousuo){
		System.out.println("---进入selectBgSms查询控制器");
		System.out.println("---分页查询短消息");
		System.out.println("---获取搜索框的值:"+sousuo);
		PageInfo<BgSms> pageInfo = bgService.selectBgSms(pageNum, pageSize, bgSms, sousuo);
		//获取用户信息
		List<XtUserInfo> selectXtUserInfo = bgService.selectXtUserInfo();//发布给员工短消息
		System.out.println(pageInfo);
		//多选下拉框的值
		String option = "";
		for (XtUserInfo xtUserInfo : selectXtUserInfo) {
			if(xtUserInfo!=null){
				option += "<option value='" + xtUserInfo.getWorkerId() + "'>" + xtUserInfo.getWorkerName() + "</option>";
			}
		}
		
		//获取登录用户的id
		Subject subject = SecurityUtils.getSubject();// 获取主体
		XtUserNum nowuser = (XtUserNum) subject.getPrincipal();// 获取当前用户对象
		System.out.println("---登录用户的id："+nowuser.getStaffId());
		XtUserInfo userInof = xtUserInfoService.getXtUserInof(nowuser.getStaffId());
		System.out.println("---获取的登录员工信息："+userInof);
		
		mav.addObject("selectuser", selectXtUserInfo);
		mav.addObject("option", option);
		mav.addObject("user", userInof);
		mav.addObject("p", pageInfo);
		mav.setViewName("BG/SendSMS");
		return mav;
	}
	
	
	//终极添加
	@RequestMapping("addBgSms.do")
	public ModelAndView addBgSms(ModelAndView mav,BgSms bgSms,BgSmsDetail bgSmsDetail,Long[] id) {
		System.out.println("---BgSms添加方法");
		System.out.println("---添加短消息,天机天假田鸡添加");		
		
		bgService.addBgSms(bgSms, bgSmsDetail, id);
		mav.setViewName("redirect:selectBgSms.do");
		return mav;
		
	}
	
	//获取状态，修改状态为已读
	@RequestMapping("updateBgSms.do")
	public ModelAndView updateBgSms(ModelAndView mav,long[] id) {
		System.out.println("---修改状态为已读，sms");
			if (id != null && id.length > 0) {
				for (Long smsId : id) {
					//通过其条件查询
					BgSmsDetail bgSmsDetail = bgService.getBgSmsDetail(smsId);
					bgSmsDetail.setInformationState("1");
					bgService.updateBgSmsDetail(bgSmsDetail);
				}
			}	
		mav.setViewName("redirect:selectBgSms.do");
		return mav;
	}
	
	//删除考核任务,批量删除
	@RequestMapping("deleteBgSms.do")
	public ModelAndView deleteBgSms(ModelAndView mav,long[] id) {
		System.out.println("---删除短消息，加详情---");
		if (id != null && id.length > 0) {
			for (Long smsId : id) {
				//设置id后，找到删除
				System.out.println("---(短消息)主键："+smsId);
				bgService.deleteBgSms(smsId); ;
				
				//通过关联键找到数据，通过smsId找到数据
				BgSmsDetail bgSmsDetail = bgService.getBgSmsDetail(smsId);
				//通过关联的id，找到主键把相应关联表删除;
				System.out.println("---(短消息详情)主键，编号:"+bgSmsDetail.getDetaileId());
				bgService.deleteBgSmsDetail(bgSmsDetail.getDetaileId());
			}
		}
		mav.setViewName("redirect:selectBgSms.do");
		return mav;
	}
	
	
	
	
	
	
	
//***************//
	//BgPersonageSchedule
	
	@RequestMapping("cs.do")
	public ModelAndView cs(ModelAndView mav){
		
		System.out.println("@@@@####$$$");
		mav.setViewName("BG/schedule");
		return mav;
	}
	
	
}
