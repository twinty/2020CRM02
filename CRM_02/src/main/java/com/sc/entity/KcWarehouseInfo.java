package com.sc.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class KcWarehouseInfo implements Serializable {
    private Long warehouseId;

    private String warehouseName;

    private String orderRemark;

    private Long companyId;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date lastModifyDate;
    
  //扩展属性 用于日期范围查询
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datemin;
    
    //扩展属性 用于日期范围查询
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datemax;

  

	@Override
	public String toString() {
		return "KcWarehouseInfo [warehouseId=" + warehouseId + ", warehouseName=" + warehouseName + ", orderRemark="
				+ orderRemark + ", companyId=" + companyId + ", lastModifyDate=" + lastModifyDate + ", datemin="
				+ datemin + ", datemax=" + datemax + "]";
	}

	public Date getDatemin() {
		return datemin;
	}

	public void setDatemin(Date datemin) {
		this.datemin = datemin;
	}

	public Date getDatemax() {
		return datemax;
	}

	public void setDatemax(Date datemax) {
		this.datemax = datemax;
	}

	private static final long serialVersionUID = 1L;

    public KcWarehouseInfo(Long warehouseId, String warehouseName, String orderRemark, Long companyId, Date lastModifyDate) {
        this.warehouseId = warehouseId;
        this.warehouseName = warehouseName;
        this.orderRemark = orderRemark;
        this.companyId = companyId;
        this.lastModifyDate = lastModifyDate;
    }

    public KcWarehouseInfo() {
        super();
    }

    public Long getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Long warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName == null ? null : warehouseName.trim();
    }

    public String getOrderRemark() {
        return orderRemark;
    }

    public void setOrderRemark(String orderRemark) {
        this.orderRemark = orderRemark == null ? null : orderRemark.trim();
    }

    public Long getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Long companyId) {
        this.companyId = companyId;
    }

    public Date getLastModifyDate() {
        return lastModifyDate;
    }

    public void setLastModifyDate(Date lastModifyDate) {
        this.lastModifyDate = lastModifyDate;
    }

	public Object getDepotName() {
		// TODO Auto-generated method stub
		return warehouseName;
	}
}