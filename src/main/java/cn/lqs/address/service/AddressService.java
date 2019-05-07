package cn.lqs.address.service;

import cn.lqs.address.bean.Address;
import cn.lqs.base.BaseService;

import java.util.List;

public interface AddressService extends BaseService<Address> {
    List<Address> queryListByUserId(String id);
}
