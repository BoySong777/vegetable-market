/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 13:32
 */
package cn.lqs.address.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class Province extends DoMain {
    private Long code;
    private String name;
    private String  area;
    private String town;
}
