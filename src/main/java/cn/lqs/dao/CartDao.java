/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 10:07
 */
package cn.lqs.dao;

import cn.lqs.cart.bean.Cart;

import java.util.List;

public interface CartDao extends DAO<Cart> {
    List<Cart> queryByUserId(String id);
    void removeByUserId(String id);
    void updateGoodsNum(Cart cart);
    Cart queryGoodsByUserIdAndGoodsId(Cart cart);

}
