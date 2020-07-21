package com.sc.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.sc.entity.CgRepGoods;
import com.sc.entity.CgSupMsg;
import com.sc.entity.KcGoodsInfo;
import com.sc.entity.KcWarehouseInfo;
import com.sc.entity.Massage;
import com.sc.entity.XsCustom;
import com.sc.entity.XtCompanyInfo;
import com.sc.entity.XtDutiesInfo;
import com.sc.entity.XtSection;
import com.sc.entity.XtUserInfo;
import com.sc.service.CgService;
import com.sc.service.KcGoodsInfoService;
import com.sc.service.KcWareHouseInfoService;
import com.sc.service.XtCompanyInfoService;
import com.sc.service.XtDutiesInfoServic;
import com.sc.service.XtDutiesInfoService;
import com.sc.service.XtSectionService;
import com.sc.service.XtUserInfoService;
@Controller
@RequestMapping("/Rsctrl")
public class RsController {
	@Autowired
	XtUserInfoService xtUserInfoService;

	@Autowired
	KcWareHouseInfoService kcWareHouseInfoService;
	
	@Autowired
	CgService cgService;
	
	@Autowired
	KcGoodsInfoService kcGoodsInfoService;
	
	//职务
	@Autowired
	XtDutiesInfoServic xtDutiesInfoServic;
	//公司
	@Autowired
	XtCompanyInfoService xtCompanyInfoService;
	
	//.添加部门信息  XT_SECTION 系统部门表
	@Autowired
	XtSectionService xtSectionService;
	
	//.职务信息  Xt_DutiesInfo 系统部门表
	@Autowired
	XtDutiesInfoService xtDutiesInfoService;
	
	// 解决页面用get传过来date时间格式是string类型的错误
		@InitBinder
		public void initBinder(ServletRequestDataBinder bin) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			CustomDateEditor cust = new CustomDateEditor(sdf, true);
			bin.registerCustomEditor(Date.class, cust);
		}
		
		// 查询员工信息表分页方法
		@RequestMapping("/selectuserinfo.do")
		public ModelAndView selectuserinfo(ModelAndView mav, 
				@RequestParam(defaultValue = "1") Integer pageNum,
				@RequestParam(defaultValue = "10") Integer pageSize,
				XtUserInfo userInfo) {
			System.out.println("进入查询员工信息表分页方法了");
			userInfo.setLastModifyDate(new Date());
			PageInfo<XtUserInfo> page = xtUserInfoService.selectXtUserInof(pageNum, pageSize, userInfo);
			System.out.println(page.getList());
			mav.addObject("p", page);
			mav.setViewName("wwj_rs/XtUserInfo_list1");
			return mav;
		}
		
		//查询单个员工的信息明细
		@RequestMapping("/selectuserid.do")
		@ResponseBody
		public XtUserInfo selectuserid(Long id ){
			System.out.println("进入员工详情页面");
			XtUserInfo UserInfo= xtUserInfoService.getXtUserInof(id);
			return UserInfo;
		}
		
	
		
		//修改员工的信息明细
		@RequestMapping("/updateuserid.do")
		@ResponseBody
		public ModelAndView updateuserid(ModelAndView mav,MultipartFile upload,HttpSession session,
				HttpServletRequest req, XtUserInfo userInfo ) throws IllegalStateException, IOException{
			System.out.println("进入员工修改页面");
			userInfo.setLastModifyDate(new Date());
			if(upload!=null){
				String name= upload.getOriginalFilename();//文件名称
				if(name!=null&&!name.equals("")){
					// 文件上传
					String path = session.getServletContext().getRealPath("upload");
					String ext = name.substring(name.lastIndexOf("."));// .jpg
					name = System.currentTimeMillis() + ext;// 2343643654.jpg
					File f=new File(path + "/" + name);// 路径+文件名的文件对象
					upload.transferTo(f);// 另存为
				}
				userInfo.setWorkerPhoto(name);
			}
			this.xtUserInfoService.updateXtUserInof(userInfo);
			// 重定向到当前控制器的查询方法，所以写的是查询方法的url地址ַ
			mav.setViewName("redirect:selectuserinfo.do");
		
			return mav;
		}
		
		// 添加员工信息
		@RequestMapping("/add.do")
		public ModelAndView add(ModelAndView mav, XtUserInfo userInfo, MultipartFile upload, HttpSession session)
				throws IllegalStateException, IOException {
			userInfo.setLastModifyDate(new Date());
            System.out.println("wwwwwwwwwwwwwwwwwwwwwwwwww");
			if (upload != null) {
				
				String name = upload.getOriginalFilename();// 1.jpg
				System.out.println("@@@@@@@@"+name);
				if (name != null && !name.equals("")) {// 用户选择文件了
					String path = session.getServletContext().getRealPath("upload");
					String ext = name.substring(name.lastIndexOf("."));// .jpg
					name = System.currentTimeMillis() + ext;// 2343643654.jpg
					upload.transferTo(new File(path + "/" + name));// 复制文件到服务器
					userInfo.setWorkerPhoto(name);
				}
			}
			xtUserInfoService.addXtUserInof(userInfo);// 添加用户
			mav.setViewName("redirect:selectuserinfo.do");// 重定向到该类的list方法
			return mav;
		}
		
		
	
		
		// 供应批量删除+删除
		@RequestMapping("/deletsup.do")
		public ModelAndView deletsup(ModelAndView mav, Long[] id) {
			if (id != null && id.length > 0) {
				for (Long long1 : id) {
					xtUserInfoService.deleteXtUserInof(long1);
				}
			}
			mav.setViewName("redirect:selectuserinfo.do");
			return mav;
		}
		
		// 模糊查询员工
		@RequestMapping("/selectSup.do")
		public ModelAndView selectSup(ModelAndView mav, @RequestParam(defaultValue = "1") Integer pageNum,
				@RequestParam(defaultValue = "10") Integer pageSize, String name) {
			PageInfo<XtUserInfo> suplist = xtUserInfoService.selectSup(pageNum, pageSize, name);
			for (XtUserInfo cs : suplist.getList()) {
				System.out.println("@@@@@@@"+cs);
			}
			String temp = "yes";
			List<XtUserInfo> list = suplist.getList();
			if (list.size() == 0) {
				temp = "no";
			}
			if (name != null) {
				mav.addObject("ssz", name);
			}
			mav.addObject("temp", temp);
			mav.addObject("p", suplist);			
			mav.setViewName("wwj_rs/XtUserInfo_list1");
			return mav;
		}
		
	
		
		// 查询仓库的分页方法
		@RequestMapping("/selectdepot.do")
		public ModelAndView selectDepot(ModelAndView mav,
				@RequestParam(defaultValue="1") Integer pageNum, 
				@RequestParam(defaultValue="10") Integer pageSize,
				KcWarehouseInfo houseInfo){
			System.out.println("进入查询仓库分页方法了:"+houseInfo);
			System.out.println("--------------最小输入时间"+houseInfo.getDatemin());//因为扩展属性是后加的，随意这里单独打印出来作为调试
			System.out.println("--------------最大输入时间"+houseInfo.getDatemax());
			
			
            PageInfo<KcWarehouseInfo> page = kcWareHouseInfoService.selecthouse(pageNum, pageSize, houseInfo);
            for (KcWarehouseInfo cc : page.getList()) {
    			System.out.println("@@@@@@@@@@@@@@@@@"+cc);
    		}
            
			mav.addObject("p", page);
			mav.addObject("depot", houseInfo);
			mav.setViewName("wwj_rs/KcHouse-list");// /WEB-INF/wwj_rs/KcHouse-list.jsp
			
			return mav;
		}
		
		@RequestMapping("/goadddepot.do")
		public ModelAndView goAddDepot(ModelAndView mav,KcWarehouseInfo useInfo){
			System.out.println("进入添加页面:"+useInfo);
			
			//修改操作
			if(useInfo.getWarehouseId()!=null){
				useInfo=kcWareHouseInfoService.gethouse(useInfo.getWarehouseId());
			}
			
	        mav.setViewName("wwj_rs/KcHouse-add");// /WEB-INF/kc/cpdepot-add.jsp
	        mav.addObject("depot", useInfo);
	        return mav;
		}
		
		@RequestMapping("/adddepot.do")
		@ResponseBody
		public Massage addDepot(ModelAndView mav,KcWarehouseInfo depot){
			System.out.println("进入添加仓库:"+depot);
			if(depot.getWarehouseId()!=null){//修改操作
				kcWareHouseInfoService.updatehouse(depot);
			}else{//添加操作
				kcWareHouseInfoService.addhouse(depot);
			}
			return  new Massage("1", "success", "成功");
		}
		
		//仓库的删除
		@RequestMapping("/deletedepot.do")
		@ResponseBody
		public Massage deleteDepot(ModelAndView mav,KcWarehouseInfo depot){
			System.out.println("进入删除仓库:"+depot);
			kcWareHouseInfoService.deletehouse(depot.getWarehouseId());
			return new Massage("1", "success", "成功");
		}
		
		//批量删除
		@RequestMapping("/deletedepotall.do")
		public String deleteDepotAll(ModelAndView mav,Long[]  ids){
			System.out.println("进入批量删除:"+Arrays.toString(ids));
			if(ids!=null&&ids.length>0){
				for (Long id : ids) {
					kcWareHouseInfoService.deletehouse(id);
				}
			}
			
			return "redirect:selectdepot.do";
		}
		

		
		
		
  //.查看部门信息  XT_SECTION 系统部门表
	@RequestMapping("/selectXtSection.do")
	public ModelAndView selectXtSection(ModelAndView mav, 
			@RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "10") Integer pageSize,
			XtSection Section) {
		System.out.println("进入部门表信息表分页方法了");
		
		PageInfo<XtSection> page = xtSectionService.selectXtSection(pageNum, pageSize, Section);
		System.out.println(page.getList());
		mav.addObject("p", page);
		mav.setViewName("wwj_rs/XtSection_list");
		return mav;
	}
	
	 //添加部门信息  XT_SECTION 系统部门表
	@RequestMapping("/addSection.do")
	public ModelAndView addSection(ModelAndView mav,XtSection s){
		 s.setLastModifyDate(new Date());
		 xtSectionService.addXtSectton(s);	
		 mav.setViewName("redirect:selectXtSection.do");
		return mav;	
	}
	
	// 模糊查询部门
	@RequestMapping("/selectSection.do")
	public ModelAndView selectSection(ModelAndView mav, @RequestParam(defaultValue = "1") Integer pageNum,
		@RequestParam(defaultValue = "10") Integer pageSize, String name) {
		PageInfo<XtSection> suplist = xtSectionService.selectXtSectionM(pageNum, pageSize, name);
		for (XtSection cs : suplist.getList()) {
			System.out.println("@@@@@@@"+cs);
		}
		String temp = "yes";
		List<XtSection> list = suplist.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		if (name != null) {
			mav.addObject("ssz", name);
		}
		mav.addObject("temp", temp);
		mav.addObject("p", suplist);			
		mav.setViewName("wwj_rs/XtSection_list");
		return mav;
	}
	
	
	
	// 模糊查询职务表
	@RequestMapping("/selectDutiesInfo.do")
	public ModelAndView selectDutiesInfo(ModelAndView mav, @RequestParam(defaultValue = "1") Integer pageNum,
		@RequestParam(defaultValue = "10") Integer pageSize, String name) {
		PageInfo<XtDutiesInfo> suplist = xtDutiesInfoService.seleteXtDutiesInfo(pageNum, pageSize, name);
		for (XtDutiesInfo cs : suplist.getList()) {
			System.out.println("@@@@@@@"+cs);
		}
		String temp = "yes";
		List<XtDutiesInfo> list = suplist.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		if (name != null) {
			mav.addObject("ssz", name);
		}
		mav.addObject("temp", temp);
		mav.addObject("p", suplist);			
		mav.setViewName("wwj_rs/XtDutiesInfo_list");
		return mav;
	}
	
	//<<<<<<<<<<<<<<<<<<<<<商品表的操作《》《》《》《》《》《》《》《》《》《》《》《》
	// 模糊查询商品表
			@RequestMapping("/selectgoodsInfo.do")
			public ModelAndView selectgoodsInfo(ModelAndView mav,
					@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
					@RequestParam(defaultValue = "10") Integer pageSize,
					KcGoodsInfo goodsInfo,String name,Long id){
				PageInfo<KcGoodsInfo> suplist =kcGoodsInfoService.selectGoodsInfoByid1(pageNum, pageSize, name, id);
				System.out.println("进入查询客户信息表的分页方法了"+goodsInfo);
				for (KcGoodsInfo cs : suplist.getList()) {
					System.out.println("@@@@@@@"+cs);
				}
				String temp = "yes";
				List<KcGoodsInfo> list = suplist.getList();
				if (list.size() == 0) {
					temp = "no";
				}
				if (name != null) {
					mav.addObject("ssz", name);
				}
				if (id != null) {
					mav.addObject("ssz", id);
				}
				
				mav.addObject("temp", temp);
				mav.addObject("p", suplist);	
				mav.setViewName("wwj_rs/KcGoodsInfo_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
				return mav;
			}
			
			
			//根据仓库的id查询所在仓库的商品
			@RequestMapping("/gogoods.do")
			public ModelAndView goGoods(ModelAndView mav,KcWarehouseInfo huseInfo,HttpSession session,
					@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
					@RequestParam(defaultValue = "10") Integer pageSize,
					KcGoodsInfo goodsInfo){
				
				
				//把BigDecimal 转换成 Long数据类型
				//获取到商品表中仓库的编号，并且把BigDecimal 转换成 Long数据类型（这里商品表中仓库的编号和仓库表中商品的编号不同
				                                               //所以要转换）
		        Long ckid = goodsInfo.getWarehouseId().longValue();
			    //获取到仓库ID
			    KcWarehouseInfo gethouse = kcWareHouseInfoService.gethouse(ckid);
			    
				PageInfo<KcGoodsInfo> page= kcGoodsInfoService.selectGoodsInfo(pageNum, pageSize, goodsInfo);
				mav.addObject("ck", gethouse);
				mav.addObject("p", page);
				mav.setViewName("wwj_rs/KcGoodsInfo_list");	
				session.setAttribute("nowhuseInfoid", huseInfo.getWarehouseId());//session.getAttribute("nowhuseInfoid")
				
				return mav;
			}	
			
			

			//添加商品的跳转页面
			@RequestMapping("/goaddgoods.do")
			public ModelAndView goselectCustom(ModelAndView mav,KcGoodsInfo goodsInfo){
				System.out.println("进入添加商品页面"+goodsInfo);
				
				//修改操作
				if(goodsInfo.getProductId()!=null){ //如果获取得到Id的话，
					goodsInfo=kcGoodsInfoService.getGoodsInfo(goodsInfo.getProductId()); //就通过id获得整个对象
				}
				mav.setViewName("wwj_rs/KcGoodsadd");
				mav.addObject("g", goodsInfo);
				return mav;
			}
			
			//添加方法
			@RequestMapping("/addcustom.do")    
			@ResponseBody
			public Massage goaddCustom(ModelAndView mav,KcGoodsInfo goodsInfo){
				System.out.println("进入添加客户方法了"+goodsInfo);
				if(goodsInfo.getProductId()!=null){ //如果获取得到Id的话，就修改
					kcGoodsInfoService.updateGoodsInfo(goodsInfo);
				}
				
				
				return new Massage("1","success","成功");
				
			}
			
			// 修改商品
			@RequestMapping("/updategoods.do")
			public ModelAndView updategoods(ModelAndView mav, KcGoodsInfo goodsInfo) {
				goodsInfo.setLastModifyDate(new Date());
				
				System.out.println("*******"+goodsInfo);
				System.out.println("测试一下");
				kcGoodsInfoService.updateGoodsInfo(goodsInfo);
				mav.setViewName("redirect:selectgoodsInfo.do");
				return mav;
			}
			
			//商品的批量删除
					@RequestMapping("/deletegoodsAll.do")
					public String deletegoodsAll(ModelAndView mav,Long[]  ids){
						System.out.println("进入批量删除:"+Arrays.toString(ids));
						if(ids!=null&&ids.length>0){
							for (Long id : ids) {
								kcGoodsInfoService.deletehouse(id);
							}
						}
						
						return "redirect:selectgoodsInfo.do";
					}
					
				
					
					//查询商品的信息明细
					@RequestMapping("/selectgoodsxq.do")
					@ResponseBody
					public KcGoodsInfo selectgoodsxq(Long id ){
						System.out.println("进入商品详情页面");
						KcGoodsInfo GoodsInfo= kcGoodsInfoService.getGoodsInfo(id);
						return GoodsInfo;
					}
//<<<<<<<<<<<<<<<<<<<<<商品表的操作《》《》《》《》《》《》《》《》《》《》《》《》
	
//<<<<<<<<<<<<<<<<<<<<<公司表的操作《》《》《》《》《》《》《》《》《》《》《》《》
					
	// 模糊查询公司
	@RequestMapping("/selectCompany.do")
	public ModelAndView selectCompany(ModelAndView mav,
			@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
			@RequestParam(defaultValue = "10") Integer pageSize,
			XtCompanyInfo companyInfo,String name){
		PageInfo<XtCompanyInfo> suplist =xtCompanyInfoService.selectCompanyInfo(pageNum, pageSize, name);
		System.out.println("进入查询客户信息表的分页方法了"+companyInfo);
		for (XtCompanyInfo cs : suplist.getList()) {
			System.out.println("@@@@@@@"+cs);
		}
		String temp = "yes";
		List<XtCompanyInfo> list = suplist.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		if (name != null) {
			mav.addObject("ssz", name);
		}
		mav.addObject("temp", temp);
		mav.addObject("page", suplist);	
		mav.setViewName("wwj_rs/XtCompanyInfo_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
		return mav;
	}				
	

	//查询公司的信息明细
	@RequestMapping("/selectCompanyid.do")
	@ResponseBody
	public XtCompanyInfo selectCompanyid(Long id ){
		System.out.println("进入公司详情页面");
		XtCompanyInfo CompanyInfo = xtCompanyInfoService.getCompanyInfo(id);
		return CompanyInfo;
	}				
	
	// 修改商品
	@RequestMapping("/updateCompany.do")
	public ModelAndView updateCompany(ModelAndView mav, XtCompanyInfo CompanyInfo) {
		CompanyInfo.setLastModifyDate(new Date());
		
		System.out.println("*******"+CompanyInfo);
		System.out.println("测试一下");
		xtCompanyInfoService.updateCompanyInfo(CompanyInfo);
		mav.setViewName("redirect:selectCompany.do");
		return mav;
	}					
	
	// 录入公司信息
		@RequestMapping("/addCompany.do")
		public ModelAndView addCompany(ModelAndView mav, XtCompanyInfo CompanyInfo) {
			CompanyInfo.setLastModifyDate(new Date());
			xtCompanyInfoService.addCompanyInfo(CompanyInfo);
			mav.setViewName("redirect:selectCompany.do");
			return mav;
		}	
		
		
		// 供应批量删除+删除
				@RequestMapping("/deletsup1.do")
				public ModelAndView deletsup1(ModelAndView mav, Long[] id) {
					
					System.out.println("%%%%%%%%%%%%");
					if (id != null && id.length > 0) {
						for (Long long1 : id) {
							xtCompanyInfoService.delectCompanyInfo(long1);
						}
					}
					mav.setViewName("redirect:selectCompany.do");
					return mav;
				}
	
				
				// 商品导出excel
				@RequestMapping("/daochu.do")
				public void goodsExcel(HttpServletResponse response) {
					XSSFWorkbook wb = kcGoodsInfoService.show();
					String fileName = "商品信息.xlsx";// 后缀要加创建出来的文件形式才是以xlsx后最的文件
					OutputStream outputStream = null;// 字符输出流
					try {
						fileName = URLEncoder.encode(fileName, "UTF-8");
						// 设置ContentType请求信息格式
						response.setContentType("application/vnd.ms-excel");
						response.setHeader("Content-disposition", "attachment;filename=" + fileName);
						outputStream = response.getOutputStream();
						wb.write(outputStream);
						outputStream.flush();
						outputStream.close();
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
	
//<<<<<<<<<<<<<<<<<<<<<公司表的操作《》《》《》《》《》《》《》《》《》《》《》《》
				
//<<<<<<<<<<<<<<<<<<<<<职务表的操作《》《》《》《》《》《》《》《》《》《》《》《》
// 模糊查询职务
@RequestMapping("/selectDuties.do")
public ModelAndView selectDutiesy(ModelAndView mav,
		@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
		@RequestParam(defaultValue = "10") Integer pageSize,
		XtDutiesInfo DutiesInfo,String name){
	PageInfo<XtDutiesInfo> suplist =xtDutiesInfoServic.selectDutiesInfo(pageNum, pageSize, DutiesInfo, name);
	System.out.println("进入查询客户信息表的分页方法了"+DutiesInfo);
	for (XtDutiesInfo cs : suplist.getList()) {
		System.out.println("@@@@@@@"+cs);
	}
	String temp = "yes";
	List<XtDutiesInfo> list = suplist.getList();
	if (list.size() == 0) {
		temp = "no";
	}
	if (name != null) {
		mav.addObject("ssz", name);
	}
	mav.addObject("temp", temp);
	mav.addObject("page", suplist);	
	mav.setViewName("wwj_rs/XtDutiesInfo_list"); //在application.yml里面配置了，   前缀/WEB-INF  /   ty/custom_list    .jsp后缀
	return mav;
}		
				
				
//查询职务的信息明细
	@RequestMapping("/selectDutiesInfo1.do")
	@ResponseBody
	public XtDutiesInfo selectDutiesInfo1(Long id ){
		System.out.println("进入公司详情页面");
		XtDutiesInfo DutiesInfo = xtDutiesInfoServic.getDutiesInfo(id);
		return DutiesInfo;
	}				
	
	// 修改商品
	@RequestMapping("/updateDutiesInfo.do")
	public ModelAndView updateDutiesInfo(ModelAndView mav, XtDutiesInfo DutiesInfo) {
		DutiesInfo.setLastModifyDate(new Date());
		
		System.out.println("*******"+DutiesInfo);
		System.out.println("测试一下");
		xtDutiesInfoServic.updateDutiesInfo(DutiesInfo);
		mav.setViewName("redirect:selectDutiesInfo.do");
		return mav;
	}					
	
	// 录入职务信息
		@RequestMapping("/addDutiesInfo.do")
		public ModelAndView addDutiesInfo(ModelAndView mav, XtDutiesInfo DutiesInfo) {
			DutiesInfo.setLastModifyDate(new Date());
			xtDutiesInfoServic.addDutiesInfo(DutiesInfo);
			mav.setViewName("redirect:selectDuties.do");
			return mav;
		}	
		
		
		// 供应批量删除+删除
				@RequestMapping("/deletsup2.do")
				public ModelAndView deletsup2(ModelAndView mav, Long[] id) {
					
					System.out.println("%%%%%%%%%%%%");
					if (id != null && id.length > 0) {
						for (Long long1 : id) {
							xtDutiesInfoServic.delectDutiesInfo(long1);
						}
					}
					mav.setViewName("redirect:selectDuties.do");
					return mav;
				}
					
				
				
				
//<<<<<<<<<<<<<<<<<<<<<职务表的操作《》《》《》《》《》《》《》《》《》《》《》《》		
//<<<<<<<<<<<<<<<<<<<<<多表的操作的操作《》《》《》《》《》《》《》《》《》《》《》《》			
				//根据仓库的id查询所在仓库的商品
				@RequestMapping("/gogouser.do")
				public ModelAndView gouser(ModelAndView mav,XtCompanyInfo CompanyInfo,HttpSession session,
						@RequestParam(defaultValue = "1") Integer pageNum,//假如没有传参数，给一个默认值
						@RequestParam(defaultValue = "10") Integer pageSize,
						XtUserInfo UserInfo ){
					
					
					//把BigDecimal 转换成 Long数据类型
					//获取到商品表中仓库的编号，并且把BigDecimal 转换成 Long数据类型（这里商品表中仓库的编号和仓库表中商品的编号不同
					                                               //所以要转换）
			        Long gsId = UserInfo.getCompanyId().longValue();
				    //获取到仓库ID
			        XtCompanyInfo getCompany = xtCompanyInfoService.getCompanyInfo(gsId);
				    
					PageInfo<XtUserInfo> page= xtUserInfoService.selectXtUserInof(pageNum, pageSize, UserInfo);
					mav.addObject("ck", UserInfo);
					mav.addObject("p", page);
					mav.setViewName("wwj_rs/KcGoodsInfo_list");	
					session.setAttribute("nowhuseInfoid", UserInfo.getCompanyId());//session.getAttribute("nowhuseInfoid")
					
					return mav;
				}	
							
				
}

