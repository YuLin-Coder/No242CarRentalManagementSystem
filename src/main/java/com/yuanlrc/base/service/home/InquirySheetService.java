package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.dao.home.InquirySheetDao;
import com.yuanlrc.base.entity.home.InquirySheet;
import com.yuanlrc.base.entity.home.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InquirySheetService {
    @Autowired
    private InquirySheetDao inquirySheetDao;
    /**
     * 添加/编辑
     */
    public InquirySheet save(InquirySheet inquirySheet){
        return inquirySheetDao.save(inquirySheet);
    }
    /**
     * 删除
     */
    public void delete(Long id){
        inquirySheetDao.deleteById(id);
    }
    /**
     * 通过id查询
     */
    public InquirySheet find(Long id){
        return inquirySheetDao.find(id);
    }
    /**
     * 查询所有
     */
    public List<InquirySheet> findAll(){
        return inquirySheetDao.findAll();
    }

    /**
     * 分页查询
     * @param inquirySheet
     * @param pageBean
     * @return
     */
    public PageBean<InquirySheet> findList(InquirySheet inquirySheet, PageBean<InquirySheet> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching().withMatcher("boardingLocation", ExampleMatcher.GenericPropertyMatchers.contains());
        Example<InquirySheet> example = Example.of(inquirySheet, exampleMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<InquirySheet> findAll = inquirySheetDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }
}
