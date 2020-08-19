package com.base;

import java.io.InputStream;
import java.util.Properties;


/**
 * Read the parameters in the system.properties configuration file
 * */
public class WeChatProperties {
	private static Properties wechatProperties;

	//Load the system.properties configuration file
    private static synchronized void loadProperties() {
        if (null == wechatProperties) {
            try {
                Properties properties = new Properties();
                InputStream inputStream = WeChatProperties.class.getClassLoader().getResourceAsStream("system.properties");
                properties.load(inputStream);
                wechatProperties = properties;
            } catch (Exception e) {
                throw new RuntimeException("Configuration file not found.");
            }
        }
    }

    //Read the value of the parameter in the configuration file
    public static String get(String key) {
        loadProperties();
        return wechatProperties.getProperty(key);
    }
}
