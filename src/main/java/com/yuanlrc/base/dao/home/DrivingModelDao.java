package com.yuanlrc.base.dao.home;

import com.yuanlrc.base.entity.home.DrivingModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DrivingModelDao extends JpaRepository<DrivingModel,Long> {
    /**
     * 通过id查询
     */
    @Query("select d from DrivingModel d where d.id=:id")
    public DrivingModel find(@Param("id") Long id);

    /**
     * 通过准驾车型从查询
     */
    public DrivingModel findByCarModel(String carModel);
}
