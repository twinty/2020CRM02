package com.sc.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class KcGoodsInfo implements Serializable {
    private Long productId;

    private String productName;

    private String productType;

    private String ggsm;

    private String unit;

    private BigDecimal warehouseId;//ccangku

    private BigDecimal kcNum;

    private BigDecimal cost;

    private BigDecimal renall;

    private BigDecimal sell;

    private String orderRemark;

    private Long companyId;
    
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date lastModifyDate;
    
    
  //扩展属性 用于日期范围查询
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datemin;
    
    //扩展属性 用于日期范围查询
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datemax;
    
    
    
    
    
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
	
	

	//这是我创建的拓展属性，不要删除哈
    private CgRepGoods cgRepGoods;

    private static final long serialVersionUID = 1L;

    public KcGoodsInfo(Long productId, String productName, String productType, String ggsm, String unit, BigDecimal warehouseId, BigDecimal kcNum, BigDecimal cost, BigDecimal renall, BigDecimal sell, String orderRemark, Long companyId, Date lastModifyDate) {
        this.productId = productId;
        this.productName = productName;
        this.productType = productType;
        this.ggsm = ggsm;
        this.unit = unit;
        this.warehouseId = warehouseId;
        this.kcNum = kcNum;
        this.cost = cost;
        this.renall = renall;
        this.sell = sell;
        this.orderRemark = orderRemark;
        this.companyId = companyId;
        this.lastModifyDate = lastModifyDate;
    }

    public KcGoodsInfo() {
        super();
    }

    
    
    public CgRepGoods getCgRepGoods() {
		return cgRepGoods;
	}

	public void setCgRepGoods(CgRepGoods cgRepGoods) {
		this.cgRepGoods = cgRepGoods;
	}

	public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName == null ? null : productName.trim();
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType == null ? null : productType.trim();
    }

    public String getGgsm() {
        return ggsm;
    }

    public void setGgsm(String ggsm) {
        this.ggsm = ggsm == null ? null : ggsm.trim();
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit == null ? null : unit.trim();
    }

    public BigDecimal getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(BigDecimal warehouseId) {
        this.warehouseId = warehouseId;
    }

    public BigDecimal getKcNum() {
        return kcNum;
    }

    public void setKcNum(BigDecimal kcNum) {
        this.kcNum = kcNum;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public BigDecimal getRenall() {
        return renall;
    }

    public void setRenall(BigDecimal renall) {
        this.renall = renall;
    }

    public BigDecimal getSell() {
        return sell;
    }

    public void setSell(BigDecimal sell) {
        this.sell = sell;
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

	@Override
	public String toString() {
		return "KcGoodsInfo [productId=" + productId + ", productName=" + productName + ", productType=" + productType
				+ ", ggsm=" + ggsm + ", unit=" + unit + ", warehouseId=" + warehouseId + ", kcNum=" + kcNum + ", cost="
				+ cost + ", renall=" + renall + ", sell=" + sell + ", orderRemark=" + orderRemark + ", companyId="
				+ companyId + ", lastModifyDate=" + lastModifyDate + ", datemin=" + datemin + ", datemax=" + datemax
				+ ", cgRepGoods=" + cgRepGoods + "]";
	}

	
    
    
    
}