package com.sc.service;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.github.pagehelper.PageInfo;
import com.sc.entity.XtCompanyInfo;
import com.sc.entity.XtDutiesInfo;


public interface XtDutiesInfoServic {

	public PageInfo<XtDutiesInfo> selectDutiesInfo(Integer pageNum, Integer pageSize,XtDutiesInfo DutiesInfo,String name);

	   // 修改信息
		public void updateDutiesInfo(XtDutiesInfo DutiesInfo);
		
		//删除
		public void delectDutiesInfo(Long dutiesId);
		
		//添加
		public void addDutiesInfo(XtDutiesInfo DutiesInfo);
		
		//根据ID查询商品信息
	    public XtDutiesInfo getDutiesInfo(Long dutiesId);
	    
	  //导出供应商excel表
		public XSSFWorkbook show();
	    
	    public PageInfo<XtDutiesInfo> selectDutiesInfo1(Integer pageNum, Integer pageSize,String name,Long dutiesId);

		
}
