package com.yuanlrc.base.entity.admin;

import lombok.Data;
import lombok.ToString;
import lombok.experimental.Accessors;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Table;

/*支付实体对象*/
@Data
@Entity
@Table(name="ylrc_Alipay")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Accessors(chain = true)
public class Alipay extends BaseEntity {

    /*商户订单号，必填*/
    @Column(name="out_trade_no")
    private String out_trade_no;
    /*订单名称，必填*/
    @Column(name="subject")
    private String subject;
    /*付款金额，必填*/
    @Column(name="total_amount")
    private String total_amount;
    /*商品描述，可空*/
    @Column(name="body")
    private String body;

    /*超时时间参数*/
    private String timeout_express="30m";

    private String product_code="FAST_INSTANT_TRADE_PAY";
}