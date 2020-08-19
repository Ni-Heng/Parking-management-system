package com.lgr.car.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;

import org.apache.commons.codec.binary.Base64;

public class Base64Util {
	/**
	 * Encode binary data into BASE64 string
	 * 
	 * @param binaryData
	 * @return
	 */
	public static String encode(byte[] binaryData) {
		try {
			return new String(Base64.encodeBase64(binaryData), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}

	/**
	 * Restore BASE64 string to binary data
	 * 
	 * @param base64String
	 * @return
	 */
	public static byte[] decode(String base64String) {
		try {
			return Base64.decodeBase64(base64String.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}

	/**
	 * Convert file into base64 string
	 * 
	 * @param path file path
	 * @return *
	 * @throws Exception
	 */

	public static String encodeBase64File(String path) throws Exception {
		File file = new File(path);
		FileInputStream inputFile = new FileInputStream(file);
		byte[] buffer = new byte[(int) file.length()];
		inputFile.read(buffer);
		inputFile.close();
		return encode(buffer);
	}

	/**
	 * Decode base64 characters and save the file
	 * 
	 * @param base64Code
	 * @param targetPath
	 * @throws Exception
	 */

	public static void decoderBase64File(String base64Code, String targetPath) throws Exception {
		byte[] buffer = decode(base64Code);
		FileOutputStream out = new FileOutputStream(targetPath);
		out.write(buffer);
		out.close();
	}

	/**
	 * Save base64 characters to a text file
	 * 
	 * @param base64Code
	 * @param targetPath
	 * @throws Exception
	 */

	public static void toFile(String base64Code, String targetPath) throws Exception {

		byte[] buffer = base64Code.getBytes();
		FileOutputStream out = new FileOutputStream(targetPath);
		out.write(buffer);
		out.close();
	}
}
