package com.yuanlrc.base.entity.home;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.entity.admin.BaseEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

/**
 * 前台企业用户信息
 */
@Entity
@Table(name="ylrc_front_desk_enterpriseInformation")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class EnterpriseInfo extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "desk_user_id")
    private DeskUser deskUser;//前台用户

    @ValidateEntity(required=true,requiredLeng=true,minLength=4,maxLength=32,errorRequiredMsg="企业名不能为空!",errorMinLengthMsg="企业名长度大于4!",errorMaxLengthMsg="企业名长度小于32!")
    @Column(name = "enterprise_name")
    private String enterpriseName;//企业名

    @Column(name = "enterprise_no")
    private String enterpriseNo;//企业账号

    @Column(name = "enterprise_pic")
    private String enterprisePic;//营业执照照片

}
