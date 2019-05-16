/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 15:04
 */
package cn.lqs.address.controller;

import cn.lqs.address.bean.Address;
import cn.lqs.address.bean.Province;
import cn.lqs.address.service.AddressService;
import cn.lqs.base.BaseController;
import cn.lqs.base.BaseServiceImpl;
import cn.lqs.user.bean.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.jws.Oneway;
import java.awt.geom.Area;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("address")
public class AddressController extends BaseController {

    @Autowired
    private AddressService addressService;

    @RequestMapping(value = "queryListByUser/{id}",method = RequestMethod.GET)
    private Object queryListByUserId(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        List<Address> addressList = addressService.queryListByUserId(id);
        map.put("code",0);
        map.put("msg","");
        map.put("data",addressList);
        return map;
    }
    @RequestMapping(value = "createAddress",method = RequestMethod.POST)
    private Object createAddr(@RequestBody Address address){
        Map<String,Object> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        address.setUserId(user.getId());
        addressService.create(address);
        map.put("code",0);
        map.put("msg","success");
        return map;
    }
    @RequestMapping("getProvinceAndArea")
    private Object getProvinceAndArea(){
        List<Province> provinceList = addressService.getProvince();
        List<Province> areaList = addressService.getArea();
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","success");
        map.put("province",provinceList);
        map.put("area",areaList);
        return map;
    }
    @RequestMapping("getTown/{area}")
    private Object getTown(@PathVariable Long area){
        //System.out.println("区域的code："+area);
        Province province = addressService.queryProvinceByCode(area);
       // System.out.println("区域："+province);
        List<Province> townList = addressService.getTwon(province.getArea());
       // System.out.println("查询到的街道："+townList);
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","success");
        map.put("town",townList);
        return map;
    }
   @RequestMapping("setDefault/{addressId}")
    private Object setDefault(@PathVariable String addressId){
       Map<String,Object> map = new HashMap<>();
       addressService.setDefault(addressId);
       map.put("code",0);
       map.put("msg","success");
       return map;
    }
    @RequestMapping("remove/{id}")
    private Object remove(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        addressService.remove(id);
        map.put("code",0);
        map.put("msg","success");
        return map;
    }
    @RequestMapping(value = "modify",method = RequestMethod.POST)
    private Object modify(@RequestBody Address address){
        Map<String,Object> map = new HashMap<>();
        addressService.modify(address);
        map.put("code",0);
        map.put("msg","success");
        return map;
    }
    @RequestMapping("queryById/{id}")
    private Object queryById(@PathVariable String id){
        Map<String,Object> map = new HashMap<>();
        Address address = addressService.queryById(id);
        session.setAttribute("defaultAddress",address);
        map.put("code",0);
        map.put("msg","success");
        map.put("data",address);
        return map;
    }


}
