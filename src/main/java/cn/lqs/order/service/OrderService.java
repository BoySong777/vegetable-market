/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 13:11
 */
package cn.lqs.order.service;

import cn.lqs.base.BaseController;
import cn.lqs.base.BaseService;
import cn.lqs.order.bean.Order;
import cn.lqs.order.bean.OrderGoods;

import java.util.List;

public interface OrderService extends BaseService<Order> {
    void createOrderGoods(OrderGoods orderGoods);
    List<Order> selectByUserId(String id);
    List<OrderGoods> selectGoodsByOrderId(String id);
    Order createOrder(List<OrderGoods> goodsList,String addressId);
    void setPayed(String id);
    void setShip(String id);
    void setFinish(String id);
    void setUrge(String id);
}
