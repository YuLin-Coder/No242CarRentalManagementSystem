package com.yuanlrc.base.service.admin;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.admin.AutomobileInformationDao;
import com.yuanlrc.base.entity.admin.AutomobileBrand;
import com.yuanlrc.base.entity.admin.AutomobileInformation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import java.util.List;

@Service
public class AutomobileInformationService {

    @Autowired
    private AutomobileInformationDao automobileInformationDao;

    /**
     * 分页查询汽车信息列表
     * @param automobileInformation
     * @param pageBean
     * @return
     */
    public PageBean<AutomobileInformation> findList(AutomobileInformation automobileInformation, PageBean<AutomobileInformation> pageBean, String brand){
        Specification<AutomobileInformation> specification = new Specification<AutomobileInformation>() {
            @Override
            public Predicate toPredicate(Root<AutomobileInformation> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Join<AutomobileBrand,AutomobileInformation> ass = root.join("automobileBrand",JoinType.INNER);
                Predicate assPre = criteriaBuilder.like(ass.get("brand"), "%" + (brand == null ? "" : brand) + "%");
                Predicate predicateIntroduceName = criteriaBuilder.like(root.get("introduceName"), "%" + (automobileInformation.getIntroduceName() == null ? "" : automobileInformation.getIntroduceName()) + "%");
                predicateIntroduceName = criteriaBuilder.and(predicateIntroduceName,assPre);
                return predicateIntroduceName;
            }
        };
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize());
        Page<AutomobileInformation> findAll = automobileInformationDao.findAll(specification,pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    public List<AutomobileInformation> findByCreateTime(){
        return automobileInformationDao.findByCreateTime();
    }

    /**
     * 查询全部汽车信息
     */
    public List<AutomobileInformation> findAll(){
        return automobileInformationDao.findAll();
    }

    /**
     * 保存/编辑汽车信息
     * @param automobileInformation
     * @return
     */
    public AutomobileInformation sava(AutomobileInformation automobileInformation){
        return automobileInformationDao.save(automobileInformation);
    }

    /**
     * 根据id删除汽车信息
     * @param id
     */
    public void delete(Long id){
        automobileInformationDao.deleteById(id);
    }

    /**
     * 根据id查询汽车信息
     * @param id
     * @return
     */
    public AutomobileInformation find(Long id){
        return automobileInformationDao.find(id);
    }



}
