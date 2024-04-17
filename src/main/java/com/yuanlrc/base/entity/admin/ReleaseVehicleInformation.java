package com.yuanlrc.base.entity.admin;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.yuanlrc.base.annotion.ValidateEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.List;

/**
 * 发布可租用车辆信息
 */
@Entity
@Table(name="ylrc_releaseVehicle_information")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class ReleaseVehicleInformation extends BaseEntity {

    public static final Integer NOTPUBLISH = 0; //不发布
    public static final Integer PUBLISH = 1;    //发布

    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;  //店主|送车点

    @ManyToOne
    @JoinColumn(name="vehicle_information")
    private AutomobileInformation automobileInformation;  //车辆信息

    @ValidateEntity(required=true,errorRequiredMsg="可租车数量不能为空!",requiredMaxValue = true, maxValue = 10000,errorMaxValueMsg = "可租车数量要小于10000辆")
    @Column(name="car_number")
    private Integer mindmapTopiccarNumber; //店铺拥有车数量


    @ValidateEntity(required=false)
    @Column(name="other_services_iems")
    @ManyToMany
    private List<OtherServicesIems> otherServicesIems;//该汽车发布所拥有的服务

    @Column(name="publish_status")
    private Integer publishStatus = NOTPUBLISH; //发布状态

}
