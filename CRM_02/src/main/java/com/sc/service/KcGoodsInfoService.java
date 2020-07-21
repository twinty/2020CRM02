package com.sc.service;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.github.pagehelper.PageInfo;
import com.sc.entity.KcGoodsInfo;


public interface KcGoodsInfoService {
	
	public PageInfo<KcGoodsInfo> selectGoodsInfo(Integer pageNum, Integer pageSize,KcGoodsInfo goodsInfo);

	   // 修改信息
		public void updateGoodsInfo(KcGoodsInfo goodsInfo);
		
		//删除
		public void delectGoodsInfo(Long productId);
		
		public void deletehouse(Long productId);

		//根据ID查询商品信息
	    public KcGoodsInfo getGoodsInfo(Long productId);
	    
	  //导出供应商excel表
		public XSSFWorkbook show();
	    
	    public PageInfo<KcGoodsInfo> selectGoodsInfoByid1(Integer pageNum, Integer pageSize,String name,Long warehouseId);
}

