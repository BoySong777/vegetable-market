/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:13
 */
package cn.lqs.cart.bean;

import cn.lqs.base.BaseModel;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@Data
@ToString
public class Cart extends BaseModel {
    private String userId;
    private String goodsId;
    private Integer number;
}
