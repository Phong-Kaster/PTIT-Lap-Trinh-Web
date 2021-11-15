package models;

import java.util.List;

import entities.Menu;

public class MenuModel {
	private Menu menu;
	private List<Menu> children;
	
	public MenuModel() {
		super();
	}
	
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	public List<Menu> getChildren() {
		return children;
	}
	public void setChildren(List<Menu> children) {
		this.children = children;
	}
	
	
}
