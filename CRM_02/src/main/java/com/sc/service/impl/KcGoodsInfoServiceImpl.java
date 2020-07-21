package com.sc.service.impl;

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
import com.sc.entity.CgSupMsg;
import com.sc.entity.KcGoodsInfo;
import com.sc.entity.KcGoodsInfoExample;
import com.sc.entity.XsCustom;
import com.sc.entity.XsCustomExample;
import com.sc.entity.XtUserInfo;
import com.sc.entity.XtUserInfoExample;
import com.sc.entity.XsCustomExample.Criteria;
import com.sc.mapper.KcGoodsInfoMapper;
import com.sc.service.KcGoodsInfoService;
@Service
public class KcGoodsInfoServiceImpl implements KcGoodsInfoService {

	@Autowired
	KcGoodsInfoMapper kcGoodsInfoMapper;
	
	@Override
	public PageInfo<KcGoodsInfo> selectGoodsInfo(Integer pageNum, Integer pageSize, KcGoodsInfo goodsInfo) {

		//通过客户名字对客户信息查询
		KcGoodsInfoExample example=new KcGoodsInfoExample();
		if(goodsInfo!=null){ //如果传入的对象不等于空，就要进行条件查询
			
			com.sc.entity.KcGoodsInfoExample.Criteria criteria = example.createCriteria();
			//通过输入的名字进行客户信息查询，所以需要判断传入的客户名字
			//以前是这样写的，现在用(这里选用的是spring框架的)工具类if(custom.getCustomName()!=null&&!custom.getCustomName().equals(""))
			if(!StringUtils.isEmpty(goodsInfo.getProductName())){//地址不为空并且内容不为空
				criteria.andProductNameLike("%"+goodsInfo.getProductName()+"%");//带上通配符
			}
			
			if(!StringUtils.isEmpty(goodsInfo.getWarehouseId())){//地址不为空并且内容不为空
				
				criteria.andWarehouseIdEqualTo(goodsInfo.getWarehouseId());
			}
			//对最小输入日期进行判断，如果不为空的话，就让最后修改时间大于等于它
			if(!StringUtils.isEmpty(goodsInfo.getDatemin())){
				System.out.println("------小时间-----"+goodsInfo.getDatemin());
				criteria.andLastModifyDateGreaterThanOrEqualTo(goodsInfo.getDatemin());
				
			}
			//对最答输入日期进行判断，如果不为空的话，就让最后修改时间小与等于它
			if(!StringUtils.isEmpty(goodsInfo.getDatemax())){
				
			Date d=goodsInfo.getDatemax();//这里解决当天时间零点后时间差的问题
			d.setHours(23);
			d.setMinutes(59);
			d.setSeconds(59);
			System.out.println("------大时间-----"+d);
				criteria.andLastModifyDateLessThanOrEqualTo(d);//到这里是按加一的时间来查的
				
			}
		}
		
		//分页查询
	    PageHelper.startPage(pageNum, pageSize);
		List<KcGoodsInfo> list=kcGoodsInfoMapper.selectByExample(example);//之前这里面放的是空
		PageInfo<KcGoodsInfo> page=new PageInfo<KcGoodsInfo>(list);
		return page;
	}
	
	
	
	
	public PageInfo<KcGoodsInfo> selectGoodsInfoByid1(Integer pageNum, Integer pageSize, String name,Long warehouseId) {
		PageHelper.startPage(pageNum, pageSize);
		KcGoodsInfoExample kcGoodsInfoExample = new KcGoodsInfoExample();

		com.sc.entity.KcGoodsInfoExample.Criteria createCriteria = kcGoodsInfoExample.createCriteria();

		if (name != null) {
			createCriteria.andProductNameLike("%" + name + "%");
		}
		
		if (warehouseId != null) {
			createCriteria.andCompanyIdGreaterThanOrEqualTo(warehouseId);
		}
		
		kcGoodsInfoExample.setOrderByClause("PRODUCT_ID");
		List<KcGoodsInfo> list = kcGoodsInfoMapper.selectByExample(kcGoodsInfoExample);
		PageInfo<KcGoodsInfo> page = new PageInfo<KcGoodsInfo>(list);
		return page;
	}


	@Override
	public void updateGoodsInfo(KcGoodsInfo goodsInfo) {
		if(goodsInfo!=null&&goodsInfo.getProductId()!=null){
			kcGoodsInfoMapper.updateByPrimaryKey(goodsInfo);
		}

	}

	@Override
	public void delectGoodsInfo(Long productId) {
		if(productId!=null){
			kcGoodsInfoMapper.deleteByPrimaryKey(productId);
		}

	}

	@Override
	public KcGoodsInfo getGoodsInfo(Long productId) {		
		if(productId!=null){
					
			return kcGoodsInfoMapper.selectByPrimaryKey(productId);
				}
				return null;
			}

	

	@Override
	public void deletehouse(Long productId) {
		if(productId!=null){
			kcGoodsInfoMapper.deleteByPrimaryKey(productId);
		}

	}




	




	@Override
	public XSSFWorkbook show() {
		List<KcGoodsInfo> list = kcGoodsInfoMapper.selectByExample(null);//查出数据库数据
        XSSFWorkbook wb = new XSSFWorkbook();//创建一个工作簿
        Sheet sheet = wb.createSheet();//创建一张表
        Row titleRow = sheet.createRow(0);//创建第一行，起始为0
        titleRow.createCell(0).setCellValue("商品编号");
        titleRow.createCell(1).setCellValue("商品名称");
        titleRow.createCell(2).setCellValue("商品类别");
        titleRow.createCell(3).setCellValue("库存数量");
        titleRow.createCell(4).setCellValue("成本价");
        titleRow.createCell(5).setCellValue("零售价");
        titleRow.createCell(5).setCellValue("仓库编号");
        int cell = 1;
        for (KcGoodsInfo csm : list) {
            Row row = sheet.createRow(cell);//从第二行开始保存数据
            row.createCell(0).setCellValue(csm.getProductId());//将数据库的数据遍历出来
            row.createCell(1).setCellValue(csm.getProductName());
            row.createCell(2).setCellValue(csm.getProductType());
//            row.createCell(3).setCellValue(csm.getKcNum());
//            row.createCell(4).setCellValue(csm.getCost());
//            row.createCell(5).setCellValue(csm.getRenall());
 //           row.createCell(5).setCellType(csm.getWarehouseId());
            cell++;
        }
        return wb;
	}
	

}
