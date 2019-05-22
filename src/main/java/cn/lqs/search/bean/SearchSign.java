/**
 * User: LiQingsong
 * Date: 2019/5/20
 * Time: 17:08
 */
package cn.lqs.search.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@Data
@ToString
public class SearchSign extends DoMain {
    private Integer code;
    private String name;
}
