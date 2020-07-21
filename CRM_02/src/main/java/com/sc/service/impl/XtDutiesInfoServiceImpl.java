package com.sc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.entity.XtDutiesInfo;
import com.sc.entity.XtDutiesInfoExample;
import com.sc.entity.XtDutiesInfoExample.Criteria;
import com.sc.mapper.XtDutiesInfoMapper;
import com.sc.service.XtDutiesInfoService;
@Service
public class XtDutiesInfoServiceImpl implements XtDutiesInfoService {

	@Autowired
	XtDutiesInfoMapper xtDutiesInfoMapper;
	//模糊查询方法
	@Override
	public PageInfo<XtDutiesInfo> seleteXtDutiesInfo(Integer pageNum, Integer pageSize, String name) {
		PageHelper.startPage(pageNum, pageSize);
		 XtDutiesInfoExample xtDutiesInfoExample = new XtDutiesInfoExample();
		 XtDutiesInfoExample.Criteria createCriteria = xtDutiesInfoExample.createCriteria();
		if(name!=null){
			createCriteria.andDutiesNameLike("%" +name+ "%");
		}
		xtDutiesInfoExample.setOrderByClause("DUTIES_ID");
		List<XtDutiesInfo> list = xtDutiesInfoMapper.selectByExample(xtDutiesInfoExample);
		PageInfo<XtDutiesInfo> page= new PageInfo<XtDutiesInfo>(list);
		return page;
	}

	@Override
	public void addXtDutiesInfo(XtDutiesInfo DutiesInfo) {
		xtDutiesInfoMapper.insert(DutiesInfo);

	}

	@Override
	public XtDutiesInfo getXtDutiesInfo(Long dutiesId) {
		if(dutiesId!=null){
			xtDutiesInfoMapper.selectByPrimaryKey(dutiesId);
		}
		return null;
	}

}
