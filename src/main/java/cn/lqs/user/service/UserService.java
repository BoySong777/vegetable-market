package cn.lqs.user.service;

import cn.lqs.base.BaseService;
import cn.lqs.user.bean.User;

public interface UserService extends BaseService<User> {
    void resetPassword(String id);

    Integer verifyAccount(String account);
    Integer verifyEmail(String email);
    Boolean verifyLogin(User user);
    Boolean register(User user);
    String selectIdByMail(String email);
    void updatePassword(User user);
    String setTokenById(String id,String email);
    void signOut();
    Boolean verifyPwdIsTrue(User user);
    void updatePwd(User user);
}
