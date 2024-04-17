package com.yuanlrc.base.service.admin;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.admin.OtherServicesIemsDao;
import com.yuanlrc.base.dao.admin.ReleaseVehicleInformationDao;
import com.yuanlrc.base.entity.admin.OtherServicesIems;
import com.yuanlrc.base.entity.admin.ReleaseVehicleInformation;
import com.yuanlrc.base.entity.admin.User;
import com.yuanlrc.base.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import java.util.List;

@Service
public class OtherServicesIemsService {

    @Autowired
    private OtherServicesIemsDao otherServicesIemsDao;
    @Autowired
    private ReleaseVehicleInformationDao releaseVehicleInformationDao;

    /**
     * 分页按其他服务名称搜索角色列表
     * @param otherServicesIems
     * @param pageBean
     * @return
     */
    public PageBean<OtherServicesIems> findAllByName(OtherServicesIems otherServicesIems, PageBean<OtherServicesIems> pageBean){
        User loginedUser = SessionUtil.getLoginedUser();
        Specification<OtherServicesIems> specification = new Specification<OtherServicesIems>() {
            @Override
            public Predicate toPredicate(Root<OtherServicesIems> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                Predicate predicateName = criteriaBuilder.like(root.get("name"), "%" + (otherServicesIems.getName() == null ? "" : otherServicesIems.getName()) + "%");

                return predicateName;
            }
        };
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<OtherServicesIems> findAll = otherServicesIemsDao.findAll(specification, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    public List<OtherServicesIems> findAll(){
        return otherServicesIemsDao.findAll();
    }

    /**
     * 其他服务添加/编辑
     * @param otherServicesIems
     * @return
     */
    public OtherServicesIems sava(OtherServicesIems otherServicesIems){
        return otherServicesIemsDao.save(otherServicesIems);
    }

    /**
     * 根据id查询其他服务
     * @param id
     * @return
     */
    public OtherServicesIems find(Long id){
        return otherServicesIemsDao.find(id);
    }

    /**
     * 根据id删除一条记录
     * @param id
     */
    public void delete(Long id){
        otherServicesIemsDao.deleteById(id);
    }


    /**
     *
     * @param id 发布id
     * @return
     */
    public List<OtherServicesIems> findByReleaseVehicleInformationsID(Long id){
        ReleaseVehicleInformation releaseVehicleInformation = releaseVehicleInformationDao.find(id);
        List<OtherServicesIems> otherServicesIems = releaseVehicleInformation.getOtherServicesIems();
        return otherServicesIems;
    }
}
