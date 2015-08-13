package com.shawnw.cms.module.domain;

import javax.persistence.*;

/**
 * Created by Shawn on 2015/6/30.
 */
@Entity
@Table(name = "t_product_type")
public class ProductType {
    @Id
    @GeneratedValue
    private Long id;
    @Column(length = 30)
    private String name;
    private Long pId;
    @Column(length = 10)
    private String type;
    private Long order = 0l;
    @Column(length = 200)
    private String description;

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
}
