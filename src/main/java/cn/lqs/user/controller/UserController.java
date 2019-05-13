/**
 * User: LiQingsong
 * Date: 2019/5/6
 * Time: 10:34
 */
package cn.lqs.user.controller;

import cn.lqs.user.bean.User;
import cn.lqs.user.bean.UserVo;
import cn.lqs.user.service.UserService;
import cn.lqs.util.QueryResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "queryList",method = RequestMethod.POST)
    @ResponseBody
    private Object queryList(@RequestBody UserVo userVo){
        Map<String,Object> map = new HashMap<>();
        QueryResult<User> queryResult = new QueryResult<User>();
        queryResult = userService.findList(userVo);
        map.put("code",0);
        map.put("msg","");
        map.put("count",queryResult.getTotal());
        map.put("data",queryResult.getRows());
        return map;
    }

    @RequestMapping(value = "queryById/{id}",method = RequestMethod.GET)
    @ResponseBody
    private Object queryById(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        User user = userService.queryById(id);
        map.put("data",user);
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "resetPwd/{id}",method = RequestMethod.GET)
    @ResponseBody
    private Object resetPwd(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        userService.resetPassword(id);
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "remove/{id}",method = RequestMethod.GET)
    @ResponseBody
    private Object remove(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        userService.remove(id);
        map.put("msg","success");
        return map;
    }
    @RequestMapping(value = "verifyAccount/{account}",method = RequestMethod.GET)
    @ResponseBody
    private Object verifyAccount(@PathVariable String account){
        Map<String,Object> map = new HashMap<>();
        int num = userService.verifyAccount(account);
        map.put("msg","success");
        map.put("num",num);
        return map;
    }

    @RequestMapping(value = "verifyEmail/{email}/{type}",method = RequestMethod.GET)
    @ResponseBody
    private Object verifyEmail(@PathVariable String email){
        Map<String,Object> map = new HashMap<>();
        int num = userService.verifyEmail(email);
        map.put("msg","success");
        map.put("num",num);
        return map;
    }
    @RequestMapping(value = "verifyLogin",method = RequestMethod.POST)
    @ResponseBody
    private Object verifyLogin(@RequestBody User user){
        Map<String,Object> map = new HashMap<>();
        boolean isTure  = userService.verifyLogin(user);
        map.put("code",0);
        map.put("msg","success");
        map.put("isTrue",isTure);

        return map;
    }
    @RequestMapping(value = "register",method = RequestMethod.POST)
    @ResponseBody
    private Object register(@RequestBody User user){
        Map<String,Object> map = new HashMap<>();
        boolean isTure  = userService.register(user);
        map.put("code",0);
        map.put("msg","success");
        map.put("isTrue",isTure);
        return map;
    }
    @RequestMapping(value = "updatePwd",method = RequestMethod.POST)
    @ResponseBody
    private Object udatePwd(@RequestBody User user){
        Map<String,Object> map = new HashMap<>();
        userService.updatePassword(user);
        map.put("code",0);
        map.put("msg","success");
        return map;
    }
    @RequestMapping(value = "signOut",method = RequestMethod.GET)
    private String signOut(){
        userService.signOut();
        return "redirect:/index.jsp";
    }
}
