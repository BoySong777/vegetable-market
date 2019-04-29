/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 14:44
 */
package cn.lqs.order.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.util.Date;

@Data
@ToString
@Component
public class Order extends DoMain {
    private String userId;
    private String userInfo;
    private Date createTime;
    private Date endTime;
    private Double totalPrice;

}
