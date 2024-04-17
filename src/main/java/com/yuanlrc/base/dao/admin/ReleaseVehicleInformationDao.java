package com.yuanlrc.base.dao.admin;

import com.yuanlrc.base.entity.admin.ReleaseVehicleInformation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;


@Repository
public interface ReleaseVehicleInformationDao extends JpaRepository<ReleaseVehicleInformation, Long>, JpaSpecificationExecutor<ReleaseVehicleInformation> {

    /**
     * 根据id查找汽车发布信息
     * @param id
     * @return
     */
    @Query("select rvi from ReleaseVehicleInformation rvi where id = :id")
    ReleaseVehicleInformation find(@Param("id")Long id);


    List<ReleaseVehicleInformation> findByUserIdAndPublishStatus(@Param("id")Long id,@Param("status")Integer status);


}
