package com.shawnw.cms.module.vo;

/**
 * 类型计数对象
 * Created by Shawn on 2015/8/7.
 */
public class ProductTypeCount {
    private Long id;
    private String name;
    private Long count;

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

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public ProductTypeCount(Long id, String name, Long count) {
        this.id = id;
        this.name = name;
        this.count = count;
    }
}
