package filter;

import org.springframework.http.HttpRequest;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;

/**
 * create by Gary Wong
 * 2017/11/12
 * class describetion : 登录的过滤器,过滤所有请求
 */
public class LoginFilter implements Filter {


    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("LoginFilter初始化");
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse)servletResponse;

        String requestURI = httpServletRequest.getRequestURI();
        System.out.println(requestURI);

        if (requestURI.equals("/") || requestURI.equals("/view/login.jsp") || requestURI.equals("/user/login")){
            filterChain.doFilter(servletRequest,servletResponse);
        }else {
            System.out.println(httpServletRequest.getSession().getAttribute("loginsuccess"));
            if (httpServletRequest.getSession().getAttribute("loginsuccess") != null){
                filterChain.doFilter(servletRequest,servletResponse);
            }else
                httpServletResponse.sendRedirect("/view/login.jsp");
        }
    }

    public void destroy() {

    }
}
