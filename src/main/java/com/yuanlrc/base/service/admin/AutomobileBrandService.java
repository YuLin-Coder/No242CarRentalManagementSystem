package com.yuanlrc.base.service.admin;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.admin.AutomobileBrandDao;
import com.yuanlrc.base.entity.admin.AutomobileBrand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AutomobileBrandService {

    @Autowired
    private AutomobileBrandDao automobileBrandDao;

    /**
     * 分页按汽车品牌搜索品牌列表
     * @param automobileBrand
     * @param pageBean
     * @return
     */
    public PageBean<AutomobileBrand> findAllByBrand(AutomobileBrand automobileBrand, PageBean<AutomobileBrand> pageBean){
        ExampleMatcher withMatcher = ExampleMatcher.matching().withMatcher("brand", ExampleMatcher.GenericPropertyMatchers.contains());
        Example<AutomobileBrand> example = Example.of(automobileBrand, withMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize());
        Page<AutomobileBrand> findAll = automobileBrandDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 汽车品牌添加/编辑操作
     * @param automobileBrand
     * @return
     */
    public AutomobileBrand save(AutomobileBrand automobileBrand){
        return automobileBrandDao.save(automobileBrand);
    }

    /**
     * 根据id查询汽车品牌
     * @param id
     * @return
     */
    public AutomobileBrand find(Long id){
        return automobileBrandDao.find(id);
    }

    /**
     * 获取所有的汽车品牌列表
     * @return
     */
    public List<AutomobileBrand> findAll(){
        return automobileBrandDao.findAll();
    }


    /**
     * 判断汽车品牌是否存在，添加和编辑均可判断
     * @param brand
     * @param id
     * @return
     */
    public boolean isExistBrand(String brand,Long id){
        AutomobileBrand automobileBrand = automobileBrandDao.findByBrand(brand);
        if(automobileBrand != null){
            //表示用户名存在，接下来判断是否是编辑用户的本身
            if(automobileBrand.getId().longValue() != id.longValue()){
                return true;
            }
        }
        return false;
    }


    /**
     * 删除汽车品牌
     * @param id
     * @return
     */
    public void delete(Long id){
        automobileBrandDao.deleteById(id);
    }

}
