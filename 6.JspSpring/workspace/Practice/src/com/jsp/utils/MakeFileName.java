package com.jsp.utils;

import java.util.UUID;

public class MakeFileName {

	public static String toUUIDFileName(String fileName, String delimeter) {
		String uuid = UUID.randomUUID().toString().replace("-", "");
		return uuid + delimeter + fileName;
	}
}
