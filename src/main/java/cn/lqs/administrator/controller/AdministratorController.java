/**
 * User: LiQingsong
 * Date: 2019/4/28
 * Time: 9:08
 */
package cn.lqs.administrator.controller;

import cn.lqs.administrator.bean.Administrator;
import cn.lqs.administrator.bean.AdministratorVo;
import cn.lqs.administrator.service.AdministratorService;
import cn.lqs.util.ExecutionResult;
import cn.lqs.util.QueryResult;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.ResultSet;
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
    @RequestMapping(value = "modify", method = RequestMethod.POST)
    @ResponseBody
    private Object modify(@RequestBody Administrator administrator){
        administratorService.modify(administrator);
        Map<String,Boolean> map = new HashMap<>();
        map.put("data",true);
        return map;
    }
    @RequestMapping(value = "selectAccount/{account}")
    @ResponseBody
    private Object selectAccount(@PathVariable String account){
        int num = administratorService.selectAccount(account);
        Map<String,Integer> map = new HashMap<>();
        map.put("num",num);
        return map;
    }
    @RequestMapping(value = "create", method = RequestMethod.POST)
    @ResponseBody
    private Object create(@RequestBody Administrator administrator){
        administratorService.create(administrator);
        Map<String,Boolean> map = new HashMap<>();
        map.put("data",true);
        return map;
    }
    @RequestMapping(value = "queryList", method = RequestMethod.POST)
    @ResponseBody
    private Object queryList(@RequestBody AdministratorVo administratorVo){
        ExecutionResult result = new ExecutionResult();
        Map<String, Object> map = new HashMap<>();

            QueryResult<Administrator> queryResult = administratorService.findList(administratorVo);
            result.setFlag(true);
            result.setTotal(queryResult.getTotal());
            result.setRows(queryResult.getRows());
            result.setMsg("admin列表查询成功");
            map.put("code",0);
            map.put("msg","");
            map.put("count",queryResult.getTotal());
            map.put("data",queryResult.getRows());

      /*  }catch (Exception e){
            result.setFlag(false);
            result.setRows(new Object[]{});
            result.setTotal(0);
            result.setMsg("查询失败");
            System.out.println("controller进入catch里面了");
        }*/
        return map;
    }

    @RequestMapping(value = "findOneById", method = RequestMethod.POST)
    @ResponseBody
    private Object findOneById(@RequestBody Map<String,String> data){
        Administrator administrator = administratorService.queryById(data.get("id"));
        Map<String,Object> map = new HashMap<>();
        map.put("administrator",administrator);
        return map;
    }

    @RequestMapping(value = "updateById", method = RequestMethod.POST)
    @ResponseBody
    private Object updateById(@RequestBody Administrator administrator){
        System.out.println("需要更改的Id为："+administrator.getId());
        administratorService.updateById(administrator);
        Map<String, Boolean> map = new HashMap<>();
        map.put("data",true);
        return map;
    }

    @RequestMapping(value = "remove", method = RequestMethod.POST)
    @ResponseBody
    private Object remove(@RequestBody Map<String,String> data){
        boolean isOwn = administratorService.remove(data.get("id"));
        Map<String,Object> map = new HashMap<>();
        map.put("isDelete",true);
        map.put("isOwn",isOwn);
        return map;
    }

}
