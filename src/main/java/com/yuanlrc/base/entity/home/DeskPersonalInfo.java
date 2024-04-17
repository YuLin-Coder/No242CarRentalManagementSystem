package com.yuanlrc.base.entity.home;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.entity.admin.BaseEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

/**
 * 前台用户信息
 */
@Entity
@Table(name="ylrc_front_desk_personalInformation")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class DeskPersonalInfo extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "deskUser_id")
    private DeskUser deskUser;//前台用户

    @ValidateEntity(required=true,requiredLeng=true,minLength=2,maxLength=18,errorRequiredMsg="身份证姓名不能为空"
            ,errorMinLengthMsg="身份证姓名不能小于2",errorMaxLengthMsg="身份证姓名长度不能大于18")
    @Column(name = "id_card_name")
    private String idCardName;//身份证姓名

    @ValidateEntity(required=true,errorRequiredMsg="身份证号不能为空")
    @Column(name = "id_number")
    private String idNumber;//身份证号

    @Column(name = "head_pic")
    private String headPic;//头像

    @ValidateEntity(required=true,requiredLeng=true,minLength=2,maxLength=18,errorRequiredMsg="紧急联系人姓名不能为空"
            ,errorMinLengthMsg="紧急联系人姓名不能小于2",errorMaxLengthMsg="紧急联系人姓名长度不能大于18")
    @Column(name = "emergency_contact_name")
    private String ecName;//紧急联系人姓名

    @ValidateEntity(required=true,errorRequiredMsg="紧急联系人手机号不能为空!")
    @Column(name = "emergency_contact_phone_number")
    private String eccPhone;//紧急联系人手机号

    @ValidateEntity(required=true,errorRequiredMsg="紧急联系人住址不能为空", requiredLeng=true,minLength=2,maxLength=18
            ,errorMinLengthMsg="紧急联系人住址长度不低于5",errorMaxLengthMsg="紧急联系人住址长度不能高于100")
    @Column(name = "emergency_contact_address")
    private String eccAddress;//紧急联系人住址
}
