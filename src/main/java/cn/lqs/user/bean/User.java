/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 14:41
 */
package cn.lqs.user.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class User extends DoMain {
    private String account;
    private String password;
    private String name;
    private String avatar;
    private String sex;
    private String phone;
}
