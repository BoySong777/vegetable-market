/**
 * User: LiQingsong
 * Date: 2019/5/4
 * Time: 21:22
 */
package cn.lqs.administrator.bean;

import cn.lqs.base.BaseModel;
import cn.lqs.util.PagingProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AdministratorVo extends PagingProperty {

    private Administrator administrator = BaseModel.getModel(Administrator.class);
}
