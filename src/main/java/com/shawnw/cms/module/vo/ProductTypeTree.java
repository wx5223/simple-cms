package com.shawnw.cms.module.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Shawn on 2015/7/9.
 */
public class ProductTypeTree {
    private Long id;
    private String name;
    private Long pId;
    private Long order;
    private String type;
    private String description;
    private List<ProductTypeTree> children;
    private Long count;

    public void addChild(ProductTypeTree child) {
        if (children == null) {
            children = new ArrayList<ProductTypeTree>();
        }
        children.add(child);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getpId() {
        return pId;
    }

    public void setpId(Long pId) {
        this.pId = pId;
    }

    public Long getOrder() {
        return order;
    }

    public void setOrder(Long order) {
        this.order = order;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ProductTypeTree> getChildren() {
        return children;
    }

    public void setChildren(List<ProductTypeTree> children) {
        this.children = children;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }
}
