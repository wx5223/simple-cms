package com.shawnw.cms.utils;

import org.apache.commons.lang3.StringUtils;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

/**
 * @author issuser
 * 读取url.properties文件
 * 可以根据省份编码查询相应省份的校讯通访问地址url
 * 可以查询用户头像的访问地址
 * 可以查询校讯通跳转到学习平台正确时，回调地址callbackUrl
 * 可以查询校讯通跳转到学习平台错误时，跳转到的注册地址regUrl
 */
public class ConfigPropertiesUtils {
	private static Map<String, String> urlMap;
	
	public static void init() {
		urlMap = new HashMap<String, String>();
		PropertiesTool pt = PropertiesTool.newInstance("config.properties");
		Properties properties = pt.getProp();
		Iterator it = properties.entrySet().iterator();
		
		while(it.hasNext()){
		    Map.Entry entry=(Map.Entry)it.next();
		    String key = (String) entry.getKey();
		    String value = (String) entry.getValue();
		    if(value != null) {
		    	urlMap.put(key, value);
		    }
		    
		}
		
	}

    public static String get(String name) {
        if(urlMap == null) {
            init();
        }
        return urlMap.get(name);
    }

	public static String get(String name, String defaultValue) {
		String value = get(name);
		if (StringUtils.isBlank(value)) {
			return defaultValue;
		}
		return value;
	}

    public static Map<String, String> getUrlMap() {
        if (urlMap == null) {
            init();
        }
        return urlMap;
    }
}
