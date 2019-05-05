/**
 * User: LiQingsong
 * Date: 2019/4/28
 * Time: 14:41
 */
package cn.lqs.util;

import lombok.Data;

/**
 * 用于分页的类
 */
@Data
public class PagingProperty {
    /**
     * 当前页面索引，从1开始(for easyUI)
     */
    private Integer page;
    /**
     * 页面显示数量，默认10条(for layUI)
     */
    private Integer limit;

    /**
     * 页面显示数量，默认10条（for easyUI)
     */
    private Integer rows;		//默认每页显示10条

    /**
     * 当前页面索引，从0开始
     */
    private Integer pageIndex;

    /**
     * 查询数量，默认10条
     */
    private Integer pageSize;		//默认每页显示10

    /**
     * 起始索引
     */
    private Integer startIndex = 0;		//起始索引

    /**
     * 结束
     */
    private Integer endIndex = 10;		//结束索引

    /**
     * 查询数量，默认10
     */
    private Integer rowCount = 10;

    /**
     * 是否分页标识，默认为true，分页
     */
    private boolean pagingFlag = true;

    private boolean pagination = true;

    /**
     * 排序字段
     */
    private String order;

    /**
     * 排序方式
     */
    private String sort;

    public Integer getStartIndex() {
        if(page == null && pageIndex != null){
            startIndex = pageIndex * getRowCount();
        }else if(page != null && pageIndex == null){
            startIndex = (page-1) * getRowCount();		//easyUI的页面索引是从1开始
        }
        return startIndex;
    }
    public Integer getEndIndex() {
        if(page == null && pageIndex != null){
            endIndex = (pageIndex + 1) * getRowCount();
        }else if(page != null && pageIndex == null){
            endIndex = page * getRowCount();
        }
        return endIndex;
    }
    public Integer getRowCount() {
        if(rows != null && pageSize == null){
            rowCount = rows;
        }else if(rows == null && pageSize != null){
            rowCount = pageSize;
        }else if (limit!=null){
            rowCount = limit;
        }
        return rowCount;
    }
    public boolean isPagingFlag() {
        if(pagination == false) {
            pagingFlag = false;
        }
        return pagingFlag;
    }

}
