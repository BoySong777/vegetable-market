/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 12:03
 */
package cn.lqs.dao;

import cn.lqs.order.bean.Order;
import cn.lqs.order.bean.OrderGoods;
import com.sun.org.apache.xpath.internal.operations.Or;

import java.util.List;
import java.util.Map;

public interface OrderDao extends DAO<Order> {
    void createOrderGoods(OrderGoods orderGoods);
    List<Order> selectByUserId(String id);
    List<OrderGoods> selectGoodsByOrderId(String id);
    void removeGoodsByOrderId(String id);
    void setPayed(Order order);
    void setShip(String id);
    void setFinish(Order order);
}
