/**
 * User: LiQingsong
 * Date: 2019/5/8
 * Time: 21:06
 */
package cn.lqs.goods.controller;

import cn.lqs.base.BaseController;
import cn.lqs.browse.bean.BrowseRecord;
import cn.lqs.browse.service.BrowseRecordService;
import cn.lqs.category.bean.Category;
import cn.lqs.category.service.CategoryService;
import cn.lqs.dao.StatisticsDao;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;
import cn.lqs.goods.bean.GoodsVo;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.statistics.bean.Statistics;
import cn.lqs.statistics.service.StatisticsService;
import cn.lqs.user.bean.User;
import cn.lqs.user.service.UserService;
import cn.lqs.util.QueryResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.jws.Oneway;
import java.util.*;

@Controller
@RequestMapping("goods")
public class GoodsController extends BaseController {

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private BrowseRecordService browseRecordService;
    @Autowired
    private UserService userService;
    @Autowired
    private StatisticsService statisticsService;

    @RequestMapping(value = "create",method = RequestMethod.POST)
    @ResponseBody
    private Object create(@RequestBody GoodsVo goodsVo){
        Map<String,Object> map = new HashMap<>();
        goodsService.createGoods(goodsVo);
        map.put("code",0);
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "queryList",method = RequestMethod.POST)
    @ResponseBody
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
    @ResponseBody
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
    @ResponseBody
    private Object update(@RequestBody GoodsVo goodsVo){
        goodsService.updateGoods(goodsVo);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","success");
        return map;
    }

    @RequestMapping(value = "remove/{id}",method = RequestMethod.GET)
    @ResponseBody
    private Object remove(@PathVariable String id){
        goodsService.remove(id);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","success");
        return map;
    }
    @RequestMapping(value = "uploadImg",method = RequestMethod.POST)
    @ResponseBody
    private Object uploadImg(@RequestBody MultipartFile file){
        System.out.println("上传到后台！");
        String fileName = goodsService.dealUpload(file);
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","success");
        map.put("data", fileName);
        return map;
    }

    @RequestMapping(value = "homePage")
    @ResponseBody
    private Object homePage(){
        List<Category> categoryList = categoryService.queryListFirstCategory();
        Map<Long,List<Category>> typeListMap = new HashMap<>();
        Map<Long,List<Goods>> goodsListMap = new HashMap<>();
        for (Category category:categoryList){
            List<Category> typeList = categoryService.queryListSecondCategory(category.getCode());
            List<Goods> goodsList = goodsService.queryByCategoryCode(category.getCode());
            typeListMap.put(category.getCode(),typeList);
            goodsListMap.put(category.getCode(),goodsList);
        }
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("categoryList",categoryList);
        map.put("goodsListMap",goodsListMap);
        map.put("typeListMap",typeListMap);
        return map;
    }

    @RequestMapping(value = "/goodsDetail/{id}",method = RequestMethod.GET)
    private String goodsDetail(@PathVariable String id){
        Statistics statistics = statisticsService.findByTimes(new Date());
        if(statistics==null){
            statistics = new Statistics();
            statistics.setTimes(new Date());
            statisticsService.create(statistics);
        }
        statisticsService.addAccess(statistics.getId());

        Goods goods = goodsService.queryById(id);
        GoodsDetail goodsDetail = goodsService.queryDetail(id);

        User user = (User) session.getAttribute("user");
        if(user!=null){
            int goodsFeature = goods.getFeature();
            this.recording(user.getId(),id,goodsFeature);
        }

        String imgs = goodsDetail.getImgs();
        String[] goodsImgList = imgs.split(",");
        session.setAttribute("detailPageGoods",goods);
        session.setAttribute("detailPageGoodsDetail",goodsDetail);
        session.setAttribute("goodsImgList",goodsImgList);

        return "front-page/goods/goodsDetailPage";
    }

    @RequestMapping("searchGoods")
    private String searchGoods(String searchValue){
        this.removeCategoryUtil();
        /*GoodsVo goodsVo = new GoodsVo();
        goodsVo.setPagingFlag(false);
        goodsVo.getGoods().setName(searchValue);
        List<Goods> searchGoodsList  = goodsService.queryList(goodsVo);*/
        List<Goods> searchGoodsList = goodsService.searchGoods(searchValue);
        session.setAttribute("searchGoodsList",searchGoodsList);
        session.setAttribute("searchVal",searchValue);
        return "front-page/goods/searchPage";
    }
    @RequestMapping("searchFirstCategory/{firstCategory}")
    private String searchFirstCategory(@PathVariable Long firstCategory){
        this.removeCategoryUtil();
        GoodsVo goodsVo = new GoodsVo();
        goodsVo.setPagingFlag(false);
        goodsVo.getGoods().setCategoryCode(firstCategory);
        List<Goods> searchGoodsList  = goodsService.queryGoodsByCategoryAndUser(goodsVo);
        String firstCategoryName = categoryService.queryNameByCode(firstCategory);
        session.setAttribute("searchGoodsList",searchGoodsList);
        session.setAttribute("searchFirstCategory",firstCategoryName);
        return "front-page/goods/searchPage";
    }

    @RequestMapping("searchSecondCategory/{firstCategory}/{typeCode}")
    private String searchSecondCategory(@PathVariable Long firstCategory,@PathVariable Long typeCode){
        this.removeCategoryUtil();
        GoodsVo goodsVo = new GoodsVo();
        goodsVo.setPagingFlag(false);
        goodsVo.getGoods().setTypeCode(typeCode);
        goodsVo.getGoods().setCategoryCode(firstCategory);
        System.out.println("查询条件goodsVo："+goodsVo);
        List<Goods> searchGoodsList  = goodsService.queryGoodsByCategoryAndUser(goodsVo);
        String firstCategoryName = categoryService.queryNameByCode(firstCategory);
        String typeCodeName = categoryService.queryNameByCode(typeCode);
        session.setAttribute("searchGoodsList",searchGoodsList);
        session.setAttribute("searchFirstCategory",firstCategoryName);
        session.setAttribute("searchSecondCategory",typeCodeName);
        return "front-page/goods/searchPage";
    }

    @RequestMapping(value = "updateStock",method = RequestMethod.POST)
    @ResponseBody
    public String updateStock(@RequestBody Goods goods){
        goodsService.updateStock(goods);
        return "success";
    }

    private void removeCategoryUtil(){
        session.removeAttribute("searchFirstCategory");
        session.removeAttribute("searchSecondCategory");
        session.removeAttribute("searchVal");
    }

    /**
     * 记录用户的浏览记录
     * @param userId
     * @param goodsId
     */
    private void recording(String userId,String goodsId,int goodsFeature){
        userService.recoding(goodsFeature,userId);

        BrowseRecord b = new BrowseRecord();
        b.setGoodsId(goodsId);
        b.setUserId(userId);
        BrowseRecord browseRecord = browseRecordService.queryByUserAndGoods(b);
        if(browseRecord == null){
            browseRecordService.create(b);
        }else {
            browseRecord.setNumber(browseRecord.getNumber()+1);
            browseRecordService.modify(browseRecord);
        }
    }
    @RequestMapping("sortGoodsByPrice/{sortType}")
    private String sortGoodsByPrice(@PathVariable String sortType){
        List<Goods> searchGoodsList = (List<Goods>) session.getAttribute("searchGoodsList");
        if (sortType.equals("up")){
            Collections.sort(searchGoodsList, new Comparator<Goods>() {
                @Override
                public int compare(Goods o1, Goods o2) {
                    double price1 = o1.getPrice();
                    double price2 = o2.getPrice();
                    if(price1>price2){
                        return 1;
                    }else{
                        return -1;
                    }
                }
            });
        }else {
            Collections.sort(searchGoodsList, new Comparator<Goods>() {
                @Override
                public int compare(Goods o1, Goods o2) {
                    double price1 = o1.getPrice();
                    double price2 = o2.getPrice();
                    if(price1>price2){
                        return -1;
                    }else{
                        return 1;
                    }
                }
            });
        }
        session.setAttribute("searchGoodsList",searchGoodsList);
        return "front-page/goods/searchPage";
    }

    @RequestMapping("clickAdPic/{adType}/{number}")
    private String clickAdPic(@PathVariable String adType,@PathVariable int number){
        this.removeCategoryUtil();
        List<Goods> searchGoodsList = goodsService.queryByAd(adType,number);
        session.setAttribute("searchGoodsList",searchGoodsList);
        return "front-page/goods/searchPage";
    }


}
