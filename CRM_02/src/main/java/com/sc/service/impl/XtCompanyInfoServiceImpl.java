package com.sc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.entity.XtCompanyInfo;
import com.sc.entity.XtCompanyInfoExample;
import com.sc.entity.XtUserInfo;
import com.sc.entity.XtUserInfoExample;
import com.sc.mapper.XtCompanyInfoMapper;
import com.sc.service.XtCompanyInfoService;
@Service
public class XtCompanyInfoServiceImpl implements XtCompanyInfoService {
    @Autowired
	XtCompanyInfoMapper xtCompanyInfoMapper;
	
	
	@Override
	public void addCompanyInfo(XtCompanyInfo companyInfo) {
		xtCompanyInfoMapper.insert(companyInfo);
	}

	@Override
	public void updateCompanyInfo(XtCompanyInfo companyInfo) {
		if(companyInfo!=null&&companyInfo.getCompanyId()!=null){
			xtCompanyInfoMapper.updateByPrimaryKey(companyInfo);
		}

	}

	@Override
	public void delectCompanyInfo(Long companyId) {
		if(companyId!=null){
			xtCompanyInfoMapper.deleteByPrimaryKey(companyId);
		}

	}

	@Override
	public XtCompanyInfo getCompanyInfo(Long companyId) {
        if(companyId!=null){
			
			return xtCompanyInfoMapper.selectByPrimaryKey(companyId);
		}
		return null;
	}

	@Override
	public PageInfo<XtCompanyInfo> selectCompanyInfo(Integer pageNum, Integer pageSize, String name) {
		PageHelper.startPage(pageNum, pageSize);
		XtCompanyInfoExample xtCompanyInfoExample = new XtCompanyInfoExample();

		com.sc.entity.XtCompanyInfoExample.Criteria createCriteria = xtCompanyInfoExample.createCriteria();

		if (name != null) {
			createCriteria.andCompanyNameLike("%" + name + "%");
		}
		xtCompanyInfoExample.setOrderByClause("COMPANY_ID");
		List<XtCompanyInfo> list = xtCompanyInfoMapper.selectByExample(xtCompanyInfoExample);
		PageInfo<XtCompanyInfo> page = new PageInfo<XtCompanyInfo>(list);
		return page;
	}

}
