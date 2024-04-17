package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.home.DeskPersonalInfoDao;
import com.yuanlrc.base.entity.home.DeskPersonalInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeskPersonalInfoService {
    @Autowired
    private DeskPersonalInfoDao deskPersonalInfoDao;

    /**
     * 添加/编辑
     */
    public DeskPersonalInfo save(DeskPersonalInfo deskPersonalInfo){
        return deskPersonalInfoDao.save(deskPersonalInfo);
    }
    /**
     * 通过id删除
     */
    public void delete(Long id){
        deskPersonalInfoDao.deleteById(id);
    }
    /**
     * 通过id查询
     */
    public DeskPersonalInfo find(Long id){
        return deskPersonalInfoDao.find(id);
    }
    /**
     * 通过 DeskUser id查询
     */
    public DeskPersonalInfo findByDeskUserId(Long id){
        return deskPersonalInfoDao.findByDeskUserId(id);
    }
    /**
     * 通过 身份证号查询
     */
    public DeskPersonalInfo findByIdNumber(String idNumber){
        return deskPersonalInfoDao.findByIdNumber(idNumber.trim());
    }
    /**
     * 通过紧急联系人手机号查询
     */
    public DeskPersonalInfo findByEccPhone(String ecPhone){
        return deskPersonalInfoDao.findByEccPhone(ecPhone.trim());
    }
    /**
     * 查询所有前台用户信息
     */
    public List<DeskPersonalInfo> findAll(){
        return deskPersonalInfoDao.findAll();
    }
    /**
     * 分页查询所有前台用户信息
     */
    public PageBean<DeskPersonalInfo> findList(DeskPersonalInfo deskPersonalInfo, PageBean<DeskPersonalInfo> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching()
                .withMatcher("idCardName", ExampleMatcher.GenericPropertyMatchers.contains());
        Example<DeskPersonalInfo> example = Example.of(deskPersonalInfo, exampleMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<DeskPersonalInfo> findAll = deskPersonalInfoDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }
}
