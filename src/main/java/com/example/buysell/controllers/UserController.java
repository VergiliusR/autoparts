package com.example.buysell.controllers;

import com.example.buysell.models.Cart;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.repositories.CartRepository;
import com.example.buysell.services.ProductService;
import com.example.buysell.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final ProductService productService;
    private CartRepository cartRepository = null;

    @GetMapping("/login")
    public String login(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "login";
    }

    @GetMapping("/profile")
    public String profile(Principal principal,
                          Model model) {
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        return "profile";
    }

    @GetMapping("/registration")
    public String registration(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "registration";
    }


    @PostMapping("/registration")
    public String createUser(User user, Model model) {
        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "Пользователь с email: " + user.getEmail() + " уже существует");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model, Principal principal) {
        model.addAttribute("user", user);
        model.addAttribute("userByPrincipal", userService.getUserByPrincipal(principal));
        model.addAttribute("products", user.getProducts());
        return "user-info";
    }

    @GetMapping("/cart/add/{id}")
    public String addProductInCart(@PathVariable("id") Long id, User user, Model model, Principal principal) {
        Product product = productService.getProductId(id);
        // получаем объект пользователя
        // в модель добавляем обект пользователя
        model.addAttribute("user" , user);
        // получаем пользователя из текущей сессии
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        //присваеваем переменно id пользователя
        Long id_person = user.getId();
        Cart cart = new Cart(id_person, product.getId());
        cartRepository.save(cart);
        return "redirect:/cart";
    }

//        @GetMapping("/cart")
//    public String cart(User user, Model model, Principal principal){
//        model.addAttribute("user" , user);
//        model.addAttribute("user", userService.getUserByPrincipal(principal));
//        Long id_person = user.getId();
//        List<Cart> cartList = cartRepository.findByUsersId(id_person);
//        List<Product> productsList = new ArrayList<>();
//        for (Cart cart: cartList) {
//            productsList.add(productService.getProductId(cart.getProductId()));
//        }
//        float price = 0;
//        for (Product product: productsList) {
//            price += product.getPrice();
//        }
//        model.addAttribute("price", price);
//        // в модель возвращаем лист с корзиной
//        model.addAttribute("cart_product", productsList);
//        return "/cart";
//    }

    @GetMapping("/cart")
    public String cart(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));

        return "/cart";
    }
    @GetMapping("/cart/delete/{id}")
    public String deleteProductCart(User user, Model model, Principal principal, @PathVariable("id") Long id){
        model.addAttribute("user" , user);
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        Long id_person = user.getId();
        cartRepository.deleteCartByProductId(id);
        return "redirect:/cart";
    }

}
