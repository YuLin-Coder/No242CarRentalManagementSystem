package com.yuanlrc.base.dao.home;

import com.yuanlrc.base.entity.home.DeskUserDriverInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DeskUserDriverInfoDao extends JpaRepository<DeskUserDriverInfo,Long> {
    /**
     * 通过id查询
     */
    @Query("select d from DeskUserDriverInfo d where d.id=:id")
    public DeskUserDriverInfo find(@Param("id") Long id);
    /**
     * 通过驾驶证号查询
     */
    public DeskUserDriverInfo findByDriverNumber(String driverNumber);
}
