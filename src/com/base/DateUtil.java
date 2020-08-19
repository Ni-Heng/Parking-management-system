package com.base;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;
import org.springframework.util.StringUtils;
/*
 * Process the conversion of date types in the entire system
 * 1.Implement the Converter interface
 * 2.Implement the abstract method convert for processing
 * 3.To configure this class in the spring-web.xml file to serve the entire system
 * <bean id="dateUtil" class="org.springframework.format.support.FormattingConversionServiceFactoryBean" >
        <property name="converters" >
            <list>
                <bean class="com.ht.base.DateUtil"></bean>
            </list>
        </property>
    </bean>
    4.Configure the following code in spring-web.xml
    <mvc:annotation-driven conversion-service="dateUtil"></mvc:annotation-driven>
 * */
public class DateUtil  implements Converter<String, Date> {

    @Override
    public Date convert(String source) {
    	
    	System.out.println("source="+source);
        //Realize the conversion of a string into a date type (the format is yyyy-MM-dd HH:mm:ss)
        SimpleDateFormat dateFormat = null;
        if(!StringUtils.isEmpty(source)){
        	//Determine whether the date string contains the time part
        	int pos1 = source.indexOf(":");//Find the position of the first colon in the string from left to right
        	int pos2 = source.lastIndexOf(":");//Find the position of the first colon in the string from right to left
        	source = source.replace("T", " ");//Replace the T in the string with a space
            if(pos1>0 && pos1 != pos2){
                dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }else if(pos1>0 && pos1==pos2){
            	source = source +":00";
            	dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }else{
                dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            }
        }
        try {
            return dateFormat.parse(source);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //If the parameter binding fails, return null
        return null;
    }

}
