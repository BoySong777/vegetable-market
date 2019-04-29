/**
 * User: LiQingsong
 * Date: 2019/4/28
 * Time: 9:08
 */
package cn.lqs.administrator.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("administrator")
public class Administrator {

    @RequestMapping(value = "login")
    private String login(){
        return "login";
    }
}
