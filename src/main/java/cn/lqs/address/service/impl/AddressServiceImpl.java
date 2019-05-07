/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 14:53
 */
package cn.lqs.address.service.impl;

import cn.lqs.address.bean.Address;
import cn.lqs.address.service.AddressService;
import cn.lqs.base.BaseServiceImpl;
import cn.lqs.dao.AddressDao;
import cn.lqs.dao.DAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AddressServiceImpl extends BaseServiceImpl<Address> implements AddressService {

    private AddressDao addressDao;

    @Override
    @Autowired
    public void setDao(@Qualifier("addressDao") DAO<Address> dao) {
        super.dao = dao;
        addressDao = (AddressDao) dao;
    }

    @Override
    public List<Address> queryListByUserId(String id) {
        List<Address> addressList = addressDao.queryListByUserId(id);
        for (Address addr:addressList
             ) {
            addr.setAreaName(addressDao.queryNameByProvinceCode(addr.getArea()));
            addr.setProvinceName(addressDao.queryNameByProvinceCode(addr.getProvince()));
            addr.setStreetName(addressDao.queryNameByProvinceCode(addr.getStreet()));
        }
        return addressList;
    }



}
