package dao;

import model.Empolyee;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * create by Gary Wong
 * 2017/12/23
 * class describetion : 员工管理的Mapper
 */
@Service
public interface EmpolyeeMapper {

    /**
     * 得到所有的员工集合
     * @return
     */
    public List<Empolyee> getAllEmps();
}
