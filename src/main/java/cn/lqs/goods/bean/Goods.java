/**
 * User: LiQingsong
 * Date: 2019/4/25
 * Time: 8:41
 */
package cn.lqs.goods.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

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

}
