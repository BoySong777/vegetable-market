package cn.lqs.dao;


import java.io.Serializable;
import java.util.List;

public interface DAO<T extends Serializable> {

    void create(T t);

    List<T> queryAll();

    List<T> queryList(Object parameter);

    T queryById(String id);

    void modify(T t);

    void remove(String id);

}
