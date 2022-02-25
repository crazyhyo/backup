package com.java.utils;

import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.apache.ibatis.io.Resources;

public class Message{

	private static Message instance = new Message();
	public static Message getInstance() {
		return instance;
	}
	private Message() {}
	
    Properties properties = new Properties();

    public void initMessage(String propertiesPath) throws IOException{

        Reader reader = Resources.getResourceAsReader(propertiesPath);
        properties.load(reader);
        
    }

    public String getMessage(String key){

        String message = properties.getProperty(key);
        
        return message;

    }

}
