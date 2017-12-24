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

    /**
     * 通过姓名模糊搜索员工
     * @param emp_name 员工姓名关键字
     * @return
     */
    public List<Empolyee> searchEmpsByName(String emp_name) {
        return empolyeeMapper.searchEmpsByName(emp_name);
    }

    /**
     * 删除员工
     * @param id 员工id
     */
    public void deleteEmpById(int id) {
        empolyeeMapper.deleteEmpById(id);
    }
}
