package service;

import dao.DepartmentMapper;
import exception.BaseException;
import model.Department;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 部门管理的业务层
 */
@Service
public class DepartmentService {

    @Resource
    private DepartmentMapper departmentMapper;

    /**
     * 分页获取部门列表
     *
     * @param page 需要获取的页数
     * @return
     */
    public List<Department> getDepartmentByPage(Integer page, Integer limit, String name) {

        Integer offset = (page - 1) * limit;

        List<Department> lists = departmentMapper.getDepartmentsByOffsetAndLimitAndName(offset, limit, name);

        return lists;
    }

    /**
     * 获取部门的条数
     *
     * @return
     */
    public Integer getDepartmentsCount() {
        return departmentMapper.getDepartmentsCount();
    }

    /**
     * 根据id删除部门
     *
     * @param id 部门id
     * @return
     */
    public boolean deleteDepartmentById(Integer id) {
        if (id == null || id < 1) {
            return false;
        }

        Integer integer = departmentMapper.deleteDepartment(id);
        if (integer < 1) {
            return false;
        }
        return true;
    }

    /**
     * 添加部门
     * @param name 部门名字
     * @param des  部门描述
     * @return 增加的部门主键序号
     */
    public Integer addDepartmentByNameAndDes(String name,String des) throws BaseException {

        if (name == null || name.trim().equals("")){
            throw new BaseException("部门名字不能为空");
        }

        if (des == null || des.trim().equals("")){
            throw new BaseException("部门描述不能为空");
        }

        Integer integer = departmentMapper.addDepartment(name, des);

        return integer;
    }

    /**
     * 获取所有部门信息
     * @return 部门信息集合
     */
    public List<Department> getAllDeps(){
        return departmentMapper.getAllDeps();
    }
}
