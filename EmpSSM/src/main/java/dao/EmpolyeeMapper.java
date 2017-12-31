package dao;

import model.Empolyee;
import org.apache.ibatis.annotations.Param;
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

    /**
     * 通过姓名模糊搜索员工
     * @param emp_name 员工姓名关键字
     * @return
     */
    List<Empolyee> searchEmpsByName(@Param(value = "emp_name") String emp_name);

    /**
     * 通过id删除员工
     * @param id 员工id
     */
    public void deleteEmpById(@Param(value = "id") int id);

    /**
     * 添加员工
     * @param empolyee 员工的模型
     * @return
     */
    Integer addEmp(@Param(value = "empolyee") Empolyee empolyee);
}
