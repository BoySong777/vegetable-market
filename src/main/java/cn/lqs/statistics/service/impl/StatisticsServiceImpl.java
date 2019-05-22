/**
 * User: LiQingsong
 * Date: 2019/5/21
 * Time: 10:35
 */
package cn.lqs.statistics.service.impl;

import cn.lqs.base.BaseServiceImpl;
import cn.lqs.dao.DAO;
import cn.lqs.dao.StatisticsDao;
import cn.lqs.statistics.bean.Statistics;
import cn.lqs.statistics.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class StatisticsServiceImpl extends BaseServiceImpl<Statistics> implements StatisticsService {

    private StatisticsDao statisticsDao;

    @Override
    @Autowired
    public void setDao(@Qualifier("statisticsDao") DAO<Statistics> dao) {
        super.dao = dao;
        statisticsDao = (StatisticsDao) dao;
    }

    @Override
    public Statistics findByTimes(Date date) {
        return statisticsDao.findByTimes(date);
    }

    @Override
    public void addSales(Statistics statistics) {
        statisticsDao.addSales(statistics);
    }

    @Override
    public void addOrders(String id) {
        statisticsDao.addOrders(id);
    }

    @Override
    public void addAccess(String id) {
        statisticsDao.addAccess(id);
    }
}
