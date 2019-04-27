/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 14:41
 */
package cn.lqs.user.bean;

import cn.lqs.base.BaseModel;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class User extends BaseModel {
    private String account;
    private String name;
    private String avatar;
    private String sex;
    private String phone;
}
