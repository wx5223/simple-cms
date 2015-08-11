package com.shawnw.cms.utils;

import sun.misc.BASE64Encoder;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by Shawn on 2014/9/4.
 */
public class Encoder {
    /**
     * URL地址编码
     * @param url url地址
     * @return
     */
    public static String urlEncode(String url) {
        try {
            return URLEncoder.encode(url, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // e.printStackTrace();
            return URLEncoder.encode(url);
        }
    }
    /**
     * md5+Base64组合算法
     * @param str
     * @return
     * @throws NoSuchAlgorithmException
     * @throws UnsupportedEncodingException
     */
    public static final String md5Base64(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();
        String result = base64en.encode(md5.digest(str.getBytes("utf-8")));
        return result;
    }

    public static void main(String[] args) {
        try {
            System.out.println(md5Base64("admin"));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
