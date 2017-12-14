package dao;

import model.Department;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 部门的数据操作层
 */
@Service
public interface DepartmentMapper {

    /**
     * 根据页数和每页个数获取部门列表,如果是搜索可以传入部门的名称模糊查询
     *
     * @param offset 从第几个数据开始
     * @param limit  每页显示的个数
     * @param name   部门的名字(模糊查询)
     * @return
     */
    public List<Department> getDepartmentsByOffsetAndLimitAndName(@Param(value = "offset") Integer offset,
                                                                  @Param(value = "limit") Integer limit,
                                                                  @Param(value = "name") String name);

    /**
     * 获取部门的条数
     *
     * @return
     */
    public Integer getDepartmentsCount();

    /**
     * 通过id删除部门
     *
     * @param id
     */
    public Integer deleteDepartment(Integer id);

    /**
     * 添加部门
     * @param dep_name 部门名称
     * @param dep_des  部门描述
     * @return 部门主键序号
     */
    public Integer addDepartment(@Param(value = "dep_name") String dep_name,
                                 @Param(value = "dep_des") String dep_des);

    /**
     * 获取全部部门信息 通过mybatis的分页插件进行分页
     * @return 部门集合
     */
    public List<Department> getAllDeps();
}
