package cn.lqs.address.service;

import cn.lqs.address.bean.Address;
import cn.lqs.address.bean.Province;
import cn.lqs.base.BaseService;

import java.util.List;

public interface AddressService extends BaseService<Address> {
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
