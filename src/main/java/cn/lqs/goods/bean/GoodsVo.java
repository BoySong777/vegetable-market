/**
 * User: LiQingsong
 * Date: 2019/4/28
 * Time: 14:40
 */
package cn.lqs.goods.bean;

import cn.lqs.base.BaseModel;
import cn.lqs.util.PagingProperty;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class GoodsVo extends PagingProperty {
    private Goods goods = BaseModel.getModel(Goods.class);
    private GoodsDetail goodsDetail = BaseModel.getModel(GoodsDetail.class);
}
