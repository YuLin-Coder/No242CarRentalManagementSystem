package com.yuanlrc.base.service.home;

import com.yuanlrc.base.bean.CodeMsg;
import com.yuanlrc.base.bean.PageBean;
import com.yuanlrc.base.bean.Result;
import com.yuanlrc.base.dao.home.DeskUserDao;
import com.yuanlrc.base.entity.home.DeskPersonalInfo;
import com.yuanlrc.base.entity.home.DeskUser;
import com.yuanlrc.base.entity.home.DeskUserDriverInfo;
import com.yuanlrc.base.entity.home.EnterpriseInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.List;

@Service
public class DeskUserService {
    @Autowired
    private DeskUserDao deskUserDao;
    @Autowired
    private DeskPersonalInfoService deskPersonalInfoService;
    @Autowired
    private DeskUserDriverInfoService deskUserDriverInfoService;
    @Autowired
    private EnterpriseInfoService enterpriseInfoService;

    /**
     * 添加/编辑
     */
    public DeskUser save(DeskUser deskUser){
        return deskUserDao.save(deskUser);
    }
    /**
     * 添加个人注册信息
     */
    @Transactional(rollbackFor = Exception.class)
    public Result<Boolean> saveDu(DeskUser deskUser){
        try{
            if (deskUser.getType()==1){
                DeskUserDriverInfo deskUserDriverInfo = new DeskUserDriverInfo();
                if(deskUserDriverInfoService.save(deskUserDriverInfo)==null){
                    return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
                }
                deskUser.setDeskUserDriverInfo(deskUserDriverInfo);
                DeskPersonalInfo deskPersonalInfo = new DeskPersonalInfo();
                DeskUser save = deskUserDao.save(deskUser);
                deskPersonalInfo.setDeskUser(save);
                if (deskPersonalInfoService.save(deskPersonalInfo)==null){
                    return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
                }
            }
            return Result.success(true);
        }catch (Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
        }
    }
    /**
     * 添加企业注册信息
     */
    @Transactional(rollbackFor = Exception.class)
    public Result<Boolean> saveEn(DeskUser deskUser,String enNo,String enPic,String enName){
        try{
            if (deskUser.getType()==0){
               DeskUserDriverInfo deskUserDriverInfo = new DeskUserDriverInfo();
               if (deskUserDriverInfoService.save(deskUserDriverInfo)==null){
                   return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
               }
               deskUser.setDeskUserDriverInfo(deskUserDriverInfo);
               EnterpriseInfo enterpriseInfo = new EnterpriseInfo();
               DeskUser save = deskUserDao.save(deskUser);
               enterpriseInfo.setDeskUser(deskUser);
               enterpriseInfo.setEnterpriseNo(enNo.trim());
               enterpriseInfo.setEnterprisePic(enPic.trim());
               enterpriseInfo.setEnterpriseName(enName.trim());
               if (enterpriseInfoService.save(enterpriseInfo)==null){
                    return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
               }
            }
            return Result.success(true);
        }catch (Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return Result.error(CodeMsg.HOME_DESK_USER_REGISTER_ERROR_2);
        }
    }

    public Long total(){
        return deskUserDao.count();
    }
    /**
     * 通过id删除
     */
    public void delete(Long id){
        deskUserDao.deleteById(id);
    }
    /**
     * 通过id查询
     */
    public DeskUser find(Long id){
        return deskUserDao.find(id);
    }
    /**
     * 查询所有前台用户
     */
    public List<DeskUser> findAll(){
        return deskUserDao.findAll();
    }
    /**
     * 通过电话号查询
     */
    public DeskUser findByPhone(String phone){
        return deskUserDao.findByPhone(phone.trim());
    }
    /**
     * 通过邮箱查询
     */
    public DeskUser findByDemail(String email){
        return deskUserDao.findByDemail(email.trim());
    }
    /**
     * 分页查询所有前台用户
     */
    public PageBean<DeskUser> findList(DeskUser deskUser, PageBean<DeskUser> pageBean) {
        ExampleMatcher exampleMatcher = ExampleMatcher
                .matching()
                .withMatcher("phone", ExampleMatcher.GenericPropertyMatchers.contains())
                .withIgnorePaths("type");
        Example<DeskUser> example = Example.of(deskUser, exampleMatcher);
        Pageable pageable = PageRequest.of(pageBean.getCurrentPage() - 1, pageBean.getPageSize());
        Page<DeskUser> findAll = deskUserDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }
}
