package com.sc.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.github.pagehelper.PageInfo;
import com.sc.entity.CgOrder;
import com.sc.entity.CgOrderDetail;
import com.sc.entity.CgRepGoods;
import com.sc.entity.CgSupMsg;
import com.sc.entity.KcGoodsInfo;
import com.sc.entity.KcWarehouseInfo;
import com.sc.entity.XtCompanyInfo;
import com.sc.entity.XtUserInfo;

public interface CgService {

	// 查询采购单并分页,包括模糊
	public PageInfo<CgOrder> selectall(Integer pageNum, Integer pageSize, String title, Date time1, Date time2);

	// 查询已处理采购单并分页,包括模糊
	public PageInfo<CgOrder> selectusedpur(Integer pageNum, Integer pageSize, String title, Date time1, Date time2);

	// 批量删除/删除采购单
	public void delectoneandall(Long cgId);

	// 根据id查询单单条购信息
	public CgOrder selectone(Long ordId);

	// 修改采购单
	public void updatcgorder(CgOrder p);

	// 添加采购单
	public void addcgorder(CgOrder p);

	// 根据采购id查询采购详情表
	public PageInfo<CgOrderDetail> selectoneCgOrderDetailByCgid(Integer pageNum, Integer pageSize, Long cgid,
			String name);

	// 查询采购详情表分页
	public PageInfo<CgOrderDetail> selectoneCgOrderDetail(Integer pageNum, Integer pageSize, String name, String wrk);

	// 根据采购单id查询采购详情
	public List<CgOrderDetail> selectBycgId(Long cgId);

	// 用过产品编号查询采购详情
	public CgOrderDetail selectDetail(Long cpId);

	// 通过采购详情id查询采购详情
	public CgOrderDetail selectDetailBycgXqId(Long cgXqId);

	// 修改采购详情
	public void updatecgxq(CgOrderDetail cg);

	// 添加采购详情
	public void addcod(CgOrderDetail cod);

	// 采购详情批量删除+删除
	public void delectcgxq(Long cgXqId);

	// 查询需采购
	public PageInfo<CgRepGoods> selectcgr(Integer pageNum, Integer pageSize, String title);

	// 查询所有需采购
	public List<CgRepGoods> selectcrgall();

	// 查出对应的需采购
	public CgRepGoods selectcgrone(Long productId);

	// 根据id查询需采购
	public CgRepGoods selectcrgbyid(Long cgRepId);

	// 根据产品id查询需采购(单条)
	public CgRepGoods selectcrgbycpid(Long cpId);

	// 根据产品id查询需采购(多条)
	public List<CgRepGoods> selectcrgbycpidall(Long cpId);

	// 修改需采购
	public void updatetCgR(CgRepGoods c);
	// 批量删除+删除需采购
		public void delectcgr(Long cgRepId);

	// 查询供应商信息
	public PageInfo<CgSupMsg> selectSup(Integer pageNum, Integer pageSize, String name);

	// 查询所有供应商（不分页）
	public List<CgSupMsg> selectSupall();

	// 批量删除+删除供应商
	public void delectSup(Long gysId);

	// 根据id查询供应商信息
	public CgSupMsg selectSupbyid(Long gysId);

	// 修改供应商信息
	public void updatetSup(CgSupMsg c);

	// 添加供应商
	public void addSup(CgSupMsg c);

	// 查出缺货商品
	public PageInfo<KcGoodsInfo> sekcGoodsInfo(Integer pageNum, Integer pageSize, BigDecimal kcnum, String name,
			BigDecimal num1, BigDecimal num2);

	// 查出所有公司（不分页）
	public List<XtCompanyInfo> selectallcompany();

	// 根据公司id查到公司信息
	public XtCompanyInfo selecteCompanyInfoBy(Long companyId);

	// 根据员工id查到员工信息
	public XtUserInfo selecteUserinfoByworkerId(Long workerId);

	// 查询到已入库商品
	public PageInfo<CgOrderDetail> selectyrk(Integer pageNum, Integer pageSize, String name, String yrk,Long cpid);

	// 添加采购请求
	public void addcgreq(CgRepGoods cgr);

	

	// 根据商品id查询商品
	public KcGoodsInfo selectgood(Long productId);

	// 库存商品补货
	public void updatagood(KcGoodsInfo KcGoodsInfo);
	
	//根据商品名称查询商品
	public List<KcGoodsInfo> seleGoodsInfosByCpName(String name);

	// 查询仓库
	public List<KcWarehouseInfo> selectcklist();

	// 添加新买的商品入库存
	public void addkcgoods(KcGoodsInfo KcGoodsInfo);
	
	//导出供应商excel表
	public XSSFWorkbook show();
}
