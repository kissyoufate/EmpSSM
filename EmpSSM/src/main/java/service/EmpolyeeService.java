package service;

import dao.EmpolyeeMapper;
import model.Empolyee;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * create by Gary Wong
 * 2017/12/23
 * class describetion : 员工的业务层
 */
@Service
public class EmpolyeeService {

    @Resource
    private EmpolyeeMapper empolyeeMapper;

    /**
     * 得到所有的员工集合
     * @return
     */
    public List<Empolyee> getAllEmps() {
        return empolyeeMapper.getAllEmps();
    }
}
