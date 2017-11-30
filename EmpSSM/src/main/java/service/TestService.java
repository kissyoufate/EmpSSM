package service;

import com.fasterxml.jackson.core.JsonProcessingException;
import dao.UserMapper;
import model.User;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tool.JsonReverTool;
import tool.SqlSessionFactoryTool;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wudi on 2017/11/10.
 */
@Service
public class TestService {

    @Resource
    private UserMapper userMapper;

    public String getAllUsers() throws IOException {

        List<User> userList = new ArrayList<User>();

        String jsonstr = null;

        List lists = userMapper.getAllUser();

        if (lists != null) {
            jsonstr = JsonReverTool.reverObjectToJsonStr(lists, 1, null);
        } else {
            jsonstr = JsonReverTool.reverObjectToJsonStr(null, 0, "用户获取失败");
        }

        System.out.println(jsonstr);

        return jsonstr;
    }

    public String addUser(String name, String password) throws IOException {
        String jsonstr = null;

        if (name == null || name.equals("")) {
            jsonstr = JsonReverTool.reverObjectToJsonStr(null, 0, "用户名不能为空");
        }

        if (password == null || password.equals("")) {
            jsonstr = JsonReverTool.reverObjectToJsonStr(null, 0, "密码不能为空");
        }

        User u = new User(name, password);

        int i = userMapper.addUser(u);

        if (i > 0) {
            //提交操作
            u.setId(i);
            jsonstr = JsonReverTool.reverObjectToJsonStr(u, 1, null);
        } else {
            jsonstr = JsonReverTool.reverObjectToJsonStr(null, 0, "用户添加失败");
        }
        return jsonstr;
    }

    public List getAllUserInJsp() throws IOException {
        return userMapper.getAllUser();
    }
}
