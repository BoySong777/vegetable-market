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

}
