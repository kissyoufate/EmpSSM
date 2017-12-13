package service;

import exception.BaseException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * create by Gary Wong
 * 2017/12/13
 * class describetion : none
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:applicationContext.xml"})
public class DepartmentServiceTest {

    @Resource
    DepartmentService departmentService;

    @Test
    public void testAdd(){
        System.out.println(departmentService);
        String name = "XX部";
        String des = "dadqwd";
        Integer integer = null;
        try {
            integer = departmentService.addDepartmentByNameAndDes(name, des);
        } catch (BaseException e) {
            System.out.println(e.getMessage());
        }
        System.out.println(integer);
    }

}
