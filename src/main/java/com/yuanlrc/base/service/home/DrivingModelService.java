package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.home.DrivingModelDao;
import com.yuanlrc.base.entity.home.DrivingModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DrivingModelService {
    @Autowired
    private DrivingModelDao drivingModelDao;
    /**
     * 添加/编辑
     */
    public DrivingModel save(DrivingModel drivingModel){
        return drivingModelDao.save(drivingModel);
    }
    /**
     * 删除
     */
    public void delete(Long id){
        drivingModelDao.deleteById(id);
    }
    /**
     * 通过准驾车型查询
     */
    public DrivingModel findByCarModel(String carModel){
         return drivingModelDao.findByCarModel(carModel.trim());
    }
    /**
     * 通过id查询
     */
    public DrivingModel find(Long id){
        return drivingModelDao.find(id);
    }
    /**
     * 查询所有
     */
    public List<DrivingModel> findAll(){
        return drivingModelDao.findAll();
    }
    /**
     * 分页查询所有
     */
    public PageBean<DrivingModel> findList(DrivingModel drivingModel, PageBean<DrivingModel> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching()
                .withMatcher("carModel", ExampleMatcher.GenericPropertyMatchers.contains());
        Example<DrivingModel> example = Example.of(drivingModel, exampleMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<DrivingModel> findAll = drivingModelDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }
}
