package tool;

import com.alibaba.fastjson.JSON;

import java.util.HashMap;
import java.util.Map;

/**
 * create by Gary Wong
 * 2017/12/21
 * class describetion : 转换json的工具类
 */
public class WGJsonTool {

    private static Map map = new HashMap();

    /**
     * 成功的json数据返回
     *
     * @param dataObj 需要返回的数据
     * @return
     */
    public static String successJson(Object dataObj) {
        map.put("status", "success");
        map.put("data", dataObj);
        map.put("message", "");
        return JSON.toJSONString(map);
    }

    /**
     * 失败的数据返回
     *
     * @param message 失败的原因
     * @return
     */
    public static String failJson(String message) {
        map.put("status", "fail");
        map.put("data", "");
        if (message == null || message.trim().equals("")){
            message = "请求出现了错误";
        }
        map.put("message", message);
        return JSON.toJSONString(map);
    }
}
