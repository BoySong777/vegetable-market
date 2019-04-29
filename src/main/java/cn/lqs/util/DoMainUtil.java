/**
 * User: LiQingsong
 * Date: 2019/4/28
 * Time: 13:45
 */
package cn.lqs.util;

import java.util.UUID;

/**
 * 实体类的工具类
 */
public class DoMainUtil {
    /**
     * 生成id的方法
     * @return UUID随机数
     */
    public static String getID() {
        return UUID.randomUUID().toString().replace("-", "");
    }
}
