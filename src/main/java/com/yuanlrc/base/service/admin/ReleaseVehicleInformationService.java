package com.yuanlrc.base.service.admin;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.admin.ReleaseVehicleInformationDao;
import com.yuanlrc.base.entity.admin.*;
import com.yuanlrc.base.service.home.ReleaseVehicleInformationVo;

import com.yuanlrc.base.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.TreeSet;
import java.util.stream.Collectors;

@Service
public class ReleaseVehicleInformationService {


    @Autowired
    private ReleaseVehicleInformationDao releaseVehicleInformationDao;


    public List<ReleaseVehicleInformation> findByUserId(Long id) {
        return releaseVehicleInformationDao.findByUserIdAndPublishStatus(id, 1);
    }


    /**
     * 查询本城市下除了本店的其他店铺拥有的车辆信息
     *
     * @param id
     * @param city
     * @return
     */
    public List<ReleaseVehicleInformation> releFind(Long id, String city) {
        Specification<ReleaseVehicleInformation> specification = new Specification<ReleaseVehicleInformation>() {
            @Override
            public Predicate toPredicate(Root<ReleaseVehicleInformation> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                Join<User, ReleaseVehicleInformation> join = root.join("user", JoinType.LEFT);

                List<Predicate> predicates = new ArrayList<>();
                Predicate publishStatus = criteriaBuilder.equal(root.get("publishStatus"), 1);
                predicates.add(publishStatus);
                Join<User, ReleaseVehicleInformation> join1 = root.join("user", JoinType.LEFT);
                if (id != null) {
                    Predicate predicate1 = criteriaBuilder.notEqual(join.get("id"), id);
                    predicates.add(predicate1);
                }
                if (city != null) {
                    Predicate predicate2 = criteriaBuilder.like(join1.get("city"), "%" + city + "%");
                    predicates.add(predicate2);
                }
                Predicate predicate3 = criteriaBuilder.equal(join1.get("status"), 1);
                predicates.add(predicate3);
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };

        List<ReleaseVehicleInformation> findAll = releaseVehicleInformationDao.findAll(specification);
        List<ReleaseVehicleInformation> publishStatus = releaseVehicleInformationDao.findByUserIdAndPublishStatus(id, 1);

        List<ReleaseVehicleInformation> collect = findAll.stream().filter(new java.util.function.Predicate<ReleaseVehicleInformation>() {
            @Override
            public boolean test(ReleaseVehicleInformation releaseVehicleInformation) {
                for (ReleaseVehicleInformation status : publishStatus) {
                    if (status.getAutomobileInformation().getId() == releaseVehicleInformation.getAutomobileInformation().getId()) {
                        return false;
                    }
                }
                return true;
            }
        }).collect(Collectors.toList());


      /*  for (int i = 0; i < findAll.size(); i++) {
            for (int y = 0; y < publishStatus.size(); y++) {
                if (findAll.get(i).getAutomobileInformation().getId() == publishStatus.get(y).getAutomobileInformation().getId()){
                    findAll.remove(i);
                }
            }
        }*/

        return collect;
    }

    /**
     * 分页查询汽车发布信息列表
     *
     * @param releaseVehicleInformation
     * @param pageBean
     * @return
     */
    public PageBean<ReleaseVehicleInformation> findList(ReleaseVehicleInformation releaseVehicleInformation, PageBean<ReleaseVehicleInformation> pageBean,
                                                        String brand, String introduceName) {
        User loginedUser = SessionUtil.getLoginedUser();
        Specification<ReleaseVehicleInformation> specification = new Specification<ReleaseVehicleInformation>() {
            @Override
            public Predicate toPredicate(Root<ReleaseVehicleInformation> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {


                Join<AutomobileInformation, ReleaseVehicleInformation> ass = root.join("automobileInformation", JoinType.INNER);
                Predicate assPre = criteriaBuilder.like(ass.get("introduceName"), "%" + (introduceName == null ? "" : introduceName) + "%");

                Join<AutomobileInformation, ReleaseVehicleInformation> ass1 = root.join("automobileInformation", JoinType.INNER)
                        .join("automobileBrand", JoinType.INNER);
                Predicate assPre1 = criteriaBuilder.like(ass1.get("brand"), "%" + (brand == null ? "" : brand) + "%");

                Join<User, ReleaseVehicleInformation> ass2 = root.join("user", JoinType.INNER);
                Predicate predicateUser = criteriaBuilder.equal(ass2.get("id"), loginedUser.getId());
                assPre = criteriaBuilder.and(assPre, assPre1, predicateUser);
                return assPre;
            }
        };
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<ReleaseVehicleInformation> findAll = releaseVehicleInformationDao.findAll(specification, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 分页查询汽车发布信息列表
     *
     * @param releaseVehicleInformation
     * @param pageBean
     * @return
     */
    public PageBean<ReleaseVehicleInformation> findAdminList(ReleaseVehicleInformation releaseVehicleInformation, PageBean<ReleaseVehicleInformation> pageBean,
                                                             String brand, String shopName) {
        Specification<ReleaseVehicleInformation> specification = new Specification<ReleaseVehicleInformation>() {
            @Override
            public Predicate toPredicate(Root<ReleaseVehicleInformation> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                Join<AutomobileInformation, ReleaseVehicleInformation> ass1 = root.join("automobileInformation", JoinType.INNER)
                        .join("automobileBrand", JoinType.INNER);
                Predicate assPre1 = criteriaBuilder.like(ass1.get("brand"), "%" + (brand == null ? "" : brand) + "%");

                Join<User, ReleaseVehicleInformation> ass = root.join("user", JoinType.LEFT);
                Predicate assPre = criteriaBuilder.like(ass.get("shopName"), "%" + (shopName == null ? "" : shopName) + "%");

                Predicate assPre12 = criteriaBuilder.equal(ass.get("status"), 1);

                assPre1 = criteriaBuilder.and(assPre1, assPre, assPre12);
                return assPre1;
            }
        };
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<ReleaseVehicleInformation> findAll = releaseVehicleInformationDao.findAll(specification, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 保存/编辑汽车发布信息
     *
     * @param releaseVehicleInformation
     * @return
     */
    public ReleaseVehicleInformation sava(ReleaseVehicleInformation releaseVehicleInformation) {
        return releaseVehicleInformationDao.save(releaseVehicleInformation);
    }

    /**
     * 根据id删除汽车发布信息
     *
     * @param id
     */
    public void delete(Long id) {
        releaseVehicleInformationDao.deleteById(id);
    }

    /**
     * 根据id查询汽车发布信息
     *
     * @param id
     * @return
     */
    public ReleaseVehicleInformation find(Long id) {
        return releaseVehicleInformationDao.find(id);
    }


    /**
     * @param releaseVehicleInformationVo
     * @return
     */
    public List<ReleaseVehicleInformation> findListAll(ReleaseVehicleInformationVo releaseVehicleInformationVo) {

        Specification<ReleaseVehicleInformation> specification = new Specification<ReleaseVehicleInformation>() {

            private static final long serialVersionUID = 1L;

            @Override
            public Predicate toPredicate(Root<ReleaseVehicleInformation> root,
                                         CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> listOr = new ArrayList<>();
                List<Predicate> predicates = new ArrayList<>();

                Join<AutomobileInformation, ReleaseVehicleInformation> join = root.join("automobileInformation", JoinType.LEFT);
                Predicate publishStatus = criteriaBuilder.equal(root.get("publishStatus"), 1);
                predicates.add(publishStatus);
                Predicate predicate1 = criteriaBuilder.greaterThanOrEqualTo(root.get("mindmapTopiccarNumber"), 0);
                predicates.add(predicate1);
                if (releaseVehicleInformationVo.getUserId() != null) {
                    Join<User, ReleaseVehicleInformation> join1 = root.join("user", JoinType.LEFT);
                    Predicate publishUser = criteriaBuilder.equal(join1.get("id"), releaseVehicleInformationVo.getUserId());
                    predicates.add(publishUser);
                }
                //汽车排挡
                if (releaseVehicleInformationVo.getAutomobileStalls() != null) {
                    Predicate equal2 = criteriaBuilder.equal(join.get("automobileStalls"), releaseVehicleInformationVo.getAutomobileStalls());
                    predicates.add(equal2);
                }
                //汽车座位
                if (releaseVehicleInformationVo.getAutomobileSeat() != null) {
                    Predicate equal3 = criteriaBuilder.equal(join.get("automobileSeat"), releaseVehicleInformationVo.getAutomobileSeat());
                    predicates.add(equal3);
                }
                //汽车类型
                if (releaseVehicleInformationVo.getAutomobileType() != null) {
                    Predicate equal4 = criteriaBuilder.equal(join.get("automobileType"), releaseVehicleInformationVo.getAutomobileType());
                    predicates.add(equal4);
                }
                //汽车日租价格
                if (releaseVehicleInformationVo.getDailyRentalRate() != null) {
                    if ("1".equals(releaseVehicleInformationVo.getDailyRentalRate())) {
                        Predicate equalDailyRentalRate = criteriaBuilder.lt(join.get("dailyRentalRate"), 100);
                        predicates.add(equalDailyRentalRate);
                    }
                    if ("2".equals(releaseVehicleInformationVo.getDailyRentalRate())) {
                        Predicate equalDailyRentalRate = criteriaBuilder.between(join.get("dailyRentalRate"), 100, 200);
                        predicates.add(equalDailyRentalRate);
                    }
                    if ("3".equals(releaseVehicleInformationVo.getDailyRentalRate())) {
                        Predicate equalDailyRentalRate = criteriaBuilder.between(join.get("dailyRentalRate"), 200, 300);
                        predicates.add(equalDailyRentalRate);
                    }
                    if ("4".equals(releaseVehicleInformationVo.getDailyRentalRate())) {
                        Predicate equalDailyRentalRate = criteriaBuilder.gt(join.get("dailyRentalRate"), 300);
                        predicates.add(equalDailyRentalRate);
                    }
                }
                if (releaseVehicleInformationVo.getBrandList().size() > 0 && releaseVehicleInformationVo.getBrandList().get(0) != null) {
                    for (int i = 0; i < releaseVehicleInformationVo.getBrandList().size(); i++) {
                        if (releaseVehicleInformationVo.getBrandList().get(i) != null) {
                            Join<AutomobileInformation, ReleaseVehicleInformation> join1 = root.join("automobileInformation")
                                    .join("automobileBrand");
                            listOr.add(criteriaBuilder.equal(join1.get("id"), releaseVehicleInformationVo.getBrandList().get(i)));
                        }
                    }
                }
                //按租金来排序
                if ("1".equals(releaseVehicleInformationVo.getRentSort())) {
                    criteriaQuery.orderBy(criteriaBuilder.asc(join.get("dailyRentalRate")));
                }
                if ("2".equals(releaseVehicleInformationVo.getRentSort())) {
                    criteriaQuery.orderBy(criteriaBuilder.desc(join.get("dailyRentalRate")));
                }
                //按排量来排序
                if ("1".equals(releaseVehicleInformationVo.getEmissionSort())) {
                    criteriaQuery.orderBy(criteriaBuilder.asc(join.get("vehicleDisplacement")));
                }
                if ("2".equals(releaseVehicleInformationVo.getEmissionSort())) {
                    criteriaQuery.orderBy(criteriaBuilder.desc(join.get("vehicleDisplacement")));
                }

                Predicate or = criteriaBuilder.or(listOr.toArray(new Predicate[listOr.size()]));
                Predicate and = criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
                if (or.getExpressions().size() > 0) {
                    and = criteriaBuilder.and(and, or);
                }
                return and;
            }
        };

        List<ReleaseVehicleInformation> informationList = releaseVehicleInformationDao.findAll(specification);
        return informationList;
    }


//    @Cacheable(value="related_products_pid",key="#product.id",unless="#result == null")
//    public List<Product> findRelatedProducts(Product product,int rowSize){
//        List<Product> relatedProducts = new ArrayList<Product>();
//        //获取相关产品
//        Specification<Product> specification = new Specification<Product>() {
//
//            /**
//             *
//             */
//            private static final long serialVersionUID = 1L;
//
//            @Override
//            public Predicate toPredicate(Root<Product> root,
//                                         CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
//
//                Predicate upDownEqual = criteriaBuilder.equal(root.get("upDown"), Product.PRODUCT_UP);
//                Predicate statusEqual = criteriaBuilder.equal(root.get("status"), Product.PRODUCT_STATUS_NORMAL);
//                Predicate idNotEqual = criteriaBuilder.notEqual(root.get("id"), product.getId());
//                Predicate predicate = criteriaBuilder.and(upDownEqual,statusEqual,idNotEqual);
//                String tags = product.getTags();
//                if(!StringUtils.isEmpty(tags)){
//                    tags = tags.replaceAll("，",",");
//                    String[] tagsArr = tags.split(",");
//                    Predicate orPredicate = null;
//                    for(String tag : tagsArr){
//                        Predicate nameLike = criteriaBuilder.like(root.get("name"), "%" + tag + "%");
//                        Predicate tagsLike = criteriaBuilder.like(root.get("tags"), "%" + tag + "%");
//                        if(orPredicate == null){
//                            orPredicate = criteriaBuilder.or(nameLike,tagsLike);
//                            continue;
//                        }
//                        orPredicate = criteriaBuilder.or(orPredicate,criteriaBuilder.or(nameLike,tagsLike));
//                        //predicate = criteriaBuilder.or(predicate,criteriaBuilder.or(nameLike,tagsLike));
//                    }
//                    if(orPredicate != null){
//                        predicate = criteriaBuilder.and(predicate,orPredicate);
//                    }
//                }
//                return predicate;
//            }
//
//        };
//        Sort sort = Sort.by(Order.desc("createTime"));
//        Pageable pageable = PageRequest.of(0 , rowSize,sort);
//        Page<Product> findAll = productRepository.findAll(specification, pageable);
//        relatedProducts = findAll.getContent();
//        if(relatedProducts.size() == 0){
//            //表示根据标签没有找到数据，此时查找相同分类的商品
//            List<Long> cids = new ArrayList<Long>();
//            cids.add(p
}
