package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 部门控制器
 */
@Controller
@RequestMapping("/department")
public class DepartmentConteoller {

    @RequestMapping("/index")
    public String gotoDepIndex(){
        return "views/department/depManager";
    }
}
