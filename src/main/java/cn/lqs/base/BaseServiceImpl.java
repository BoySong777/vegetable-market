/**
 * User: LiQingsong
 * Date: 2019/5/6
 * Time: 10:13
 */
package cn.lqs.base;

import cn.lqs.dao.DAO;
import cn.lqs.util.QueryResult;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.util.List;

public abstract class BaseServiceImpl<T extends Serializable> implements BaseService<T> {

    protected DAO<T> dao;

    protected HttpServletRequest request;

    protected HttpSession session;

    public abstract void setDao(DAO<T> dao);

    @Autowired
    public void setRequest( HttpServletRequest request){
        this.request = request;
        this.session = request.getSession();
    }

    @Override
    public void create(T t) {
        dao.create(t);
    }

    @Override
    public List<T> queryList(Object parameter) {
        return dao.queryList(parameter);
    }

    @Override
    public Integer countModelNum(Object parameter) {
        return dao.countModelNum(parameter);
    }

    @Override
    public T queryById(String id) {
        return dao.queryById(id);
    }

    @Override
    public void modify(T t) {
        dao.modify(t);
    }

    @Override
    public void remove(String id) {
        dao.remove(id);
    }

    @Override
    public QueryResult<T> findList(Object object) {
        QueryResult<T> result = new QueryResult<>();
        result.setRows(this.queryList(object));
        result.setTotal(this.countModelNum(object));
        return result;
    }
}
