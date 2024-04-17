package com.yuanlrc.base.entity.admin;

import com.yuanlrc.base.annotion.ValidateEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

/**
 * 其他服务
 */
@Entity
@Table(name="ylrc_other_services_iems")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class OtherServicesIems extends BaseEntity {

    @ValidateEntity(required=true,requiredLeng=true,minLength=1,maxLength=18,errorRequiredMsg="其他服务名称不能为空!",errorMinLengthMsg="其他服务名称长度需大于1!",errorMaxLengthMsg="其他服务名称长度不能大于18!")
    @Column(name="name",nullable=false,length=18)
    private String name;

    @ValidateEntity(required=true,requiredMaxValue = true, maxValue = 1000000,errorMaxValueMsg = "其他服务价格不能超过一百万",errorRequiredMsg="其他服务价格不能为空!")
    @Column(name="money")
    private Double money;  //其他服务金额




}
