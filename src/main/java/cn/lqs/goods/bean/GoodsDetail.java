
/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 9:39
 */
package cn.lqs.goods.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class GoodsDetail extends DoMain {
    private String goodsId;
    private String imgs;
    private String specification;//商品规格
    private Integer shelfLife;
    private String edibleMethod;
    private String details;
    private String description;
}