package com.shawnw.cms.module.action;

import com.shawnw.cms.module.service.ProductService;
import com.shawnw.cms.module.vo.ProductTypeTree;
import com.shawnw.cms.module.vo.ResultMsg;
import com.shawnw.cms.utils.ConfigPropertiesUtils;
import org.apache.commons.io.FilenameUtils;
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
import java.util.List;
import java.util.UUID;

/**
 * Created by Shawn on 2015/6/2.
 */
@Controller
@RequestMapping("/api")
public class CommonApiController {

    @RequestMapping({"/", "/main"})
    public String index(ModelMap model) {
        return "/main";
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
