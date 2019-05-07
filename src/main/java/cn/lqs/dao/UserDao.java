package cn.lqs.dao;

import cn.lqs.user.bean.User;

public interface UserDao extends DAO<User> {
    void resetPassword(String id);
}
