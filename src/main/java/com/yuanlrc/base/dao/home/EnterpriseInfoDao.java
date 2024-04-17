package com.yuanlrc.base.dao.home;

import com.yuanlrc.base.entity.home.EnterpriseInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface EnterpriseInfoDao extends JpaRepository<EnterpriseInfo,Long> {
    /**
     * 通过id查询
     */
    @Query("select e from EnterpriseInfo e where e.id=:id")
    EnterpriseInfo find(@Param("id") Long id);
    /**
     * 通过前台用户啊id查询
     */
    EnterpriseInfo findByDeskUserId(Long deskUserId);

    /**
     * 通过前台用户啊id查询
     */
    EnterpriseInfo findByEnterpriseName(String enName);
}
