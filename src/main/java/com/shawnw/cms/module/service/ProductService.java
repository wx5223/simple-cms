package com.shawnw.cms.module.service;

import com.shawnw.cms.module.dao.ProductRepository;
import com.shawnw.cms.module.dao.ProductTypeRepository;
import com.shawnw.cms.module.domain.Product;
import com.shawnw.cms.module.domain.ProductType;
import com.shawnw.cms.module.vo.ProductTypeCount;
import com.shawnw.cms.module.vo.ProductTypeTree;
import com.shawnw.cms.utils.SimpleCache;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Shawn on 2015/7/10.
 */
@Service
public class ProductService {
    @PersistenceContext
    private EntityManager em;

    private static ProductTypeRepository productTypeRepository;
    private static ProductRepository productRepository;
    private static SimpleCache simpleCache = new SimpleCache();
    private Pageable top20pager = new PageRequest(0, 20, new Sort(Sort.Direction.DESC, "updateTime"));

    public static List<ProductTypeTree> getProductTypeTreeList() {
        List<ProductTypeTree> productTypeTreeList = (List<ProductTypeTree>) simpleCache.get("productTypeTree");
        if (productTypeTreeList == null) {
            List<ProductType> productTypeList = productTypeRepository.findAll();
            Map<Long, ProductTypeCount> countMap = getProductTypeCount();
            productTypeTreeList = handleTree(productTypeList, countMap);
            simpleCache.put("productTypeTree", productTypeTreeList, 2*60*60l);
        }
        return productTypeTreeList;
    }

    public Page<Product> getProductRecommendPage() {
        Page<Product> productRecommendPage = (Page<Product>) simpleCache.get("productRecommendPage");;
        if (productRecommendPage == null) {
            productRecommendPage = productRepository.findAll(getSpecification(null, 1l, null, null), top20pager);
            simpleCache.put("productRecommendPage", productRecommendPage, 2*60*60l);
        }
        return productRecommendPage;
    }

    public Page<Product> getProductHotPage() {
        Page<Product> productHotPage = (Page<Product>) simpleCache.get("productHotPage");;
        if (productHotPage == null) {
            productHotPage = productRepository.findAll(getSpecification(null, null, 1l, null), top20pager);
            simpleCache.put("productHotPage", productHotPage, 2*60*60l);
        }
        return productHotPage;
    }

    public static Specification<Product> getSpecification(final String keyword, final Long recommend, final Long hot, final String ids){
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

    public List<ProductTypeTree> getTreeList() {
        return getProductTypeTreeList();
    }

    private static List<ProductTypeTree> handleTree(List<ProductType> productTypeList, Map<Long, ProductTypeCount> countMap) {
        List<ProductTypeTree> treeList = new ArrayList<ProductTypeTree>();
        Map<Long, ProductTypeTree> treeMap = new HashMap<Long, ProductTypeTree>();
        int i = 0;
        int last = -1;
        while (productTypeList.size() > 0) {
            if (i >= productTypeList.size() - 1) {
                if (i == last) {//循环一遍未处理到任何一个节点，表示此时应该是存在未关联的节点 跳出 不作处理
                    break;
                } else {
                    last = i;
                }
                i = 0;
            }
            ProductType productType = productTypeList.get(i);
            Long pId = productType.getpId();
            Long id = productType.getId();
            if (pId == null) {//根节点
                ProductTypeTree productTypeTree = new ProductTypeTree();
                BeanUtils.copyProperties(productType, productTypeTree);
                if (countMap.get(id) != null) {
                    productTypeTree.setCount(countMap.get(id).getCount());
                }
                treeList.add(productTypeTree);
                treeMap.put(productTypeTree.getId(), productTypeTree);
                productTypeList.remove(i);
                continue;
            } else {
                ProductTypeTree parent = treeMap.get(pId);
                if (parent != null) {
                    ProductTypeTree productTypeTree = new ProductTypeTree();
                    BeanUtils.copyProperties(productType, productTypeTree);
                    if (countMap.get(id) != null) {
                        productTypeTree.setCount(countMap.get(id).getCount());
                    }
                    parent.addChild(productTypeTree);
                    treeMap.put(productTypeTree.getId(), productTypeTree);
                    productTypeList.remove(i);
                    continue;
                } else {
                    i++;
                }
            }
        }
        return treeList;
    }

    @Autowired
    public void setProductTypeRepository(ProductTypeRepository productTypeRepository) {
        ProductService.productTypeRepository = productTypeRepository;
    }
    @Autowired
    public void setProductRepository(ProductRepository productRepository) {
        ProductService.productRepository = productRepository;
    }

    public static Map<Long, ProductTypeCount> getProductTypeCount() {
        Map<Long, ProductTypeCount> map = new HashMap<Long, ProductTypeCount>();
        List result = productRepository.findProductTypeCount();
        for (Object obj : result) {
            Object[] row = (Object[]) obj;
            Long id = ((BigInteger) row[0]).longValue();
            String name = (String) row[1];
            Long count = ((BigInteger) row[2]).longValue();
            ProductTypeCount ptc = new ProductTypeCount(id, name, count);
            map.put(id, ptc);
        }
        return map;
    }
}
