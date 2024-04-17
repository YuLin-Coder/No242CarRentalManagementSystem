package com.yuanlrc.base.entity.home;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.entity.admin.BaseEntity;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * 前台用户驾驶证信息
 */
@Entity
@Table(name="ylrc_desk_user_driver_info")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class DeskUserDriverInfo extends BaseEntity {

    @ValidateEntity(required=true,errorRequiredMsg="驾驶证号不能为空")
    @Column(name = "driver_number")
    private String driverNumber;

    @ManyToOne
    @JoinColumn(name = "driving_model_id")
    private DrivingModel drivingModel;//准假车型

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "start")
    private Date start;//驾驶证领取时间

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "end")
    private Date end;//驾驶证到期时间
}
