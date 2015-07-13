package com.shawnw.cms.module.service;

import com.shawnw.cms.module.dao.ProductTypeRepository;
import com.shawnw.cms.module.domain.ProductType;
import com.shawnw.cms.module.vo.ProductTypeTree;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Shawn on 2015/7/10.
 */
@Service
public class ProductService {
    private static ProductTypeRepository productTypeRepository;
    public static List<ProductTypeTree> productTypeTreeList = null;

    public static List<ProductTypeTree> getProductTypeTreeList() {
        if (productTypeTreeList == null) {
            List<ProductType> productTypeList = productTypeRepository.findAll();
            productTypeTreeList = handleTree(productTypeList);
        }
        return productTypeTreeList;
    }

    public List<ProductTypeTree> getTreeList() {
        if (productTypeTreeList == null) {
            List<ProductType> productTypeList = productTypeRepository.findAll();
            productTypeTreeList = handleTree(productTypeList);
        }
        return productTypeTreeList;
    }

    private static List<ProductTypeTree> handleTree(List<ProductType> productTypeList) {
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
            if (pId == null) {//根节点
                ProductTypeTree productTypeTree = new ProductTypeTree();
                BeanUtils.copyProperties(productType, productTypeTree);
                treeList.add(productTypeTree);
                treeMap.put(productTypeTree.getId(), productTypeTree);
                productTypeList.remove(i);
                continue;
            } else {
                ProductTypeTree parent = treeMap.get(pId);
                if (parent != null) {
                    ProductTypeTree productTypeTree = new ProductTypeTree();
                    BeanUtils.copyProperties(productType, productTypeTree);
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
}
