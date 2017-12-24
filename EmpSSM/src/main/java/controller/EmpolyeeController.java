package controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import model.Empolyee;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.EmpolyeeService;

import javax.annotation.Resource;
import javax.jws.WebParam;
import java.rmi.server.RemoteServer;
import java.util.List;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 员工控制器
 */
@Controller
@RequestMapping("/empolyee")
public class EmpolyeeController {

    public static final Integer LIMIT = 5;

    @Resource
    private EmpolyeeService empolyeeService;

    /**
     * 进入员工管理的首页
     * @param model 储存的数据的模型
     * @return
     */
    @RequestMapping("/index")
    public String gotoEmpIndex(@RequestParam(value = "page",defaultValue = "1") String page,
                               Model model){
        getEmpsLists(Integer.parseInt(page),model);
        model.addAttribute("requestUri","/empolyee/index");//储存请求的uri,分页的链接使用
        return "views/empolyee/empManager";
    }

    /**
     * 分页得到员工列表
     * @param page
     * @param model
     */
    public void getEmpsLists(Integer page,Model model){
        PageHelper.startPage(page,LIMIT);
        List<Empolyee> lists = empolyeeService.getAllEmps();
        PageInfo<Empolyee> pageInfo = new PageInfo<Empolyee>(lists);
        model.addAttribute("pageInfo",pageInfo);
    }

    /**
     * 模糊搜索
     * @param emp_name 搜索的名字关键字
     * @param model 数据模型的容器
     * @return
     */
    @RequestMapping("/search")
    public String searchEmpsByName(@RequestParam(value = "emp_name") String emp_name,
                                   @RequestParam(value = "page",defaultValue = "1") String page,
                                   Model model){
        if (emp_name ==  null || emp_name.trim().equals("")){
            getEmpsLists(1,model);
            model.addAttribute("errorInfo","请输入搜索的关键字");
            model.addAttribute("requestUri","/empolyee/index");
            return "views/empolyee/empManager";
        }

        PageHelper.startPage(Integer.parseInt(page),LIMIT);
        List<Empolyee> lists = empolyeeService.searchEmpsByName(emp_name);
        PageInfo<Empolyee> pageInfo = new PageInfo<Empolyee>(lists);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("requestUri","/empolyee/search");
        model.addAttribute("emp_name",emp_name);
        return "views/empolyee/empManager";
    }

    /**
     * 删除员工
     * @param id 员工id
     * @param model 数据容器
     * @return
     */
    @RequestMapping("/delete")
    public String deleteEmpById(@RequestParam(value = "id") String id,
                                Model model){
        model.addAttribute("requestUri","/empolyee/index");

        if (id == null || id.trim().equals("")){
            getEmpsLists(1,model);
            model.addAttribute("errorInfo","删除失败");
            getEmpsLists(1,model);
            return "views/empolyee/empManager";
        }

        empolyeeService.deleteEmpById(Integer.parseInt(id));
        getEmpsLists(1,model);
        return "views/empolyee/empManager";
    }
}
