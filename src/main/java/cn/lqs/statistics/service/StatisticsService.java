/**
 * User: LiQingsong
 * Date: 2019/5/21
 * Time: 10:34
 */
package cn.lqs.statistics.service;

import cn.lqs.base.BaseService;
import cn.lqs.statistics.bean.Statistics;

import java.util.Date;

public interface StatisticsService extends BaseService<Statistics> {
    Statistics findByTimes(Date date);
    void addSales(Statistics statistics);
    void addOrders(String id);
    void  addAccess(String id);
}
