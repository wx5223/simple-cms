package com.shawnw.cms.module.action;

import com.shawnw.cms.module.dao.ProductRepository;
import com.shawnw.cms.module.dao.ProductTypeRepository;
import com.shawnw.cms.module.domain.Product;
import com.shawnw.cms.module.domain.ProductType;
import com.shawnw.cms.module.service.ProductService;
import com.shawnw.cms.module.vo.ProductTypeTree;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Shawn on 2015/7/9.
 */
@Controller
@RequestMapping("/")
public class CommonController {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ProductTypeRepository productTypeRepository;
    @RequestMapping("/index")
    public String index(ModelMap model) {
        List<ProductTypeTree> treeList = ProductService.getProductTypeTreeList();
        model.addAttribute("treeList", treeList);
        return "/index";
    }

    @RequestMapping("/products")
    public String products(ModelMap model, Long[] type, String keyword, Integer page) {
        List<ProductTypeTree> treeList = ProductService.getProductTypeTreeList();
        model.addAttribute("treeList", treeList);
        if (page == null || page < 0) {
            page = 0;
        }
        int pageSize = 10;
        Page<Product> productPage = null;
        Pageable pager = new PageRequest(page, pageSize);
        if (StringUtils.isBlank(keyword)) {
            productPage = productRepository.findAll(pager);
        } else {
            productPage = productRepository.findByTitle(keyword, pager);
        }
        model.addAttribute("page", productPage);
        return "/products";
    }

    @RequestMapping("/product/{id}")
    public String product(@PathVariable Long id, ModelMap model) {
        Product product = productRepository.findOne(id);
        model.addAttribute("product", product);
        return "/product";
    }
}
