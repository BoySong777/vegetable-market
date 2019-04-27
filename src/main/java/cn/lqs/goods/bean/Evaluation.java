/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:00
 */
package cn.lqs.goods.bean;

import cn.lqs.base.BaseModel;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.util.Date;

@Data
@ToString
@Component
public class Evaluation extends BaseModel {
    private String userId;
    private String goodsId;
    private String content;
    private Date time;
    private Integer score;

}
