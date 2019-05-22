/**
 * User: LiQingsong
 * Date: 2019/5/21
 * Time: 9:52
 */
package cn.lqs.dao;

import cn.lqs.statistics.bean.Statistics;

import java.util.Date;

public interface StatisticsDao extends DAO<Statistics> {
    Statistics findByTimes(Date date);
    void addSales(Statistics statistics);
    void addOrders(String id);
   void  addAccess(String id);
}
