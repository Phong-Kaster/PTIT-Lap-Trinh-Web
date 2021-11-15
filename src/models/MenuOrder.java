package models;

import java.util.List;

public class MenuOrder {
	private String id;
	private List<MenuOrder> children;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<MenuOrder> getChildren() {
		return children;
	}
	public void setChildren(List<MenuOrder> children) {
		this.children = children;
	}
	
	
}
