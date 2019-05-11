/**
 * User: LiQingsong
 * Date: 2019/5/8
 * Time: 21:06
 */
package cn.lqs.goods.controller;

import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;
import cn.lqs.goods.bean.GoodsVo;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.util.QueryResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.jws.Oneway;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;
    @RequestMapping(value = "create",method = RequestMethod.POST)
    private Object create(@RequestBody GoodsVo goodsVo){
        Map<String,Object> map = new HashMap<>();
        goodsService.createGoods(goodsVo);
        map.put("code",0);
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "queryList",method = RequestMethod.POST)
    private Object queryList(@RequestBody GoodsVo goodsVo){
        Map<String,Object> map = new HashMap<>();
        QueryResult<Goods> queryResult = goodsService.findList(goodsVo);
        map.put("code",0);
        map.put("msg","");
        map.put("count",queryResult.getTotal());
        map.put("data",queryResult.getRows());
        return map;
    }

    @RequestMapping("queryDetail/{goodsId}")
    private Object queryDetail(@PathVariable String goodsId){
        GoodsDetail goodsDetail = goodsService.queryDetail(goodsId);
        Goods goods = goodsService.queryById(goodsId);
        Map<String,Object> map = new HashMap<>();
        map.put("goodsDetail",goodsDetail);
        map.put("goods",goods);
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "update",method = RequestMethod.POST)
    private Object update(@RequestBody GoodsVo goodsVo){
        goodsService.updateGoods(goodsVo);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "remove/{id}",method = RequestMethod.GET)
    private Object remove(@PathVariable String id){
        goodsService.remove(id);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","success");
        return map;
    }
    @RequestMapping(value = "uploadImg",method = RequestMethod.POST)
    private Object uploadImg(@RequestBody MultipartFile file){
        System.out.println("上传到后台！");
        String fileName = goodsService.dealUpload(file);
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","success");
        map.put("data", fileName);
        return map;
    }
}
