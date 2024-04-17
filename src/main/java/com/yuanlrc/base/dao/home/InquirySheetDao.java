package com.yuanlrc.base.dao.home;

import com.yuanlrc.base.entity.home.InquirySheet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface InquirySheetDao extends JpaRepository<InquirySheet,Long> {

    /**
     * 通过id查询
     */
    @Query("select i from InquirySheet i where i.id = :id")
    InquirySheet find(@Param("id") Long id);
}
