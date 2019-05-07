/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 15:04
 */
package cn.lqs.address.controller;

import cn.lqs.address.bean.Address;
import cn.lqs.address.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("address")
public class AddressController {

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
}
