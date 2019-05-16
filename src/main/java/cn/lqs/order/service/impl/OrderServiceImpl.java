/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 13:12
 */
package cn.lqs.order.service.impl;

import cn.lqs.address.bean.Address;
import cn.lqs.address.service.AddressService;
import cn.lqs.base.BaseServiceImpl;
import cn.lqs.dao.AddressDao;
import cn.lqs.dao.DAO;
import cn.lqs.dao.OrderDao;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.order.bean.Order;
import cn.lqs.order.bean.OrderGoods;
import cn.lqs.order.service.OrderService;
import cn.lqs.user.bean.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl extends BaseServiceImpl<Order> implements OrderService {

    private OrderDao orderDao;

    @Autowired
    private AddressService addressService;

    @Autowired
    private GoodsService goodsService;


    @Override
    @Autowired
    public void setDao(@Qualifier("orderDao") DAO<Order> dao) {
        super.dao = dao;
        this.orderDao = (OrderDao) dao;
    }

    @Override
    public void createOrderGoods(OrderGoods orderGoods) {
        orderDao.createOrderGoods(orderGoods);
    }

    @Override
    public List<Order> selectByUserId(String id) {
        return orderDao.selectByUserId(id);
    }

    @Override
    public List<OrderGoods> selectGoodsByOrderId(String id) {
        return orderDao.selectGoodsByOrderId(id);
    }

    @Override
    public void removeGoodsByOrderId(String id) {
        orderDao.removeGoodsByOrderId(id);
    }

    @Override
    public Order createOrder(List<OrderGoods> goodsList, String addressId) {
        String userId = ((User) session.getAttribute("user")).getId();
        Order order = new Order();
        order.setUserId(userId);
        order.setCreateTime(new Date());
        Address address = addressService.queryById(addressId);
        String userInfo = address.getProvinceName() + " " + address.getAreaName() + " " +
                address.getStreetName() + " " + address.getDetail() + " 收件人：" + address.getRecipient()
                + " 手机号：" + address.getPhone();
        order.setUserInfo(userInfo);
        Goods goods = null;
        double totalPrice = 0;
        for (OrderGoods orderGoods : goodsList) {
            goods = goodsService.queryById(orderGoods.getGoodsId());
            totalPrice += goods.getPrice() * orderGoods.getNumber();
            orderGoods.setOrderId(order.getId());
            orderDao.createOrderGoods(orderGoods);
        }
        order.setTotalPrice(totalPrice);
        orderDao.create(order);
        return order;

    }

    @Override
    public void setPayed(String id) {
        Order order = new Order();
        order.setId(id);
        order.setPayTime(new Date());
        orderDao.setPayed(order);

    }

    @Override
    public void setShip(String id) {
        orderDao.setShip(id);
    }

    @Override
    public void setFinish(String id) {
        Order order = new Order();
        order.setId(id);
        order.setPayTime(new Date());
        orderDao.setFinish(order);
    }

    @Override
    public void remove(String id) {
        orderDao.remove(id);
        this.removeGoodsByOrderId(id);
    }
}
