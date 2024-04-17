package com.yuanlrc.base.entity.admin;

import com.yuanlrc.base.annotion.ValidateEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Table;

/**
 * 车辆品牌
 */
@Entity
@Table(name="ylrc_automobile_brand")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class AutomobileBrand extends BaseEntity{

    @ValidateEntity(required=true,requiredLeng=true,minLength=1,maxLength=18,errorRequiredMsg="汽车品牌不能为空!",errorMinLengthMsg="汽车品牌长度需大于1!",errorMaxLengthMsg="汽车品牌长度不能大于18!")
    @Column(name="brand",nullable=false,length=18)
    private String brand;

}
