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

    /**
     * 添加员工
     * @param emp_name 员工姓名
     * @param emp_sex  员工性别
     * @param emp_age  员工年龄
     * @param emp_tel  员工电话
     * @param dep_id   员工所属部门id
     * @return
     */
    public Integer addEmp(String emp_name, Integer emp_age, String emp_sex, String emp_tel, Integer dep_id) {
        Empolyee empolyee = new Empolyee();
        empolyee.setEmp_name(emp_name);
        empolyee.setEmp_age(emp_age);
        empolyee.setEmp_sex(emp_sex);
        empolyee.setEmp_tel(emp_tel);
        empolyee.setDep_id(dep_id);
        return empolyeeMapper.addEmp(empolyee);
    }
}
