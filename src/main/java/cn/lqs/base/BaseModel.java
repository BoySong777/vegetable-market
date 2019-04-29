/**
 * User: LiQingsong
 * Date: 2019/4/25
 * Time: 8:32
 */
package cn.lqs.base;

import lombok.Data;

import java.io.Serializable;

/**
 * 创建实体的类
 */
public class BaseModel {

    /**
     *
     * @param clazz 实体类型.class
     * @param <T>
     * @return id为null的实体类的对象
     */
    public static <T> T getModel(Class<?> clazz){
      try{
          DoMain domain = (DoMain) clazz.newInstance();
          ((DoMain)domain).setId(null);
          return (T)domain;
      } catch (Exception e){
          System.err.println("创建实体类时出错，位置在BaseMdel.getModel");
      }
      return null;
    }
}
