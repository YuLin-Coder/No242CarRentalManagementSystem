package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.home.EnterpriseInfoDao;
import com.yuanlrc.base.entity.home.DeskUser;
import com.yuanlrc.base.entity.home.EnterpriseInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EnterpriseInfoService {
    @Autowired
    private EnterpriseInfoDao enterpriseInfoDao;

    /**
     * 添加/编辑
     */
    public EnterpriseInfo save(EnterpriseInfo enterpriseInfo){
        return enterpriseInfoDao.save(enterpriseInfo);
    }
    /**
     * 删除
     */
    public void delete(Long id){
        enterpriseInfoDao.deleteById(id);
    }
    /**
     * 通过id查询
     */
    public EnterpriseInfo find(Long id){
        return enterpriseInfoDao.find(id);
    }
    /**
     * 通过前台用户id查询
     */
    public EnterpriseInfo findByDeskUserId(Long deskUserId){
        return enterpriseInfoDao.findByDeskUserId(deskUserId);
    }

    public EnterpriseInfo findByEnterpriseName(String enName){
        return enterpriseInfoDao.findByEnterpriseName(enName.trim());
    }

    /**
     * 查询所有
     */
    public List<EnterpriseInfo> findAll(){
        return enterpriseInfoDao.findAll();
    }
    /**
     * 分页查询所有前台用户
     */
    public PageBean<EnterpriseInfo> findList(EnterpriseInfo enterpriseInfo, PageBean<EnterpriseInfo> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching().withMatcher("enterpriseName", ExampleMatcher.GenericPropertyMatchers.contains());
        Example<EnterpriseInfo> example = Example.of(enterpriseInfo, exampleMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<EnterpriseInfo> findAll = enterpriseInfoDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }
}
