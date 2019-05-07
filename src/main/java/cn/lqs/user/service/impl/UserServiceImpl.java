/**
 * User: LiQingsong
 * Date: 2019/5/6
 * Time: 10:20
 */
package cn.lqs.user.service.impl;

import cn.lqs.base.BaseServiceImpl;
import cn.lqs.dao.DAO;
import cn.lqs.dao.UserDao;
import cn.lqs.user.bean.User;
import cn.lqs.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService {

    private UserDao userDao;

    @Override
    @Autowired
    public void setDao(@Qualifier("userDao") DAO<User> dao) {
        super.dao = dao;
        userDao = (UserDao) dao;
    }


    @Override
    public void resetPassword(String id) {
        userDao.resetPassword(id);
    }
}
