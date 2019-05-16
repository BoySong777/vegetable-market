/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 14:44
 */
package cn.lqs.order.bean;

import cn.lqs.base.DoMain;
import com.fasterxml.jackson.annotation.JsonFormat;
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
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private Date createTime;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private Date endTime;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private Date payTime;
    private Double totalPrice;
    private Integer status;
    private String statusName;

    public String getStatusName() {
       if(status==1){
           statusName = "未发货";
       }else if(status==0){
           statusName = "未付款";
       }else if(status==2){
           statusName = "未收货";
       }else if(status==3){
           statusName = "已完成";
       }
        return statusName;
    }
}
