/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 18:50
 */
package cn.lqs.category.controller;

import cn.lqs.category.bean.Category;
import cn.lqs.category.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping(value = "findListFirst",method = RequestMethod.GET)
    private Object findListFirst(){
        Map<String,Object> map = new HashMap<>();
        List<Category> categoryList = categoryService.queryListFirstCategory();
        map.put("code",0);
        map.put("msg","");
        map.put("data",categoryList);
        return map;
    }
    @RequestMapping(value = "findListSecond/{code}",method = RequestMethod.GET)
    private Object findListSecond(@PathVariable String code){
        Map<String,Object> map = new HashMap<>();
        if ("0".equals(code)){
            map.put("data",new ArrayList());
            return map;
        }

        List<Category> categoryList = categoryService.queryListSecondCategory(Long.parseLong(code));
        map.put("code",0);
        map.put("msg","");
        map.put("data",categoryList);
        return map;
    }
}
