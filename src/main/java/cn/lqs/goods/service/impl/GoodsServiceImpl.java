/**
 * User: LiQingsong
 * Date: 2019/5/8
 * Time: 21:00
 */
package cn.lqs.goods.service.impl;

import cn.lqs.base.BaseServiceImpl;
import cn.lqs.dao.CategoryDao;
import cn.lqs.dao.DAO;
import cn.lqs.dao.GoodsDao;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;
import cn.lqs.goods.bean.GoodsVo;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.util.QueryResult;
import cn.lqs.util.UploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class GoodsServiceImpl extends BaseServiceImpl<Goods> implements GoodsService {

    private GoodsDao goodsDao;
    @Autowired
    private CategoryDao categoryDao;

    @Override
    @Autowired
    public void setDao(@Qualifier("goodsDao") DAO<Goods> dao) {
        super.dao = dao;
        goodsDao = (GoodsDao) dao;
    }

    @Override
    public void updateGoods(GoodsVo goodsVo) {
        Goods goods = goodsVo.getGoods();
        GoodsDetail goodsDetail = goodsVo.getGoodsDetail();
        Long categoryCode = goods.getCategoryCode();
        Long typeCode = goods.getTypeCode();
        String oldPath = request.getSession().getServletContext()
                .getRealPath("\\img\\");
        String newPath = "E:\\graduationProject\\goods\\"+categoryCode+"\\"+
                        typeCode+"\\"+goods.getId()+"\\";

       /* Goods oldGoods = goodsDao.queryById(goods.getId());
        if (!oldGoods.getCategoryCode().equals(goods.getCategoryCode())||!oldGoods.getTypeCode().equals(goods.getTypeCode())){
            String oldNewPath = "E:\\graduationProject\\goods\\"+oldGoods.getCategoryCode()+"\\"+
                    oldGoods.getTypeCode()+"\\"+goods.getId()+"\\";
            File file = new File(oldNewPath);
            file.renameTo(new File(newPath));
        }
*/
        if (goodsVo.getGoods().getAvatar()!=null&&!"".equals(goodsVo.getGoods().getAvatar())){
            String avatarPath = goods.getAvatar();

            //先删除老的图片
            System.out.println("avatar删除图片的路径:"+newPath+"avatar\\");
            UploadUtil.delFile(newPath+"avatar\\");
            try {
                //再上传新的图片
                UploadUtil.uploadFileToServer(avatarPath,oldPath,newPath+"avatar\\");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        super.modify(goods);
        if(goodsDetail.getImgs()!=null&&!"".equals(goodsDetail.getImgs())){
            String imgs = goodsDetail.getImgs();
            //先删除老的图片
            System.out.println("删除图片的路径:"+newPath+"imgs\\");
            UploadUtil.delFile(newPath+"imgs\\");
            try {
                //再上传新的图片
                UploadUtil.uploadFileToServer(imgs,oldPath,newPath+"imgs\\");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        goodsDao.modifyDetail(goodsDetail);
        UploadUtil.delFile(oldPath);
    }

    @Override
    public void createGoods(GoodsVo goodsVo) {
        Goods goods = goodsVo.getGoods();
        String avatarPath = goods.getAvatar();
        Long categoryCode = goods.getCategoryCode();
        Long typeCode = goods.getTypeCode();
        String oldPath = request.getSession().getServletContext()
                .getRealPath("\\img\\");
        String newPath = "E:\\graduationProject\\goods\\"+categoryCode+"\\"+typeCode+"\\"+goods.getId()+"\\";
        try {
            UploadUtil.uploadFileToServer(avatarPath,oldPath,newPath+"avatar\\");
        } catch (IOException e) {
            e.printStackTrace();
        }
        super.create(goodsVo.getGoods());
        GoodsDetail goodsDetail = goodsVo.getGoodsDetail();
        goodsDetail.setGoodsId(goodsVo.getGoods().getId());
        String imgs = goodsDetail.getImgs();
        try {
            UploadUtil.uploadFileToServer(imgs,oldPath,newPath+"imgs\\");
        } catch (IOException e) {
            e.printStackTrace();
        }
        goodsDao.createDetail(goodsVo.getGoodsDetail());
        UploadUtil.delFile(oldPath);
    }

    @Override
    public GoodsVo queryGoodsById(String goodsId) {
        GoodsVo goodsVo = new GoodsVo();
        Goods goods = queryById(goodsId);
        GoodsDetail goodsDetail = queryDetail(goodsId);
        goodsVo.setGoods(goods);
        goodsVo.setGoodsDetail(goodsDetail);
        return goodsVo;

    }

    @Override
    public GoodsDetail queryDetail(String goodsId) {
        return goodsDao.queryDetail(goodsId);
    }

    @Override
    public String dealUpload(MultipartFile file) {
        String newFileName = "";
        String name = file.getOriginalFilename();//上传文件的真实名称
        String path = request.getSession().getServletContext()
                .getRealPath("\\img\\");
        System.out.println("存放图片的路径："+path);
        try {
            newFileName = UploadUtil.uploadFile(file,path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return newFileName;
    }

    @Override
    public List<Goods> queryByCategoryCode(Long code) {
        return goodsDao.queryByCategoryCode(code);
    }

    @Override
    public void updateStock(Goods goods) {
        goodsDao.updateStock(goods);
    }

    @Override
    public QueryResult<Goods> findList(Object object) {
        QueryResult<Goods> result = new QueryResult<>();
        List<Goods> goodsList = dao.queryList(object);
        for (Goods goods:goodsList){
            String categoryCodeName = categoryDao.selectNameByCode(goods.getCategoryCode());
            goods.setCategoryCodeName(categoryCodeName);
            String typeCodeName = categoryDao.selectNameByCode(goods.getTypeCode());
            goods.setTypeCodeName(typeCodeName);
        }
        result.setRows(goodsList);
        result.setTotal(dao.countModelNum(object));
        return result;
    }
}
