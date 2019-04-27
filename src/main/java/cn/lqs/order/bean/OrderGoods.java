/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 14:56
 */
package cn.lqs.order.bean;

import cn.lqs.base.BaseModel;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class OrderGoods extends BaseModel {
    private String orderId;
    private String goodsId;
    private Integer number;
}
