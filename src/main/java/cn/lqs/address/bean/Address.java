/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 13:28
 */
package cn.lqs.address.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@Data
@ToString
public class Address extends DoMain {
    private String userId;
    private Long province;
    private String provinceName;
    private Long area;
    private String areaName;
    private Long street;
    private String streetName;
    private String detail;
    private String phone;
    private String recipient;
    private Integer status;
}
