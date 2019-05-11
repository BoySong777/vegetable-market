package cn.lqs.category.service;

import cn.lqs.base.BaseService;
import cn.lqs.category.bean.Category;

import java.util.List;

public interface CategoryService extends BaseService<Category> {
    List<Category> queryListFirstCategory();

    List<Category> queryListSecondCategory(long code);
}
