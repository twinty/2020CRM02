package com.sc.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class XtDutiesInfo implements Serializable {
    private Long dutiesId;

    private String dutiesName;

    private Long sectionId;

    public Date getDatemin() {
		return datemin;
	}

	@Override
	public String toString() {
		return "XtDutiesInfo [dutiesId=" + dutiesId + ", dutiesName=" + dutiesName + ", sectionId=" + sectionId
				+ ", orderRemark=" + orderRemark + ", companyId=" + companyId + ", lastModifyDate=" + lastModifyDate
				+ ", datemin=" + datemin + ", datemax=" + datemax + "]";
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

	private String orderRemark;

    private Long companyId;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date lastModifyDate;
    
    
  //扩展属性,用于查询-start
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datemin;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datemax;
    

    private static final long serialVersionUID = 1L;

    public XtDutiesInfo(Long dutiesId, String dutiesName, Long sectionId, String orderRemark, Long companyId, Date lastModifyDate) {
        this.dutiesId = dutiesId;
        this.dutiesName = dutiesName;
        this.sectionId = sectionId;
        this.orderRemark = orderRemark;
        this.companyId = companyId;
        this.lastModifyDate = lastModifyDate;
    }

    public XtDutiesInfo() {
        super();
    }

    public Long getDutiesId() {
        return dutiesId;
    }

    public void setDutiesId(Long dutiesId) {
        this.dutiesId = dutiesId;
    }

    public String getDutiesName() {
        return dutiesName;
    }

    public void setDutiesName(String dutiesName) {
        this.dutiesName = dutiesName == null ? null : dutiesName.trim();
    }

    public Long getSectionId() {
        return sectionId;
    }

    public void setSectionId(Long sectionId) {
        this.sectionId = sectionId;
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
}