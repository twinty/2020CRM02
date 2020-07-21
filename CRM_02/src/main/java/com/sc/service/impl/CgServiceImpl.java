package com.sc.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.entity.CgOrder;
import com.sc.entity.CgOrderDetail;
import com.sc.entity.CgOrderDetailExample;
import com.sc.entity.CgOrderExample;
import com.sc.entity.CgOrderExample.Criteria;
import com.sc.entity.CgRepGoods;
import com.sc.entity.CgRepGoodsExample;
import com.sc.entity.CgSupMsg;
import com.sc.entity.CgSupMsgExample;
import com.sc.entity.KcGoodsInfo;
import com.sc.entity.KcGoodsInfoExample;
import com.sc.entity.KcWarehouseInfo;
import com.sc.entity.XtCompanyInfo;
import com.sc.entity.XtUserInfo;
import com.sc.mapper.CgOrderDetailMapper;
import com.sc.mapper.CgOrderMapper;
import com.sc.mapper.CgRepGoodsMapper;
import com.sc.mapper.CgSupMsgMapper;
import com.sc.mapper.KcGoodsInfoMapper;
import com.sc.mapper.KcWarehouseInfoMapper;
import com.sc.mapper.XtCompanyInfoMapper;
import com.sc.mapper.XtUserInfoMapper;
import com.sc.service.CgService;

@Service
public class CgServiceImpl implements CgService {

	@Autowired
	CgOrderMapper cgOrderMapper;
	@Autowired
	KcGoodsInfoMapper kcGoodsInfoMapper;
	@Autowired
	CgSupMsgMapper cgSupMsgMapper;
	@Autowired
	CgRepGoodsMapper cgRepGoodsMapper;
	@Autowired
	CgOrderDetailMapper cgOrderDetailMapper;
	@Autowired
	XtCompanyInfoMapper xtCompanyInfoMapper;
	@Autowired
	XtUserInfoMapper xtUserInfoMapper;
	@Autowired
	KcWarehouseInfoMapper kcWarehouseInfoMapper;

	public PageInfo<CgOrder> selectall(Integer pageNum, Integer pageSize, String title, Date time1, Date time2) {
		PageHelper.startPage(pageNum, pageSize);
		CgOrderExample cgOrderExample = new CgOrderExample();
		Criteria c = cgOrderExample.createCriteria();
		if (title != null) {
			c.andCgTitleLike("%" + title + "%");
		}
		if (time1 != null) {
			// 大于等于
			c.andCgDateGreaterThanOrEqualTo(time1);
		}
		if (time2 != null) {
			// 小于等于
			c.andCgDateLessThanOrEqualTo(time2);
		}
		cgOrderExample.setOrderByClause("CG_ID");
		ArrayList<CgOrder> list = new ArrayList<CgOrder>();
		List<CgOrder> list1 = cgOrderMapper.selectByExample(cgOrderExample);
		for (CgOrder cgOrder : list1) {
			CgOrderDetailExample cgOrderDetailExample = new CgOrderDetailExample();
			com.sc.entity.CgOrderDetailExample.Criteria createCriteria = cgOrderDetailExample.createCriteria();
			if (!StringUtils.isEmpty(cgOrder)) {
				createCriteria.andCgIdEqualTo(cgOrder.getCgId());
				List<CgOrderDetail> selectByExample = cgOrderDetailMapper.selectByExample(cgOrderDetailExample);
				if (!StringUtils.isEmpty(selectByExample)) {
					cgOrder.setCgOrderDetail(selectByExample);
				}
			}
		}
		if (list1 != null && list1.size() > 0) {
			for (CgOrder cgOrder : list1) {
				String tt = "no";
				if (cgOrder.getCgOrderDetail().size() > 0 && cgOrder.getCgOrderDetail() != null) {
					for (CgOrderDetail cs : cgOrder.getCgOrderDetail()) {
						if (cs.getSfRk() != null && cs.getSfRk().equals("未入库")) {
							tt = "yes";
						}
					}
				}
				if (tt == "yes" && cgOrder != null) {
					list.add(cgOrder);
				}

			}
		}
		PageInfo<CgOrder> page = new PageInfo<CgOrder>(list);
		return page;
	}
	
	public PageInfo<CgOrder> selectusedpur(Integer pageNum, Integer pageSize, String title, Date time1, Date time2) {
		PageHelper.startPage(pageNum, pageSize);
		CgOrderExample cgOrderExample = new CgOrderExample();
		Criteria c = cgOrderExample.createCriteria();
		if (title != null) {
			c.andCgTitleLike("%" + title + "%");
		}
		if (time1 != null) {
			// 大于等于
			c.andCgDateGreaterThanOrEqualTo(time1);
		}
		if (time2 != null) {
			// 小于等于
			c.andCgDateLessThanOrEqualTo(time2);
		}
		cgOrderExample.setOrderByClause("CG_ID");
		ArrayList<CgOrder> list = new ArrayList<CgOrder>();
		List<CgOrder> list1 = cgOrderMapper.selectByExample(cgOrderExample);
		for (CgOrder cgOrder : list1) {
			CgOrderDetailExample cgOrderDetailExample = new CgOrderDetailExample();
			com.sc.entity.CgOrderDetailExample.Criteria createCriteria = cgOrderDetailExample.createCriteria();
			if (!StringUtils.isEmpty(cgOrder)) {
				createCriteria.andCgIdEqualTo(cgOrder.getCgId());
				List<CgOrderDetail> selectByExample = cgOrderDetailMapper.selectByExample(cgOrderDetailExample);
				if (!StringUtils.isEmpty(selectByExample)) {
					cgOrder.setCgOrderDetail(selectByExample);
				}
			}
		}
		if (list1 != null && list1.size() > 0) {
			for (CgOrder cgOrder : list1) {
				String tt = "no";
				if (cgOrder.getCgOrderDetail().size() > 0 && cgOrder.getCgOrderDetail() != null) {
					for (CgOrderDetail cs : cgOrder.getCgOrderDetail()) {
						if (cs.getSfRk() != null && cs.getSfRk().equals("未入库")) {
							tt = "yes";
						}
					}
				}
				if (tt == "no") {
					cgOrder.setCgJz("采购完成");
					cgOrderMapper.updateByPrimaryKey(cgOrder);
					list.add(cgOrder);
				}

			}
		}
		PageInfo<CgOrder> page = new PageInfo<CgOrder>(list);
		return page;
	}

	@Override
	public void delectoneandall(Long cgId) {
		cgOrderMapper.deleteByPrimaryKey(cgId);

	}

	@Override
	public CgOrder selectone(Long cgId) {
		return cgOrderMapper.selectByPrimaryKey(cgId);
	}

	@Override
	public void updatcgorder(CgOrder p) {

		cgOrderMapper.updateByPrimaryKey(p);
	}

	@Override
	public void addcgorder(CgOrder p) {

		cgOrderMapper.insert(p);
	}

	@Override
	public PageInfo<KcGoodsInfo> sekcGoodsInfo(Integer pageNum, Integer pageSize, BigDecimal kcnum, String name,
			BigDecimal num1, BigDecimal num2) {
		PageHelper.startPage(pageNum, pageSize);
		KcGoodsInfoExample kcGoodsInfoExample = new KcGoodsInfoExample();
		kcGoodsInfoExample.setOrderByClause("PRODUCT_ID");
		com.sc.entity.KcGoodsInfoExample.Criteria c = kcGoodsInfoExample.createCriteria();
		if (num1 != null) {
			// 大于等于
			c.andKcNumGreaterThanOrEqualTo(num1);
		}
		if (num2 != null) {
			// 小于等于
			c.andKcNumLessThanOrEqualTo(num2);
		}
		if (name != null) {
			c.andProductNameLike("%" + name + "%");
		}
		c.andKcNumLessThanOrEqualTo(kcnum);
		List<KcGoodsInfo> list = kcGoodsInfoMapper.selectByExample(kcGoodsInfoExample);
		PageInfo<KcGoodsInfo> page = new PageInfo<KcGoodsInfo>(list);
		return page;
	}

	@Override
	public CgRepGoods selectcgrone(Long productId) {
		CgRepGoods cgRepGoods = null;
		CgRepGoodsExample cgRepGoodsExample = new CgRepGoodsExample();
		com.sc.entity.CgRepGoodsExample.Criteria createCriteria = cgRepGoodsExample.createCriteria();
		createCriteria.andCpIdEqualTo(productId);
		List<CgRepGoods> list = cgRepGoodsMapper.selectByExample(cgRepGoodsExample);
		if (list != null && list.size() > 0) {
			cgRepGoods = list.get(0);
		}
		return cgRepGoods;
	}

	@Override
	public PageInfo<CgSupMsg> selectSup(Integer pageNum, Integer pageSize, String name) {
		PageHelper.startPage(pageNum, pageSize);
		CgSupMsgExample cgSupMsgExample = new CgSupMsgExample();

		com.sc.entity.CgSupMsgExample.Criteria createCriteria = cgSupMsgExample.createCriteria();

		if (name != null) {
			createCriteria.andGysNameLike("%" + name + "%");
		}
		cgSupMsgExample.setOrderByClause("GYS_ID");
		List<CgSupMsg> list = cgSupMsgMapper.selectByExample(cgSupMsgExample);
		PageInfo<CgSupMsg> page = new PageInfo<CgSupMsg>(list);
		return page;
	}

	@Override
	public void delectSup(Long gysId) {
		cgSupMsgMapper.deleteByPrimaryKey(gysId);
	}

	@Override
	public CgSupMsg selectSupbyid(Long gysId) {
		return cgSupMsgMapper.selectByPrimaryKey(gysId);
	}

	@Override
	public void updatetSup(CgSupMsg c) {

		cgSupMsgMapper.updateByPrimaryKey(c);
	}

	@Override
	public void addSup(CgSupMsg c) {

		cgSupMsgMapper.insert(c);
	}

	public PageInfo<CgRepGoods> selectcgr(Integer pageNum, Integer pageSize, String title) {
		PageHelper.startPage(pageNum, pageSize);
		CgRepGoodsExample cgRepGoodsExample = new CgRepGoodsExample();
		com.sc.entity.CgRepGoodsExample.Criteria c = cgRepGoodsExample.createCriteria();
		if (title != null && !title.equals("")) {
			c.andZtEqualTo(title);
		}
		cgRepGoodsExample.setOrderByClause("CG_REP_ID");
		List<CgRepGoods> list = cgRepGoodsMapper.selectByExample(cgRepGoodsExample);
		PageInfo<CgRepGoods> page = new PageInfo<CgRepGoods>(list);
		return page;
	}

	public CgOrderDetail selectDetail(Long cpId) {
		CgOrderDetail cg = null;
		CgOrderDetailExample cgOrderDetailExample = new CgOrderDetailExample();
		com.sc.entity.CgOrderDetailExample.Criteria createCriteria = cgOrderDetailExample.createCriteria();
		createCriteria.andCpIdEqualTo(cpId);
		List<CgOrderDetail> list = cgOrderDetailMapper.selectByExample(cgOrderDetailExample);
		if (list != null && list.size() != 0) {
			cg = list.get(0);
		}
		return cg;
	}

	@Override
	public void updatecgxq(CgOrderDetail cg) {

		cgOrderDetailMapper.updateByPrimaryKey(cg);
	}

	@Override
	public void addcgreq(CgRepGoods cgr) {
		cgRepGoodsMapper.insert(cgr);
	}

	@Override
	public void addcod(CgOrderDetail cod) {
		cgOrderDetailMapper.insert(cod);
	}

	@Override
	public void delectcgr(Long cgRepId) {

		cgRepGoodsMapper.deleteByPrimaryKey(cgRepId);
	}

	@Override
	public CgRepGoods selectcrgbyid(Long cgRepId) {
		return cgRepGoodsMapper.selectByPrimaryKey(cgRepId);
	}

	@Override
	public void updatetCgR(CgRepGoods c) {

		cgRepGoodsMapper.updateByPrimaryKey(c);
	}

	@Override
	public KcGoodsInfo selectgood(Long productId) {
		return kcGoodsInfoMapper.selectByPrimaryKey(productId);
	}

	@Override
	public void delectcgxq(Long cgXqId) {
		cgOrderDetailMapper.deleteByPrimaryKey(cgXqId);
	}

	@Override
	public List<CgRepGoods> selectcrgall() {
		return cgRepGoodsMapper.selectByExample(null);
	}

	@Override
	public CgRepGoods selectcrgbycpid(Long cpId) {
		CgRepGoods cg = null;
		CgRepGoodsExample cgRepGoodsExample = new CgRepGoodsExample();
		com.sc.entity.CgRepGoodsExample.Criteria createCriteria = cgRepGoodsExample.createCriteria();
		createCriteria.andCpIdEqualTo(cpId);
		List<CgRepGoods> list = cgRepGoodsMapper.selectByExample(cgRepGoodsExample);
		if (list != null && list.size() != 0) {
			cg = list.get(0);
		}
		return cg;
	}

	@Override
	public List<CgRepGoods> selectcrgbycpidall(Long cpId) {
		CgRepGoodsExample cgRepGoodsExample = new CgRepGoodsExample();
		com.sc.entity.CgRepGoodsExample.Criteria createCriteria = cgRepGoodsExample.createCriteria();
		createCriteria.andCpIdEqualTo(cpId);
		List<CgRepGoods> list = cgRepGoodsMapper.selectByExample(cgRepGoodsExample);
		return list;
	}

	@Override
	public PageInfo<CgOrderDetail> selectoneCgOrderDetailByCgid(Integer pageNum, Integer pageSize, Long cgid,
			String name) {
		PageHelper.startPage(pageNum, pageSize);
		CgOrderDetailExample cgOrderDetailExample = new CgOrderDetailExample();
		com.sc.entity.CgOrderDetailExample.Criteria createCriteria = cgOrderDetailExample.createCriteria();
		createCriteria.andCgIdEqualTo(cgid);
		if (name != null) {
			createCriteria.andCpNameLike("%" + name + "%");
		}
		cgOrderDetailExample.setOrderByClause("CG_XQ_ID");
		List<CgOrderDetail> list = cgOrderDetailMapper.selectByExample(cgOrderDetailExample);
		PageInfo<CgOrderDetail> page = new PageInfo<CgOrderDetail>(list);
		return page;
	}

	@Override
	public PageInfo<CgOrderDetail> selectoneCgOrderDetail(Integer pageNum, Integer pageSize, String name, String wrk) {
		PageHelper.startPage(pageNum, pageSize);
		CgOrderDetailExample cgOrderDetailExample = new CgOrderDetailExample();
		com.sc.entity.CgOrderDetailExample.Criteria createCriteria = cgOrderDetailExample.createCriteria();
		if (name != null) {
			createCriteria.andCpNameLike("%" + name + "%");
		}
		if (!StringUtils.isEmpty(wrk)) {
			createCriteria.andSfRkEqualTo(wrk);
		}
		cgOrderDetailExample.setOrderByClause("CG_XQ_ID");
		List<CgOrderDetail> list1 = cgOrderDetailMapper.selectByExample(cgOrderDetailExample);
		ArrayList<CgOrderDetail> list = new ArrayList<CgOrderDetail>();
		for (CgOrderDetail cgOrderDetail : list1) {
			if (cgOrderDetail != null) {
				CgOrder selectByPrimaryKey = cgOrderMapper.selectByPrimaryKey(cgOrderDetail.getCgId());
				if (selectByPrimaryKey != null) {
					cgOrderDetail.setCgOrder(selectByPrimaryKey);
					if (cgOrderDetail.getCgOrder().getFkQk().equals("已付款")) {
						list.add(cgOrderDetail);
					}
				}

			}
		}
		PageInfo<CgOrderDetail> page = new PageInfo<CgOrderDetail>(list);
		return page;
	}

	@Override
	public List<XtCompanyInfo> selectallcompany() {
		return xtCompanyInfoMapper.selectByExample(null);
	}

	@Override
	public XtUserInfo selecteUserinfoByworkerId(Long workerId) {
		return xtUserInfoMapper.selectByPrimaryKey(workerId);
	}

	@Override
	public XtCompanyInfo selecteCompanyInfoBy(Long companyId) {
		// TODO Auto-generated method stub
		return xtCompanyInfoMapper.selectByPrimaryKey(companyId);
	}

	@Override
	public CgOrderDetail selectDetailBycgXqId(Long cgXqId) {
		// TODO Auto-generated method stub
		return cgOrderDetailMapper.selectByPrimaryKey(cgXqId);
	}

	@Override
	public List<CgSupMsg> selectSupall() {
		// TODO Auto-generated method stub
		CgSupMsgExample e = new CgSupMsgExample();
		com.sc.entity.CgSupMsgExample.Criteria c = e.createCriteria();
		c.andSfYxEqualTo("是");
		return cgSupMsgMapper.selectByExample(e);
	}

	@Override
	public List<CgOrderDetail> selectBycgId(Long cgId) {
		CgOrderDetailExample cgOrderDetailExample = new CgOrderDetailExample();
		com.sc.entity.CgOrderDetailExample.Criteria createCriteria = cgOrderDetailExample.createCriteria();
		if (cgId != null && !cgId.equals("")) {
			createCriteria.andCgIdEqualTo(cgId);
		}
		return cgOrderDetailMapper.selectByExample(cgOrderDetailExample);
	}

	@Override
	public PageInfo<CgOrderDetail> selectyrk(Integer pageNum, Integer pageSize, String name, String yrk,Long cpid) {
		// TODO Auto-generated method stub
		PageHelper.startPage(pageNum, pageSize);
		CgOrderDetailExample cgOrderDetailExample = new CgOrderDetailExample();
		com.sc.entity.CgOrderDetailExample.Criteria createCriteria = cgOrderDetailExample.createCriteria();
		if (name != null) {
			createCriteria.andCpNameLike("%" + name + "%");
		}
		if (!StringUtils.isEmpty(yrk)) {
			createCriteria.andSfRkEqualTo(yrk);
		}
		if (!StringUtils.isEmpty(cpid)) {
			createCriteria.andCpIdEqualTo(cpid);
		}
		List<CgOrderDetail> list = cgOrderDetailMapper.selectByExample(cgOrderDetailExample);
		PageInfo<CgOrderDetail> page = new PageInfo<CgOrderDetail>(list);
		return page;
	}


	@Override
	public void updatagood(KcGoodsInfo kcGoodsInfo) {
		// TODO Auto-generated method stub
		kcGoodsInfoMapper.updateByPrimaryKey(kcGoodsInfo);
	}

	@Override
	public List<KcWarehouseInfo> selectcklist() {
		// TODO Auto-generated method stub
		return kcWarehouseInfoMapper.selectByExample(null);
	}

	@Override
	public void addkcgoods(KcGoodsInfo KcGoodsInfo) {
		// TODO Auto-generated method stub
		kcGoodsInfoMapper.insert(KcGoodsInfo);
	}

	@Override
	public XSSFWorkbook show() {
		List<CgSupMsg> list = cgSupMsgMapper.selectByExample(null);//查出数据库数据
        XSSFWorkbook wb = new XSSFWorkbook();//创建一个工作簿
        Sheet sheet = wb.createSheet();//创建一张表
        Row titleRow = sheet.createRow(0);//创建第一行，起始为0
        titleRow.createCell(0).setCellValue("供应商编号");
        titleRow.createCell(1).setCellValue("供应商名称");
        titleRow.createCell(2).setCellValue("供应商简称");
        titleRow.createCell(3).setCellValue("联系人");
        titleRow.createCell(4).setCellValue("电话");
        titleRow.createCell(5).setCellValue("地址");
        int cell = 1;
        for (CgSupMsg csm : list) {
            Row row = sheet.createRow(cell);//从第二行开始保存数据
            row.createCell(0).setCellValue(csm.getGysId());//将数据库的数据遍历出来
            row.createCell(1).setCellValue(csm.getGysName());
            row.createCell(2).setCellValue(csm.getGysShortName());
            row.createCell(3).setCellValue(csm.getLxr());
            row.createCell(4).setCellValue(csm.getTel());
            row.createCell(5).setCellValue(csm.getAddress());
            cell++;
        }
        return wb;
	}

	@Override
	public List<KcGoodsInfo> seleGoodsInfosByCpName(String name) {
		KcGoodsInfoExample e = new KcGoodsInfoExample();
		com.sc.entity.KcGoodsInfoExample.Criteria c = e.createCriteria();
		if(name!=null&&!name.equals("")){
			c.andProductNameEqualTo(name);
		}
		List<KcGoodsInfo> list = kcGoodsInfoMapper.selectByExample(e);
		return list;
	}
	
}
