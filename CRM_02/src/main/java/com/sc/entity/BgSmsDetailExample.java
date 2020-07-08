package com.sc.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BgSmsDetailExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public BgSmsDetailExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andDetaileIdIsNull() {
            addCriterion("DETAILE_ID is null");
            return (Criteria) this;
        }

        public Criteria andDetaileIdIsNotNull() {
            addCriterion("DETAILE_ID is not null");
            return (Criteria) this;
        }

        public Criteria andDetaileIdEqualTo(Long value) {
            addCriterion("DETAILE_ID =", value, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdNotEqualTo(Long value) {
            addCriterion("DETAILE_ID <>", value, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdGreaterThan(Long value) {
            addCriterion("DETAILE_ID >", value, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdGreaterThanOrEqualTo(Long value) {
            addCriterion("DETAILE_ID >=", value, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdLessThan(Long value) {
            addCriterion("DETAILE_ID <", value, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdLessThanOrEqualTo(Long value) {
            addCriterion("DETAILE_ID <=", value, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdIn(List<Long> values) {
            addCriterion("DETAILE_ID in", values, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdNotIn(List<Long> values) {
            addCriterion("DETAILE_ID not in", values, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdBetween(Long value1, Long value2) {
            addCriterion("DETAILE_ID between", value1, value2, "detaileId");
            return (Criteria) this;
        }

        public Criteria andDetaileIdNotBetween(Long value1, Long value2) {
            addCriterion("DETAILE_ID not between", value1, value2, "detaileId");
            return (Criteria) this;
        }

        public Criteria andSmsIdIsNull() {
            addCriterion("SMS_ID is null");
            return (Criteria) this;
        }

        public Criteria andSmsIdIsNotNull() {
            addCriterion("SMS_ID is not null");
            return (Criteria) this;
        }

        public Criteria andSmsIdEqualTo(Long value) {
            addCriterion("SMS_ID =", value, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdNotEqualTo(Long value) {
            addCriterion("SMS_ID <>", value, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdGreaterThan(Long value) {
            addCriterion("SMS_ID >", value, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdGreaterThanOrEqualTo(Long value) {
            addCriterion("SMS_ID >=", value, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdLessThan(Long value) {
            addCriterion("SMS_ID <", value, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdLessThanOrEqualTo(Long value) {
            addCriterion("SMS_ID <=", value, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdIn(List<Long> values) {
            addCriterion("SMS_ID in", values, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdNotIn(List<Long> values) {
            addCriterion("SMS_ID not in", values, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdBetween(Long value1, Long value2) {
            addCriterion("SMS_ID between", value1, value2, "smsId");
            return (Criteria) this;
        }

        public Criteria andSmsIdNotBetween(Long value1, Long value2) {
            addCriterion("SMS_ID not between", value1, value2, "smsId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdIsNull() {
            addCriterion("RECEIVER_ID is null");
            return (Criteria) this;
        }

        public Criteria andReceiverIdIsNotNull() {
            addCriterion("RECEIVER_ID is not null");
            return (Criteria) this;
        }

        public Criteria andReceiverIdEqualTo(Long value) {
            addCriterion("RECEIVER_ID =", value, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdNotEqualTo(Long value) {
            addCriterion("RECEIVER_ID <>", value, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdGreaterThan(Long value) {
            addCriterion("RECEIVER_ID >", value, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdGreaterThanOrEqualTo(Long value) {
            addCriterion("RECEIVER_ID >=", value, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdLessThan(Long value) {
            addCriterion("RECEIVER_ID <", value, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdLessThanOrEqualTo(Long value) {
            addCriterion("RECEIVER_ID <=", value, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdIn(List<Long> values) {
            addCriterion("RECEIVER_ID in", values, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdNotIn(List<Long> values) {
            addCriterion("RECEIVER_ID not in", values, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdBetween(Long value1, Long value2) {
            addCriterion("RECEIVER_ID between", value1, value2, "receiverId");
            return (Criteria) this;
        }

        public Criteria andReceiverIdNotBetween(Long value1, Long value2) {
            addCriterion("RECEIVER_ID not between", value1, value2, "receiverId");
            return (Criteria) this;
        }

        public Criteria andInformationStateIsNull() {
            addCriterion("INFORMATION_STATE is null");
            return (Criteria) this;
        }

        public Criteria andInformationStateIsNotNull() {
            addCriterion("INFORMATION_STATE is not null");
            return (Criteria) this;
        }

        public Criteria andInformationStateEqualTo(String value) {
            addCriterion("INFORMATION_STATE =", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateNotEqualTo(String value) {
            addCriterion("INFORMATION_STATE <>", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateGreaterThan(String value) {
            addCriterion("INFORMATION_STATE >", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateGreaterThanOrEqualTo(String value) {
            addCriterion("INFORMATION_STATE >=", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateLessThan(String value) {
            addCriterion("INFORMATION_STATE <", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateLessThanOrEqualTo(String value) {
            addCriterion("INFORMATION_STATE <=", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateLike(String value) {
            addCriterion("INFORMATION_STATE like", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateNotLike(String value) {
            addCriterion("INFORMATION_STATE not like", value, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateIn(List<String> values) {
            addCriterion("INFORMATION_STATE in", values, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateNotIn(List<String> values) {
            addCriterion("INFORMATION_STATE not in", values, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateBetween(String value1, String value2) {
            addCriterion("INFORMATION_STATE between", value1, value2, "informationState");
            return (Criteria) this;
        }

        public Criteria andInformationStateNotBetween(String value1, String value2) {
            addCriterion("INFORMATION_STATE not between", value1, value2, "informationState");
            return (Criteria) this;
        }

        public Criteria andCompanyIdIsNull() {
            addCriterion("COMPANY_ID is null");
            return (Criteria) this;
        }

        public Criteria andCompanyIdIsNotNull() {
            addCriterion("COMPANY_ID is not null");
            return (Criteria) this;
        }

        public Criteria andCompanyIdEqualTo(Long value) {
            addCriterion("COMPANY_ID =", value, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdNotEqualTo(Long value) {
            addCriterion("COMPANY_ID <>", value, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdGreaterThan(Long value) {
            addCriterion("COMPANY_ID >", value, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdGreaterThanOrEqualTo(Long value) {
            addCriterion("COMPANY_ID >=", value, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdLessThan(Long value) {
            addCriterion("COMPANY_ID <", value, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdLessThanOrEqualTo(Long value) {
            addCriterion("COMPANY_ID <=", value, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdIn(List<Long> values) {
            addCriterion("COMPANY_ID in", values, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdNotIn(List<Long> values) {
            addCriterion("COMPANY_ID not in", values, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdBetween(Long value1, Long value2) {
            addCriterion("COMPANY_ID between", value1, value2, "companyId");
            return (Criteria) this;
        }

        public Criteria andCompanyIdNotBetween(Long value1, Long value2) {
            addCriterion("COMPANY_ID not between", value1, value2, "companyId");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateIsNull() {
            addCriterion("LAST_MODIFY_DATE is null");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateIsNotNull() {
            addCriterion("LAST_MODIFY_DATE is not null");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateEqualTo(Date value) {
            addCriterion("LAST_MODIFY_DATE =", value, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateNotEqualTo(Date value) {
            addCriterion("LAST_MODIFY_DATE <>", value, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateGreaterThan(Date value) {
            addCriterion("LAST_MODIFY_DATE >", value, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateGreaterThanOrEqualTo(Date value) {
            addCriterion("LAST_MODIFY_DATE >=", value, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateLessThan(Date value) {
            addCriterion("LAST_MODIFY_DATE <", value, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateLessThanOrEqualTo(Date value) {
            addCriterion("LAST_MODIFY_DATE <=", value, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateIn(List<Date> values) {
            addCriterion("LAST_MODIFY_DATE in", values, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateNotIn(List<Date> values) {
            addCriterion("LAST_MODIFY_DATE not in", values, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateBetween(Date value1, Date value2) {
            addCriterion("LAST_MODIFY_DATE between", value1, value2, "lastModifyDate");
            return (Criteria) this;
        }

        public Criteria andLastModifyDateNotBetween(Date value1, Date value2) {
            addCriterion("LAST_MODIFY_DATE not between", value1, value2, "lastModifyDate");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}