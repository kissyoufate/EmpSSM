package model;

/**
 * create by Gary Wong
 * 2017/12/2
 * class describetion : 部门的实体类
 */
public class Department {
    private Integer id;
    private String dep_name;
    private String dep_des;
    private Integer dep_mark;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDep_name() {
        return dep_name;
    }

    public void setDep_name(String dep_name) {
        this.dep_name = dep_name;
    }

    public String getDep_des() {
        return dep_des;
    }

    public void setDep_des(String dep_des) {
        this.dep_des = dep_des;
    }

    public Integer getDep_mark() {
        return dep_mark;
    }

    public void setDep_mark(Integer dep_mark) {
        this.dep_mark = dep_mark;
    }

    @Override
    public String toString() {
        return "Department{" +
                "id=" + id +
                ", dep_name='" + dep_name + '\'' +
                ", dep_des='" + dep_des + '\'' +
                ", dep_mark=" + dep_mark +
                '}';
    }
}
