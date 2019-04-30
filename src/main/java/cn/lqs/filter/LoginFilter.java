/**
 * User: LiQingsong
 * Date: 2019/4/30
 * Time: 23:38
 */
package cn.lqs.filter;

import cn.lqs.administrator.bean.Administrator;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {
    private String dispatchUrl = "";
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        dispatchUrl = filterConfig.getInitParameter("dispatchUrl");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest)request;
        HttpSession session = req.getSession();

        HttpServletResponse res = (HttpServletResponse)response;
        String url = req.getRequestURI();

        if(!(url.endsWith("login")||url.endsWith("login.jsp"))){
            Administrator administrator = (Administrator) session.getAttribute("admin");
            if (administrator==null){
                res.sendRedirect(req.getContextPath()+dispatchUrl);
                return;
            }
        }

        chain.doFilter(request,response);

    }

    @Override
    public void destroy() {

    }
}
