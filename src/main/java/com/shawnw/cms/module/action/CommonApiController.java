package com.shawnw.cms.module.action;

import com.shawnw.cms.module.dao.UserRepository;
import com.shawnw.cms.module.domain.User;
import com.shawnw.cms.module.vo.ResultMsg;
import com.shawnw.cms.utils.ConfigPropertiesUtils;
import com.shawnw.cms.utils.Encoder;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

/**
 * Created by Shawn on 2015/6/2.
 */
@Controller
@RequestMapping("/api")
public class CommonApiController {
    @Autowired
    private UserRepository userRepository;

    @RequestMapping({"", "/", "/main"})
    public String index(ModelMap model) {
        return "/main";
    }

    @RequestMapping({"/login"})
    @ResponseBody
    public ResultMsg login(String account, String password, String code, HttpServletRequest request) {
        String kaptchaExpected = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        if (StringUtils.isBlank(kaptchaExpected) || !kaptchaExpected.equals(code)) {
            return ResultMsg.msg(-1l, "验证码不正确");
        }
        request.getSession().removeAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        User user = userRepository.findByAccount(account);
        if (user == null) {
            return ResultMsg.msg(-2l, "账号不正确");
        }
        String passwordEncoder = null;
        try {
            passwordEncoder = Encoder.md5Base64(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        if (user.getPassword().equals(passwordEncoder)) {
            request.getSession().setAttribute("user", user);
            return ResultMsg.success("成功");
        }
        return ResultMsg.msg(-10l, "账号、密码不正确");
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().removeAttribute("user");
        return "redirect:/login";
    }

    @RequestMapping("/encode/password")
    @ResponseBody
    public ResultMsg updatePassword(String password) {
        String passwordEncoder = null;
        try {
            passwordEncoder = Encoder.md5Base64(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return ResultMsg.success("成功", "password", passwordEncoder);
    }

    @RequestMapping("/password")
    public String password() {
        return "/password";
    }

    @RequestMapping("/update/password")
    @ResponseBody
    public ResultMsg updatePassword(String oldPassword, String password, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return ResultMsg.msg(-1l, "用户未登录");
        }
        String oldPasswordEncoder = null;
        try {
            oldPasswordEncoder = Encoder.md5Base64(oldPassword);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        if (user.getPassword() == null || !user.getPassword().equals(oldPasswordEncoder)) {
            return ResultMsg.msg(-2l, "原密码不正确");
        }
        String passwordEncoder = null;
        try {
            passwordEncoder = Encoder.md5Base64(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        user.setPassword(passwordEncoder);
        userRepository.save(user);
        return ResultMsg.success("成功");
    }

    @RequestMapping("/update/user/password")
    @ResponseBody
    public ResultMsg updateUserPassword(String account, String password, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return ResultMsg.msg(-1l, "用户未登录");
        }
        if (user.getId() != 1l) {
            return ResultMsg.msg(-2l, "无权限");
        }
        String passwordEncoder = null;
        try {
            passwordEncoder = Encoder.md5Base64(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        user = userRepository.findByAccount(account);
        if (user == null) {
            return ResultMsg.msg(-3l, "用户账号不存在");
        }
        user.setPassword(passwordEncoder);
        userRepository.save(user);
        return ResultMsg.success("成功");
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile file,HttpServletRequest request) {
        String name = UUID.randomUUID().toString() + "." + FilenameUtils.getExtension(file.getOriginalFilename());
        String absolutePath = ConfigPropertiesUtils.get("upload.file.path", request.getSession().getServletContext().getRealPath("/") + "upload") + File.separator + name;
        String downloadPath = "/upload/" + name;
        File saveFile = new File(absolutePath);
        if (!saveFile.exists()) {
            saveFile.mkdirs();
        }
        try {
            file.transferTo(saveFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return downloadPath;
    }


    @RequestMapping(value = "/upload1", method = RequestMethod.POST)
    @ResponseBody
    public ResultMsg upload1(@RequestParam("file") MultipartFile file,HttpServletRequest request) {
        String name = UUID.randomUUID().toString() + "." + FilenameUtils.getExtension(file.getOriginalFilename());
        String absolutePath = ConfigPropertiesUtils.get("upload.file.path", request.getSession().getServletContext().getRealPath("/") + "upload") + File.separator + name;
        String downloadPath = "/upload/" + name;
        File saveFile = new File(absolutePath);
        if (!saveFile.exists()) {
            saveFile.mkdirs();
        }
        try {
            file.transferTo(saveFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ResultMsg.success("成功", "path", downloadPath);
    }
}
