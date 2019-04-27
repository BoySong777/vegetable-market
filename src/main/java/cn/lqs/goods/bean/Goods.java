/**
 * User: LiQingsong
 * Date: 2019/4/25
 * Time: 8:41
 */
package cn.lqs.goods.bean;

import cn.lqs.base.BaseModel;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@Component
public class Goods extends BaseModel {
    private String name;
    private String categoryId;//一级类别
    private String typeId;//二级类别
    private Double price;//商品图像
    private String avatar;//商品头像
    private String isDelete;//是否被删除

}
