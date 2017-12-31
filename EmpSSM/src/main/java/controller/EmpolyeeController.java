package controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import model.Empolyee;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.EmpolyeeService;
import tool.WGJsonTool;

import javax.annotation.Resource;
import java.util.List;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 员工控制器
 */
@Controller
@RequestMapping("/empolyee")
public class EmpolyeeController {

    private static final Integer LIMIT = 5;

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

    /**
     * 添加员工
     * @param emp_name 员工姓名
     * @param emp_sex  员工性别
     * @param emp_age  员工年龄
     * @param emp_tel  员工电话
     * @param dep_id   员工所属部门id
     * @return
     */
    @RequestMapping("/addEmp")
    @ResponseBody
    public String addEmp(@RequestParam(value = "emp_name") String emp_name,
                         @RequestParam(value = "emp_sex") String emp_sex,
                         @RequestParam(value = "emp_age") Integer emp_age,
                         @RequestParam(value = "emp_tel") String emp_tel,
                         @RequestParam(value = "dep_id") Integer dep_id){

        if (emp_name == null || emp_name.trim().equals("")){
            return WGJsonTool.failJson("请输入员工姓名");
        }

        if (!emp_sex.equals("1") && !emp_sex.equals("2")){
            System.out.println(emp_sex);
            return WGJsonTool.failJson("请选择正确的员工性别");
        }

        if (emp_age < 16 || emp_age > 120){
            return WGJsonTool.failJson("请输入正确的员工年龄");
        }

        if (emp_tel.length() != 11){
            return WGJsonTool.failJson("请输入正确的员工电话");
        }

        if (dep_id == null || dep_id == 0){
            return WGJsonTool.failJson("请选择正确的员工所属部门");
        }

        Integer i = empolyeeService.addEmp(emp_name,emp_age,emp_sex,emp_tel,dep_id);

        if (i> 0){
            return WGJsonTool.successJson("员工添加成功");
        }

        return WGJsonTool.failJson("员工添加失败了");
    }
}
