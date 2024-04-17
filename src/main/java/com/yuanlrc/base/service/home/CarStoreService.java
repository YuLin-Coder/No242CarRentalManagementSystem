package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.admin.ReleaseVehicleInformationDao;
import com.yuanlrc.base.entity.admin.AutomobileInformation;
import com.yuanlrc.base.entity.admin.ReleaseVehicleInformation;
import com.yuanlrc.base.entity.admin.User;
import com.yuanlrc.base.service.admin.OtherServicesIemsService;
import com.yuanlrc.base.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 查询所有的拥有该车的门店
 * @author wangzihan
 * @date : 2020/12/25 11:23
 */
@Service
public class CarStoreService {


    @Autowired
    private ReleaseVehicleInformationDao releaseVehicleInformationDao;


    /**
     * 分页查询汽车发布信息列表
     *
     * @param introduceName
     * @param pageBean
     * @return
     */
    public PageBean<ReleaseVehicleInformation> findList(String introduceName,Long userId,String city, PageBean<ReleaseVehicleInformation> pageBean) {
        Specification<ReleaseVehicleInformation> specification = new Specification<ReleaseVehicleInformation>() {
            @Override
            public Predicate toPredicate(Root<ReleaseVehicleInformation> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                Join<AutomobileInformation,ReleaseVehicleInformation> join = root.join("automobileInformation", JoinType.LEFT);

                List<Predicate> predicates  = new ArrayList<>();
                Predicate publishStatus = criteriaBuilder.equal(root.get("publishStatus"), 1);
                predicates.add(publishStatus);
                Predicate predicate = criteriaBuilder.equal(join.get("introduceName"), (introduceName == null ? "" : introduceName));
                predicates.add(predicate);
                Join<User,ReleaseVehicleInformation> join1 = root.join("user", JoinType.LEFT);
                Predicate predicate4 = criteriaBuilder.equal(join1.get("type"), 1);
                predicates.add(predicate4);
                Predicate predicate6 = criteriaBuilder.equal(join1.get("status"), 1);
                predicates.add(predicate6);

                Predicate predicate5 = criteriaBuilder.greaterThanOrEqualTo(root.get("mindmapTopiccarNumber"), 0);
                predicates.add(predicate5);
                if (userId !=null){
                    Predicate predicate1 = criteriaBuilder.notEqual(join1.get("id"), userId);
                    predicates.add(predicate1);
                }
                if (city !=null){
                    Predicate predicate2 = criteriaBuilder.like(join1.get("city"), "%"+city+"%");
                    predicates.add(predicate2);
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<ReleaseVehicleInformation> findAll = releaseVehicleInformationDao.findAll(specification,pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }



}
