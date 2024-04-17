package com.yuanlrc.base.dao.home;

import com.yuanlrc.base.entity.home.DeskPersonalInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import sun.security.krb5.internal.crypto.Des;

@Repository
public interface DeskPersonalInfoDao extends JpaRepository<DeskPersonalInfo,Long> {
    /**
     * 通过id查询
     */
    @Query("select dp from DeskPersonalInfo dp where dp.id=:id")
    public DeskPersonalInfo find(@Param("id") Long id);
    /**
     * 通过DeskUser id查询
     */
    public DeskPersonalInfo findByDeskUserId(Long id);
    /**
     * 通过紧急联系人手机号查询
     */
    public DeskPersonalInfo findByEccPhone(String ecPhone);
    /**
     * 通过身份证号查询
     */
    public DeskPersonalInfo findByIdNumber(String idNumber);
}
