package com.Food.DAO;

import java.util.List;

import com.Food.Model.Menu;

public interface MenuDAO  {
	
	void addMenu(Menu menu);
	Menu getMenu(int menuId);
	void updateMenu(Menu menu);
	void deleteMenu(int menuId);
	List<Menu> addAllMenu();
	List<Menu> getMenuByRestaurant(int restaurantId);
	Menu getMenuById(int menuId);

}
