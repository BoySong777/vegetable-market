package cn.lqs.cart.service;

import cn.lqs.base.BaseService;
import cn.lqs.cart.bean.Cart;

import java.util.List;

public interface CartService extends BaseService<Cart>{
    List<Cart> queryByUserId(String id);
    void removeByUserId(String id);
    void updateGoodsNum(Cart cart);
}
