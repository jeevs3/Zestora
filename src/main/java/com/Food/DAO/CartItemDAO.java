package com.Food.DAO;

import java.util.List;

import com.Food.Model.CartItem;

public interface CartItemDAO {

    void addCartItem(CartItem cartItem);

    List<CartItem> getCartItems(int cartId);

    void updateQuantity(int cartItemId, int quantity);

    void removeCartItem(int cartItemId);

    void clearCart(int cartId);

	CartItem getCartItemByCartIdAndMenuId(int cartId, int menuId);
}
