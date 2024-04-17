package com.yuanlrc.base.entity.admin;
/**
 * 订单验证日志记录表
 */

import com.yuanlrc.base.annotion.ValidateEntity;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Table;


@Entity
@Table(name="ylrc_order_auth")
@EntityListeners(AuditingEntityListener.class)
public class OrderAuth extends BaseEntity{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ValidateEntity(required=true,requiredLeng=true,minLength=11,maxLength=11,errorRequiredMsg="手机号不能为空!",errorMinLengthMsg="手机号长为11!",errorMaxLengthMsg="手机号长度不能大于11!")
	@Column(name="phone",nullable=false,length=12)
	private String phone;//手机号
	
	@ValidateEntity(required=true,requiredLeng=true,minLength=18,maxLength=18,errorRequiredMsg="订单号不能为空!",errorMinLengthMsg="订单号长度不能小于18!",errorMaxLengthMsg="订单号长度不能大于18!")
	@Column(name="order_sn",nullable=false,length=18)
	private String orderSn;//订单编号
	
	@ValidateEntity(required=false)
	@Column(name="mac",length=32)
	private String mac ;//mac

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getOrderSn() {
		return orderSn;
	}

	public void setOrderSn(String orderSn) {
		this.orderSn = orderSn;
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	@Override
	public String toString() {
		return "OrderAuth [phone=" + phone + ", orderSn=" + orderSn + ", mac="
				+ mac + "]";
	}
	
	
	
	
	
}
