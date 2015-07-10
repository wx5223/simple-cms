package com.shawnw.cms.module.dao;

import com.shawnw.cms.module.domain.ProductType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by Shawn on 2015/6/1.
 */
public interface ProductTypeRepository extends JpaRepository<ProductType, Long> {
    @Query("select p from ProductType p where p.pId is null ")
    List<ProductType> findRootType();
}
