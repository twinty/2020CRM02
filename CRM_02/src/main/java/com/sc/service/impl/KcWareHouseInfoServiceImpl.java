package com.sc.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.entity.KcWarehouseInfo;
import com.sc.entity.KcWarehouseInfoExample;
import com.sc.entity.KcWarehouseInfoExample.Criteria;
import com.sc.mapper.KcWarehouseInfoMapper;
import com.sc.service.KcWareHouseInfoService;
@Service
public class KcWareHouseInfoServiceImpl implements KcWareHouseInfoService {
	@Autowired
	KcWarehouseInfoMapper  kcWarehouseInfoMapper;
	
	//增加
	@Override
	public void addhouse(KcWarehouseInfo houseInfo) {
		
		kcWarehouseInfoMapper.insert(houseInfo);
	}
	
   //修改
	@Override
	public void updatehouse(KcWarehouseInfo houseInfo) {
		if(houseInfo!=null&&houseInfo.getWarehouseId()!=null){
			kcWarehouseInfoMapper.updateByPrimaryKey(houseInfo);
		}
	}

	//删除
	@Override
	public void deletehouse(Long warehouseId) {
		if(warehouseId!=null){
			kcWarehouseInfoMapper.deleteByPrimaryKey(warehouseId);
		}

	}

	//根据id查询
	@Override
	public KcWarehouseInfo gethouse(Long warehouseId) {
		if(warehouseId!=null){
			return kcWarehouseInfoMapper.selectByPrimaryKey(warehouseId);
		}
		return null;
	}

	//分页+时间+仓库名称模糊查询
	@Override
	public PageInfo<KcWarehouseInfo> selecthouse(Integer pageNum, Integer pageSize, KcWarehouseInfo houseInfo) {
		//通过客户名字对客户信息查询
		KcWarehouseInfoExample example = new KcWarehouseInfoExample();
		if(houseInfo!=null){//如果传入的对象不等于空，就要进行条件查询
			Criteria criteria = example.createCriteria();
			
			//通过输入的名字进行客户信息查询，所以需要判断传入的客户名字
			//以前是这样写的，现在用(这里选用的是spring框架的)工具类if(custom.getCustomName()!=null&&!custom.getCustomName().equals(""))
			if(!StringUtils.isEmpty(houseInfo.getWarehouseName())){
				//仓库名称模糊查询
				criteria.andWarehouseNameLike("%" +houseInfo.getWarehouseName()+ "%");
			}
			if(!StringUtils.isEmpty(houseInfo.getDatemax())){
				//最后修改时间大于等于最小日期
				System.out.println("----小----"+houseInfo.getDatemin());
				criteria.andLastModifyDateGreaterThanOrEqualTo(houseInfo.getDatemin());
			}
			
			if(!StringUtils.isEmpty(houseInfo.getDatemin())){
				//最后修改时间小于等于最大日期
				Date d=houseInfo.getDatemax();
				d.setHours(23);
				d.setMinutes(59);
				d.setSeconds(59);
				System.out.println("----大----"+d);
				criteria.andLastModifyDateLessThanOrEqualTo(d);
			}
		}
		
		PageHelper.startPage(pageNum, pageSize);
		List<KcWarehouseInfo> list = kcWarehouseInfoMapper.selectByExample(example);
		PageInfo<KcWarehouseInfo> page=new PageInfo<KcWarehouseInfo>(list);
		return page;
	}

	
	
}
