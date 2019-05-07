package cn.lqs.user.service;

import cn.lqs.base.BaseService;
import cn.lqs.user.bean.User;

public interface UserService extends BaseService<User> {
    void resetPassword(String id);
}
