package com.yuanlrc.base.dao.home;

import com.yuanlrc.base.entity.home.DeskUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DeskUserDao extends JpaRepository<DeskUser,Long> {

    /**
     * 通过id查询
     */
    @Query("select d from DeskUser d where d.id=:id")
    public DeskUser find(@Param("id") Long id);

    /**
     * 通过手机号查询
     */
    @Query("select d from DeskUser d where d.phone=:phone")
    public DeskUser findByPhone(@Param("phone") String phone);

    /**
     * 通过邮箱查询
     */
    @Query("select d from DeskUser d where d.demail=:demail")
    public DeskUser findByDemail(@Param("demail") String email);
}
