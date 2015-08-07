package com.shawnw.cms.module.dao;

import com.shawnw.cms.module.domain.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by Shawn on 2015/6/1.
 */
public interface ProductRepository extends JpaRepository<Product, Long>,JpaSpecificationExecutor<Product> {
    Page<Product> findByTitle(String title, Pageable pageable);
    Page<Product> findByTitleAndRecommendOrHot(String title, Pageable pageable);
    @Query(value = "select id, name,(select count(1) from t_product where typeId=t.id) count from t_product_type t ", nativeQuery = true)
    List findProductTypeCount();
}
