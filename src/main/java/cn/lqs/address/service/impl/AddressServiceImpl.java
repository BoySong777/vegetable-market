/**
 * User: LiQingsong
 * Date: 2019/5/7
 * Time: 14:53
 */
package cn.lqs.address.service.impl;

import cn.lqs.address.bean.Address;
import cn.lqs.address.bean.Province;
import cn.lqs.address.service.AddressService;
import cn.lqs.base.BaseServiceImpl;
import cn.lqs.dao.AddressDao;
import cn.lqs.dao.DAO;
import cn.lqs.user.bean.User;
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

    @Override
    public String queryNameByProvinceCode(Long code) {
        return addressDao.queryNameByProvinceCode(code);
    }

    @Override
    public Address queryDefault(String id) {
        return this.transform(addressDao.queryDefault(id));
    }

    @Override
    public void setDefault(String id) {
        User user = (User) session.getAttribute("user");

        this.resetDefault(user.getId());
        addressDao.setDefault(id);
    }

    @Override
    public void resetDefault(String userId) {
        addressDao.resetDefault(userId);
    }

    @Override
    public List<Province> getProvince() {
        return addressDao.getProvince();
    }

    @Override
    public List<Province> getArea() {
        return addressDao.getArea();
    }

    @Override
    public List<Province> getTwon(String areaCode) {
        return addressDao.getTwon(areaCode);
    }

    @Override
    public Province queryProvinceByCode(long code) {
        return addressDao.queryProvinceByCode(code);
    }

    @Override
    public Address queryById(String id){
        Address address = addressDao.queryById(id);
        address = this.transform(address);
        return address;
    }
    private Address transform(Address address){
        address.setAreaName(addressDao.queryNameByProvinceCode(address.getArea()));
        address.setProvinceName(addressDao.queryNameByProvinceCode(address.getProvince()));
        address.setStreetName(addressDao.queryNameByProvinceCode(address.getStreet()));
        return address;
    }



}
