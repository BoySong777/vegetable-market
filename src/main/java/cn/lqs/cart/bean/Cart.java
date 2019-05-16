/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:13
 */
package cn.lqs.cart.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@Data
@ToString
public class Cart extends DoMain {
    private String userId;
    private String goodsId;
    private Integer number;
    private String goodsName;
    private double goodsPrice;
    private Long categoryCode;//一级类别
    private Long typeCode;//二级类别
    private String avatar;
}
