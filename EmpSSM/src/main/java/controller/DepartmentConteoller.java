package controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import exception.BaseException;
import model.Department;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.DepartmentService;
import tool.WGJsonTool;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 部门控制器
 */
@Controller
@RequestMapping("/department")
public class DepartmentConteoller {

    @Resource
    private DepartmentService departmentService;

    /**
     * 固定每页的个数
     */
    public static final Integer limit = 5;

    /**
     * 获取部门首页的数据并保存
     *
     * @param page  页码
     * @param name  搜索的名字
     * @param model 保存数据的容器
     */
    private void getDepData(@RequestParam(value = "page", required = false) Integer page,
                            @RequestParam(value = "name", required = false) String name,
                            Model model) {
        //当前页数的部门集合
        List<Department> lists = departmentService.getDepartmentByPage(page, limit, name);
        //总条数
        Integer count = 0;
        if (!name.equals("")) {
            count = lists.size();
        } else {
            count = departmentService.getDepartmentsCount();
        }

        //总页数
        Integer pages = 1;
        if (count % limit == 0) {
            pages = count / limit;
        } else {
            pages = count / limit + 1;
        }

        model.addAttribute("name", name);
        model.addAttribute("count", count);
        model.addAttribute("pages", pages);
        model.addAttribute("limit", limit);
        model.addAttribute("page", page);
        model.addAttribute("lists", lists);
    }

    @RequestMapping("/index")
    public String gotoDepIndex(@RequestParam(value = "page", required = false) Integer page,
                               @RequestParam(value = "name", required = false) String name,
                               Model model) {
        if (page == null || page < 1) {
            page = 1;
        }

        if (name == null) {
            name = "";
        }
        getDepData(page, name, model);
        return "views/department/depManager";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String deleteDepartmentById(@RequestParam(value = "id", required = true) Integer id,
                                       @RequestParam(value = "page", required = false) Integer page,
                                       @RequestParam(value = "name", required = false) String name,
                                       Model model) {
        boolean b = departmentService.deleteDepartmentById(id);

//        //检查页数是否足够
//        Integer count = departmentService.getDepartmentsCount();
//        Integer pages = 0;
//        if (count % limit == 0) {
//            pages = count / limit;
//        } else {
//            pages = count / limit + 1;
//        }
//
//        if (page > pages) {
//            page = pages;
//        }

        Map map = new HashMap();
        if (b) {
            map.put("status", "success");
//            map.put("data", page);
        } else {
            map.put("status", "fail");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 跳转到增加部门页面
     *
     * @return 员工页面所在位置
     */
    @RequestMapping("/addDep")
    public String gotoAddDepPage() {
        return "views/department/addDepartment";
    }


    /**
     * 添加部门操作
     *
     * @param name 部门名字
     * @param des  部门描述
     * @return 返回的页面
     */
    @RequestMapping("/addDepHandle")
    public String addDepHandle(@RequestParam(value = "dep_name") String name,
                               @RequestParam(value = "dep_des") String des,
                               Model model) {

        try {
            Integer integer = departmentService.addDepartmentByNameAndDes(name, des);
            if (integer > 0) {
                getDepData(1, "", model);
                return "views/department/depManager";
            } else {
                model.addAttribute("dep_name", name);
                model.addAttribute("dep_des", des);
                model.addAttribute("error", "添加部门失败!!");
                return "views/department/addDepartment";
            }

        } catch (BaseException e) {
            model.addAttribute("dep_name", name);
            model.addAttribute("dep_des", des);
            model.addAttribute("error", e.getMessage());
            return "views/department/addDepartment";
        }
    }

    /**
     * mybatis分页插件获取部门全部信息
     *
     * @param pg    当前页码
     * @param model
     * @return
     */
    @RequestMapping("/deps")
    public String getAll(@RequestParam(value = "pg", defaultValue = "1") String pg,
                         @RequestParam(value = "search_name", defaultValue = "") String searchName,
                         Model model) {
        //分页
        PageHelper.startPage(Integer.parseInt(pg), limit);

        List<Department> lists = departmentService.getAllDeps();
        PageInfo<Department> pageInfo = new PageInfo<Department>(lists);

        model.addAttribute("pageInfo", pageInfo);

        return "views/department/depManager";
    }

    /**
     * 搜索部门
     *
     * @param name  部门名字
     * @param pg    当前页数
     * @param model 数据模型
     * @return 跳转的页面地址
     */
    @RequestMapping("/searchDeps")
    public String searchDepsByName(@RequestParam(value = "name") String name,
                                   @RequestParam(value = "pg", defaultValue = "1") String pg,
                                   Model model) {
        //分页
        PageHelper.startPage(Integer.parseInt(pg), limit);

        if (name == null || name.trim().equals("")) {
            List<Department> lists = departmentService.getAllDeps();
            PageInfo<Department> pageInfo = new PageInfo<Department>(lists);
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("error", "请输入要搜索的部门名字");
        } else {
            List<Department> lists = departmentService.searchDeps(name);
            PageInfo<Department> pageInfo = new PageInfo<Department>(lists);
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("searchName",name);
        }
        return "views/department/depManager";
    }

    /**
     * 添加部门
     *
     * @param dep_name 部门名字
     * @param dep_des  部门描述
     * @return 数据json
     */
    @RequestMapping("/addDepReturnJson")
    @ResponseBody
    public String addDepReturnJson(@RequestParam(value = "dep_name") String dep_name,
                                   @RequestParam(value = "dep_des") String dep_des) {

        if (dep_name == null || dep_name.trim().equals("")) {
            return WGJsonTool.failJson("部门名字不能为空");
        }

        if (dep_des == null || dep_des.trim().equals("")) {
            return WGJsonTool.failJson("部门描述不能为空");
        }

        Integer integer = null;
        try {
            integer = departmentService.addDepartmentByNameAndDes(dep_name, dep_des);
            if (integer > 0) {
                return WGJsonTool.successJson("部门条件成功");
            } else {
                return WGJsonTool.failJson(null);
            }
        } catch (BaseException e) {
            return WGJsonTool.failJson(e.getMessage());
        }
    }

    /**
     * 更新部门操作 返回json数据集合
     *
     * @param dep_id   部门id
     * @param dep_name 部门名字
     * @param dep_des  部门描述
     * @return
     */
    @RequestMapping("/updateDepReturnJson")
    @ResponseBody
    public String updateDep(@RequestParam(value = "dep_id") String dep_id,
                            @RequestParam(value = "dep_name") String dep_name,
                            @RequestParam(value = "dep_des") String dep_des) {
        if (dep_id == null || dep_id.trim().equals("")) {
            return WGJsonTool.failJson("部门id不能为空");
        }

        if (dep_name == null || dep_name.trim().equals("")) {
            return WGJsonTool.failJson("部门名字不能为空");
        }

        if (dep_des == null || dep_des.trim().equals("")) {
            return WGJsonTool.failJson("部门描述不能为空");
        }

        Integer integer = departmentService.updateDep(Integer.parseInt(dep_id), dep_name, dep_des);
        if (integer > 0) {
            return WGJsonTool.successJson("修改成功");
        } else
            return WGJsonTool.failJson("修改失败");
    }
}
