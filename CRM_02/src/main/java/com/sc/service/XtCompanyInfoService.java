package com.sc.service;

import com.github.pagehelper.PageInfo;

import com.sc.entity.XtCompanyInfo;


public interface XtCompanyInfoService {

	// 添加员工信息
		public void addCompanyInfo(XtCompanyInfo companyInfo);
	
	   // 修改信息
			public void updateCompanyInfo(XtCompanyInfo companyInfo);
			
			//删除
			public void delectCompanyInfo(Long companyId);
			

			//根据ID查询商品信息
		    public XtCompanyInfo getCompanyInfo(Long companyId);
	
	//模糊查询
	  public PageInfo<XtCompanyInfo> selectCompanyInfo(Integer pageNum, Integer pageSize,String name);
}
