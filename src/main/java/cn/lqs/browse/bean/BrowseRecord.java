/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:20
 */
package cn.lqs.browse.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class BrowseRecord extends DoMain {
    private String userId;
    private String goodsId;
    private Integer number;
}
