package cn.lqs.dao;

import cn.lqs.administrator.bean.Administrator;

public interface AdministratorDao extends DAO<Administrator> {
   Administrator selectOneByAccountAndPwd(Administrator administrator);

   void updatePassword(Administrator administrator);

   Integer selectAccount(String account);

}
