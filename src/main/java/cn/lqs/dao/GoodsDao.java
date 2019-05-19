/**
 * User: LiQingsong
 * Date: 2019/5/8
 * Time: 18:21
 */
package cn.lqs.dao;

import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;

import java.util.List;

public interface GoodsDao extends DAO<Goods> {

    GoodsDetail queryDetail(String goodsId);
    void createDetail(GoodsDetail goodsDetail);
    void modifyDetail(GoodsDetail goodsDetail);
    List<Goods> queryByCategoryCode(Long code);
    void updateStock(Goods goods);
}
