/**
 * User: LiQingsong
 * Date: 2019/5/6
 * Time: 13:24
 */
package cn.lqs.user.bean;

import cn.lqs.base.BaseModel;
import cn.lqs.util.PagingProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class UserVo extends PagingProperty {
    private User user = BaseModel.getModel(User.class);
}
