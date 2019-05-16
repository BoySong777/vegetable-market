package cn.lqs.dao;

import cn.lqs.address.bean.Address;
import cn.lqs.address.bean.Province;

import java.util.List;

public interface AddressDao extends DAO<Address> {
    List<Address> queryListByUserId(String id);
    String queryNameByProvinceCode(Long code);
    Address queryDefault(String id);
    void setDefault(String id);
    void resetDefault(String userId);
    List<Province> getProvince();
    List<Province> getArea();
    List<Province> getTwon(String areaCode);
    Province queryProvinceByCode(long code);

}
