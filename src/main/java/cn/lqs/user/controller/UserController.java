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

@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "queryList",method = RequestMethod.POST)
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
    private Object queryById(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        User user = userService.queryById(id);
        map.put("data",user);
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "resetPwd/{id}",method = RequestMethod.GET)
    private Object resetPwd(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        userService.resetPassword(id);
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "remove/{id}",method = RequestMethod.GET)
    private Object remove(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        userService.remove(id);
        map.put("msg","success");
        return map;
    }
}
