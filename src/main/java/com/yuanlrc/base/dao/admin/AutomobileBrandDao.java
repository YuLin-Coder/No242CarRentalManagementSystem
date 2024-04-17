package com.yuanlrc.base.dao.admin;

import com.yuanlrc.base.entity.admin.AutomobileBrand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AutomobileBrandDao extends JpaRepository<AutomobileBrand,Long> {

    /**
     * 根据车牌id查询
     * @param id
     * @return
     */
    @Query("select ab from AutomobileBrand ab where id = :id")
    public AutomobileBrand find(@Param("id")Long id);

    /**
     * 按照汽车品牌查找汽车品牌信息
     * @param brand
     * @return
     */
    public AutomobileBrand findByBrand(String brand);

}
