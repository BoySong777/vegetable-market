/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 13:18
 */
package cn.lqs.order.controller;

import cn.lqs.address.bean.Address;
import cn.lqs.address.service.AddressService;
import cn.lqs.base.BaseController;
import cn.lqs.cart.bean.Cart;
import cn.lqs.cart.service.CartService;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.order.bean.Order;
import cn.lqs.order.bean.OrderGoods;
import cn.lqs.order.service.OrderService;
import cn.lqs.user.bean.User;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@RequestMapping("order")
@Controller()
public class OrderController extends BaseController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private AddressService addressService;
    @Autowired
    private CartService cartService;

    @RequestMapping("buyOne/{goodsId}/{number}")
    private String buyOne(@PathVariable String goodsId,@PathVariable int number){
        Goods buyOneGoods = goodsService.queryById(goodsId);
        List<Cart> buyGoodsList = new ArrayList<>();
        Cart cart = new Cart();
        cart.setNumber(number);
        cart.setGoodsId(buyOneGoods.getId());
        cart.setGoodsPrice(buyOneGoods.getPrice());
        cart.setGoodsName(buyOneGoods.getName());
        cart.setCategoryCode(buyOneGoods.getCategoryCode());
        cart.setTypeCode(buyOneGoods.getTypeCode());
        cart.setAvatar(buyOneGoods.getAvatar());
        buyGoodsList.add(cart);
        double buyGoodsPrice = buyOneGoods.getPrice()*number;
        User user = (User) session.getAttribute("user");
        Address defaultAddress = addressService.queryDefault(user.getId());
        List<Address> addressList = addressService.queryListByUserId(user.getId());
        if(defaultAddress==null && addressList.size()>0){
            defaultAddress = addressList.get(0);
        }
        session.setAttribute("defaultAddress",defaultAddress);
        session.setAttribute("addressList",addressList);
        session.setAttribute("buyGoodsList",buyGoodsList);
        session.setAttribute("buyGoodsPrice",buyGoodsPrice);
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
        List<Cart> buyGoodsList = (List<Cart>) session.getAttribute("buyGoodsList");
        List<OrderGoods> goodsList = new ArrayList<>();
        for (Cart buyGoods:buyGoodsList){
            OrderGoods orderGoods = new OrderGoods();
            orderGoods.setNumber(buyGoods.getNumber());
            orderGoods.setGoodsName(buyGoods.getGoodsName());
            orderGoods.setGoodsPrice(buyGoods.getGoodsPrice());
            orderGoods.setGoodsId(buyGoods.getGoodsId());
            orderGoods.setCategoryCode(buyGoods.getCategoryCode());
            orderGoods.setTypeCode(buyGoods.getTypeCode());
            orderGoods.setAvatar(buyGoods.getAvatar());
            goodsList.add(orderGoods);
        }
        Order order = orderService.createOrder(goodsList,addressId);
        session.setAttribute("userInfo",order.getUserInfo());
        session.setAttribute("orderId",order.getId());
        session.setAttribute("totalGoodsPrice",order.getTotalPrice());
        for (Cart cart:buyGoodsList){
            cartService.remove(cart.getId());
        }
        return  "front-page/goods/payPage";
    }
    @RequestMapping("findOrderList/{userId}")
    private String findOrderList(@PathVariable String userId){
        List<Order> orderList = orderService.selectByUserId(userId);
        Map<String,List<OrderGoods>> orderGoodsMapperList = new HashMap<>();
        Map<String,List<Goods>> goodsMapperList = new HashMap<>();
        List<OrderGoods> orderGoodsList = new ArrayList<>();
        List<Goods> goodsList = new ArrayList<>();
        for(Order order:orderList){
            orderGoodsList = orderService.selectGoodsByOrderId(order.getId());
            for(OrderGoods orderGoods:orderGoodsList){
                goodsList.add(goodsService.queryById(orderGoods.getId()));
            }
            goodsMapperList.put(order.getId(),goodsList);
            orderGoodsMapperList.put(order.getId(),orderGoodsList);
        }
        session.setAttribute("orderList",orderList);
        session.setAttribute("orderGoodsMapperList",orderGoodsMapperList);
        session.setAttribute("goodsMapperList",goodsMapperList);
        return "front-page/goods/orderListPage";
    }
    @RequestMapping("confirmPay/{orderId}")
    public String confirmPay(@PathVariable String orderId){
        Order order = orderService.queryById(orderId);
        session.setAttribute("userInfo",order.getUserInfo());
        session.setAttribute("orderId",order.getId());
        session.setAttribute("totalGoodsPrice",order.getTotalPrice());
        return  "front-page/goods/payPage";
    }
    @RequestMapping("receipted/{orderId}")
    @ResponseBody
    public Object receipted(@PathVariable String orderId){
        Map<String,Object> map = new HashMap<>();
        orderService.setFinish(orderId);
        map.put("msg","success");
        return map;
    }
    @RequestMapping("myOrder")
    public String myOrder(){
        User user = (User) session.getAttribute("user");
        String basepath = (String) request.getAttribute("ctx");
        if(user!=null){
            return "redirect:/order/findOrderList/"+user.getId();
        }else {
            return "redirect:/jsp/front-page/login.jsp";
        }
    }
    @RequestMapping("deleteOrder")
    @ResponseBody
    public String deleteOrder(String orderId){
        orderService.remove(orderId);
        return "success";
    }

    @RequestMapping("setUrge")
    @ResponseBody
    public String setUrge(String orderId){
        orderService.setUrge(orderId);
        return "success";
    }

}
