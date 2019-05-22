/**
 * User: LiQingsong
 * Date: 2019/5/8
 * Time: 18:21
 */
package cn.lqs.dao;

import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;
import java.util.Map;

public interface GoodsDao extends DAO<Goods> {

    GoodsDetail queryDetail(String goodsId);
    void createDetail(GoodsDetail goodsDetail);
    void modifyDetail(GoodsDetail goodsDetail);
    List<Goods> queryByCategoryCode(Long code);
    void updateStock(Goods goods);
    List<Goods> searchLikeGoodsName(String string);
    List<Goods> searchByCategory(Long code);
    List<Goods> searchByType(Long code);
    List<Goods> searchBySearchSign(String string);
    Integer queryNeedAddGoodsNum();
    List<Goods> queryByAd(Map<String,Object> map);
    void updateSales(GoodsDetail goodsDetail);

}
