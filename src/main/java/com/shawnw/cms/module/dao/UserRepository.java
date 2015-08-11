package com.shawnw.cms.module.dao;

import com.shawnw.cms.module.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Shawn on 2015/8/11.
 */
public interface UserRepository extends JpaRepository<User, Long> {
    User findByAccount(String account);
}
