package com.Food.DAO;

import com.Food.Model.Cart;

public interface CartDAO {

    Cart getCartByUserId(int userId);

    int createCart(Cart cart);

    void updateTotalAmount(int cartId, double totalAmount);

    void deleteCart(int cartId);

	void updateRestaurantId(int cartId, int restaurantId);
}
