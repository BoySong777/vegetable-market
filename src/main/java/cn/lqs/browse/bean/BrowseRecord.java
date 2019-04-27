/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:20
 */
package cn.lqs.browse.bean;

import cn.lqs.base.BaseModel;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class BrowseRecord extends BaseModel {
    private String userId;
    private String goodsId;
    private String categoryId;
}
