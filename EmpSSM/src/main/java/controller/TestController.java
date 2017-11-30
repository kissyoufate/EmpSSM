package controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.UserMapper;
import model.User;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;
import service.TestService;
import tool.JsonReverTool;
import tool.SqlSessionFactoryTool;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wudi on 2017/11/10.
 */
@Controller
@RequestMapping(value = "/test")
public class TestController {

    @Resource
    private  TestService testService;

    @RequestMapping(value = "/one")
    public String gotoSomePage(Model model){
        System.out.println("....to do");
        model.addAttribute("test","test");
        return "test";
    }

    @RequestMapping(value = "/two")
    public String gotoSomePage2(Model model){
        System.out.println("gotoSomePage2");
        model.addAttribute("test","two");
        return "test";
    }

    @RequestMapping(value = "/getAllUser")
    @ResponseBody
    public String getAllUser() throws IOException {
        return testService.getAllUsers();
    }

    @RequestMapping(value = "/addUser")
    @ResponseBody
    public String addUser(@RequestParam() String name,@RequestParam() String password) throws IOException {
        return testService.addUser(name,password);
    }

    @RequestMapping(value = "/getAllUserJsp")
    public String getAllUserInJsp(Model model) throws IOException {
        List list = testService.getAllUserInJsp();
        model.addAttribute("lists",list);
        return "test";
    }
}
