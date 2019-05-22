/**
 * User: LiQingsong
 * Date: 2019/5/20
 * Time: 16:48
 */
package cn.lqs.dao;

import cn.lqs.browse.bean.BrowseRecord;

public interface BrowseRecordDao extends DAO<BrowseRecord> {
   BrowseRecord queryByUserAndGoods(BrowseRecord browseRecord);
}
