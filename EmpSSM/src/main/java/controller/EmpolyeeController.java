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
}
