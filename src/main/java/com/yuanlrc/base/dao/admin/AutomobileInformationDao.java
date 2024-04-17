package com.yuanlrc.base.dao.admin;

import com.yuanlrc.base.entity.admin.AutomobileInformation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AutomobileInformationDao extends JpaRepository<AutomobileInformation,Long>, JpaSpecificationExecutor<AutomobileInformation> {

    /**
     * 根据id查询汽车信息
     * @param id
     * @return
     */
    @Query("select vi from AutomobileInformation vi where id = :id")
    public AutomobileInformation find(@Param("id") Long id);

    @Query(nativeQuery = true,value = "SELECT * FROM ylrc_automobile_information a ORDER BY a.create_time DESC LIMIT 0,4")
    public List<AutomobileInformation> findByCreateTime();

}
