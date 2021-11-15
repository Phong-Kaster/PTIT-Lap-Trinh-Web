package models;

import java.util.List;

import entities.Categories;
import entities.Posts;

public class WidgetModel {
	private Categories category;
	private List<Posts> posts;
	private String layout;
	
	public WidgetModel() {
		super();
	}
	
	public WidgetModel(Categories category, List<Posts> posts, String layout) {
		this.category = category;
		this.posts = posts;
		this.layout = layout;
	}

	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}

	public List<Posts> getPosts() {
		return posts;
	}

	public void setPosts(List<Posts> posts) {
		this.posts = posts;
	}

	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}
	
	
}
