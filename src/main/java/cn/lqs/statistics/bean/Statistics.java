/**
 * User: LiQingsong
 * Date: 2019/5/21
 * Time: 9:21
 */
package cn.lqs.statistics.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.util.Date;

@Data
@ToString
@Component
public class Statistics extends DoMain {
    private Double sales;
    private Integer orders;
    private Integer access;
    private Date times;
}
