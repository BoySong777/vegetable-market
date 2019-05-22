/**
 * User: LiQingsong
 * Date: 2019/4/25
 * Time: 8:41
 */
package cn.lqs.goods.bean;

import cn.lqs.base.DoMain;
import cn.lqs.util.CommUtil;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.lang.reflect.Array;
import java.util.*;

@Data
@ToString
@Component
public class Goods extends DoMain {
    private String name;
    private Long categoryCode;//一级类别
    private String categoryCodeName;
    private Long typeCode;//二级类别
    private String typeCodeName;
    private Double price;//商品价格
    private Double discount;//折扣
    private String avatar;//商品头像
    private String brand;//品牌
    private Integer stock;//库存
    private String isDelete;//是否被删除
    private Integer feature;//商品特征
    private String searchSign;
    private List<Integer> searchSignList;

    /*public List<Integer> getSearchSignList() {
        if (searchSign == null || ("").equals(searchSign)) {
            return searchSignList;
        }
        String[] signArray = searchSign.split(",");
        searchSignList = Arrays.asList(CommUtil.strToInt(signArray));
        Collections.sort(searchSignList);
        return searchSignList;
    }*/

}
