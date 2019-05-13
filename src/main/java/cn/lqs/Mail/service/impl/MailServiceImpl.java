package cn.lqs.Mail.service.impl;

import cn.lqs.Mail.bean.Mail;
import cn.lqs.Mail.service.MailService;
import cn.lqs.user.bean.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;


import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Service
public class MailServiceImpl implements MailService {

    private JavaMailSender javaMailSender;
    private MimeMessage mimeMessage;

    @Autowired
    private HttpServletRequest request;


    @Autowired
    public void setJavaMailSender(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    @Autowired
    public void setMimeMessage(MimeMessage mimeMessage) {
        this.mimeMessage = mimeMessage;
    }

    @Override
    public void sendAttachMail(Mail mail) {
        //设置编码方式
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(this.mimeMessage, "UTF-8");
        try {
            //设置邮件消息的发送者
            mimeMessageHelper.setFrom(mail.getEmailFrom());
            //设置邮件消息的主题
            mimeMessageHelper.setSubject(mail.getSubject());
            mimeMessageHelper.setSentDate(new Date());//设置邮件发送时间
            mimeMessageHelper.setText(mail.getContent(), true);//设置邮件正文，true表示以html格式发送

            String[] toAddresses = mail.getToEmails().split(";");//设置要发送邮件的地址数组

            for (String toAddress : toAddresses) {
                mimeMessageHelper.setTo(toAddress);

                this.javaMailSender.send(this.mimeMessage);
                System.out.println("Send to: " + toAddress);
            }
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }

    @Override
    public boolean verifyUpdatePwd(User user,String token) {
        long tokenTime = user.getTokenTime();
        long currentTime = System.currentTimeMillis();
        int hour = (int) ((currentTime - tokenTime) / 1000 / 60 / 60);
        if (hour < 1) {
            if (token.equals(user.getToken())) {
                request.getSession().setAttribute("userId", user.getId());
                return true;
            }
        }
        request.getSession().setAttribute("timeOutMessage", "时间超时，请重试");
        return false;
    }


}
