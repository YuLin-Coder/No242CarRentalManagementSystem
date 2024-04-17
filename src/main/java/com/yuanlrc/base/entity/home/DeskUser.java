package com.yuanlrc.base.entity.home;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.entity.admin.BaseEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;


/**
 * 前台用户
 */
@Entity
@Table(name="ylrc_front_desk_user")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class DeskUser extends BaseEntity {

    @ValidateEntity(required=true,errorRequiredMsg="手机号为登录账号,不能为空!")
    @Column(name = "phone")
    private String phone;//手机号  即登录账号
    @ValidateEntity(required=true,requiredLeng=true,minLength=4,maxLength=18,errorRequiredMsg="登录密码不能为空"
            ,errorMinLengthMsg="登录密码长度不能小于4!",errorMaxLengthMsg="登录密码长度不能大于18!")
    @Column(name = "password")
    private String password;//登录密码

    @ValidateEntity(required = true,errorRequiredMsg = "电子邮箱不能为空")
    @Column(name = "demail")
    private String demail;//电子邮箱

    @ValidateEntity(required = true,errorRequiredMsg = "身份类型不能为空")
    @Column(name = "type")
    private Integer type;//是否是个人  1个人/0企业

    @OneToOne
    @JoinColumn(name = "desk_user_driver_info_id")
    private DeskUserDriverInfo deskUserDriverInfo;//驾驶证信息

    @Column(name="status",length=1)
    private Integer status;//状态 个人:默认可用 企业:默认不可用
}
