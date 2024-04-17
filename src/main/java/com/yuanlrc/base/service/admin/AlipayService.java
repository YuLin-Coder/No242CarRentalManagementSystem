package com.yuanlrc.base.service.admin;

import com.yuanlrc.base.dao.admin.AlipayDao;
import com.yuanlrc.base.entity.admin.Alipay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlipayService {

    @Autowired
    private AlipayDao alipayDao;

    public Alipay save(Alipay alipay){
       return alipayDao.save(alipay);
    }

    public Alipay findByOut_trade_no(String out_trade_no){
        return alipayDao.findByOut_trade_no(out_trade_no);
    }




}
