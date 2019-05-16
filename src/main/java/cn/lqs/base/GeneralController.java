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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller

public class GeneralController extends BaseController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private GoodsService goodsService;


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
        session.setAttribute("categoryList", categoryList);
        session.setAttribute("goodsListMap", goodsListMap);
        session.setAttribute("typeListMap", typeListMap);
        List<Category> fistCategory = categoryService.queryListFirstCategory();
        session.setAttribute("cs", fistCategory);
        System.out.println("真的是走这个方法了。");
        return "redirect:/index.jsp";
    }
}
