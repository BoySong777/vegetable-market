package cn.lqs.dao;

import cn.lqs.address.bean.Address;
import java.util.List;

public interface AddressDao extends DAO<Address> {
    List<Address> queryListByUserId(String id);
    String queryNameByProvinceCode(Long code);
}
