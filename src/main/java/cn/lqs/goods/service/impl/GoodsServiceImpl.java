/**
 * User: LiQingsong
 * Date: 2019/5/8
 * Time: 21:00
 */
package cn.lqs.goods.service.impl;

import cn.lqs.base.BaseServiceImpl;
import cn.lqs.browse.bean.BrowseRecord;
import cn.lqs.category.bean.Category;
import cn.lqs.dao.*;
import cn.lqs.goods.bean.Goods;
import cn.lqs.goods.bean.GoodsDetail;
import cn.lqs.goods.bean.GoodsVo;
import cn.lqs.goods.service.GoodsService;
import cn.lqs.search.bean.SearchSign;
import cn.lqs.statistics.bean.Statistics;
import cn.lqs.user.bean.User;
import cn.lqs.util.CommUtil;
import cn.lqs.util.QueryResult;
import cn.lqs.util.UploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.CriteriaBuilder;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Service
public class GoodsServiceImpl extends BaseServiceImpl<Goods> implements GoodsService {

    private GoodsDao goodsDao;
    @Autowired
    private CategoryDao categoryDao;

    @Autowired
    private SearchSignDao searchSignDao;

    @Autowired
    private BrowseRecordDao browseRecordDao;


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
        goods.setSearchSign(this.createSearchSign(goods.getSearchSign()));
        super.create(goods);
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
    public List<Goods> searchLikeGoodsName(String string) {
        return goodsDao.searchLikeGoodsName(string);
    }

    @Override
    public List<Goods> searchGoods(String searchValue) {
        List<BrowseRecord> historyList = this.queryUserHistory();
        List<Goods> likeNameAndSignList = this.searchGoodsBySearchValue(searchValue);
        List<Goods> sameList = new ArrayList<>();
        if(historyList!=null){
            for(BrowseRecord browseRecord:historyList){
                for(Goods goods:likeNameAndSignList){
                    if(goods.getId().equals(browseRecord.getGoodsId())){
                        sameList.add(goods);
                    }
                }
            }
        }
        sameList.addAll(likeNameAndSignList);
        sameList = CommUtil.removeDuplicate(sameList);
        return sameList;
    }

    @Override
    public List<Goods> queryGoodsByCategoryAndUser(GoodsVo goodsVo) {
        List<Goods> queryResult = this.queryList(goodsVo);
        queryResult = this.resultSortByUser(queryResult);
        List<BrowseRecord> historyList = this.queryUserHistory();
        List<Goods> sameList = new ArrayList<>();
        if(historyList!=null){
            for(BrowseRecord browseRecord:historyList){
                for(Goods goods:queryResult){
                    if(goods.getId().equals(browseRecord.getGoodsId())){
                        sameList.add(goods);
                    }
                }
            }
        }
        sameList.addAll(queryResult);
        sameList = CommUtil.removeDuplicate(sameList);
        return sameList;
    }

    @Override
    public Integer queryNeedAddGoodsNum() {
        return goodsDao.queryNeedAddGoodsNum();
    }

    @Override
    public List<Goods> queryByAd(String adType, int number) {
        Map<String,Object> map = this.adSearch(adType,number);

        return goodsDao.queryByAd(map);
    }

    @Override
    public void updateSales(GoodsDetail goodsDetail) {
        goodsDao.updateSales(goodsDetail);
    }

    /**
     * 利用输入的搜索的词汇进行名字和标签的搜索，并对结果根据用户进行排序
     * @param searchValue
     * @return
     */
    public List<Goods> searchGoodsBySearchValue(String searchValue) {
        List<Goods> searchResult = new ArrayList<>();
        Category category = categoryDao.searchName(searchValue);
        if(category!=null){
            if(category.getFatherCode()==0){
                searchResult = goodsDao.searchByCategory(category.getCode());
            }else{
                searchResult = goodsDao.searchByType(category.getCode());
            }
            searchResult = this.resultSortByUser(searchResult);
            return searchResult;
        }
        List<Goods> searchNameResult = this.searchLikeGoodsName(searchValue);
        searchNameResult = this.resultSortByUser(searchNameResult);
        List<Goods> searchSignResult = new ArrayList<>();
        List<SearchSign> signList = searchSignDao.queryByLikeName(searchValue);
        for (SearchSign sign:signList){
            String signStr = ","+sign.getCode()+",";
            searchSignResult.addAll(goodsDao.searchBySearchSign(signStr));
        }
        searchSignResult = this.resultSortByUser(searchSignResult);
        System.out.println("通过name模糊查询得到的数据："+searchNameResult);
        System.out.println("通过标签查询得到的数据："+searchSignResult);
        searchResult.addAll(searchNameResult);
        searchResult.addAll(searchSignResult);

        return searchResult;

    }

    public List<BrowseRecord> queryUserHistory(){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return null;
        }
        BrowseRecord b = new BrowseRecord();
        b.setUserId(user.getId());
        List<BrowseRecord> goodsList = browseRecordDao.queryList(b);
        System.out.println("查询到的历史记录："+goodsList);
        return goodsList;
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

    private String createSearchSign(String str){
        StringBuffer sbf = new StringBuffer();
        sbf.append(",");
        String[] strArray = str.split("\\s+");
        for (String sign:strArray){
            SearchSign searchSign = searchSignDao.queryByName(sign);
            if(searchSign==null){
                SearchSign newSearchSign = new SearchSign();
                newSearchSign.setName(sign);
                searchSignDao.create(newSearchSign);
               sbf.append(newSearchSign.getCode()+",");
            }else {
                sbf.append(searchSign.getCode()+",");
            }
        }
        return sbf.toString();
    }

    private List<Goods> resultSortByUser(List<Goods> resultList){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return resultList;
        }
        List<Goods> endList = new ArrayList<>();
        for (int num : user.getLikeSort()){
            for(Goods goods:resultList){
                if(num==goods.getFeature()){
                    endList.add(goods);
                }
            }

        }
        return endList;
    }

    private Map<String, Object> adSearch(String adType, int number){
        Map<String,Object> map = new HashMap<>();
        if(adType.equals("com")){
            if(number%3==1){
                map.put("feature",1);
            }else if(number%3==2){
                map.put("feature",2);
            }else if(number%3==0){
                map.put("feature",3);
            }
        }else if(adType.equals("lowPrice")){
            map.put("feature",1);
        }else if(adType.equals("solid")){
            map.put("feature",2);
        }else if(adType.equals("soild")){
            map.put("feature",3);
        }
        switch (number){
            case 1:
                map.put("category",1001);
                break;
            case 2:
                map.put("category",1007);
                break;
            case 3:
                map.put("category",1002);
                break;
            case 4:
                map.put("category",1010);
                break;
            case 5:
                map.put("category",1009);
                break;
        }
        return map;
    }
}
