/**
 * User: LiQingsong
 * Date: 2019/4/28
 * Time: 9:08
 */
package cn.lqs.administrator.controller;

import cn.lqs.administrator.bean.Administrator;
import cn.lqs.administrator.service.AdministratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("administratorController")
public class AdministratorController {

    @Autowired
    private AdministratorService administratorService;

    @RequestMapping(value = "login")
    private String login(){
        return "manage-page/login";
    }

    @RequestMapping(value = "verifyAccountAndPwd", method = RequestMethod.POST)
    @ResponseBody
    private Object verifyAccountAndPwd(@RequestBody Administrator administrator){
        Administrator admin = administratorService.verifyLogin(administrator);
        Map<String,Boolean> map = new HashMap<>();
        if (admin!=null){
            map.put("isTrue",true);
        }else{
            map.put("isTrue",false);
        }
        return map;
    }
    @RequestMapping(value = "verifyPassword", method = RequestMethod.POST)
    @ResponseBody
    private Object verifyPassword(@RequestBody Map<String,String> data){
        System.out.println("接收到的密码是："+data.get("password"));
        Boolean isTure = administratorService.verifyPassword(data.get("password"));
        Map<String,Boolean> map = new HashMap<>();
        map.put("isTrue",isTure);
        return map;
    }
    @RequestMapping(value = "modifyPassword", method = RequestMethod.POST)
    @ResponseBody
    private Object modifyPassword(@RequestBody Map<String,String> data){
        administratorService.updatePassword(data.get("password"));
        Map<String,Boolean> map = new HashMap<>();
        map.put("data",true);
        return map;
    }
    @RequestMapping(value = "signOut")
    public String signOut(){
       administratorService.signOut();
        return "redirect:/administratorController/login";
    }
}
