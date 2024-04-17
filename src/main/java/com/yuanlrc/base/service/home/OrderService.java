package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.admin.AlipayDao;
import com.yuanlrc.base.dao.admin.OtherServicesIemsDao;
import com.yuanlrc.base.dao.admin.ReleaseVehicleInformationDao;
import com.yuanlrc.base.dao.home.OrderDao;
import com.yuanlrc.base.entity.admin.Alipay;
import com.yuanlrc.base.entity.admin.OtherServicesIems;
import com.yuanlrc.base.entity.admin.ReleaseVehicleInformation;
import com.yuanlrc.base.entity.admin.User;
import com.yuanlrc.base.entity.home.DeskUser;
import com.yuanlrc.base.entity.home.Order;
import com.yuanlrc.base.service.admin.OtherServicesIemsService;
import com.yuanlrc.base.service.admin.ReleaseVehicleInformationService;
import com.yuanlrc.base.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.persistence.criteria.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ReleaseVehicleInformationDao releaseVehicleInformationDao;

    @Autowired
    private OtherServicesIemsDao otherServicesIemsDao;

    @Autowired
    private AlipayDao alipayDao;

    /**
     * 添加/编辑
     */
    public Order save(Order order) {
        return orderDao.save(order);
    }

    /**
     * 删除
     */
    public void delete(Long id) {
        orderDao.deleteById(id);
    }

    /**
     * 查询所有
     */
    public List<Order> findAll() {
        return orderDao.findAll();
    }

    /**
     * 通过前台用户id和类型查询
     */
    public List<Order> findByDeskUserIdAndType(Long deskUserId, Integer type) {
        return orderDao.findByDeskUserIdAndType(deskUserId, type);
    }

    /**
     * 根据编号查询
     * @param outTradeNo
     * @return
     */
    public Order findByOutTradeNo(String outTradeNo) {
        return orderDao.findByOutTradeNo(outTradeNo);
    }

    /**
     * 通过前台用户id查询
     */
    public List<Order> findByDeskUserId(Long deskUserId) {
        return orderDao.findByDeskUserId(deskUserId);
    }

    /**
     * 通过id查询
     */
    public Order find(Long id) {
        return orderDao.find(id);
    }

    /**
     * 分页查询所有
     */
    public PageBean<Order> findList(Order order, PageBean<Order> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching().withIgnorePaths("type");
        Example<Order> example = Example.of(order, exampleMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<Order> findAll = orderDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }


    /**
     * 分页查询汽车发布信息列表
     *
     * @param pageBean
     * @return
     */
    public PageBean<Order> findList(PageBean<Order> pageBean) {
        DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
        Specification<Order> specification = new Specification<Order>() {

            @Override
            public Predicate toPredicate(Root<Order> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                
                Predicate predicate = criteriaBuilder.gt(root.get("type"), -1);
                predicate = criteriaBuilder.and(predicate);


                Join deskUser = root.join("deskUser", JoinType.LEFT);
                Predicate phonePredicate = criteriaBuilder.equal(deskUser.get("id"),loginedDeskUser.getId());
                predicate = criteriaBuilder.and(phonePredicate,predicate);

                return predicate;

            }
        };
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<Order> findAll = orderDao.findAll(specification,pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }


    /**
     * 通过前台用户id分页查询
     */
    public PageBean<Order> findListByDid(Order order, PageBean<Order> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching().withIgnorePaths("type");
        Example<Order> example = Example.of(order, exampleMatcher);

       // Sort sort = new Sort(Sort.Direction.DESC, "deskUserId");
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<Order> findAll = orderDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 通过前台用户id和type分页查询
     */
    public PageBean<Order> findListByDidAndType(Order order, PageBean<Order> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching()
                .withMatcher("type", ExampleMatcher.GenericPropertyMatchers.contains());
        Example<Order> example = Example.of(order, exampleMatcher);

        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<Order> findAll = orderDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 查询店铺订单
     *
     * @param order
     * @param pageBean
     * @param phone
     * @return
     */
    public PageBean<Order> findListByUserIdandDeskUserPhone(Order order, PageBean<Order> pageBean, String phone,String outTradeNo) {
        User loginedUser = SessionUtil.getLoginedUser();

        Specification<Order> specification = new Specification<Order>() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Join user = root.join("releaseVehicleInformation", JoinType.LEFT).join("user",JoinType.LEFT);
                Predicate predicateUser = criteriaBuilder.equal(user.get("id"), loginedUser.getId());
                Predicate linkPredicate = null;
                Predicate predicate = criteriaBuilder.gt(root.get("type"), -1);

                Predicate phonePredicateoutTradeNo = criteriaBuilder.like(root.get("outTradeNo"), "%" + (outTradeNo == null ? "" : outTradeNo) + "%");

                Join deskUser = root.join("deskUser", JoinType.LEFT);
                Predicate phonePredicate = criteriaBuilder.like(deskUser.get("phone"), "%" + (phone == null ? "" : phone) + "%");
                linkPredicate = criteriaBuilder.and(phonePredicate,phonePredicateoutTradeNo,predicate,predicateUser);

                return linkPredicate;
            }
        };
        Sort sort = Sort.by(Sort.Direction.ASC, "type");
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize(),sort);
        Page<Order> findAll = orderDao.findAll(specification, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 查询全部订单
     *
     * @param order
     * @param pageBean
     * @param outTradeNo
     * @return
     */
    public PageBean<Order> findAllList(Order order, PageBean<Order> pageBean, String outTradeNo, String shopName) {
        Specification<Order> specification = new Specification<Order>() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Predicate and = null;

                Predicate type = criteriaBuilder.gt(root.get("type"), -1);

                Join ass = root.join("releaseVehicleInformation", JoinType.LEFT).join("user",JoinType.LEFT);
                Predicate shopName1 = criteriaBuilder.like(ass.get("shopName"), "%" + (shopName == null ? "" : shopName) + "%");

                Predicate phonePredicate = criteriaBuilder.like(root.get("outTradeNo"), "%" + (outTradeNo == null ? "" : outTradeNo) + "%");

                and = criteriaBuilder.and(shopName1, phonePredicate,type);

                return and;
            }
        };
        Sort sort = Sort.by(Sort.Direction.DESC, "type");
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize(),sort);
        Page<Order> findAll = orderDao.findAll(specification, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }







    /**
     * 保存订单
     * @return
     */
    @Transactional(isolation = Isolation.DEFAULT,propagation = Propagation.REQUIRES_NEW,timeout = 3000)
    public Alipay orderFormSave(Long releaseVehicleInformationId , String otherServicesAuthorities,
                               String out_trade_no,String collectionTime, String returnTime,String total_amount,String subject) {

        Alipay alipay = null;

        Alipay saveAlipay = null;
        ReleaseVehicleInformation releaseVehicleInformation = releaseVehicleInformationDao.find(releaseVehicleInformationId);
        System.out.println();
        try {
            if (releaseVehicleInformation!=null){
                DeskUser loginedDeskUser = SessionUtil.getLoginedDeskUser();
                Order order = new Order();
                ArrayList<OtherServicesIems> otherServicesIemsArrayList = new ArrayList<>();
                if (otherServicesAuthorities != null && !"".equals(otherServicesAuthorities)){
                    String[] strArr= otherServicesAuthorities.split(",");
                    for (int i = 0; i < strArr.length; i++) {
                        OtherServicesIems otherServicesIems = otherServicesIemsDao.find(Long.valueOf(strArr[i]));
                        otherServicesIemsArrayList.add(otherServicesIems);
                    }
                }
                order.setOutTradeNo(out_trade_no);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                Date collectionTimeDate = simpleDateFormat.parse(collectionTime);
                Date returnTimeDate = simpleDateFormat.parse(returnTime);
                order.setCollectionTime(collectionTimeDate);
                order.setReturnTime(returnTimeDate);
                order.setOtherServicesAuthorities(otherServicesIemsArrayList);
                order.setReleaseVehicleInformation(releaseVehicleInformation);
                order.setDeskUser(loginedDeskUser);
                orderDao.save(order);
                alipay = new Alipay();
                alipay.setOut_trade_no(out_trade_no);
                alipay.setTotal_amount(total_amount);
                alipay.setSubject(subject);
                saveAlipay = alipayDao.save(alipay);
            }
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

        return saveAlipay;
    }






}
