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
import org.apache.commons.codec.digest.DigestUtils;
import org.jasypt.util.password.StrongPasswordEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Enumeration;

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

    @Override
    public Integer verifyAccount(String account) {
        return userDao.verifyAccount(account);
    }

    @Override
    public Integer verifyEmail(String email) {
        return userDao.verifyEmail(email);
    }

    @Override
    public Boolean verifyLogin(User user) {
        boolean isTrue = false;
        User user1 = userDao.verifyLogin(user);
        if(user1!=null){
            session.setAttribute("user",user1);
            isTrue = true;
        }
        return isTrue;
    }

    @Override
    public Boolean register(User user) {
        user.setAvatar("userDefaultAvatar.png");
        user.setCreateTime(new Date());
        user.setSex(2);
        System.out.println("打印要注册的user："+user);
        userDao.register(user);
        return true;
    }

    @Override
    public String selectIdByMail(String email) {
        return userDao.selectIdByMail(email);
    }

    @Override
    public void updatePassword(User user) {
        userDao.updatePassword(user);
    }

    @Override
    public String setTokenById(String id,String email) {
        User user = new User();
        user.setId(id);
        StrongPasswordEncryptor strongPasswordEncryptor = new StrongPasswordEncryptor();
        String token = strongPasswordEncryptor.encryptPassword(email);
        token = DigestUtils.md5Hex(token);
        long tokenTime = System.currentTimeMillis();
        user.setToken(token);
        user.setTokenTime(tokenTime);
        userDao.setTokenById(user);

        return token;
    }
    @Override
    public void signOut() {
        Enumeration em = request.getSession().getAttributeNames();
        while(em.hasMoreElements()){
            request.getSession().removeAttribute(em.nextElement().toString());
        }
    }
}
