/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:22
 */
package cn.lqs.administrator.bean;

import cn.lqs.base.BaseModel;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@ToString
@Data
public class Administrator extends BaseModel {
    private String acount;
    private String password;
    private String position;
}
