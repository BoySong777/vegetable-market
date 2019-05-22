/**
 * User: LiQingsong
 * Date: 2019/5/20
 * Time: 16:04
 */
package cn.lqs.util;

import cn.lqs.goods.bean.Goods;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CommUtil {
    public static Integer[] strToInt(String[] arrs){
        Integer[] ints = new Integer[arrs.length];
        for(int i=0;i<arrs.length;i++){
            ints[i] = Integer.parseInt(arrs[i]);
        }
        return ints;
    }

    /*public static List<Integer> sortUserLike(Integer lowPrice,Integer solid,Integer fresh){
        List<Integer> likeSort = new ArrayList<>();
        if(lowPrice == null){
            lowPrice = 0;
        }
        if(solid == null){
            solid = 0;
        }
        if(fresh == null){
            fresh = 0;
        }
        if(lowPrice>solid){
            if (lowPrice>fresh){
                likeSort.add(1);
                if(fresh>solid){
                    likeSort.add(3);
                    likeSort.add(2);
                }else {
                    likeSort.add(2);
                    likeSort.add(3);
                }
            }else {
                likeSort.add(3);
                likeSort.add(1);
                likeSort.add(2);

            }
        }else{
            if(solid>fresh){
                likeSort.add(2);
                if(lowPrice>fresh){
                    likeSort.add(1);
                    likeSort.add(3);
                }else {
                    likeSort.add(3);
                    likeSort.add(1);
                }
            }else {
                likeSort.add(3);
                likeSort.add(2);
                likeSort.add(1);
            }
        }
        return likeSort;
    }*/

    public static List<Goods>removeDuplicate(List<Goods> list){
        for (int i = 0; i < list.size() - 1; i++) {
            for (int j = list.size() - 1; j > i; j--) {
                if (list.get(i).getId().equals(list.get(j).getId())) {
                    list.remove(j);
                }
            }
        }
        return list;
    }

}
