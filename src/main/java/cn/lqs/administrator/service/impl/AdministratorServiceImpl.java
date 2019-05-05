/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 22:47
 */
package cn.lqs.administrator.service.impl;

import cn.lqs.administrator.bean.Administrator;
import cn.lqs.administrator.bean.AdministratorVo;
import cn.lqs.administrator.service.AdministratorService;
import cn.lqs.dao.AdministratorDao;
import cn.lqs.util.QueryResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class AdministratorServiceImpl implements AdministratorService {

    @Autowired
    private AdministratorDao administratorDao;
    @Autowired
    private HttpServletRequest request;

    @Override
    public Administrator verifyLogin(Administrator administrator) {
        Administrator administrator1 = administratorDao.selectOneByAccountAndPwd(administrator);
        request.getSession().setAttribute("admin",administrator1);
        System.out.println("参数是："+administrator+",,结果是："+administrator1);
        return administrator1;
    }

    @Override
    public Boolean verifyPassword(String password) {
       Administrator administrator= (Administrator)request.getSession().getAttribute("admin");
       if(administrator!=null&&password!=null){
           if(password.equals(administrator.getPassword())){
               return true;
           }
       }
       return false;
    }

    @Override
    public void updatePassword(String password) {
        Administrator administrator= (Administrator)request.getSession().getAttribute("admin");
        administrator.setPassword(password);
        administratorDao.updatePassword(administrator);
        this.signOut();
    }

    @Override
    public void create(Administrator administrator) {
        //TODO:密码加密
        if(administrator.getPassword()==null||administrator.getPassword().equals("")){
            administrator.setPassword("1");
        }
        administratorDao.create(administrator);
    }

    @Override
    public Boolean remove(String id) {
        boolean isOwn = false;
        Administrator administrator= (Administrator)request.getSession().getAttribute("admin");
        if (administrator.getId().equals(id)){
            this.signOut();
            isOwn = true;
        }
        administratorDao.remove(id);
        return isOwn;
    }

    @Override
    public void signOut() {
        request.getSession().invalidate();
    }

    @Override
    public void modify(Administrator newAdministrator) {
        Administrator  administrator = (Administrator)request.getSession().getAttribute("admin");
        administrator.setAccount(newAdministrator.getAccount());
        administrator.setPhone(newAdministrator.getPhone());
        administratorDao.modify(administrator);
    }

    @Override
    public Integer selectAccount(String account) {
        int num = administratorDao.selectAccount(account)==null?0:administratorDao.selectAccount(account);
        return num;
    }

    @Override
    public QueryResult<Administrator> findList(AdministratorVo administratorVo) {
        QueryResult<Administrator> result = new QueryResult<>();
        result.setRows(this.queryList(administratorVo));
        int num = this.countAdminNum(administratorVo)==null?0:this.countAdminNum(administratorVo);
        result.setTotal(num);
        return result;

    }

    @Override
    public List<Administrator> queryList(AdministratorVo administratorVo) {
        return administratorDao.queryList(administratorVo);
    }

    @Override
    public Integer countAdminNum(AdministratorVo administratorVo) {
        return administratorDao.countModelNum(administratorVo);
    }

    @Override
    public Administrator queryById(String id) {
        return administratorDao.queryById(id);
    }

    @Override
    public void updateById(Administrator administrator) {
        administratorDao.modify(administrator);
    }
}
