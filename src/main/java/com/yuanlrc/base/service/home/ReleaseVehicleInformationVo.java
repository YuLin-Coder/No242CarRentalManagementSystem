package com.yuanlrc.base.service.home;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReleaseVehicleInformationVo {
    List<Integer> brandList;   //品牌list

    Integer automobileSeat;   //座位

    Integer automobileStalls;   //排挡

    Integer automobileType;  //类型

    String dailyRentalRate; //日租价格

    Long userId;  //user

    String rentSort;//按租金排序 2是升序，1是降序

    String emissionSort;//按排量排序 2是升序，1是降序


}
