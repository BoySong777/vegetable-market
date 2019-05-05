package cn.lqs.administrator.service;


import cn.lqs.administrator.bean.Administrator;
import cn.lqs.administrator.bean.AdministratorVo;
import cn.lqs.util.QueryResult;

import java.util.List;

public interface AdministratorService {

    Administrator verifyLogin(Administrator administrator);

    Boolean verifyPassword(String password);

    void updatePassword(String password);

    void create(Administrator administrator);

    Boolean remove(String id);

    void signOut();

    void modify(Administrator administrator);

    /**
     * 验证时候存在相同的account
     * @param account
     * @return 0 没有，!0 有
     */
    Integer selectAccount(String account);

    QueryResult<Administrator> findList(AdministratorVo administratorVo);

    List<Administrator> queryList(AdministratorVo administratorVo);

    Integer countAdminNum(AdministratorVo administratorVo);

    Administrator queryById(String id);

    void updateById(Administrator administrator);
}