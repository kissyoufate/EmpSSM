package service;

import dao.LoginMapper;
import model.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * create by Gary Wong
 * 2017/11/12
 * class describetion : 登录的业务逻辑
 */
@Service
public class LoginService {

    @Resource
    private LoginMapper loginMapper;

    /**
     * 登录方法
     * @param name 登录的用户名
     * @param password 登录密码
     * @return 登录是否成功
     */
    public boolean doLoginService(String name,String password){
        if (null == name || "".equals(name.trim())){
            System.out.println("账号密码不能为空");
            return false;
        }
        if (null == password || "".equals(password.trim())){
            System.out.println("账号密码不能为空");
            return false;
        }

        System.out.println(loginMapper);

        List<User> userList = loginMapper.getUserByNameAndPassword(name, password);

        if (null == userList || userList.size() == 0){
            return false;
        }

        return true;
    }
}
