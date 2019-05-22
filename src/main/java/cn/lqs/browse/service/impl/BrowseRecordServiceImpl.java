/**
 * User: LiQingsong
 * Date: 2019/5/20
 * Time: 20:42
 */
package cn.lqs.browse.service.impl;

import cn.lqs.base.BaseServiceImpl;
import cn.lqs.browse.bean.BrowseRecord;
import cn.lqs.browse.service.BrowseRecordService;
import cn.lqs.dao.BrowseRecordDao;
import cn.lqs.dao.DAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class BrowseRecordServiceImpl extends BaseServiceImpl<BrowseRecord> implements BrowseRecordService {

    private BrowseRecordDao browseRecordDao;
    @Override
    @Autowired
    public void setDao(@Qualifier("browseRecordDao") DAO<BrowseRecord> dao) {
        super.dao = dao;
        browseRecordDao = (BrowseRecordDao) dao;
    }

    @Override
    public BrowseRecord queryByUserAndGoods(BrowseRecord browseRecord) {
        return browseRecordDao.queryByUserAndGoods(browseRecord);
    }
}
