package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.LoginService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * create by Gary Wong
 * 2017/11/12
 * class describetion : 登录控制器
 */
@Controller
@RequestMapping(value = "/user")
public class LoginController {

    @Resource
    private LoginService loginService;

    @RequestMapping(value = "/login")
    public String doLogin(@RequestParam(value = "name") String name,
                          @RequestParam(value = "password") String password,
                          Model model,
                          HttpServletRequest httpServletRequest){
        System.out.println(loginService);
        boolean b = loginService.doLoginService(name, password);
        if (!b){
            model.addAttribute("error","账号或密码错误!");
            return "login";
        }
        httpServletRequest.getSession().setAttribute("loginsuccess","欢迎您" + name);
        return "index";
    }
}
