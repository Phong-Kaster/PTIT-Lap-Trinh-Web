package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="MENU")
public class Menu {
	@Id @GeneratedValue
	@Column(name="ID")
	private int id;

	@Column(name="TITLE")
	private String title;
	
	@Column(name="TARGET")
	private String target;
	
	@Column(name="ORDER_MENU")
	private int order_menu;
		
	@Column(name="parent")
	private int parent;
	
	@Column(name="position")
	private int position;
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public int getOrder_menu() {
		return order_menu;
	}

	public void setOrder_menu(int order_menu) {
		this.order_menu = order_menu;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}
	
}
