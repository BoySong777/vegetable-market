package cn.lqs.administrator.service;


import cn.lqs.administrator.bean.Administrator;

public interface AdministratorService {

    Administrator verifyLogin(Administrator administrator);

    Boolean verifyPassword(String password);

    void updatePassword(String password);

    void create(Administrator administrator);

    void remove(String id);

    void signOut();
}