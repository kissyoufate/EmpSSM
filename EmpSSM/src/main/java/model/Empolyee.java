package model;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 员工的实体类
 */
public class Empolyee {
    private Integer id;
    private String emp_name;
    private String emp_sex;
    private Integer emp_age;
    private String emp_tel;
    private Integer dep_id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmp_name() {
        return emp_name;
    }

    public void setEmp_name(String emp_name) {
        this.emp_name = emp_name;
    }

    public String getEmp_sex() {
        return emp_sex;
    }

    public void setEmp_sex(String emp_sex) {
        this.emp_sex = emp_sex;
    }

    public Integer getEmp_age() {
        return emp_age;
    }

    public void setEmp_age(Integer emp_age) {
        this.emp_age = emp_age;
    }

    public String getEmp_tel() {
        return emp_tel;
    }

    public void setEmp_tel(String emp_tel) {
        this.emp_tel = emp_tel;
    }

    public Integer getDep_id() {
        return dep_id;
    }

    public void setDep_id(Integer dep_id) {
        this.dep_id = dep_id;
    }

    @Override
    public String toString() {
        return "Empolyee{" +
                "id=" + id +
                ", emp_name='" + emp_name + '\'' +
                ", emp_sex='" + emp_sex + '\'' +
                ", emp_age=" + emp_age +
                ", emp_tel='" + emp_tel + '\'' +
                ", dep_id=" + dep_id +
                '}';
    }
}
