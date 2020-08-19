package com.lgr.car.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

public class SignUtil {

	/**
	 * Signature production
	 * @param appKey
	 * @param params
	 * @return
	 */
	public static String getSignName(String appKey, Map<String,String> params) {
		Map<String,String> sortMap = new TreeMap<String,String>();
		sortMap.putAll(params);
		StringBuilder strb = new StringBuilder();
		for(Entry<String,String> entry:sortMap.entrySet()) {
			String key = entry.getKey();
			String value = entry.getValue();
			if(value!=null && !"".equals(value.trim())) {
				strb.append(key).append("=").append(urlEncodeUTF8(value)).append("&");
			}
		}
		strb.append("app_key=").append(appKey);
		String result = Security.MD5(strb.toString());
		return result.toUpperCase();
	}
	
	public static String getSignature(String appKey, Map<String,String> params) throws UnsupportedEncodingException {
        // First sort the parameters in ascending lexicographical order of their parameter names
        Map<String, String> sortedParams = new TreeMap<String, String>(params);
        Set<Map.Entry<String, String>> entrys = sortedParams.entrySet();
        // Traverse the sorted dictionary and splice all the parameters together in the "key=value" format
        StringBuilder baseString = new StringBuilder();
        for (Map.Entry<String, String> param : entrys) {
            //The sign parameter and the null parameter are not added to the algorithm
            if(param.getValue()!=null && !"".equals(param.getKey().trim()) && !"sign".equals(param.getKey().trim()) && !"".equals(param.getValue().trim())) {
                baseString.append(param.getKey().trim()).append("=").append(URLEncoder.encode(param.getValue().trim(),"UTF-8")).append("&");
            }
        }
        System.err.println("Parameters of APPKEY not spliced："+baseString.toString());
        if(baseString.length() > 0 ) {
            baseString.deleteCharAt(baseString.length()-1).append("&app_key="+appKey);
        }
        System.err.println("Parameters after splicing APPKEY："+baseString.toString());
		String result = Security.MD5(baseString.toString());
		return result.toUpperCase();
    }
	
	/**
	 * URL encoding (utf-8)
	 * 
	 * @param source
	 * @return
	 */
	public static String urlEncodeUTF8(String source) {
		String result = source;
		try {
			result = java.net.URLEncoder.encode(source, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return result;
	}
}
