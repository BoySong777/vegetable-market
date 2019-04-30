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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
