package com.shawnw.cms.module.domain;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Shawn on 2015/6/1.
 */
@Entity
@Table(name = "T_PRODUCT")
public class Product {
    @Id
    @GeneratedValue
    private Long id;
    @Column(length = 100)
    private String title;
    private String thumbnail;
    private Long typeId;
    private String typeName;
    @Column(length = 1000)
    private String brief;
    @Lob
    private String content;
    private Date createTime;
    private Date updateTime;
    private Long recommend;
    private Long hot;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public Long getTypeId() {
        return typeId;
    }

    public void setTypeId(Long typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getRecommend() {
        return recommend;
    }

    public void setRecommend(Long recommend) {
        this.recommend = recommend;
    }

    public Long getHot() {
        return hot;
    }

    public void setHot(Long hot) {
        this.hot = hot;
    }
}
