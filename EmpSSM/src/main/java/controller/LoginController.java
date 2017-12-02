package controller;

import model.User;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.LoginService;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 登录控制器
 */
@Controller
@RequestMapping("/user")
public class LoginController {
    @Resource
    private LoginService loginService;

    @RequestMapping("/login")
    public String login(@RequestParam("username") String username,
                        @RequestParam("password") String password,
                        Model model,
                        HttpServletResponse httpServletResponse) {
        User user = loginService.loginByUsernameAndPassword(username, password);
        System.out.println(user);
        if (user == null) {
            model.addAttribute("info", "用户名或密码错误!");
            return "login";
        }
        model.addAttribute("user", user);

        //保存登录状态
        Cookie cookie = new Cookie("loginUser", user.getUsername());
        cookie.setMaxAge(3600);
        httpServletResponse.addCookie(cookie);

        return "index";
    }
}
