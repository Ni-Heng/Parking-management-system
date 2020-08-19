package com.lgr.car;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import com.alibaba.fastjson.JSONObject;
import com.base.WeChatConfig;
import com.lgr.car.utils.MyX509TrustManager;
import com.lgr.car.utils.SignUtil;

public class FaceApi {
	//License Plate Recognition
	public static final String API_OCR_PLATEOCR = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_plateocr";
	public String httpsRequest(String requestUrl, Map<String, String> params) {
		StringBuilder strb = new StringBuilder();
		for (Entry<String, String> entry : params.entrySet()) {
			String key = entry.getKey();
			String value = entry.getValue();
			if (strb.length() == 0) {
				strb.append(key).append("=").append(SignUtil.urlEncodeUTF8(value));
			} else {
				strb.append("&").append(key).append("=").append(SignUtil.urlEncodeUTF8(value));
			}
		}
		// logger.info(strb.toString());
		String result = null;
		try {
			// Create an SSLContext object and initialize it with the trust manager we specify
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// Get the SSLSocketFactory object from the above SSLContext object
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
			conn.setSSLSocketFactory(ssf);
			//send data
			conn.setDoOutput(true);
			//Receive data
			conn.setDoInput(true);
			//Do not use cache
			conn.setUseCaches(false);
			// Set the request method (GET/POST)
			conn.setRequestMethod("POST");

			// Write data to the output stream when outputStr is not null
			if (strb.length() > 0) {
				OutputStream outputStream = conn.getOutputStream();
				// Pay attention to the encoding format
				outputStream.write(strb.toString().getBytes());
				// outputStream.write(strb.toString().getBytes("UTF-8"));
				outputStream.close();
			}

			// Read the returned content from the input stream
			InputStream inputStream = conn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			String str = null;
			StringBuffer buffer = new StringBuffer();
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}

			// Release resources
			bufferedReader.close();
			inputStreamReader.close();
			inputStream.close();
			inputStream = null;
			conn.disconnect();
			result = buffer.toString();
		} catch (ConnectException ce) {
			System.out.println("Connection timed out：{}"+ce);
		} catch (Exception e) {
			System.out.println("httpsRequest exception：{}"+ e);
		}
		return result;
	}

	//License Plate Recognition
	public RootResp getPlateOcr(String image) {
		int timeStamp = (int) Math.ceil(System.currentTimeMillis() / 1000);
		Map<String, String> params = new HashMap<String, String>();
		params.put("app_id", String.valueOf(WeChatConfig.APPID));
		params.put("time_stamp", String.valueOf(timeStamp));
		params.put("nonce_str", WeChatConfig.NONCESTR);
		params.put("image", image);
		String substring = WeChatConfig.APPKEY.substring(0, WeChatConfig.APPKEY.length()-1);
		String sign = SignUtil.getSignName(substring, params);
		params.put("sign", sign);
		String result = httpsRequest(API_OCR_PLATEOCR, params);
		System.out.println(result);
		RootResp resp = JSONObject.parseObject(result, RootResp.class);
		return resp;
	}
}
