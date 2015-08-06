package com.shawnw.cms.module.action;

import com.shawnw.cms.module.dao.ProductRepository;
import com.shawnw.cms.module.dao.ProductTypeRepository;
import com.shawnw.cms.module.domain.Product;
import com.shawnw.cms.module.domain.ProductType;
import com.shawnw.cms.module.vo.ResultMsg;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Shawn on 2015/6/1.
 */
@Controller
@RequestMapping("/api/product")
public class ProductApiController {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ProductTypeRepository productTypeRepository;

    @RequestMapping("/add")
    public String add() {
        return "/product_add";
    }

    @RequestMapping("/update/{id}")
    public String update(@PathVariable Long id, ModelMap model) {
        Product product = productRepository.findOne(id);
        model.addAttribute("product", product);
        return "/product_add";
    }

    @RequestMapping("/save")
    @ResponseBody
    public ResultMsg save(Product product) {
        if (product == null) {
            return ResultMsg.msg(-1l, "失败");
        }
        Date time = new Date();
        if (product.getId() == null) {
            product.setCreateTime(time);
        }
        product.setUpdateTime(time);
        productRepository.save(product);
        return ResultMsg.success("成功");
    }

    @RequestMapping("/delete/{id}")
    @ResponseBody
    public ResultMsg delete(@PathVariable Long id, ModelMap model) {
        productRepository.delete(id);
        return ResultMsg.success("成功");
    }

    @RequestMapping("/delete/batch")
    @ResponseBody
    public ResultMsg deleteBatch(Long[] checkbox, ModelMap model) {
        List<Product> products = new ArrayList<Product>();
        for (Long id : checkbox) {
            if (id == 0) {
                continue;
            }
            Product product = new Product();
            product.setId(id);
            products.add(product);
        }
        productRepository.deleteInBatch(products);
        return ResultMsg.success("成功");
    }

    @RequestMapping("/index")
    public String index() {
        return "/index";
    }

    @RequestMapping("/list")
    public String products(ModelMap model, String keyword, Integer page) {
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
        return "/product_list";
    }

    @RequestMapping("/type/save")
    @ResponseBody
    public ResultMsg saveType(ProductType productType) {
        productTypeRepository.save(productType);
        return ResultMsg.success("成功");
    }

    @RequestMapping("/type/list")
    public String typeList(ModelMap model) {
        return "/product_type_list";
    }

    @RequestMapping("/type/json")
    @ResponseBody
    public List<ProductType> product(ModelMap model) {
        List<ProductType> productTypeList = productTypeRepository.findAll();
        return productTypeList;
    }

    @RequestMapping("/type/delete/{id}")
    @ResponseBody
    public ResultMsg deleteType(@PathVariable Long id, ModelMap model) {
        productTypeRepository.delete(id);
        return ResultMsg.success("成功");
    }
/*
    @RequestMapping("/product_list")
    public String product_list(ModelMap model) {
        List<Product> productList = productRepository.findAll();
        model.addAttribute("list", productList);
        Page page = new Page(1, 1000, "product_list");
        model.addAttribute("page", page);
        return "/product_list";
    }*/



}
