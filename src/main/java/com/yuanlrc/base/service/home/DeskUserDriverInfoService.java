package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.home.DeskUserDriverInfoDao;
import com.yuanlrc.base.entity.home.DeskUserDriverInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeskUserDriverInfoService {
    @Autowired
    private DeskUserDriverInfoDao deskUserDriverInfoDao;

    /**
     * 添加/编辑
     */
    public DeskUserDriverInfo save(DeskUserDriverInfo deskUserDriverInfo){
        return deskUserDriverInfoDao.save(deskUserDriverInfo);
    }
    /**
     * 删除
     */
    public void delete(Long id){
        deskUserDriverInfoDao.deleteById(id);
    }
    /**
     * 通过id查询
     */
    public DeskUserDriverInfo find(Long id){
        return deskUserDriverInfoDao.find(id);
    }
    /**
     * 查询所有
     */
    public List<DeskUserDriverInfo> findAll(){
        return deskUserDriverInfoDao.findAll();
    }
    /**
     * 通过驾驶证号查询
     */
    public DeskUserDriverInfo findByDriverNumber(String driverNumber){
        return deskUserDriverInfoDao.findByDriverNumber(driverNumber.trim());
    }
    /**
     * 分页查询所有
     */
    public PageBean<DeskUserDriverInfo> findList(DeskUserDriverInfo deskUserDriverInfo, PageBean<DeskUserDriverInfo> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching()
                .withMatcher("driverNumber", ExampleMatcher.GenericPropertyMatchers.contains());
        Example<DeskUserDriverInfo> example = Example.of(deskUserDriverInfo, exampleMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<DeskUserDriverInfo> findAll = deskUserDriverInfoDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }
}
