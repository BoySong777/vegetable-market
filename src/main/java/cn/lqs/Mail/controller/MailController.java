package cn.lqs.Mail.controller;

import cn.lqs.Mail.bean.Mail;
import cn.lqs.Mail.service.MailService;
import cn.lqs.user.bean.User;
import cn.lqs.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("mail")
public class MailController {

    private MailService mailService;

    @Autowired
    private UserService userService;

    @Autowired
    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }

    @RequestMapping("send/{email}/{type}")
    @ResponseBody
    private Object send(@PathVariable String email) {
       String userId =  userService.selectIdByMail(email);
       String token = userService.setTokenById(userId,email);
        Map<String,Object> map = new HashMap<>();
       if(userId!=null&&!"".equals(userId)){
           Mail mail = new Mail();
           mail.setEmailFrom("qingsong777@qq.com");
           mail.setToEmails(email);
           mail.setSubject("网上菜市场 重置密码");
           String link = "link: http://localhost:8081/Gradle___cn_lqs___vegetable_market_1_0_SNAPSHOT_war__exploded_/mail/resetPassword/" + userId + "/" + token;
           mail.setContent(link);
           mailService.sendAttachMail(mail);
           map.put("isTrue",true);
       }
        return map;

    }

    @RequestMapping("resetPassword/{id}/{token}")
    private String resetPassword(@PathVariable String id, @PathVariable String token) {
        User user = userService.queryById(id);
        boolean isTrue = mailService.verifyUpdatePwd(user,token);

        if (isTrue) {
            return "redirect:/reset-password.jsp";
        }
        return "front-page/forgetPwd";
    }
}
