package com.example.buysell.repositories;

import com.example.buysell.models.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface CartRepository extends JpaRepository<Cart, Long> {

    // Получаем корзину по id пользователя
    List<Cart> findByUsersId(Long userId);

    void deleteCartByProductId(Long id);

}
