package cn.lqs.browse.service;

import cn.lqs.base.BaseService;
import cn.lqs.browse.bean.BrowseRecord;

public interface BrowseRecordService extends BaseService<BrowseRecord> {
    BrowseRecord queryByUserAndGoods(BrowseRecord browseRecord);
}
