package com.yuanlrc.base.dao.admin;

import com.yuanlrc.base.entity.admin.Alipay;
import com.yuanlrc.base.entity.admin.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AlipayDao extends JpaRepository<Alipay,Long> {

    /**
     * 根据支付报订单号id查询
     * @param out_trade_no
     * @return
     */
    @Query("select a from Alipay a where out_trade_no = :out_trade_no")
    public Alipay findByOut_trade_no(@Param("out_trade_no")String out_trade_no);


}
