package tool;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;


/**
 * Created by wudi on 2017/11/10.
 */
public class SqlSessionFactoryTool {

    private  static SqlSessionFactory sqlSessionFactory;

    public static SqlSessionFactory getSqlSessionFactory() throws IOException {
        String resoureStr = "mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resoureStr);
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        return  sqlSessionFactory;
    }
}
