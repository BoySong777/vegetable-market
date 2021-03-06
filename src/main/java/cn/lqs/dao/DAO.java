package cn.lqs.dao;


import javax.persistence.criteria.CriteriaBuilder;
import java.io.Serializable;
import java.util.List;

public interface DAO<T extends Serializable> {

    void create(T t);

    List<T> queryList(Object parameter);

    /**
     * 查看实体类的数量，用于分页显示总数
     * @param parameter 查询的条件，是一个实体类
     * @return
     */
    Integer countModelNum(Object parameter);

    T queryById(String id);

    void modify(T t);

    void remove(String id);

}
