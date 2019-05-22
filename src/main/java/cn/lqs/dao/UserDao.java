package cn.lqs.dao;

import cn.lqs.user.bean.User;

public interface UserDao extends DAO<User> {
    void resetPassword(String id);
    Integer verifyAccount(String account);
    Integer verifyEmail(String email);
    User verifyLogin(User user);
    void register(User user);
    String selectIdByMail(String email);
    void updatePassword(User user);
    void setTokenById(User user);
    Integer verifyPwdIsTrue(User user);
    void updatePwd(User user);
    void addLowPrice(String id);
    void addSolid(String id);
    void addFresh(String id);

}
