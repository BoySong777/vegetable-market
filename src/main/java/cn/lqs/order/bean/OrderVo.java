/**
 * User: LiQingsong
 * Date: 2019/5/17
 * Time: 23:00
 */
package cn.lqs.order.bean;

import cn.lqs.base.BaseModel;
import cn.lqs.util.PagingProperty;
import lombok.Data;
import lombok.ToString;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Data
@ToString
public class OrderVo extends PagingProperty {
    Order goodsOrder = BaseModel.getModel(Order.class);
    private Date startTime;
    private Date endTime;
    private String searchId;
    private String startAndEndTime;

    public Date getStartTime(){
        if (startAndEndTime==null||"".equals(startAndEndTime)){

        }else{
            String timeStirng = this.startAndEndTime.substring(0,10);
            timeStirng = timeStirng + " 00:00:00";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                this.startTime = sdf.parse(timeStirng);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        return startTime;
    }

    public Date getEndTime(){
        if (startAndEndTime==null||"".equals(startAndEndTime)){

        }else{
            String timeStirng = this.startAndEndTime.substring(13);
            timeStirng = timeStirng + " 23:59:59";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                this.endTime = sdf.parse(timeStirng);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        return endTime;
    }

}
