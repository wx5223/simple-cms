package com.shawnw.cms.module.domain;

import javax.persistence.*;

/**
 * Created by Shawn on 2015/8/11.
 */
@Entity
@Table(name = "T_USER")
public class User {
    @Id
    @GeneratedValue
    private Long id;
    @Column(length = 50, unique = true)
    private String account;
    @Column(length = 100)
    private String password;
    @Column(length = 50)
    private String username;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
