package cn.lqs.dao;

import cn.lqs.search.bean.SearchSign;

import java.util.List;

public interface SearchSignDao extends DAO<SearchSign> {
    SearchSign queryByName(String name);
    List<SearchSign> queryByLikeName(String name);
}
