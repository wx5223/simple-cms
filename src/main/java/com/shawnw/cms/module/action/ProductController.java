package com.shawnw.cms.module.action;

import com.shawnw.cms.module.dao.ProductRepository;
import com.shawnw.cms.module.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Shawn on 2015/6/1.
 */
@Controller
@RequestMapping("/api")
public class ProductController {
    @Autowired
    private ProductRepository productRepository;

    @RequestMapping("/form")
    public String form() {
        return "/form";
    }

    @RequestMapping("/index")
    public String index() {
        return "/index";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String save(Product product) {
        productRepository.save(product);
        return "success";
    }

}
