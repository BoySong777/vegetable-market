/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 14:56
 */
package cn.lqs.order.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class OrderGoods extends DoMain {
    private String orderId;
    private String goodsId;
    private Integer number;
}
