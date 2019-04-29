package cn.lqs.administrator.service;


import cn.lqs.administrator.bean.Administrator;

public interface AdministratorService {

    Administrator verifyLogin(Administrator administrator);

    void updatePassword(Administrator administrator);

    void create(Administrator administrator);

    void remove(String id);
}