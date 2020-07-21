package com.sc.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.sc.entity.XtSection;
import com.sc.entity.XtUserInfo;

public interface XtSectionService {
	 //.查看部门信息  XT_SECTION 系统部门表
	public PageInfo<XtSection> selectXtSection(Integer pageNum, Integer pageSize, XtSection Section);

    //.添加部门信息  XT_SECTION 系统部门表
		public void addXtSectton(XtSection Section );

		 //模糊查寻部门信息  XT_SECTION 系统部门表
		public PageInfo<XtSection> selectXtSectionM(Integer pageNum, Integer pageSize, String name);
}
