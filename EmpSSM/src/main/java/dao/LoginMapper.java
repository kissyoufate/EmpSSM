package dao;

import model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * create by Gary Wong
 * 2017/11/12
 * class describetion : 登录的数据库操作接口
 */
@Service
public interface LoginMapper {

    public List<User> getUserByNameAndPassword(@Param("name") String name, @Param("password") String password);
}
