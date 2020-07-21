package com.sc.service.impl;

import java.util.List;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.entity.KcGoodsInfo;
import com.sc.entity.KcGoodsInfoExample;
import com.sc.entity.XtDutiesInfo;
import com.sc.entity.XtDutiesInfoExample;
import com.sc.mapper.XtDutiesInfoMapper;
import com.sc.service.XtDutiesInfoServic;
@Service
public class XtDutiesInfoServicImpl implements XtDutiesInfoServic {
   @Autowired
	XtDutiesInfoMapper xtDutiesInfoMapper;
	
	@Override
	public PageInfo<XtDutiesInfo> selectDutiesInfo(Integer pageNum, Integer pageSize, XtDutiesInfo DutiesInfo,String name) {
		PageHelper.startPage(pageNum, pageSize);
		 XtDutiesInfoExample xtDutiesInfoExample = new XtDutiesInfoExample();

		com.sc.entity.XtDutiesInfoExample.Criteria createCriteria = xtDutiesInfoExample.createCriteria();

		if (name != null) {
			createCriteria.andDutiesNameLike("%" + name + "%");
		}
		
		
		
		xtDutiesInfoExample.setOrderByClause("DUTIES_ID");
		List<XtDutiesInfo> list = xtDutiesInfoMapper.selectByExample(xtDutiesInfoExample);
		PageInfo<XtDutiesInfo> page = new PageInfo<XtDutiesInfo>(list);
		return page;
	}

	@Override
	public void updateDutiesInfo(XtDutiesInfo DutiesInfo) {
		if(DutiesInfo!=null&&DutiesInfo.getDutiesId()!=null){
			xtDutiesInfoMapper.updateByPrimaryKey(DutiesInfo);
		}

	}

	@Override
	public void delectDutiesInfo(Long dutiesId) {
		if(dutiesId!=null){
			xtDutiesInfoMapper.deleteByPrimaryKey(dutiesId);
		}
	}

	

	@Override
	public XtDutiesInfo getDutiesInfo(Long dutiesId) {
		if(dutiesId!=null){
			
			return xtDutiesInfoMapper.selectByPrimaryKey(dutiesId);
				}
				return null;
			}
	

	@Override
	public XSSFWorkbook show() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageInfo<XtDutiesInfo> selectDutiesInfo1(Integer pageNum, Integer pageSize, String name, Long dutiesId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addDutiesInfo(XtDutiesInfo DutiesInfo) {
		xtDutiesInfoMapper.insert(DutiesInfo);
		
	}

}
