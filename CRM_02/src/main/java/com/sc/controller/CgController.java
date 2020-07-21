package com.sc.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.github.pagehelper.PageInfo;
import com.sc.entity.CgOrder;
import com.sc.entity.CgOrderDetail;
import com.sc.entity.CgRepGoods;
import com.sc.entity.CgSupMsg;
import com.sc.entity.KcGoodsInfo;
import com.sc.entity.KcWarehouseInfo;
import com.sc.entity.XtCompanyInfo;
import com.sc.entity.XtUserInfo;
import com.sc.service.CgService;

@Controller
@RequestMapping("/purctrl")
public class CgController {

	@Autowired
	CgService cgService;

	// http://lib.h-ui.net/Hui-iconfont/1.0.7/demo.html

	// 解决页面用get传过来date时间格式是string类型的错误
	@InitBinder
	public void initBinder(ServletRequestDataBinder bin) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		CustomDateEditor cust = new CustomDateEditor(sdf, true);
		bin.registerCustomEditor(Date.class, cust);
	}

	// 订单查询+模糊+时间范围查询+补货判断
	@RequestMapping("/purlist.do")
	ModelAndView purlist(ModelAndView mav,
			// 配置获取到的参数(配置初始默认值)
			@RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "5") Integer pageSize,
			String title, Date time1, Date time2) {

		PageInfo<CgOrder> purlist = cgService.selectall(pageNum, pageSize, title, time1, time2);
		///////////// 判断是否需要补货/////////////
		String zt = "noneed";
		List<CgRepGoods> listcrg = cgService.selectcrgall();
		if (listcrg.size() > 0) {
			for (CgRepGoods cc : listcrg) {
				cc.setCgOrderDetail(cgService.selectDetail(cc.getCpId()));
			}
		}
		if (listcrg.size() == 0) {
			zt = "no";
		}
		if (listcrg.size() > 0) {
			for (CgRepGoods cgRepGoods : listcrg) {
				if (cgRepGoods.getCgOrderDetail().getCgId() != null && cgRepGoods.getCgOrderDetail().getCgId() == 0) {
					zt = "need";
				}
			}
		}
		mav.addObject("zt", zt);
		////////////////////////////
		String temp = "yes";
		List<CgOrder> list = purlist.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		mav.addObject("temp", temp);
		if (title != null) {
			mav.addObject("ssz", title);
		}
		if (time1 != null) {
			mav.addObject("time1", time1);
		}
		if (time2 != null) {
			mav.addObject("time2", time2);
		}

		mav.addObject("page", purlist);
		mav.setViewName("zy_cg/pur_list");
		return mav;
	}

	// 订单查询+模糊+时间范围查询+补货判断
	@RequestMapping("/purlistused.do")
	ModelAndView purusedlist(ModelAndView mav,
			// 配置获取到的参数(配置初始默认值)
			@RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "5") Integer pageSize,
			String title, Date time1, Date time2) {

		PageInfo<CgOrder> purlist = cgService.selectusedpur(pageNum, pageSize, title, time1, time2);
		String temp = "yes";
		List<CgOrder> list = purlist.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		mav.addObject("temp", temp);
		if (title != null) {
			mav.addObject("ssz", title);
		}
		if (time1 != null) {
			mav.addObject("time1", time1);
		}
		if (time2 != null) {
			mav.addObject("time2", time2);
		}

		mav.addObject("page", purlist);
		mav.setViewName("zy_cg/purused_list");
		return mav;
	}

	// 采购单+采购单详情
	@RequestMapping("/selectorderanddel.do")
	public ModelAndView selectorderanddel(ModelAndView mav, @RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "5") Integer pageSize, Long cgid, String name) {
		CgOrder selectone = cgService.selectone(cgid);
		PageInfo<CgOrderDetail> page = cgService.selectoneCgOrderDetailByCgid(pageNum, pageSize, cgid, name);
		if (name != null) {
			mav.addObject("ssz", name);
		}
		selectone.setCgOrderDetail(page.getList());
		mav.addObject("order", selectone);
		mav.addObject("page", page);
		mav.setViewName("zy_cg/pur_purdetail_list");
		return mav;
	}

	// 通过采购详情id查询采购详情
	@RequestMapping("/selectDetailBycgXqId.do")
	@ResponseBody
	public CgOrderDetail selectDetailBycgXqId(Long id) {
		CgOrderDetail selectone = cgService.selectDetailBycgXqId(id);
		XtCompanyInfo selecteCompanyInfoBy = cgService.selecteCompanyInfoBy(selectone.getConpanyId());
		XtUserInfo selecteUserinfoByworkerId = cgService.selecteUserinfoByworkerId(selectone.getOperaterId());
		selectone.setCzrmc(selecteUserinfoByworkerId.getWorkerName());
		selectone.setComname(selecteCompanyInfoBy.getCompanyName());
		return selectone;
	}

	// 订单批量删除+删除
	@RequestMapping("/deletepur.do")
	public ModelAndView deletepur(ModelAndView mav, Long[] id) {
		if (id != null && id.length > 0) {
			for (Long long1 : id) {
				List<CgOrderDetail> selectBycgId = cgService.selectBycgId(long1);// 查出对应的采购单详情
				if (selectBycgId != null) {// 如果查处的对应的详情不为空
					for (CgOrderDetail cgOrderDetail : selectBycgId) {
						String cpidstr = "-1";
						long cpid = Long.parseLong(cpidstr);
						if (cgOrderDetail.getCpId().equals(cpid)) {
							cgService.delectcgxq(cgOrderDetail.getCgXqId());
						}
						if (!cgOrderDetail.getCpId().equals(cpid)) {
							String cgidstr = "0";
							long cgid = Long.parseLong(cgidstr);
							cgOrderDetail.setCgId(cgid);
							cgService.updatecgxq(cgOrderDetail);
							// 根据产品id查出所有需采购商品信息表
							List<CgRepGoods> selectcrgbycpidall = cgService.selectcrgbycpidall(cgOrderDetail.getCpId());
							if (selectcrgbycpidall != null) {
								for (CgRepGoods cgRepGoods : selectcrgbycpidall) {
									cgRepGoods.setZt("未处理");
									cgService.updatetCgR(cgRepGoods);
								}
							}
						}
					}
				}
				cgService.delectoneandall(long1);// 删除采购单
			}
		}
		mav.setViewName("redirect:purlist.do");
		return mav;
	}

	// 订单批量删除+删除
	@RequestMapping("/deleteusedpur.do")
	public ModelAndView deleteusedpur(ModelAndView mav, Long[] id) {
		if (id != null && id.length > 0) {
			for (Long long1 : id) {
				cgService.delectoneandall(long1);// 删除采购单
			}
		}
		mav.setViewName("redirect:purlistused.do");
		return mav;
	}

	// 根据id查询单条采购信息
	@RequestMapping("/selectpurone.do")
	@ResponseBody
	public CgOrder selectpurone(Long id) {
		CgOrder selectone = cgService.selectone(id);
		XtCompanyInfo selecteCompanyInfoBy = cgService.selecteCompanyInfoBy(selectone.getCompanyId());
		XtUserInfo selecteUserinfoByworkerId = cgService.selecteUserinfoByworkerId(selectone.getOperaterId());
		CgSupMsg selectSupbyid = cgService.selectSupbyid(selectone.getGysId());
		List<CgSupMsg> selectSupall = cgService.selectSupall();
		List<XtCompanyInfo> selectallcompany = cgService.selectallcompany();
		if (selectSupall != null) {
			selectone.setCgSupMsg(selectSupall);
		}
		if (selectSupbyid != null) {
			selectone.setGysmc(selectSupbyid.getGysName());
		}
		if (selectallcompany != null) {
			selectone.setXtCompanyInfo(selectallcompany);
		}
		if (selecteCompanyInfoBy != null) {
			selectone.setGsmc(selecteCompanyInfoBy.getCompanyName());
		}
		if (selecteUserinfoByworkerId != null) {
			selectone.setCzrmc(selecteUserinfoByworkerId.getWorkerName());
		}

		return selectone;
	}

	// 查询供应商和公司
	@RequestMapping("/selectsupandcomp.do")
	@ResponseBody
	public Map<String, List<?>> map() {
		Map<String, List<?>> map = new HashMap<String, List<?>>();
		List<CgSupMsg> selectSupall = cgService.selectSupall();
		List<XtCompanyInfo> selectallcompany = cgService.selectallcompany();
		List<CgRepGoods> list = cgService.selectcrgall();
		for (CgRepGoods cc : list) {
			cc.setKcGoodsInfo(cgService.selectgood(cc.getCpId()));
			cc.setCgOrderDetail(cgService.selectDetail(cc.getCpId()));
		}
		map.put("comp", selectallcompany);
		map.put("sup", selectSupall);
		map.put("crp", list);
		return map;
	}

	// 查出所有公司
	@RequestMapping("/selectallcompany.do")
	@ResponseBody
	public List<XtCompanyInfo> selectallcompany() {
		return cgService.selectallcompany();
	}

	// 修改采购表信息
	@RequestMapping("/update.do")
	public ModelAndView deletepur(ModelAndView mav, CgOrder p) {
		p.setLastTime(new Date());
		cgService.updatcgorder(p);
		mav.setViewName("redirect:purlist.do");
		return mav;
	}

	// 添加采购单信息
	@RequestMapping("/add.do")
	public ModelAndView addpur(ModelAndView mav, CgOrder p, Long[] id) {
		p.setLastTime(new Date());
		cgService.addcgorder(p);
		if (id != null) {
			for (Long long1 : id) {
				System.out.println("通过序列查询到新增的主键" + p.getCgId());
				CgOrderDetail selectDetail = cgService.selectDetail(long1);
				CgRepGoods selectcrgbycpid = cgService.selectcrgbycpid(long1);
				selectcrgbycpid.setZt("已处理");
				selectDetail.setCgId(p.getCgId());
				cgService.updatecgxq(selectDetail);
				cgService.updatetCgR(selectcrgbycpid);
			}
		}
		mav.setViewName("redirect:purlist.do");
		return mav;
	}

	// 购买新货
	@RequestMapping("/addnew.do")
	public ModelAndView addnew(ModelAndView mav, CgOrder p, CgOrderDetail c) {
		p.setLastTime(new Date());
		cgService.addcgorder(p);
		c.setCgId(p.getCgId());
		c.setSfRk("未入库");
		String cpid = "-1";
		c.setCpId(Long.parseLong(cpid));
		c.setConpanyId(p.getCompanyId());
		cgService.addcod(c);
		mav.setViewName("redirect:purlist.do");
		return mav;
	}

	// 查出需补获商品
	@RequestMapping("/seKcGoodsInfo.do")
	ModelAndView seKcGoodsInfo(ModelAndView mav,
			// 配置获取到的参数(配置初始默认值)
			@RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "5") Integer pageSize,
			String name, BigDecimal num1, BigDecimal num2) {
		int num = 10;
		BigDecimal kcnum = new BigDecimal(num);
		PageInfo<KcGoodsInfo> KcGoods = cgService.sekcGoodsInfo(pageNum, pageSize, kcnum, name, num1, num2);
		List<KcGoodsInfo> list2 = KcGoods.getList();
		for (KcGoodsInfo kcGoodsInfo : list2) {
			CgRepGoods ss = cgService.selectcgrone(kcGoodsInfo.getProductId());
			kcGoodsInfo.setCgRepGoods(ss);
		}
		String temp = "yes";
		List<KcGoodsInfo> list = KcGoods.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		mav.addObject("temp", temp);
		if (name != null) {
			mav.addObject("ssz", name);
		}
		if (num1 != null) {
			mav.addObject("num1", num1);
		}
		if (num2 != null) {
			mav.addObject("num2", num2);
		}
		mav.addObject("page", KcGoods);
		mav.setViewName("zy_cg/kcgoods_list");
		return mav;
	}

	// 查询供应商
	@RequestMapping("/selectSup.do")
	public ModelAndView selectSup(ModelAndView mav, @RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "5") Integer pageSize, String name) {
		PageInfo<CgSupMsg> suplist = cgService.selectSup(pageNum, pageSize, name);
		String temp = "yes";
		List<CgSupMsg> list = suplist.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		if (name != null) {
			mav.addObject("ssz", name);
		}
		mav.addObject("temp", temp);
		mav.addObject("page", suplist);
		mav.setViewName("zy_cg/sup_list");
		return mav;
	}

	// 供应批量删除+删除
	@RequestMapping("/deletsup.do")
	public ModelAndView deletsup(ModelAndView mav, Long[] id) {
		if (id != null && id.length > 0) {
			for (Long long1 : id) {
				cgService.delectSup(long1);
			}
		}
		mav.setViewName("redirect:selectSup.do");
		return mav;
	}

	// 根据id查询供应商信息
	@RequestMapping("/selectSupbyid.do")
	@ResponseBody
	public CgSupMsg selectSupbyid(Long id) {
		CgSupMsg selectSupbyid = cgService.selectSupbyid(id);
		List<XtCompanyInfo> selectallcompany = cgService.selectallcompany();
		XtCompanyInfo selecteCompanyInfoBy = cgService.selecteCompanyInfoBy(selectSupbyid.getCompanyId());
		XtUserInfo selecteUserinfoByworkerId = cgService.selecteUserinfoByworkerId(selectSupbyid.getOperaterId());
		selectSupbyid.setXtUserInfo(selecteUserinfoByworkerId);
		selectSupbyid.setXtCompanyInfo(selectallcompany);
		selectSupbyid.setCompname(selecteCompanyInfoBy.getCompanyName());
		return selectSupbyid;
	}

	// 修改供应商
	@RequestMapping("/updatetSup.do")
	public ModelAndView updatetSup(ModelAndView mav, CgSupMsg c) {
		c.setLastTime(new Date());
		cgService.updatetSup(c);
		mav.setViewName("redirect:selectSup.do");
		return mav;
	}

	// 录入供应商
	@RequestMapping("/addSup.do")
	public ModelAndView addSup(ModelAndView mav, CgSupMsg c) {
		c.setLastTime(new Date());
		cgService.addSup(c);
		mav.setViewName("redirect:selectSup.do");
		return mav;
	}

	// 需采购查询+模糊+时间范围查询
	@RequestMapping("/selectcgr.do")
	ModelAndView selectcgr(ModelAndView mav,
			// 配置获取到的参数(配置初始默认值)
			@RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "5") Integer pageSize,
			String title, Date time1, Date time2) {
		PageInfo<CgRepGoods> purlist = cgService.selectcgr(pageNum, pageSize, title);
		String temp = "yes";
		List<CgRepGoods> list = purlist.getList();
		for (CgRepGoods cc : list) {
			cc.setCgOrderDetail(cgService.selectDetail(cc.getCpId()));
			cc.setKcGoodsInfo(cgService.selectgood(cc.getCpId()));
		}

		if (list.size() == 0) {
			temp = "no";
		}
		mav.addObject("temp", temp);
		if (title != null) {
			mav.addObject("ssz", title);
		}
		mav.addObject("page", purlist);
		mav.setViewName("zy_cg/crg_list");
		return mav;
	}

	// 需采购批量删除+删除
	@RequestMapping("/deletcgr.do")
	public ModelAndView deletcgr(ModelAndView mav, Long[] id) {
		if (id != null && id.length > 0) {
			for (Long long1 : id) {
				CgRepGoods selectcrgbyid = cgService.selectcrgbyid(long1);
				CgOrderDetail selectDetail = cgService.selectDetail(selectcrgbyid.getCpId());
				if (selectDetail != null) {
					cgService.delectcgxq(selectDetail.getCgXqId());
				}
				cgService.delectcgr(long1);
			}
		}
		mav.setViewName("redirect:selectcgr.do");
		return mav;
	}

	// 根据id查询需采购
	@RequestMapping("/selectcrgbyid.do")
	@ResponseBody
	public CgRepGoods selectcrgbyid(Long id) {
		CgRepGoods selectcrgbyid = cgService.selectcrgbyid(id);
		XtUserInfo selecteUserinfoByworkerId = cgService.selecteUserinfoByworkerId(selectcrgbyid.getOperaterId());
		XtCompanyInfo selecteCompanyInfoBy = cgService.selecteCompanyInfoBy(selectcrgbyid.getCompanyId());
		selectcrgbyid.setCompname(selecteCompanyInfoBy.getCompanyName());
		selectcrgbyid.setCzrname(selecteUserinfoByworkerId.getWorkerName());
		selectcrgbyid.setKcGoodsInfo(cgService.selectgood(selectcrgbyid.getCpId()));
		return selectcrgbyid;
	}

	// 修改需采购
	@RequestMapping("/updatetCgR.do")
	public ModelAndView updatetCgR(ModelAndView mav, CgRepGoods c, CgOrderDetail g) {
		CgOrderDetail selectDetail = cgService.selectDetail(c.getCpId());
		selectDetail.setCpNum(g.getCpNum());
		selectDetail.setCpJg(g.getCpJg());
		selectDetail.setLastTime(new Date());
		c.setLastTime(new Date());
		c.setJhDate(new Date());
		cgService.updatetCgR(c);
		cgService.updatecgxq(selectDetail);
		mav.setViewName("redirect:selectcgr.do");
		return mav;
	}

	// 请求采购+添加采购详情
	@RequestMapping("/addcgreq.do")
	public ModelAndView addcgreq(ModelAndView mav, CgRepGoods c, CgOrderDetail d) {
		c.setZt("未处理");
		c.setLastTime(new Date());
		c.setJhDate(new Date());
		d.setSfRk("未入库");
		String idi = "0";
		Long id = Long.parseLong(idi);
		d.setCgId(id);
		d.setConpanyId(c.getCompanyId());
		d.setLastTime(new Date());
		cgService.addcgreq(c);
		cgService.addcod(d);
		mav.setViewName("redirect:seKcGoodsInfo.do");
		return mav;
	}

	// 修改采购单的付款状况
	@RequestMapping("/changefkqk.do")
	@ResponseBody
	public int changefkqk(Long id) {
		int i = 1;
		CgOrder selectone = cgService.selectone(id);
		selectone.setFkQk("已付款");
		cgService.updatcgorder(selectone);
		return i;
	}

	// 入库单查询
	@RequestMapping("/enter.do")
	public ModelAndView enter(ModelAndView mav, @RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "5") Integer pageSize, String name) {
		String wrk = "未入库";
		PageInfo<CgOrderDetail> page = cgService.selectoneCgOrderDetail(pageNum, pageSize, name, wrk);
		String temp = "yes";
		List<CgOrderDetail> list = page.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		if (name != null) {
			mav.addObject("ssz", name);
		}
		mav.addObject("temp", temp);
		mav.addObject("page", page);
		mav.setViewName("zy_cg/enter_list");
		return mav;
	}

	// 修改入库状况
	@RequestMapping("/changerk.do")
	@ResponseBody
	public int changerk(Long id) {
		int i = 1;
		String cpidst = "-1";
		long cpid = Long.parseLong(cpidst);
		CgOrderDetail selectDetailBycgXqId = cgService.selectDetailBycgXqId(id);
		KcGoodsInfo selectgood = cgService.selectgood(selectDetailBycgXqId.getCpId());
		BigDecimal cgsl = new BigDecimal(selectDetailBycgXqId.getCpNum());
		BigDecimal kcsl = selectgood.getKcNum();
		BigDecimal rk = cgsl.add(kcsl);
		selectgood.setKcNum(rk);
		cgService.updatagood(selectgood);
		CgOrderDetail selectDetailBycgXqId2 = cgService.selectDetailBycgXqId(id);
		CgRepGoods selectcrgbycpid = cgService.selectcrgbycpid(selectDetailBycgXqId.getCpId());
		selectDetailBycgXqId2.setSfRk("已入库");
		selectDetailBycgXqId2.setCpId(cpid);
		cgService.addcod(selectDetailBycgXqId2);
		cgService.delectcgr(selectcrgbycpid.getCgRepId());
		cgService.delectcgxq(selectDetailBycgXqId.getCgXqId());
		return i;
	}

	// 查询已入库商品
	@RequestMapping("/enterused.do")
	public ModelAndView enterused(ModelAndView mav, @RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "5") Integer pageSize, String name) {
		String yrk = "已入库";
		String cpidst = "-1";
		long cpid = Long.parseLong(cpidst);
		PageInfo<CgOrderDetail> page = cgService.selectyrk(pageNum, pageSize, name, yrk, cpid);
		String temp = "yes";
		List<CgOrderDetail> list = page.getList();
		if (list.size() == 0) {
			temp = "no";
		}
		if (name != null) {
			mav.addObject("ssz", name);
		}
		mav.addObject("temp", temp);
		mav.addObject("page", page);
		mav.setViewName("zy_cg/enterused_list");
		return mav;
	}

	// 采购详情批量删除+删除
	@RequestMapping("/deletdal.do")
	public ModelAndView deletdal(ModelAndView mav, Long[] id) {
		if (id != null && id.length > 0) {
			for (Long long1 : id) {
				CgOrderDetail selectDetailBycgXqId = cgService.selectDetailBycgXqId(long1);
				CgRepGoods selectcrgbycpid = cgService.selectcrgbycpid(selectDetailBycgXqId.getCpId());
				if (selectcrgbycpid != null) {
					cgService.delectcgr(selectcrgbycpid.getCgRepId());
				}
				cgService.delectcgxq(long1);
			}
		}
		mav.setViewName("redirect:enterused.do");
		return mav;
	}

	// 根据采购详情id查询采购信息
	@RequestMapping("/selectdial.do")
	@ResponseBody
	public CgOrderDetail selectdial(Long id) {
		CgOrderDetail cg = cgService.selectDetailBycgXqId(id);
		XtCompanyInfo selecteCompanyInfoBy = cgService.selecteCompanyInfoBy(cg.getConpanyId());
		cg.setComname(selecteCompanyInfoBy.getCompanyName());
		List<KcWarehouseInfo> selectcklist = cgService.selectcklist();
		cg.setKcWarehouseInfo(selectcklist);
		return cg;
	}

	// 检查新货是否与库存重复
	@RequestMapping("/jccpname.do")
	@ResponseBody
	public int jccpname(String name) {
		int i = 0;
		List<KcGoodsInfo> list = cgService.seleGoodsInfosByCpName(name);
		if (list != null && list.size() > 0) {
			i = 1;
		}
		return i;
	}

	// 新货入库
	@RequestMapping("/addkcgoods.do")
	public ModelAndView addkcgoods(ModelAndView mav, KcGoodsInfo kc, Long id) {
		CgOrderDetail selectDetailBycgXqId = cgService.selectDetailBycgXqId(id);
		selectDetailBycgXqId.setSfRk("已入库");
		kc.setLastModifyDate(new Date());
		cgService.addkcgoods(kc);
		cgService.updatecgxq(selectDetailBycgXqId);
		mav.setViewName("redirect:enter.do");
		return mav;
	}

	// 供应商导出excel
	@RequestMapping("/daochu.do")
	public void goodsExcel(HttpServletResponse response) {
		XSSFWorkbook wb = cgService.show();
		String fileName = "供应商报表.xlsx";// 后缀要加创建出来的文件形式才是以xlsx后最的文件
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

}
