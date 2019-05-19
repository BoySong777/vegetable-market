package cn.lqs.goods.service;

import cn.lqs.base.BaseService;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;
import cn.lqs.goods.bean.GoodsVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface GoodsService extends BaseService<Goods> {
    void updateGoods(GoodsVo goodsVo);
    void createGoods(GoodsVo goodsVo);
    GoodsVo queryGoodsById(String goodsId);
    GoodsDetail queryDetail(String goodsId);
    String dealUpload(MultipartFile file);
    List<Goods> queryByCategoryCode(Long code);
    void updateStock(Goods goods);
}
