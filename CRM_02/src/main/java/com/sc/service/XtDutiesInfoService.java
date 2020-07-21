package com.sc.service;



import com.github.pagehelper.PageInfo;
import com.sc.entity.XtDutiesInfo;

public interface XtDutiesInfoService {
	//查看职务信息表
	public PageInfo<XtDutiesInfo> seleteXtDutiesInfo(Integer pageNum,Integer pageSize,String name);

	//添加职务信息
	public void addXtDutiesInfo(XtDutiesInfo DutiesInfo);
	
	//按id查询职务信息
	public XtDutiesInfo getXtDutiesInfo(Long dutiesId);
}
