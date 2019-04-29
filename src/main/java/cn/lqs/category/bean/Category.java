/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:10
 */
package cn.lqs.category.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class Category extends DoMain {
    private String name;
    private Integer typeNumber;
    private String fatherType;
}
