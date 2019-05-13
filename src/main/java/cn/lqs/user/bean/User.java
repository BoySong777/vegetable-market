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

import java.util.Date;

@Data
@ToString
@Component
public class User extends DoMain {
    private String account;
    private String password;
    private String name;
    private String avatar;
    private Integer sex;
    private String sexName;
    private String phone;
    private String email;
    private Date createTime;
    private String token;
    private Long tokenTime;

    public String getSexName(){
        if(sex!=null){
            if(sex==0){
                sexName = "女";
            } else if(sex==1){
                sexName = "男";
            }else{
                sexName = "";
            }
        }
        return sexName;
    }
}
