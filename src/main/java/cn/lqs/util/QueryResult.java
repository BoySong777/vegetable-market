/**
 * User: LiQingsong
 * Date: 2019/5/4
 * Time: 21:38
 */
package cn.lqs.util;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@JsonInclude(value = JsonInclude.Include.NON_NULL)
@Data
@ToString
public class QueryResult<T> {
    private List<T> rows = null;
    private Integer total = null;
}
