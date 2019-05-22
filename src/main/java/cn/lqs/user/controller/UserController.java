/**
 * User: LiQingsong
 * Date: 2019/5/6
 * Time: 10:34
 */
package cn.lqs.user.controller;

import cn.lqs.base.BaseController;
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
public class UserController extends BaseController {

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
        System.out.println("查询员工：后台查询成功将要返回");
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
    //这个应该是没用的，下边还有一个修改密码的方法
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
        return "redirect:/index";
    }
    @RequestMapping("checkLogin")
    @ResponseBody
    private Object checkLogin(){
        Map<String,Object> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if(user!=null){
            String id = user.getId();
            map.put("userId",id);
            map.put("result","success");
        }else{
            map.put("result","fail");
        }

        return map;
    }
    @RequestMapping(value = "updateUser",method = RequestMethod.POST)
    @ResponseBody
    private Object udateUser(@RequestBody User user){
        User user1 = (User) session.getAttribute("user");
        if(user==null){
            return "fail";
        }
        user.setId(user1.getId());
        userService.modify(user);
        user1 = userService.queryById(user1.getId());
        session.setAttribute("user",user1);
        return "success";
    }
    @RequestMapping(value = "updateUserPassword",method = RequestMethod.POST)
    @ResponseBody
    private Object updateUserPassword(@RequestBody Map map){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return "fail";
        }
        user.setPassword((String) map.get("oldPwd"));
        boolean data = userService.verifyPwdIsTrue(user);
        if(data){
            user.setPassword((String) map.get("newPwd"));
            userService.updatePwd(user);
            return "success";
        }
        return "notTrue";
    }
}
