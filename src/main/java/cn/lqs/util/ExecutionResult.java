/**
 * User: LiQingsong
 * Date: 2019/5/4
 * Time: 22:02
 */
package cn.lqs.util;

import lombok.Data;
import lombok.ToString;

import java.util.Map;

/**
 * 返回前段数据的类
 */
@Data
@ToString
public class ExecutionResult {
    /**
     * 执行结果编码
     */
    private String code;

    /**
     * 是否执行成功标识
     */
    private boolean flag;

    /**
     * 执行返回信息
     */
    private String msg;

    /**
     * 执行结果数量
     */
    private long total;

    /**
     * 数据行
     */
    private Object data;

    /**
     * 数据行（for easyUi)
     */
    private Object rows;

    /**
     * 扩展结果集
     */
    private Map<String,Object> extMap;

    /**
     * 错误信息
     */
    private String errorMsg;

    public void setRows(Object rows) {
        if(rows==null){
            this.rows = new Object[]{};
        }else{
            this.rows = rows;
        }
    }
}
