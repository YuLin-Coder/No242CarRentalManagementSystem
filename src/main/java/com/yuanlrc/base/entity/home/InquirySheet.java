package com.yuanlrc.base.entity.home;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.entity.admin.BaseEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Table;
import java.util.Date;

/**
 * 询价单
 */

@Entity
@Table(name="ylrc_inquiry_sheet")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class InquirySheet extends BaseEntity {

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "boarding_time")
    private Date boardingTime;//上车时间

    @ValidateEntity(required=true,requiredLeng=true,minLength=5,maxLength=100,errorRequiredMsg="上车地点不能为空"
            ,errorMinLengthMsg="上车地点长度不能小于5",errorMaxLengthMsg="上车地点长度不能大于100")
    @Column(name = "boarding_location")
    private String boardingLocation;//上车地点

    @Column(name = "boarding_location_nearby")
    private String boardingLocationNearby;//上车地点附近的小区或者街道

    @ValidateEntity(required=false)
    @Column(name = "demand")
    private String demand;//其他需求

    @ValidateEntity(required=true,requiredLeng=true,minLength=2,maxLength=18,errorRequiredMsg="姓名不能为空"
            ,errorMinLengthMsg="姓名长度不能小于2",errorMaxLengthMsg="姓名长度不能大于18")
    @Column(name = "name")
    private String name;//姓名

    @ValidateEntity(required=true,errorRequiredMsg="手机号不能为空")
    @Column(name = "phone")
    private String phone;//电话号

    @ValidateEntity(required = true,errorRequiredMsg = "电子邮箱不能为空")
    @Column(name = "email")
    private String email;//电子邮箱
}
