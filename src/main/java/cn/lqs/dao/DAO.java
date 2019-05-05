package cn.lqs.dao;


import javax.persistence.criteria.CriteriaBuilder;
import java.io.Serializable;
import java.util.List;

public interface DAO<T extends Serializable> {

    void create(T t);

    List<T> queryList(Object parameter);

    Integer countModelNum(Object parameter);

    T queryById(String id);

    void modify(T t);

    void remove(String id);

}
