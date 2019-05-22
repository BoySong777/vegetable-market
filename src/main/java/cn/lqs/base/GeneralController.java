/**
 * User: LiQingsong
 * Date: 2019/5/14
 * Time: 17:05
 */
package cn.lqs.base;

import cn.lqs.category.bean.Category;
import cn.lqs.category.service.CategoryService;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.order.service.OrderService;
import cn.lqs.statistics.bean.Statistics;
import cn.lqs.statistics.service.StatisticsService;
import cn.lqs.user.bean.User;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller

public class GeneralController extends BaseController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private StatisticsService statisticsService;
    @Autowired
    private OrderService orderService;


    @RequestMapping("index")
    private String start() {
        List<Category> categoryList = categoryService.queryListFirstCategory();
        Map<Long, List<Category>> typeListMap = new HashMap<>();
        Map<Long, List<Goods>> goodsListMap = new HashMap<>();
        for (Category category : categoryList) {
            List<Category> typeList = categoryService.queryListSecondCategory(category.getCode());
            List<Goods> goodsList = goodsService.queryByCategoryCode(category.getCode());
            typeListMap.put(category.getCode(), typeList);
            goodsListMap.put(category.getCode(), goodsList);
        }
        /*Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("categoryList",categoryList);
        map.put("goodsListMap",goodsListMap);
        map.put("typeListMap",typeListMap);*/

        this.setAd();

        session.setAttribute("categoryList", categoryList);
        session.setAttribute("goodsListMap", goodsListMap);
        session.setAttribute("typeListMap", typeListMap);
        List<Category> fistCategory = categoryService.queryListFirstCategory();
        session.setAttribute("fistCategory", fistCategory);
        System.out.println("真的是走这个方法了。");
        return "redirect:/newIndex.jsp";
    }

    @RequestMapping("searchRecord")
    @ResponseBody
    private Object searchRecord(){
        Map<String,Object> map = new HashMap<>();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date today = new Date();
        Statistics todayStatistics = statisticsService.findByTimes(today);
        if(todayStatistics==null){
            todayStatistics.setSales(0.00);
            todayStatistics.setAccess(0);
            todayStatistics.setOrders(0);
            todayStatistics.setTimes(today);
        }
        String[] dateStr = new String[5];
        int[] dateSales = new int[5];
        Calendar c = Calendar.getInstance();
        c.setTime(today);
        for(int i=1;i<=5;i++){
            c.add(Calendar.DAY_OF_MONTH,-1);
            Date day = c.getTime();
            String dayStr = format.format(day);
            Statistics statistics = statisticsService.findByTimes(day);
            if(statistics==null){
                dateSales[i-1]=0;
            }else{
                double sales = statistics.getSales();
                dateSales[i-1] = (int) sales;
            }
            dateStr[i-1] = dayStr;
        }

        int noShipOrderNumber = orderService.queryNoShipOrder()==null?0:orderService.queryNoShipOrder();
        int needAddGoodsNumber = goodsService.queryNeedAddGoodsNum()==null?0:goodsService.queryNeedAddGoodsNum();

        map.put("dateSales",dateSales);
        map.put("dateStr",dateStr);
        map.put("todayData",todayStatistics);
        map.put("noShipOrderNumber",noShipOrderNumber);
        map.put("needAddGoodsNumber",needAddGoodsNumber);
        map.put("msg","success");
        return map;
    }

    private void setAd(){
        String mainAd = "";
        String secAd = "";
        String thrAd = "";
        User user = (User) session.getAttribute("user");
        if(user==null){
            mainAd = secAd = thrAd = "com";
        }else {
            List<Integer> likeSort = user.getLikeSort();
            if(likeSort.get(0)==1){
                mainAd = "lowPrice";
                secAd = "solid";
                thrAd = "fresh";
            }else if(likeSort.get(0)==2){
                 mainAd= "solid";
                 secAd = "fresh";
                 thrAd  = "lowPrice";
            }else {
                 mainAd= "fresh";
                 secAd  = "lowPrice";
                 thrAd = "solid";
            }
        }
        session.setAttribute("mainAd",mainAd);
        session.setAttribute("secAd",secAd);
        session.setAttribute("thrAd",thrAd);
    }
}
