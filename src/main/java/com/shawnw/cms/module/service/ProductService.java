package com.shawnw.cms.module.service;

import com.shawnw.cms.module.dao.ProductRepository;
import com.shawnw.cms.module.dao.ProductTypeRepository;
import com.shawnw.cms.module.domain.ProductType;
import com.shawnw.cms.module.vo.ProductTypeCount;
import com.shawnw.cms.module.vo.ProductTypeTree;
import com.shawnw.cms.utils.SimpleCache;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
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
    public static List<ProductTypeTree> productTypeTreeList = null;
    private static SimpleCache<List<ProductTypeTree>> productTypeTreeCache = new SimpleCache<List<ProductTypeTree>>();

    public static List<ProductTypeTree> getProductTypeTreeList() {
        List<ProductTypeTree> productTypeTreeList = productTypeTreeCache.get("productTypeTree");
        if (productTypeTreeList == null) {
            List<ProductType> productTypeList = productTypeRepository.findAll();
            Map<Long, ProductTypeCount> countMap = getProductTypeCount();
            productTypeTreeList = handleTree(productTypeList, countMap);
            productTypeTreeCache.put("productTypeTree", productTypeTreeList, 2*60*60l);
        }
        return productTypeTreeList;
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
