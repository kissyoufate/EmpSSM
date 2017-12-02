package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 员工控制器
 */
@Controller
@RequestMapping("/empolyee")
public class EmpolyeeController {

    @RequestMapping("/index")
    public String gotoEmpIdex(){
        return "views/empolyee/empManager";
    }
}
