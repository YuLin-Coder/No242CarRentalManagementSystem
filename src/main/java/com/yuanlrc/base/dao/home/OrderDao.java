package com.yuanlrc.base.dao.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.entity.home.Order;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDao extends JpaRepository<Order,Long>, JpaSpecificationExecutor<Order> {

    /**
     * 通过id查询
     */
    @Query("select o from Order o where o.id=:id")
    Order find(@Param("id") Long id);

    /**
     * 通过类型查询和前台用户id查询
     */
    List<Order> findByDeskUserIdAndType(Long deskUserId,Integer type);

    /**
     * 通过前台用户id查询
     */
    List<Order> findByDeskUserId(Long deskUserId);

    /**
     * 通过订单号查询
     */
    Order findByOutTradeNo(String outTradeNo);

}
