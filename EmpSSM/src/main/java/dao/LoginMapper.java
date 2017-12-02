package dao;

import model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 用户的登录
 */
@Service
public interface LoginMapper {
    /**
     * 使用账号密码进行登录
     * @param username 账号
     * @param password 密码
     * @return 管理员对象
     */
    public User loginByUsernameAndPassword(@Param("username") String username,
                                           @Param("password") String password);
}
