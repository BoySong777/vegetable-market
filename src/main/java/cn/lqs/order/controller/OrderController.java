/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 13:18
 */
package cn.lqs.order.controller;

import cn.lqs.address.bean.Address;
import cn.lqs.address.service.AddressService;
import cn.lqs.base.BaseController;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.order.bean.Order;
import cn.lqs.order.bean.OrderGoods;
import cn.lqs.order.service.OrderService;
import cn.lqs.user.bean.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("order")
@Controller()
public class OrderController extends BaseController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private AddressService addressService;

    @RequestMapping("buyOne/{goodsId}/{number}")
    private String buyOne(@PathVariable String goodsId,@PathVariable int number){
        Goods buyOneGoods = goodsService.queryById(goodsId);
        double buyOnetotalPrice = buyOneGoods.getPrice()*number;
        User user = (User) session.getAttribute("user");
        Address defaultAddress = addressService.queryDefault(user.getId());
        List<Address> addressList = addressService.queryListByUserId(user.getId());
        if(defaultAddress==null && addressList.size()>0){
            defaultAddress = addressList.get(0);
        }
        session.setAttribute("defaultAddress",defaultAddress);
        session.setAttribute("addressList",addressList);
        session.setAttribute("buyOneGoods",buyOneGoods);
        session.setAttribute("buyOnetotalPrice",buyOnetotalPrice);
        session.setAttribute("buyOneNumber",number);
        return  "front-page/goods/orderPage";
    }
    @RequestMapping("payed/{orderId}")
    private String payed(@PathVariable String orderId){
        System.out.println("更改已付款状态的订单id："+orderId);
        orderService.setPayed(orderId);
        return  "front-page/goods/payedPage";
    }
    @RequestMapping("createOneGoodsOrder/{addressId}")
    private String createOneGoodsOrder(@PathVariable String addressId){
        Goods goods = (Goods) session.getAttribute("buyOneGoods");
        int number = (int) session.getAttribute("buyOneNumber");
        OrderGoods orderGoods = new OrderGoods();
        orderGoods.setNumber(number);
        orderGoods.setGoodsId(goods.getId());
        List<OrderGoods> goodsList = new ArrayList<>();
        goodsList.add(orderGoods);
        Order order = orderService.createOrder(goodsList,addressId);
        session.setAttribute("userInfo",order.getUserInfo());
        session.setAttribute("orderId",order.getId());
        session.setAttribute("totalGoodsPrice",order.getTotalPrice());
        return  "front-page/goods/payPage";
    }


}
