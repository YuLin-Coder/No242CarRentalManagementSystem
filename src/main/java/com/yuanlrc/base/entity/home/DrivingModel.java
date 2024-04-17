package com.yuanlrc.base.entity.home;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.entity.admin.BaseEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Table;

/**
 * 准驾车型信息
 */
@Entity
@Table(name="ylrc_driving_model")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class DrivingModel extends BaseEntity {

    @ValidateEntity(required=true,requiredLeng=true,minLength=1,maxLength=18,errorRequiredMsg="准驾车型不能为空!",errorMinLengthMsg="准驾车型长度需大于1!",errorMaxLengthMsg="准驾车型长度不能大于18!")
    @Column(name = "car_model")
    private String carModel;//车型 C1 C2
}
