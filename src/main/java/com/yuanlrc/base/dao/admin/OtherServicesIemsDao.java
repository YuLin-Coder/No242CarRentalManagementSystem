package com.yuanlrc.base.dao.admin;

import com.yuanlrc.base.entity.admin.OtherServicesIems;
import com.yuanlrc.base.entity.admin.ReleaseVehicleInformation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OtherServicesIemsDao extends JpaRepository<OtherServicesIems,Long> , JpaSpecificationExecutor<OtherServicesIems> {

    /**
     * 根据id查找其他服务
     * @param id
     * @return
     */
    @Query("select osi from OtherServicesIems osi where id = :id")
    OtherServicesIems find(@Param("id")Long id);

}
