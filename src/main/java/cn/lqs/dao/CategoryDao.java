/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 16:20
 */
package cn.lqs.dao;

import cn.lqs.cart.bean.Cart;
import cn.lqs.category.bean.Category;

import java.util.List;

public interface CategoryDao extends DAO<Category> {
    List<Category> queryListFirstCategory();

    List<Category> queryListSecondCategory(long code);

    String selectNameByCode(long code);

    String queryNameByCode(long code);

    Category searchName(String string);
}