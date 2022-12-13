package com.example.buysell.models;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Component;

import javax.persistence.*;

//@EnableJpaRepositories("com.spring")
//@Component
//@EntityScan("com.example.data.models")
@Entity
@Table(name = "product_cart")
public class Cart {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "users_id")
    private Long usersId;

    @Column(name = "product_id")
    private Long productId;


    public Cart(Long usersId, Long productId) {
        this.usersId = usersId;
        this.productId = productId;
    }

    public Cart() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUsersId() {
        return usersId;
    }

    public void setUsersId(Long usersId) {
        this.usersId = usersId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductsId(Long productsId) {
        this.productId = productsId;
    }
}




