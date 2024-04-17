package com.yuanlrc.base.entity.home;

import com.yuanlrc.base.annotion.ValidateEntity;
import com.yuanlrc.base.entity.admin.*;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.lang.annotation.Target;
import java.util.Date;
import java.util.List;

/**
 * 个人订单
 */
@Entity
@Table(name="ylrc_order")
@EntityListeners(AuditingEntityListener.class)
@ToString
@Data
public class Order extends BaseEntity {


    public static final Integer RESERVING = 1;//预约中
    public static final Integer RENTING = 2;//租赁中
    public static final Integer COMPLETE = 3;//已完成
    public static final Integer CANCELED = 0;//已取消


    
    @Column(name = "out_trade_no")
    private String outTradeNo;  //订单号

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "collection_time")
    private Date collectionTime;//取车时间

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "return_time")
    private Date returnTime;//还车时间


    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "reality_collection_time")
    private Date realityCollectionTime;//实际取车时间

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "reality_return_time")
    private Date realityReturnTime;//实际还车时间

    @ManyToOne
    @JoinColumn(name = "rv_info_id")
    private ReleaseVehicleInformation releaseVehicleInformation;//车辆发布信息

    @ManyToOne
    @JoinColumn(name = "desk_user_id")
    private DeskUser deskUser;//前台用户

    @Column(name = "type")
    private Integer type;//订单类型

    @ValidateEntity(required=false)
    @Column(name="other_services_authorities")
    @ManyToMany
    private List<OtherServicesIems> otherServicesAuthorities;//该订单所拥有的服务


}
