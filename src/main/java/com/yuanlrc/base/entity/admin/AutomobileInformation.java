package com.yuanlrc.base.entity.admin;

import com.yuanlrc.base.annotion.ValidateEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import javax.persistence.*;

/**
 * 车辆信息
 */
@Entity
@Table(name="ylrc_automobile_information")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class AutomobileInformation extends BaseEntity {

    @ValidateEntity(required=true,errorRequiredMsg="汽车介绍图片不能为空!")
    @Column(name="automobile_picture_path")
    private String automobilePicturePath;   //汽车介绍图片路径

    @ValidateEntity(required=true,errorRequiredMsg="汽车介绍视频不能为空!")
    @Column(name="automobile_video_path")
    private String automobileVideoPath; //汽车介绍视频路径

    @ValidateEntity(required=true,requiredLeng = true,maxLength=30, errorMaxLengthMsg="汽车介绍名称长度需小于30!" ,errorRequiredMsg="汽车介绍名称不能为空!")
    private String introduceName;   //汽车介绍名称

    @ValidateEntity(required=true,errorRequiredMsg="汽车介绍名称不能为空!")
    private String vehicleDisplacement; //汽车排量

    @ValidateEntity(required=true,requiredMaxValue = true, maxValue = 1000000,errorMaxValueMsg = "汽车日租价格太贵了,不能超过一百万",errorRequiredMsg="汽车日租价格不能为空!")
    @Column(name="daily_rental_rate")
    private Double dailyRentalRate;  //汽车日租价格

    @ValidateEntity(required=true,requiredMaxValue = true, maxValue = 1000000,errorMaxValueMsg = "汽车押金太贵了,不能超过一百万",errorRequiredMsg="汽车押金不能为空!")
    @Column(name="vehicle_deposit")
    private Double vehicleDeposit;  //汽车押金

    @ValidateEntity(required=true,requiredMaxValue = true, maxValue = 1000000,errorMaxValueMsg = "违章押金太贵了,不能超过一百万",errorRequiredMsg="违章押金不能为空!")
    @Column(name="violation_of_the_deposit")
    private Double violationOfTheDeposit;  //违章押金

    @Enumerated
    @Column(name="automobile_type")
    private AutomobileTypeEnum automobileType;    //汽车类型

    @ManyToOne
    @JoinColumn(name="automobile_brand_id")
    private AutomobileBrand automobileBrand;    //汽车品牌

    @Enumerated
    @Column(name="Automobile_gear")
    private AutomobileStallsEnum automobileStalls;  //汽车排挡

    @Enumerated
    @Column(name="automobile_seat")
    private AutomobileSeatEnum automobileSeat;    //汽车座位

    @ValidateEntity(required=true,requiredLeng = true,maxLength=100, errorMaxLengthMsg="汽车介绍标签总和长度需小于100!" ,errorRequiredMsg="汽车介绍标签不能为空!")
    @Column(name="introduction_labels")
    private String introductionLabels; //介绍汽车标签

}
