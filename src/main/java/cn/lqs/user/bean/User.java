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

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
    private Integer lowPrice;
    private Integer solid;
    private Integer fresh;
   private List<Integer> likeSort;

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

   public List<Integer> getLikeSort() {
        if(likeSort==null){
            likeSort = new ArrayList<>();
        }else {
            return likeSort;
        }
        if(lowPrice == null){
            lowPrice = 0;
        }
        if(solid == null){
            solid = 0;
        }
        if(fresh == null){
            fresh = 0;
        }
        if(lowPrice>solid){
            if (lowPrice>fresh){
                likeSort.add(1);
                if(fresh>solid){
                    likeSort.add(3);
                    likeSort.add(2);
                }else {
                    likeSort.add(2);
                    likeSort.add(3);
                }
            }else {
                likeSort.add(3);
                likeSort.add(1);
                likeSort.add(2);

            }
        }else{
            if(solid>fresh){
                likeSort.add(2);
                if(lowPrice>fresh){
                    likeSort.add(1);
                    likeSort.add(3);
                }else {
                    likeSort.add(3);
                    likeSort.add(1);
                }
            }else {
                likeSort.add(3);
                likeSort.add(2);
                likeSort.add(1);
            }
        }
        return likeSort;
    }
}
