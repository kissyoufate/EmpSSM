package dao;

import model.User;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wudi on 2017/11/10.
 */
@Service
public interface UserMapper {

    /**
     * 通过id查找用户
     * @param id 用户id
     * @return 用户对象
     */
    public User getUserById(Integer id);

    /**
     * 获得所有用户
     * @return
     */
    public List<User> getAllUser();

    /**
     * 添加一个用户
     * @param u
     * @return
     */
    public int addUser(User u);
}
