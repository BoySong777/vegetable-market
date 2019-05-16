/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 10:07
 */
package cn.lqs.cart.controller;

import cn.lqs.address.bean.Address;
import cn.lqs.address.service.AddressService;
import cn.lqs.base.BaseController;
import cn.lqs.cart.bean.Cart;
import cn.lqs.cart.service.CartService;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.user.bean.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("cart")
public class CartController extends BaseController {

    @Autowired
    private CartService cartService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private AddressService addressService;

    @RequestMapping("addCart")
    @ResponseBody
    private Object addCart(@RequestBody Cart cart){
        Goods goods = goodsService.queryById(cart.getGoodsId());
        cart.setGoodsName(goods.getName());
        cart.setCategoryCode(goods.getCategoryCode());
        cart.setTypeCode(goods.getTypeCode());
        cart.setAvatar(goods.getAvatar());
        cart.setGoodsPrice(goods.getPrice());
        Map<String,Object> map = new HashMap<>();
        cartService.create(cart);

        map.put("msg","success");
        return map;
    }
    @RequestMapping("getCartList")
    private String getCartList(){
        User user = (User) session.getAttribute("user");
        if (user==null){
            return "redirect:/jsp/front-page/login.jsp";
        }

        Map<String,Integer> goodsStockMap = new HashMap<>();
        List<Cart> cartGoodsList = cartService.queryByUserId(user.getId());
        int stock = 0;
        for(Cart cart:cartGoodsList){
            stock = goodsService.queryById(cart.getGoodsId()).getStock();
            goodsStockMap.put(cart.getGoodsId(),stock);
        }

        session.setAttribute("goodsStockMap",goodsStockMap);
        session.setAttribute("cartGoodsList",cartGoodsList);

        return "front-page/goods/cartPage";
    }

    @RequestMapping("removeCartGoods")
    @ResponseBody
    public String deleteOrderItem(String cartGoodsId){
        User user =(User) session.getAttribute("user");
        if(null==user)
            return "fail";
       cartService.remove(cartGoodsId);
        return "success";
    }

    @RequestMapping("forechangeOrderItem")
    @ResponseBody
    public String changeOrderItem(Model model, String goodsId, int number) {
        User user =(User)  session.getAttribute("user");
        if(null==user)
            return "fail";
        Cart cart = new Cart();
        cart.setUserId(user.getId());
        cart.setGoodsId(goodsId);
        cart.setNumber(number);
        cartService.updateGoodsNum(cart);
        return "success";
    }
    @RequestMapping(value = "createOrder",method = RequestMethod.POST)
    @ResponseBody
    public String createOrder(@RequestBody String[] goodsIdList){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return "fail";
        }
        List<Cart> buyGoodsList = new ArrayList<>();
        Cart cart = null;
        double buyGoodsPrice = 0;
        for(String goodsId:goodsIdList){
            cart = cartService.queryById(goodsId);
            buyGoodsPrice += cart.getNumber()*cart.getGoodsPrice();
            buyGoodsList.add(cart);
        }
        Address defaultAddress = addressService.queryDefault(user.getId());
        List<Address> addressList = addressService.queryListByUserId(user.getId());
        if(defaultAddress==null && addressList.size()>0){
            defaultAddress = addressList.get(0);
        }
        session.setAttribute("defaultAddress",defaultAddress);
        session.setAttribute("addressList",addressList);
        session.setAttribute("buyGoodsList",buyGoodsList);
        session.setAttribute("buyGoodsPrice",buyGoodsPrice);
        return  "success";
    }


}
