/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 16:51
 */
package cn.lqs.category.service.impl;

import cn.lqs.base.BaseServiceImpl;
import cn.lqs.category.bean.Category;
import cn.lqs.category.service.CategoryService;
import cn.lqs.dao.CategoryDao;
import cn.lqs.dao.DAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CategoryServiceImpl extends BaseServiceImpl<Category> implements CategoryService {

    private CategoryDao categoryDao;
    @Autowired
    @Override
    public void setDao(@Qualifier("categoryDao") DAO<Category> dao) {
        super.dao = dao;
        this.categoryDao = (CategoryDao) dao;
    }

    @Override
    public List<Category> queryListFirstCategory() {
        return categoryDao.queryListFirstCategory();
    }

    @Override
    public List<Category> queryListSecondCategory(long code) {
        return categoryDao.queryListSecondCategory(code);
    }
}
