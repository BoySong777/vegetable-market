package cn.lqs.Mail.service;


import cn.lqs.Mail.bean.Mail;
import cn.lqs.user.bean.User;

public interface MailService {

    void sendAttachMail(Mail mail);
    boolean verifyUpdatePwd(User user,String token);
}
