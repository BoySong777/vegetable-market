/**
 * User: LiQingsong
 * Date: 2019/5/8
 * Time: 18:21
 */
package cn.lqs.dao;

import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;

public interface GoodsDao extends DAO<Goods> {

    GoodsDetail queryDetail(String goodsId);
    void createDetail(GoodsDetail goodsDetail);
    void modifyDetail(GoodsDetail goodsDetail);
}
