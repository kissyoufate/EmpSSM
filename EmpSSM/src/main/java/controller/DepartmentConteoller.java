package controller;

import com.alibaba.fastjson.JSON;
import model.Department;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.DepartmentService;

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
        return "views/department/depManager";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String deleteDepartmentById(@RequestParam(value = "id", required = true) Integer id,
                                       @RequestParam(value = "page", required = false) Integer page,
                                       @RequestParam(value = "name", required = false) String name,
                                       Model model) {
        boolean b = departmentService.deleteDepartmentById(id);

        //检查页数是否足够
        Integer count = departmentService.getDepartmentsCount();
        Integer pages = 0;
        if (count % limit == 0) {
            pages = count / limit;
        } else {
            pages = count / limit + 1;
        }

        if (page > pages) {
            page = pages;
        }

        Map map = new HashMap();
        if (b) {
            map.put("status", "success");
            map.put("data", page);
        } else {
            map.put("status", "fail");
        }

        return JSON.toJSONString(map);
    }
}
