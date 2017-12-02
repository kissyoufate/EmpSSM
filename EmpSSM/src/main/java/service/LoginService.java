package service;

import dao.LoginMapper;
import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 登录的业务层
 */
@Service
public class LoginService {

    @Resource
    private LoginMapper loginMapper;

    /**
     * 登录
     * @param username 账号
     * @param password 密码
     * @return
     */
    public User loginByUsernameAndPassword(String username,String password){
        if (username == null || username.equals("")){
            return null;
        }

        if (password == null || password.equals("")){
            return null;
        }

        User user = loginMapper.loginByUsernameAndPassword(username, password);

        if (user == null){
            return null;
        }

        return user;
    }
}
