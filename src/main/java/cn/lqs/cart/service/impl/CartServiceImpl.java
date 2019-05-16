/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 10:29
 */
package cn.lqs.cart.service.impl;

import cn.lqs.base.BaseServiceImpl;
import cn.lqs.cart.bean.Cart;
import cn.lqs.cart.service.CartService;
import cn.lqs.dao.CartDao;
import cn.lqs.dao.DAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CartServiceImpl extends BaseServiceImpl<Cart> implements CartService {

    private CartDao cartDao;

    @Override
    @Autowired
    public void setDao(@Qualifier("cartDao") DAO<Cart> dao) {
        super.dao = dao;
        cartDao = (CartDao) dao;
    }

    @Override
    public List<Cart> queryByUserId(String id) {
        return cartDao.queryByUserId(id);
    }

    @Override
    public void removeByUserId(String id) {
        cartDao.removeByUserId(id);
    }

    @Override
    public void updateGoodsNum(Cart cart) {
        cartDao.updateGoodsNum(cart);
    }

    @Override
    public Cart queryGoodsByUserIdAndGoodsId(Cart cart) {
        return cartDao.queryGoodsByUserIdAndGoodsId(cart);
    }
    @Override
    public void create(Cart cart){
        Cart cart1 = this.queryGoodsByUserIdAndGoodsId(cart);
        if (cart1==null){
            cartDao.create(cart);
        }else {
            cart1.setNumber(cart1.getNumber()+cart.getNumber());
            this.updateGoodsNum(cart1);
        }
    }

}
