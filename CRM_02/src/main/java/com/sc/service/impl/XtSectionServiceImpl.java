package com.sc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.entity.XtSection;
import com.sc.entity.XtSectionExample;
import com.sc.entity.XtSectionExample.Criteria;
import com.sc.mapper.XtSectionMapper;
import com.sc.service.XtSectionService;
@Service
public class XtSectionServiceImpl implements XtSectionService {

	@Autowired
	XtSectionMapper xtSectionMapper;

	 //.添加部门信息  XT_SECTION 系统部门表
	@Override
	public void addXtSectton(XtSection Section) {
		xtSectionMapper.insert(Section);	
	}

	@Override
	public PageInfo<XtSection> selectXtSection(Integer pageNum, Integer pageSize, XtSection Section) {
		PageHelper.startPage(pageNum, pageSize);
		List<XtSection> List = xtSectionMapper.selectByExample(null);
		PageInfo<XtSection> page = new PageInfo<XtSection>(List);
		return page;
	}

	@Override
	public PageInfo<XtSection> selectXtSectionM(Integer pageNum, Integer pageSize, String name) {
		PageHelper.startPage(pageNum, pageSize);
		  XtSectionExample xtSectionExample = new XtSectionExample();
		  com.sc.entity.XtSectionExample.Criteria createCriteria = xtSectionExample.createCriteria();
		  if(name!=null){
			  createCriteria.andSectionNameLike("%" + name + "%");
		  }
		  xtSectionExample.setOrderByClause("SECTION_ID");
		  List<XtSection> list = xtSectionMapper.selectByExample(xtSectionExample);
		  PageInfo<XtSection> page = new PageInfo<XtSection>(list);
		return page;
	}

}
