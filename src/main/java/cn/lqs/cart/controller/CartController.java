/**
 * User: LiQingsong
 * Date: 2019/5/15
 * Time: 10:07
 */
package cn.lqs.cart.controller;

import cn.lqs.base.BaseController;
import cn.lqs.cart.bean.Cart;
import cn.lqs.cart.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("cart")
public class CartController extends BaseController {

    @Autowired
    private CartService cartService;

    @RequestMapping("addCart")
    @ResponseBody
    private Object addCart(@RequestBody Cart cart){
        Map<String,Object> map = new HashMap<>();
        cartService.create(cart);

        map.put("msg","success");
        return map;
    }

}
