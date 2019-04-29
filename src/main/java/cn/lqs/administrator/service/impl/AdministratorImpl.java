/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 22:47
 */
package cn.lqs.administrator.service.impl;

import cn.lqs.administrator.bean.Administrator;
import cn.lqs.administrator.service.AdministratorService;
import cn.lqs.dao.AdministratorDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdministratorImpl implements AdministratorService {

    @Autowired
    private AdministratorDao administratorDao;

    @Override
    public Administrator verifyLogin(Administrator administrator) {
        Administrator administrator1 = administratorDao.selectOneByAccountAndPwd(administrator);
        return administrator1;
    }

    @Override
    public void updatePassword(Administrator administrator) {
        administratorDao.modify(administrator);
    }

    @Override
    public void create(Administrator administrator) {
        administratorDao.create(administrator);
    }

    @Override
    public void remove(String id) {
        administratorDao.remove(id);
    }
}
