/**
 * User: LiQingsong
 * Date: 2019/4/28
 * Time: 13:48
 */
package cn.lqs.base;

import cn.lqs.util.DoMainUtil;
import lombok.Data;

import java.io.Serializable;

@Data
public class DoMain implements Serializable {

    private String id = DoMainUtil.getID();
}
