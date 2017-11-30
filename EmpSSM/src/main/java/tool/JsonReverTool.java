package tool;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wudi on 2017/11/10.
 */
public class JsonReverTool {
    private static ObjectMapper objectMapper = new ObjectMapper();

    public static String reverObjectToJsonStr(Object object,Integer status,String reson) throws JsonProcessingException {
        String jsonStr;
        Map map = new HashMap();

        if (status == 1){
            //成功状态
            map.put("status",status);
            if (object!=null){
                map.put("data",object);
            }else {
                map.put("data","");
            }
        }else{
            //非成功状态
            map.put("status",status);
            if (reson != null && !reson.equals("")) {
                map.put("reson",reson);
            }else {
                map.put("reson","未识别的错误");
            }
        }
        return objectMapper.writeValueAsString(map);
    }
}
