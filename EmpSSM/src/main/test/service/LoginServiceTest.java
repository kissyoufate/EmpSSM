package service;

import dao.LoginMapper;
import model.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * create by Gary Wong
 * 2017/12/3
 * class describetion : spring 的测试环境搭建
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:applicationContext.xml"})
public class LoginServiceTest {

    @Resource
    private LoginMapper loginMapper;

    @Test
    public void test(){
        User user = loginMapper.loginByUsernameAndPassword("admin", "123456");
        System.out.println(user);
    }
}
