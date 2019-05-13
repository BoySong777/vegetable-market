/**
 * User: LiQingsong
 * Date: 2019/4/27
 * Time: 15:13
 */
package cn.lqs.Mail.bean;

import cn.lqs.base.DoMain;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.util.Map;

@Data
@ToString
public class Mail extends DoMain {
    private String emailHost;//发送邮件服务器
    private String emailFrom;//发送人邮箱
    private String emailUsername;//发件人用户名
    private String emailPassword;//发件人密码
    private String toEmails;//收件人邮箱
    private String subject;//邮件主题
    private String content;//邮件内容
    private Map<String, String> pictures;//邮件中的图片，为null时无图片，key为ID，value为图片地址
}
