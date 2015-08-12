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
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
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
    private Pageable pager = new PageRequest(1, 20, new Sort(Sort.Direction.DESC, "updateTime"));
    @RequestMapping({"/", "/index"})
    public String index() {
        //推荐
        Page<Product> productPageRecommend = null;
        productPageRecommend = productRepository.findAll(getSpecification(null, 1l, 0l, null), pager);
        //热门
        Page<Product> productPageHot = null;
        productPageHot = productRepository.findAll(getSpecification(null, 1l, 0l, null), pager);
        return "/index";
    }

    @RequestMapping("/login")
    public String login() {
        return "/login";
    }

    @RequestMapping("/buy_first")
    public String buy_first() {
        return "/buy_first";
    }

    @RequestMapping("/buy")
    public String buy() {
        return "/buy";
    }

    @RequestMapping("/order")
    public String order() {
        return "/order";
    }

    @RequestMapping("/send")
    public String send() {
        return "/send";
    }

    @RequestMapping("/partners")
    public String partners() {
        return "/partners";
    }

    @RequestMapping("/products")
    public String products(String[] type) {
        return "/products";
    }

    @RequestMapping("/products/query")
    @ResponseBody
    public Page<Product> productsQuery(String keyword, Integer page, Long recommend, Long hot, String ids) {
        if (page == null || page < 0) {
            page = 0;
        }
        int pageSize = 10;
        Page<Product> productPage = null;
        Pageable pager = new PageRequest(page, pageSize, new Sort(Sort.Direction.DESC, "updateTime"));
        productPage = productRepository.findAll(getSpecification(keyword, recommend, hot, ids), pager);
        return productPage;
    }

    private Specification<Product> getSpecification(final String keyword, final Long recommend, final Long hot, final String ids){
        return new Specification<Product>() {
            public Predicate toPredicate(Root<Product> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicate = new ArrayList<Predicate>();
                if(StringUtils.isNotBlank(keyword)){
                    String keywordLike = keyword;
                    if (keyword.indexOf("%") < 0) {
                        keywordLike = "%" + keyword + "%";
                    }
                    predicate.add(cb.like(root.get("title").as(String.class), keywordLike));
                }
                if (recommend != null && hot != null) {
                    predicate.add(cb.or(
                            cb.equal(root.get("recommend").as(Long.class), recommend),
                            cb.equal(root.get("hot").as(Long.class), hot)
                    ));
                } else if (recommend != null) {
                    predicate.add(cb.equal(root.get("recommend").as(Long.class), recommend));
                } else if (hot != null) {
                    predicate.add(cb.equal(root.get("hot").as(Long.class), hot));
                }
                if (StringUtils.isNotBlank(ids)) {
                    String[] idsArray = ids.split(",");
                    CriteriaBuilder.In in = cb.in(root.get("typeId"));
                    for (String idStr : idsArray) {
                        Long id = null;
                        try {
                            id = Long.parseLong(idStr);
                            in.value(id);
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                        }
                    }
                    predicate.add(in);
                }
                /*if (searchArticle.getRecTimeEnd()!=null){
                    predicate.add(cb.lessThanOrEqualTo(root.get("recommendTime").as(Date.class), searchArticle.getRecTimeEnd()));
                }
                if (StringUtils.isNotBlank(searchArticle.getNickname())){
                    //两张表关联查询
                    Join<Article,User> userJoin = root.join(root.getModel().getSingularAttribute("user",User.class),JoinType.LEFT);
                    predicate.add(cb.like(userJoin.get("nickname").as(String.class), "%" + searchArticle.getNickname() + "%"));
                }*/
                Predicate[] pre = new Predicate[predicate.size()];
                return query.where(predicate.toArray(pre)).getRestriction();
            }
        };
    }

    @RequestMapping("/product/{id}")
    public String product(@PathVariable Long id, ModelMap model) {
        Product product = productRepository.findOne(id);
        model.addAttribute("product", product);
        return "/product";
    }
}
