package com.sc.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class XtPermissionExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public XtPermissionExample() {
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

        public Criteria andQxIdIsNull() {
            addCriterion("QX_ID is null");
            return (Criteria) this;
        }

        public Criteria andQxIdIsNotNull() {
            addCriterion("QX_ID is not null");
            return (Criteria) this;
        }

        public Criteria andQxIdEqualTo(Long value) {
            addCriterion("QX_ID =", value, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdNotEqualTo(Long value) {
            addCriterion("QX_ID <>", value, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdGreaterThan(Long value) {
            addCriterion("QX_ID >", value, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdGreaterThanOrEqualTo(Long value) {
            addCriterion("QX_ID >=", value, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdLessThan(Long value) {
            addCriterion("QX_ID <", value, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdLessThanOrEqualTo(Long value) {
            addCriterion("QX_ID <=", value, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdIn(List<Long> values) {
            addCriterion("QX_ID in", values, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdNotIn(List<Long> values) {
            addCriterion("QX_ID not in", values, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdBetween(Long value1, Long value2) {
            addCriterion("QX_ID between", value1, value2, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxIdNotBetween(Long value1, Long value2) {
            addCriterion("QX_ID not between", value1, value2, "qxId");
            return (Criteria) this;
        }

        public Criteria andQxNameIsNull() {
            addCriterion("QX_NAME is null");
            return (Criteria) this;
        }

        public Criteria andQxNameIsNotNull() {
            addCriterion("QX_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andQxNameEqualTo(String value) {
            addCriterion("QX_NAME =", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameNotEqualTo(String value) {
            addCriterion("QX_NAME <>", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameGreaterThan(String value) {
            addCriterion("QX_NAME >", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameGreaterThanOrEqualTo(String value) {
            addCriterion("QX_NAME >=", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameLessThan(String value) {
            addCriterion("QX_NAME <", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameLessThanOrEqualTo(String value) {
            addCriterion("QX_NAME <=", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameLike(String value) {
            addCriterion("QX_NAME like", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameNotLike(String value) {
            addCriterion("QX_NAME not like", value, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameIn(List<String> values) {
            addCriterion("QX_NAME in", values, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameNotIn(List<String> values) {
            addCriterion("QX_NAME not in", values, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameBetween(String value1, String value2) {
            addCriterion("QX_NAME between", value1, value2, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxNameNotBetween(String value1, String value2) {
            addCriterion("QX_NAME not between", value1, value2, "qxName");
            return (Criteria) this;
        }

        public Criteria andQxIsNull() {
            addCriterion("QX is null");
            return (Criteria) this;
        }

        public Criteria andQxIsNotNull() {
            addCriterion("QX is not null");
            return (Criteria) this;
        }

        public Criteria andQxEqualTo(String value) {
            addCriterion("QX =", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxNotEqualTo(String value) {
            addCriterion("QX <>", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxGreaterThan(String value) {
            addCriterion("QX >", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxGreaterThanOrEqualTo(String value) {
            addCriterion("QX >=", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxLessThan(String value) {
            addCriterion("QX <", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxLessThanOrEqualTo(String value) {
            addCriterion("QX <=", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxLike(String value) {
            addCriterion("QX like", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxNotLike(String value) {
            addCriterion("QX not like", value, "qx");
            return (Criteria) this;
        }

        public Criteria andQxIn(List<String> values) {
            addCriterion("QX in", values, "qx");
            return (Criteria) this;
        }

        public Criteria andQxNotIn(List<String> values) {
            addCriterion("QX not in", values, "qx");
            return (Criteria) this;
        }

        public Criteria andQxBetween(String value1, String value2) {
            addCriterion("QX between", value1, value2, "qx");
            return (Criteria) this;
        }

        public Criteria andQxNotBetween(String value1, String value2) {
            addCriterion("QX not between", value1, value2, "qx");
            return (Criteria) this;
        }

        public Criteria andQxFlIdIsNull() {
            addCriterion("QX_FL_ID is null");
            return (Criteria) this;
        }

        public Criteria andQxFlIdIsNotNull() {
            addCriterion("QX_FL_ID is not null");
            return (Criteria) this;
        }

        public Criteria andQxFlIdEqualTo(Long value) {
            addCriterion("QX_FL_ID =", value, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdNotEqualTo(Long value) {
            addCriterion("QX_FL_ID <>", value, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdGreaterThan(Long value) {
            addCriterion("QX_FL_ID >", value, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdGreaterThanOrEqualTo(Long value) {
            addCriterion("QX_FL_ID >=", value, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdLessThan(Long value) {
            addCriterion("QX_FL_ID <", value, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdLessThanOrEqualTo(Long value) {
            addCriterion("QX_FL_ID <=", value, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdIn(List<Long> values) {
            addCriterion("QX_FL_ID in", values, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdNotIn(List<Long> values) {
            addCriterion("QX_FL_ID not in", values, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdBetween(Long value1, Long value2) {
            addCriterion("QX_FL_ID between", value1, value2, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andQxFlIdNotBetween(Long value1, Long value2) {
            addCriterion("QX_FL_ID not between", value1, value2, "qxFlId");
            return (Criteria) this;
        }

        public Criteria andBzIsNull() {
            addCriterion("BZ is null");
            return (Criteria) this;
        }

        public Criteria andBzIsNotNull() {
            addCriterion("BZ is not null");
            return (Criteria) this;
        }

        public Criteria andBzEqualTo(String value) {
            addCriterion("BZ =", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzNotEqualTo(String value) {
            addCriterion("BZ <>", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzGreaterThan(String value) {
            addCriterion("BZ >", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzGreaterThanOrEqualTo(String value) {
            addCriterion("BZ >=", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzLessThan(String value) {
            addCriterion("BZ <", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzLessThanOrEqualTo(String value) {
            addCriterion("BZ <=", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzLike(String value) {
            addCriterion("BZ like", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzNotLike(String value) {
            addCriterion("BZ not like", value, "bz");
            return (Criteria) this;
        }

        public Criteria andBzIn(List<String> values) {
            addCriterion("BZ in", values, "bz");
            return (Criteria) this;
        }

        public Criteria andBzNotIn(List<String> values) {
            addCriterion("BZ not in", values, "bz");
            return (Criteria) this;
        }

        public Criteria andBzBetween(String value1, String value2) {
            addCriterion("BZ between", value1, value2, "bz");
            return (Criteria) this;
        }

        public Criteria andBzNotBetween(String value1, String value2) {
            addCriterion("BZ not between", value1, value2, "bz");
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