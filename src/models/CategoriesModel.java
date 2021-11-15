package models;

import java.util.List;

import entities.Categories;

public class CategoriesModel {
	private Categories category;
	private List<Categories> children;
	
	public CategoriesModel() {
		super();
	}
	
	public Categories getCategory() {
		return category;
	}
	public void setCategory(Categories category) {
		this.category = category;
	}
	public List<Categories> getChildren() {
		return children;
	}
	public void setChildren(List<Categories> children) {
		this.children = children;
	}
	
	
}
